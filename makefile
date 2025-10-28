# Name: Katrina Wilhelm
# Date: 10/26/2025
# CMSC 430 Project 1
# This file contains the makefile and will compile the project

compile: scanner.o listing.o
	g++ -o compile scanner.o listing.o
	
scanner.o: scanner.c listing.h tokens.h
	g++ -c scanner.c

scanner.c: scanner.l
	flex scanner.l
	mv lex.yy.c scanner.c

listing.o: listing.cc listing.h
	g++ -c listing.cc
