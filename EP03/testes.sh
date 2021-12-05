#!/bin/bash

# Checagem de argumentos opcionais
THREAD=3
re="^[0-9]+$"
if [[ -n $1 ]] ; then
    if [[ $1 == "-C" ]] ; then
        if [[ -z $2 ]] ; then
            echo "Erro: opção -C precisa de um argumento válido" >&2
            exit 1
        elif ! [[ $2 =~ $re ]] ; then
            echo "Erro: opção -C precisa de um argumento inteiro" >&2
            exit 1
        else
            THREAD=$2
        fi
    elif [[ $1 == "-h" ]] || [[ $1 == "--help" ]]; then
        echo "teste.sh: Testa o programa gaussJacobi-likwid e gera gráficos com resultados"
        echo "Opções:"
        echo -e "\t-C [THREAD]: seleciona a thread para rodar os testes. Padrão: 3"
        echo -e "\t-h --help: Imprime esta mensagem de ajuda"
        exit 0
    else
        echo "Erro: opção inválida. Use --help para uma lista de opções válidas." >&2
        exit 1
    fi
fi

# Executando comandos para poder utilizar o likwid
echo "performance" | sudo tee /sys/devices/system/cpu/cpufreq/policy3/scaling_governor

#Compilando programas
make avx
make geraSL
clear

# Rodando testes
for i in 10 32 50 64 100 128 200 250 256 300 400 512 600 1000 1024 2000 2048 3000 4096
do
    echo "Processando sistema de dimensão $i"
    ./geraSL "$i" > sistemas.txt
    likwid-perfctr -C $THREAD -g L3 -m ./gaussJacobi-likwid sistemas.txt > l3_${i}.txt
    likwid-perfctr -C $THREAD -g L2CACHE -m ./gaussJacobi-likwid sistemas.txt > l2cache_${i}.txt
    likwid-perfctr -C $THREAD -g FLOPS_DP -m ./gaussJacobi-likwid sistemas.txt > flops_dp_${i}.txt
    clear
done

# Gerando arquivos .dat
echo "Gerando arquivos de dados"
./gera_dados.sh
clear

# Limpando arquivos temporários
make purge
rm sistemas.txt
rm l3*.txt
rm l2*.txt
rm flops*.txt

# Gerando gráficos
echo "Gerando gráficos"
gnuplot ./plot_dados.gp
rm *.dat
clear

# Retornando para frequência original
clear
echo "Frequência do processador configurada para modo:"
echo "powersave" | sudo tee /sys/devices/system/cpu/cpufreq/policy3/scaling_governor 