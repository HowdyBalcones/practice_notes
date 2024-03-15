print "Enter a temperature:\n";
$input = <STDIN>; #this reads one line from the user
chomp($input); #This removes the newline from $input

if ($input =~ m/^([-+.]?[0-9]+(?:\.[0-9]*)?)\s*([CF])$/i) {
#once inside the regex, the input has matched
$InputNum = $1; #saving positional variables so the program is easier to read
$type =     $2; #this is the variable for [CF]

if ($type eq "C" or $type eq "c") { #eq tests if the string $type is equal to C
#the input here is celsius only, so we are calculating fahrenheit
$celsius = $InputNum;
$fahrenheit = ($celsius * 9 / 5) + 32;

} else {
#if it didn't match celsius, the input should be fahrenheit so calc celsius 
$fahrenheit = $InputNum;
$celsius = ($fahrenheit - 32) * 5 / 9;
}
#At this point we have both temps so we can display the result
printf "%.3f C is %.3f F\n", $celsius, $fahrenheit;
} else {
print "Expecting a number followed by \"C\" or \"F\", \n";
print "so I don't understand \"$input\".\n";
}
