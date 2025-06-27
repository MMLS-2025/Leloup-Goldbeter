# Leloup-Goldbeter

LG.m: LG model, original, without REV_ERBα

LG_light.m: LG model with v_sP square wave

period_peak.m: calculate period of Per mRNA when the simulation become stable (when to be stable need to be modified by yourself)

LG_fixed.mlx: how to use, standard plot examples, and no PER protein version.

LG_full.m and LG_full_light.m: LG model (full)

LG2.mlx: test for full model

LG_fixed_no24.mlx: modify params to simulate disease

Lyapunov.m, Nullcline.m, Hopf.m are all mathematical analysis

# VIP Multi-cell

spatial_weight.m: 计算网格上各细胞权重

calculate_eps.m: 计算权重的归一化值

init_params.m: 初始化每个细胞的参数，对k1~k8扰动

init_pre_params.m: 初始化所有方程需要用到的参数

init_v_sP0.m: 初始化每个细胞的v_sP0，进行扰动

init_y.m: 初始化所有方程的y的初始值

LG_VIP.m: 每个细胞的方程

LG_VIP_total.m: 完整模型方程

LG_VIP_simulate.mlx: 模拟脚本

SI.m: 计算synchronization index

R.m: 计算order parameter
