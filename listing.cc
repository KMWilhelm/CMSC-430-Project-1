// CMSC 430 Compiler Theory and Design
// Project 1 Skeleton
// UMGC CITE
// Summer 2023

// This file contains the bodies of the functions that produces the
// compilation listing

#include <cstdio>
#include <string>
#include <queue>

using namespace std;

#include "listing.h"

static int lineNumber;
static string error = "";
// 0 lexical, 1 syntax, 2 semantic
static int totalErrors[] = {0, 0, 0};
static queue<string> errorQueue;

static void displayErrors();

void firstLine()
{
	lineNumber = 1;
	printf("\n%4d  ", lineNumber);
}

void nextLine()
{
	displayErrors();
	lineNumber++;
	printf("%4d  ", lineNumber);
}

int lastLine()
{
	printf("\r");
	displayErrors();
	printf("     \n");
	// Calculate total number of errors
	int errors = totalErrors[0] + totalErrors[1] + totalErrors[2];

	if (errors > 0)
	{
		printf("Lexical errors: %d\n", totalErrors[0]);
		printf("Syntax errors: %d\n", totalErrors[1]);
		printf("Semantic errors: %d\n", totalErrors[2]);
	}
	else
	{
		printf("Compiled Successfully\n");
	}
	return errors;
}

void appendError(ErrorCategories errorCategory, string message)
{
	string messages[] = {"Lexical Error, Invalid Character ", "",
						 "Semantic Error, ", "Semantic Error, Duplicate ",
						 "Semantic Error, Undeclared "};

	// Add error message to queue
	errorQueue.push(messages[errorCategory] + message);

	// Count the error by type
	if (errorCategory == LEXICAL)
		totalErrors[0]++;
	else if (errorCategory == SYNTAX)
		totalErrors[1]++;
	else
		totalErrors[2]++;
}

void displayErrors()
{
	// Display queue errors for this line
	while (!errorQueue.empty())
	{
		printf("%s\n", errorQueue.front().c_str());
		errorQueue.pop();
	}
}
