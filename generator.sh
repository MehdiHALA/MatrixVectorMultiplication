for var in 2 4 8 10 15 20
do
    echo $var
    export OMP_NUM_THREADS=$var
    ./ttmatvec -a ttmat.bin -x ttvec.bin -y ttmul.bin | grep -oP '.{0,13}seconds' | cut -d ' ' -f 1
  done
