/* r65adr.c */

/*
 *  Copyright (C) 1995-2021  Alan R. Baldwin
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 */

/*
 * With Contributions from
 *
 * Marko Makela
 * Sillitie 10 A
 * 01480 Vantaa
 * Finland
 * Internet: Marko dot Makela at Helsinki dot Fi
 * EARN/BitNet: msmakela at finuh
 */

#include "asxxxx.h"
#include "r6500.h"

int
addr(esp)
struct expr *esp;
{
	int c;
	char *p;
	int iflag, dtyp;
	char ldlm, rdlm;

	/* fix order of '<', '>', and '#' */
	p = ip;
	if (((c = getnb()) == '<') || (c == '>')) {
		p = ip-1;
		if (getnb() == '#') {
			*p = *(ip-1);
			*(ip-1) = c;
		}
	}
	ip = p;

	/*
	 * Before ','
	 *	Scan for '[' delimiter character
	 *	and set the delimiter pair.
	 * After ','
	 *	Scan for 'rdlm' and set indexed mode.
	 */
	ldlm = '(';	/* Default Delimiters */
	rdlm = ')';
	iflag = 0;	/* Default Non Indexed */
	p = ip;
	while (more()) {
		if ((c = getnb()) == '[') {
			ldlm = '[';	/* Bracket Delimiters */
			rdlm = ']';
		} else
		if (c == ',') {
			while (more()) {
				if (getnb() == rdlm) {
					iflag = 1;
				}
			}
		}
	}
	ip = p;


	if ((c = getnb()) == '#') {
		expr(esp, 0);
		esp->e_mode = S_IMMED;
	} else
	if (c == '*') {
		if (comma(0)) {
			switch(admode(axy)) {
			case S_X:
				esp->e_mode = S_DINDX;	/* ___  *,X */
				break;
			case S_Y:
				esp->e_mode = S_DINDY;	/* ___  *,Y */
				break;
			default:
				aerr();
				break;
			}
		} else {
			expr(esp, 0);
			esp->e_mode = S_DIR;	/* ___  *arg */
			if (more()) {
				comma(1);
				switch(admode(axy)) {
				case S_X:
					esp->e_mode = S_DINDX;	/* ___  *arg,X */
					break;
				case S_Y:
					esp->e_mode = S_DINDY;	/* ___  *arg,Y */
					break;
				default:
					aerr();
					break;
				}
			}
		}
	} else
	if ((c == ldlm) && iflag) {
		if ((c = getnb()) != '*') {
			unget(c);
		}
		if (comma(0)) {
			switch(admode(axy)) {
			case S_X:
				esp->e_mode = S_IPREX;	/* ___  (,X) */
				break;
			default:
				aerr();
				break;
			}
		} else {
			expr(esp, 0);
			comma(1);
			if (admode(axy) != S_X)
				qerr();		/* ___  (arg,Y)  Is Illegal */
			esp->e_mode = S_IPREX;	/* ___  (arg,X) */
		}
		if (getnb() != rdlm) {
			qerr();
		}
	} else {
		unget(c);
		/*
		 * Scan delimiters for addressing mode.
		 */
		p = ip;
		iflag = 0;
		if ((c = getnb()) == ldlm) {
			unget(c);
			while (more() && ((c = getnb()) != ',')) {
				if (c == rdlm) {
					dtyp = -1;
				} else
				if (c == ldlm) {
					dtyp = +1;
				} else {
					dtyp = 0;
				}
				if (dtyp != 0) {
					iflag += dtyp;
					if (iflag == 0) {
						if (more()) {
							if ((c = getnb()) == ',') {
								iflag = 1;
							}
						} else {
							iflag = 1;
						}
						break;
					}
				}
			}
		}
		ip = p;

		if (iflag == 1) {
			if ((c = getnb()) != ldlm)
				qerr();
			if ((c = getnb()) != '*')
				unget(c);
			expr(esp, 0);
			if ((c = getnb()) != rdlm)
				qerr();
			if (more()) {
				comma(1);
				if (admode(axy) != S_Y)
					qerr();		/* ___  (arg),X  Is Illegal */
				esp->e_mode = S_IPSTY;	/* ___  (arg),Y */
			} else {
				esp->e_mode = S_IND;	/* ___  (arg) */
			}
		} else {
			switch(admode(axy)) {
			case S_A:
				esp->e_mode = S_ACC;	/* ___  A */
				break;
			case S_X:	/* ___  X  Is Illegal */
			case S_Y:	/* ___  Y  Is Illegal */
				aerr();
				break;
			default:
				if (!more()) {
					esp->e_mode = S_ACC;	/* ___  BLANK  ->  ___  A */
				} else
				if (comma(0)) {
					switch(admode(axy)) {
					case S_X:	/* ___  ,X */
						esp->e_mode = espmode(esp, S_INDX);
						break;
					case S_Y:	/* ___  ,Y */
						esp->e_mode = espmode(esp, S_INDY);
						break;
					default:
						aerr();
						break;
					}
				} else {
					expr(esp, 0);
					if (more()) {
						comma(1);
						switch(admode(axy)) {
						case S_X:	/* ___  arg,X */
							esp->e_mode = espmode(esp, S_INDX);
							break;
						case S_Y:	/* ___  arg,Y */
							esp->e_mode = espmode(esp, S_INDY);
							break;
						default:
							aerr();
							break;
						}
						} else {	/* arg */
						esp->e_mode = espmode(esp, S_EXT);
					}
				}
			}
		}
	}
	return (esp->e_mode);
}

