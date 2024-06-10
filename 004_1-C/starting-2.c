#include <stdio.h>
#include <stdlib.h>

int main() {
	char character = 'J';
	char characterName[] = "Johnny Boy";
	int characterAge = 35;
	int dadsAge;
	double yourMomsAge = 69.69;
	
	printf("%f is how old %c, your MOM, is.\n", yourMomsAge, character);
	printf("%s is a young lad of %d years.\n", characterName, characterAge );
	printf("Enter your Dads age: \n");
	scanf("%d", &dadsAge);
	printf("So your dad is %d years old?\n", dadsAge);
	return 0;
}
