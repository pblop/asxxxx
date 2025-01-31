/* assubr.c */

/*
 *  Copyright (C) 1989-2022  Alan R. Baldwin
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

#include "asxxxx.h"

/*)Module	assubr.c
 *
 *	The module assubr.c contains the error
 *	processing routines.
 *
 *	assubr.c contains the following functions:
 *		VOID	aerr()
 *		VOID	diag()
 *		VOID	err()
 *		VOID	qerr()
 *		VOID	rerr()
 *		char *	geterr()
 *		VOID	xerr()
 *
 *	assubr.c contains the local array of *error[]
 */

/*)Function	VOID	err(c)
 *
 *		int	c		error type character
 *
 *	The legacy function err() reports errors using
 *	the default error descriptions by calling xerr()
 *	with a NULL string.
  *
 *	functions called:
 *		VOID	xerr()		assubr.c
 *
 *	side effects:
 *		The error code may be inserted into the
 *		error code array eb[].
 */

VOID
err(c)
int c;
{
	xerr(c, NULL);
}

/*)Function	VOID	xerr(c, str)
 *
 *		int	c		error type character
 *		char *	str		the error message string
 *
 *	The function xerr() logs the error code character
 *	suppressing duplicate errors.  If the error code
 *	is 'q' then the parse of the current assembler-source
 *	text line is terminated.
 *
 *	local variables:
 *		char *	p		pointer to the error array
 *
 *	global variables:
 *		int	aserr		error counter
 *		char	eb[]		array of generated error codes
 *		char *	ex[]		array of error string pointers
 *
 *	functions called:
 *		VOID	longjmp()	c_library
 *
 *	side effects:
 *		The error code may be inserted into the
 *		error code array eb[], a pointer to the
 *		optional error message inserted into the
 *		array ex[], or the parse terminated.
 */

VOID
xerr(c, str)
int c;
char *str;
{
	char *p;

	aserr++;
	p = eb;
	while (p < ep)
		if (*p++ == c)
			return;
	if (p < &eb[NERR]) {
		ex[(int) (p-eb)] = str;
		*p++ = c;
		ep = p;
	}
	if (c == 'q')
		longjmp(jump_env, -1);
}

/*)Function	VOID	diag()
 *
 *	The function diag() prints any error codes and
 *	the source line number to the stderr output device
 *	and to the listing file.
  *	
 *
 *	local variables:
 *		char *	p		pointer to error code array eb[]
 *		int	flag		set if not an internal error message
 *		FILE *	fp		output handle
 *
 *	global variables:
 *		char	eb[]		array of generated error codes
 *		char *	ep		pointer into error list
 *		char *	il		pointer to input line text
 *		int	kflag		disable output to .lst file
 *		int	incline		include file line number
 *		int	srcline		source file line number
 *		FILE *	stderr		console error output (c_library)
 *		FILE *	lfp		.lst file handle
 *
 *	functions called:
 *		int	fprintf()	c_library
 *		char *	geterr()	assubr.c
 *		int	getlnm()	assubr.c
 *		VOID	listhlr()	aslist.c
 *
 *	side effects:
 *		Error strings output to stderr and the
 *		listing file.
 */

VOID
diag()
{
	char *p,*errstr;
	FILE *fp;

	fp = stderr;
	while (fp != NULL) {
		if (eb != ep) {
			p = eb;
			fprintf(fp, "?ASxxxx-Error-<");
			while (p < ep) {
				fprintf(fp, "%c", *p);
				p++;
			}
			fprintf(fp, "> in line ");
			fprintf(fp, "%d", getlnm());
			fprintf(fp, " of %s\n", afn);
			if (fp == lfp) {
				listhlr(LIST_SRC, SLIST, 0);
			}
			p = eb;
			while (p < ep) {
				if ((p == eb) && (fp == stderr)) {
					fprintf(fp, "              <%c> '%d %s'\n", *p, getlnm(), il);
				}
				if ((ex[(int) (p-eb)] != NULL) && (*ex[(int) (p-eb)] != 0)) {
					fprintf(fp, "              <%c> %s\n", *p, ex[(int) (p-eb)]);
					if (fp == lfp) {
						listhlr(LIST_SRC, SLIST, 0);
					}
				} else
				if ((errstr = geterr(*p)) != NULL) {
					fprintf(fp, "              %s\n", errstr);
					if (fp == lfp) {
						listhlr(LIST_SRC, SLIST, 0);
					}
				}
				p++;
			}
		}
		if (fp == lfp) { fp = NULL; }
		if (fp == stderr) {
			if (kflag) {
				fp = NULL;
			} else {
				fp = lfp;
			}
		}
	}
}

/*)Functions:	VOID	aerr()
 *		VOID	qerr()
 *		VOID	rerr()
 *
 *	The functions aerr(), qerr(), and rerr() report their
 *	respective error type.  These are included only for
 *	convenience.
 *
 *	local variables:
 *		none
 *
 *	global variables:
 *		none
 *
 *	functions called:
 *		VOID	err()		assubr.c
 *
 *	side effects:
 *		The appropriate error code is inserted into the
 *		error array and the parse may be terminated.
 */

/*
 * Note an 'r' error.
 */
VOID
rerr()
{
	err('r');
}

/*
 * Note an 'a' error.
 */
VOID
aerr()
{
	err('a');
}

/*
 * Note a 'q' error.
 */
VOID
qerr()
{
	err('q');
}

/*
 * Default ASxxxx assembler errors
 */
char *errors[] = {
	"<.> use \". = . + <arg>\" not \". = <arg>\"",
	"<a> machine specific addressing or addressing mode error",
	"<b> address / direct page boundary error",
	"<c> .bndry offset error",
	"<d> direct page addressing error",
	"<e> .error/.assume programmed error",
	"<i> .include/.incbin file error or an .if/.endif mismatch",
	"<k> numerical conversion error",
	"<m> multiple definitions error or macro recursion error",
	"<n> .endm, .mexit, or .narg outside of a macro",
	"<o> .org in REL area or directive / mnemonic error",
	"<p> phase error: label location changing between passes 2 and 3",
	"<q> missing or improper operators, terminators, or delimiters",
	"<r> relocation error",
	"<s> string substitution / recursion error",
	"<u> undefined symbol encountered during assembly",
	"<v> out of range signed / unsigned value",
	"<z> divide by zero or mod of zero error",
	NULL
};
	
/*)Function:	char	*geterr(c)
 *
 *		int	c		the error code character
 *
 *	The function geterr() scans the list of errors returning the
 *	error string corresponding to the input error character.
 *
 *	local variables:
 *		int	i		error index counter
 *
 *	global variables:
 *		char	*errors[]	array of pointers to the
 *					error strings
 *
 *	functions called:
 *		none
 *
 *	side effects:
 *		A pointer to the appropriate
 *		error code string is returned.
 */
char *
geterr(c)
int c;
{
	int i;

	for (i=0; errors[i]!=NULL; i++) {
		if (c == errors[i][1]) {
			return(errors[i]);
		}
	}
	return(NULL);
}


