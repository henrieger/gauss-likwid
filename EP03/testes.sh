#!/bin/bash

#Executando comandos para poder utilizar o likwid
echo "performance" | sudo tee /sys/devices/system/cpu/cpufreq/policy3/scaling_governor

#Compilando programas
make avx
make geraSL
clear

#Rodando testes
for i in 10 32 50 64 100 128 200 250 256 300 400 512 600 1000 1024 2000 2048 3000 4096
do
    echo "Processando sistema de dimensão $i"
    ./geraSL "$i" > sistemas.txt
    likwid-perfctr -C 7 -g L3 -m ./gaussJacobi-likwid sistemas.txt > l3_${i}.txt
    likwid-perfctr -C 7 -g L2CACHE -m ./gaussJacobi-likwid sistemas.txt > l2cache_${i}.txt
    likwid-perfctr -C 7 -g FLOPS_DP -m ./gaussJacobi-likwid sistemas.txt > flops_dp_${i}.txt
    clear
done


#Encerrando
make purge
rm sistemas.txt
#rm l3*.txt
#rm l2*.txt
#rm flops*.txt

#Retornando para frequência original
clear
echo "Frequência do processador configurada para modo:"
echo "powersave" | sudo tee /sys/devices/system/cpu/cpufreq/policy3/scaling_governor 