#include<stdio.h>
#include<stdlib.h>
#include<time.h>

#define filename "data.txt"

// use to get the random float
// and wrtie into data.txt

int main(){
	
    FILE * outputFile = fopen(filename,"w+");

    srand(time(NULL));

    for(int i=0;i<400;i++){
        for(int j=0;j<198;j++){
			float x = 9.9 * rand() / ( RAND_MAX + 1.0 ) + 1; 
            fprintf(outputFile,"%.3f",x);
            if(j!=197){
                fprintf(outputFile," ");
            }else{
                fprintf(outputFile,"\n");
            }
        }
    }

    fclose(outputFile);
}
