PATH=~/assembly/arm-tool-20.4/bin/
all: hw4_test.s numsort.s
	$(PATH)/arm-none-eabi-gcc -g hw4_test.s numsort.s -o hw4.exe
gbd:
	$(PATH)/arm-none-eabi-insight
clean:
	rm -f hw4.exe

