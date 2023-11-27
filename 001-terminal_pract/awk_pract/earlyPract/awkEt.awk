#!/bin/bash
# awkEt -- assign shell's $1 to awk search variable
# '$1 == search' -- matches each record in the first field against search
# $1=search assigns the first argument from the command line to search 
#
awk '$1 == search' search=$1 acronyms
