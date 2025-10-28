/* Name: Katrina Wilhelm
 *  Date: 10/26/2025
 *  CMSC 430 Project 1
 *  This file contains the function prototypes for the functions that produce
 *  the compilation listing
 */

enum ErrorCategories
{
	LEXICAL,
	SYNTAX,
	GENERAL_SEMANTIC,
	DUPLICATE_IDENTIFIER,
	UNDECLARED
};

void firstLine();
void nextLine();
int lastLine();
void appendError(ErrorCategories errorCategory, string message);
