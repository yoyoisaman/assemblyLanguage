#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

// AVX
#include <immintrin.h> 

#define inputFileName "data.txt"
#define outputFileName "outputSIMD.txt"

// Count the different of the time
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

int main(int argc, const char * argv[]){

    struct timespec begin_time, end_time, readTime, compTime, writeTime;

    // File io
    FILE * inputFile = fopen(inputFileName,"r+");
    FILE * outputFile = fopen(outputFileName,"w+");



    // For Float, Aligned should 32 bits

    float inputNum[400][200] __attribute__((aligned(32)));
    float tmpMulArray[8] __attribute__((aligned(32)));
    float tmpSumArray[8] __attribute__((aligned(32)));
    float resultNum[200]  __attribute__((aligned(32)));

    __m256 *tmp1, *tmp2;
 
    // Count the time of Reading the Input File from Data
    clock_gettime(CLOCK_MONOTONIC, &begin_time);
    for (int i = 0; i < 400; i++) {
        for (int j = 0; j < 200; j++) {
			// 198 cant divide by 8,So padding the last two elements
			if(j>197){
				inputNum[i][j] = 0;
				continue;
			}
            fscanf(inputFile,"%f", &inputNum[i][j]);
        }
    }
    clock_gettime(CLOCK_MONOTONIC, &end_time);
    readTime = diff(begin_time,end_time);
	// Finished Read

	// Count the time of Computing
    clock_gettime(CLOCK_MONOTONIC, &begin_time);

	// Compute by AVX instruction 
    for (int i = 0; i < 200; i++) {

        __m256 *tmpSum = (__m256 *) tmpSumArray;

        for (int j = 0; j < 200; j++) {

            tmp1 = (__m256 *) inputNum[i];
            tmp2 = (__m256 *) inputNum[j+200];

			// 256 / 32 = 8, So it can compute 8 float at once
			// So we need to compute 200(After padding)/ 8 = 25 times 
            for (int k = 0; k < 25 ; k++) {
                __m256 *tmpMul = (__m256 *) tmpMulArray;
				// For explaining those  _mm256 usage
				// Please go to:https//software.intel.com/sites/landingpage/IntrinsicsGuide/#/
                *tmpMul = _mm256_mul_ps(tmp1[k], tmp2[k]);
                *tmpSum = _mm256_add_ps(*tmpMul, *tmpSum);
            }
        }
		// Sum all the float
		for(int k = 0; k < 8; k++){
			resultNum[i] += tmpSumArray[k];
		}
        memset(tmpSumArray, 0, sizeof(tmpSumArray));
    }
    clock_gettime(CLOCK_MONOTONIC, &end_time);
    compTime = diff(begin_time,end_time);
	// Finished Compute

    // Count write time
    clock_gettime(CLOCK_MONOTONIC, &begin_time);
    for(int i=0;i<200;i++){
        fprintf(outputFile,"%f\n",resultNum[i]);
    }
    clock_gettime(CLOCK_MONOTONIC, &end_time);
    writeTime = diff(begin_time,end_time);
	// Count end

	// Write all three times into file 
    fprintf(outputFile,"SIMD readTime: %f\n", readTime.tv_sec + (float) readTime.tv_nsec / 1000000000.0);
    fprintf(outputFile,"SIMD compTime: %f\n", compTime.tv_sec + (float) compTime.tv_nsec / 1000000000.0);
    fprintf(outputFile,"SIMD writeTime: %f\n", writeTime.tv_sec + (float) writeTime.tv_nsec / 1000000000.0);

    return 0;
}
