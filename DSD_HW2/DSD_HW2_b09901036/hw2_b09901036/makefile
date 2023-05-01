# CC and CFLAGS are varilables
CC = g++
# -c option ask g++ to compile the source files, but do not link.
# -g option is for debugging version
# -O2 option is for optimized version
OPTFLAGS = -g

all	: bin/mps

# optimized version
bin/mps	:
			$(CC) $(OPTFLAGS) src/mps.cpp -o bin/mps

# clean all the .o and executable files
clean:
		rm -rf *.o lib/*.a lib/*.o bin/*

