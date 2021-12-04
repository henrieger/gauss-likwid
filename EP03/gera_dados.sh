#!/bin/bash

# Apaga os remanescentes de outras iterações
rm -f *.dat

# Procura e exporta dados nos arquivos de log do LIKWID
for i in 10 32 50 64 100 128 200 250 256 300 400 512 600 1000 1024 2000 2048 3000 4096
do
    TEMPO=$(grep 'Tempo' l3_$i.txt | cut -d' ' -f3)
    echo $i ${TEMPO[@]} >> tempo.dat

    L3=$(grep 'L3 bandwidth' l3_$i.txt | cut -d'|' -f3)
    echo $i ${L3[@]} >> l3.dat

    L2_CACHE=$(grep 'L2 miss ratio' l2cache_$i.txt | cut -d'|' -f3)
    echo $i ${L2_CACHE[@]} >> l2cache.dat

    FLOPS_DP=$(grep 'DP \[MFLOP/s\]' flops_dp_$i.txt | cut -d'|' -f3)
    echo $i ${FLOPS_DP[@]} >> flops_dp.dat
done