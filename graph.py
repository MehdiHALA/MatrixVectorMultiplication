import matplotlib.pyplot as plt
import sys

def time_to_perf(time, N=1024, R=8):
    return N*N*R*R*R*R/time*1e-9

def main():
    args = sys.argv[1:]
    if (len(args) != 3):
        N = 1024
        R = 8
        print("Number of args is not 3! N is set to 1024 and R to 8. Please reexecute with python3 graph.py file N R")
    f = open(args[0], "r")
    N = args[1]
    R = args[2]

    x = []
    y = []

    v = f.readline()
    while (v):
        x.append(int(v))
        y.append(float(f.readline()))
        v = f.readline()
    y = list(map(time_to_perf, y))

    plt.plot(x,y)
    plt.title("Performance in Gflops of our MatVecMul")
    plt.xlabel("Number of threads")
    plt.ylabel("GFlop/s")
    plt.savefig('plot_perf.png')
    plt.close()

if __name__ == "__main__":
        main()
