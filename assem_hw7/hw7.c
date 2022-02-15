#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define inputFileName "data.txt"
#define outputFileName "output.txt"

float inputNum[400][198];

float resultNum[200];

//use to count the difference of time
struct timespec diff(struct timespec start, struct timespec end) {

    struct timespec tmp;
    if ((end.tv_nsec-start.tv_nsec)<0) {
        tmp.tv_sec = end.tv_sec-start.tv_sec-1;
        tmp.tv_nsec = 1000000000+end.tv_nsec-start.tv_nsec;
    }else {
        tmp.tv_sec = end.tv_sec-start.tv_sec;
        tmp.tv_nsec = end.tv_nsec-start.tv_nsec;
    }
    return tmp;
}

int main(){

	// There are three types of time need to count
    struct timespec begin_time, end_time, readTime, compTime, writeTime;

    // File io
    FILE * inputFile = fopen(inputFileName,"r+");
    FILE * outputFile = fopen(outputFileName,"w+");

    // Count read time
    clock_gettime(CLOCK_MONOTONIC, &begin_time);
    // Read the file into array using fscanf()
    for(int i=0;i<400;i++){
        for(int j=0;j<198;j++){
            fscanf(inputFile,"%f ",&inputNum[i][j]);
        }
    }
    // Count end
    clock_gettime(CLOCK_MONOTONIC, &end_time);
    readTime = diff(begin_time,end_time);

    // Count compute time
    clock_gettime(CLOCK_MONOTONIC, &begin_time);
    // Compute the result
    for(int i=0;i<200;i++){
        float sum = 0;
        for(int j=0;j<200;j++){
            for(int k=0;k<198;k++){
                sum += inputNum[i][k] * inputNum[200+j][k];
            }
        }
        resultNum[i]=sum;
    }
    // Count end
    clock_gettime(CLOCK_MONOTONIC, &end_time);
    compTime = diff(begin_time,end_time);

    // Count write time
    clock_gettime(CLOCK_MONOTONIC, &begin_time);
	// Write the file using fprintf()
    for(int i=0;i<200;i++){
        fprintf(outputFile,"%f\n",resultNum[i]);
    }
    // Count end
    clock_gettime(CLOCK_MONOTONIC, &end_time);
    writeTime = diff(begin_time,end_time);

    // Write all time into the file
    fprintf(outputFile,"C readTime: %f\n", readTime.tv_sec + (float) readTime.tv_nsec / 1000000000.0);
    fprintf(outputFile,"C compTime: %f\n", compTime.tv_sec + (float) compTime.tv_nsec / 1000000000.0);
    fprintf(outputFile,"C writeTime: %f\n", writeTime.tv_sec + (float) writeTime.tv_nsec / 1000000000.0);

    //file close
    fclose(inputFile);
    fclose(outputFile);

    return 0;
}
