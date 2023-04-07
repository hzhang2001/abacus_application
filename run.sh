#!/bin/bash

rm -r np

#4. np
mkdir np_24
cd np_24
echo -e "np \t \t E_tot(eV)" >> E_tot_np.txt
echo -e "np \t \t time(s)" >> t_tot_np.txt
for np in $(seq 8 4 64)
do
       	mkdir $np
	cp ../INPUT ../STRU ../KPT $np
	cd $np
    mpirun -np $np abacus  > log.txt
	dt=`grep 'HSolverPW' log.txt | awk '{print $3}'`
	cd ..
	e=`grep 'FINAL' $np/OUT.Al/running_scf.log | awk '{print $2}'`
	echo -e "$np \t \t$e">> E_tot_np.txt
	echo -e "$np \t \t$dt">> t_tot_np.txt
done
cd ..