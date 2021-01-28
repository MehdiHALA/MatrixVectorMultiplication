import matplotlib.pyplot as plt
import sys

def time_to_perf(time, N=1024, R=8):
    return N*N*R*R*R*R/time*1e-9

def dump(file1, file2):
    file1.readline()
    file2.readline()
    return

def main():
    args = sys.argv[1:]
    if (len(args) != 2):
        N = 1024
        R = 8
        print("Number of args is not 2! N is set to 1024 and R to 8. Please reexecute with python3 graph.py N R")
    seq = open("seq.txt", "r")
    omp = open("omp.txt", "r")
    task = open("task.txt", "r")

    N = args[0]
    R = args[1]

    x = []
    s = []
    o = []
    t = []

    v = seq.readline()
    dump(omp, task)
    while (v):
        x.append(int(v))
        s.append(float(seq.readline()))
        o.append(float(omp.readline()))
        t.append(float(task.readline()))
        v = seq.readline()
        dump(omp, task)
    s = list(map(time_to_perf, s))
    o = list(map(time_to_perf, o))
    t = list(map(time_to_perf, t))


    plt.plot(x,s, color='green', label="seq")
    plt.plot(x,o, color='blue', label="omp")
    plt.plot(x,t, color='red', label="task")

    plt.title("Performance in Gflops of our MatVecMul")
    plt.xlabel("Number of threads")
    plt.ylabel("GFlop/s")
    plt.legend()
    plt.savefig('plot_perf.png')
    plt.close()

if __name__ == "__main__":
        main()
