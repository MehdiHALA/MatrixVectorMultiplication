CPP_FLAGS=-O3 -march=native -mtune=native -std=c++11 -fopenmp -mavx

.PHONY:all
all: create-ttmat create-ttvec compare-ttvec ttmatvec ttmatvec-omp ttmatvec-task
necessary : create-ttmat create-ttvec compare-ttvec ttmatvec

ttmatvec: ttmatvec.cpp ttmat.cpp ttmat.h ttvec.cpp ttvec.h
	g++ ${CPP_FLAGS} ttmatvec.cpp ttmat.cpp ttvec.cpp -lm -o ttmatvec

ttmatvec-omp: ttmatvec.cpp ttmat_omp.cpp ttmat.h ttvec.cpp ttvec.h
	g++ ${CPP_FLAGS} ttmatvec.cpp ttmat_omp.cpp ttvec.cpp -lm -o ttmatvec

ttmatvec-task: ttmatvec.cpp ttmat_task.cpp ttmat.h ttvec.cpp ttvec.h
	g++ ${CPP_FLAGS} ttmatvec.cpp ttmat_task.cpp ttvec.cpp -lm -o ttmatvec

create-ttmat: create-ttmat.cpp
	g++ ${CPP_FLAGS} create-ttmat.cpp -o create-ttmat

create-ttvec: create-ttvec.cpp
	g++ ${CPP_FLAGS} create-ttvec.cpp -o create-ttvec

compare-ttvec: compare-ttvec.cpp ttvec.cpp
	g++ ${CPP_FLAGS} compare-ttvec.cpp ttvec.cpp -lm -o compare-ttvec

perf: ttmatvec.cpp ttmat.cpp ttmat_omp.cpp ttmat_task.cpp ttmat.h ttvec.cpp ttvec.h
	make ttmatvec
	./generator.sh > seq.txt
	make ttmatvec-omp
	./generator.sh > omp.txt
	make ttmatvec-task
	./generator.sh > task.txt


NB_THREADS = 20
N = 1024
n = 256
R = 8

init-small:
	./create-ttmat -f ttmat.bin -d 3 -m $(n),$(n),$(n) -n $(n),$(n),$(n) -r $(R),$(R)
	./create-ttvec -f ttvec.bin -d 3 -m $(n),$(n),$(n) -r $(R),$(R)

init:
	./create-ttmat -f ttmat.bin -d 3 -m $(N),$(N),$(N) -n $(N),$(N),$(N) -r $(R),$(R)
	./create-ttvec -f ttvec.bin -d 3 -m $(N),$(N),$(N) -r $(R),$(R)


clean:
	rm -f ttmatvec create-ttmat create-ttvec compare-ttvec *.bin
	export OMP_NUM_THREADS=$(NB_THREADS)
