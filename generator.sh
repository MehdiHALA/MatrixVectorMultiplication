for var in 2 4 8 10 15 20
do
    echo $var
    export OMP_NUM_THREADS=$var
    ./ttmatvec -a ttmat.bin -x ttvec.bin -y ttmul.bindone
  done
