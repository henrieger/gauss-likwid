# Configurações gerais
set terminal pngcairo size 1024,512
set xlabel "N"

# Gráfico de L3
set output "l3.png"
set title "Largura de Banda de L3"
set ylabel "bandwidth [MBytes/s]"
plot "l3.dat" using 2:xticlabels(1) title "gaussJacobi" lt 7 lc 7 w lp , \
     "l3.dat" using 3:xticlabels(1) title "gaussJacobiOpt" lc 6 lt 7 w lp

# Gráfico de L2 miss ratio
set output "l2cache.png"
set title "Razão de cache miss de L2"
set ylabel "L2 cache miss ratio"
plot "l2cache.dat" using 2:xticlabels(1) title "gaussJacobi" lc 7 lt 7 w lp , \
     "l2cache.dat" using 3:xticlabels(1) title "gaussJacobiOpt" lc 6 lt 7 w lp

# Gráfico de FLOPS_DP e FLOPS_AVX
set output "flops_dp.png"
set title "Número de Operações de Ponto Flutuante"
set ylabel "MFLOP/s"
plot "flops_dp.dat" using 2:xticlabels(1) title "gaussJacobi DP" lc 7 lt 7 w lp , \
     "flops_dp.dat" using 3:xticlabels(1) title "gaussJacobi AVX" lc 7 lt 7 dt 2 w lp , \
     "flops_dp.dat" using 4:xticlabels(1) title "gaussJacobiOpt DP" lc 6 lt 7 w lp , \
     "flops_dp.dat" using 5:xticlabels(1) title "gaussJacobiOpt AVX" lc 6 lt 7 dt 2 w lp

# Gráfico de tempo
set output "tempo.png"
set title "Tempo de Execução das Funções"
set ylabel "tempo [ms]"
set logscale y
plot "tempo.dat" using 2:xticlabels(1) title "gaussJacobi" lc 7 lt 7 w lp , \
     "tempo.dat" using 3:xticlabels(1) title "gaussJacobiOpt" lc 6 lt 7 w lp
