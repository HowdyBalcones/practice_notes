#!/usr/bin/perl
use strict;
use warnings;

#This is how you declare a variable
my $animal = "Tortoise";
my $answer = 42;



#Printing multiple variables
printf "$animal \n $answer \n"; 

#This is a comment
#Below is an array in perl
my @item = ("item1\n","item2\n","item3\n");

#This is referred to as an array slice
print "@item[0..2]";

print 'Hello World\n';
print "Hello World\n";

print "45454\n"; #numbers do not need quotes but do need a semicolon, this language is not forgiving on 
		 #if you want a newline though you'll have to place it within the double quotes		

print "Hello
World";

#here double quotes will interpret the newline, but not single quotes, notice the syntx highlight change

#a scalar represents a single value
my $animals = "Tortoises\n"; #as above

print "AAA a $animals\n";
print "The square of $answer is ", $answer * $answer, "\n";

#There are a number of perl specific scalars that can be called, they are documented within the perlvar
#For starters, the important one is $_ , also the "default variable"