/*
 * Evaluate For Direct Mode
 *
 * Addressing Modes Must Be
 * Ordered From Long To Short:
 *
 *	S_EXT	+ 1	->	S_DIR
 *	S_INDX	+ 1	->	S_DINDX
 *	S_INDY	+ 1	->	S_DINDY
 */
int
espmode(esp, s)
struct expr *esp;
int s;
{
	int mode;

	/* Constants In Direct Page */
	if (autodpcnst
	    && (!esp->e_flag)
	    && (esp->e_base.e_ap == NULL)
	    && !(esp->e_addr & ~0xFF)) {
		mode = s + 1;
	} else
	/* Local Symbols In Direct Page */
	if (autodpsmbl
	    && (!esp->e_flag)
	    && (zpg != NULL)
	    && (esp->e_base.e_ap == zpg)) {
		mode = s + 1;
	} else
	/* External Symbols In Direct Page */
	if (autodpsmbl
	    && (esp->e_flag)
	    && (zpg != NULL)
	    && (esp->e_base.e_sp->s_area == zpg)) {
		mode = s + 1;
	} else {
		mode = s;
	}
	return(mode);
}

/*
 * When building a table that has variations of a common
 * symbol always start with the most complex symbol first.
 * for example if x, x+, and x++ are in the same table
 * the order should be x++, x+, and then x.  The search
 * order is then most to least complex.
 */

/*
 * When searching symbol tables that contain characters
 * not of type LTR16, eg with '-' or '+', always search
 * the more complex symbol tables first. For example:
 * searching for x+ will match the first part of x++,
 * a false match if the table with x+ is searched
 * before the table with x++.
 */

/*
 * Enter admode() to search a specific addressing mode table
 * for a match. Return the addressing value on a match or
 * zero for no match.
 */
int
admode(sp)
struct adsym *sp;
{
	char *ptr;
	int i;
	char *ips;

	ips = ip;
	unget(getnb());

	i = 0;
	while ( *(ptr = &sp[i].a_str[0]) ) {
		if (srch(ptr)) {
			return(sp[i].a_val);
		}
		i++;
	}
	ip = ips;
	return(0);
}

/*
 *      srch --- does string match ?
 */
int
srch(str)
char *str;
{
	char *ptr;
	ptr = ip;

	while (*ptr && *str) {
		if(ccase[*ptr & 0x007F] != ccase[*str & 0x007F])
			break;
		ptr++;
		str++;
	}
	if (ccase[*ptr & 0x007F] == ccase[*str & 0x007F]) {
		ip = ptr;
		return(1);
	}

	if (!*str)
		if (!(ctype[*ptr & 0x007F] & LTR16)) {
			ip = ptr;
			return(1);
		}
	return(0);
}

struct adsym	axy[] = {	/* a, x, or y registers */
    {	"a",	S_A	},
    {	"x",    S_X	},
    {	"y",    S_Y	},
    {	"",	0x00	}
};
