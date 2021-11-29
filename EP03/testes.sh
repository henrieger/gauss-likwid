#!/bin/bash

#Compilando programas
make
make geraSL

#Rodando testes
for i in 10 32 50 64 100 128 200 250 256 300 400 512 600 1000 1024 2000 2048 3000 4096
do
    ./geraSL "$i" > sistemas.txt
    ./gaussjacobi sistemas.txt
    #adicionar -m no comando acima
done

#Encerrando
make purge
rm gaussjacobi
rm sistemas.txt