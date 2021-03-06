all: interface library gut

CC=g++
CCFLAGS=-DDEBUG -g -Wall
LIBS=-lgsl -lcblas -latlas -lm 

ofiles= gba.o

%.o:%.cpp
	$(CC) -c $(CCFLAGS) $<
	 
interface:
	swig -python -c++ GbA.i

library:
	g++ -fPIC $(FLAGS) -c  gba.cpp ;\
	g++ -fPIC  $(FLAGS) -c GbA_wrap.cxx -I/usr/include/python2.7;\
 	g++ -shared $(FLAGS) gba.o GbA_wrap.o -o _gba.so $(LIBS)

gut: $(ofiles)
	$(CC) $(CCFLAGS) -o gba main.cpp $(ofiles) $(LIBS)
	
clean:
	-rm *.o 