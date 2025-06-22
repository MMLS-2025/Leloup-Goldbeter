经过检查，发现之前模拟周期有问题是因为模拟得不够久（总之很快修好了

LG.m: LG model, original, without REV_ERBα

LG_light.m: LG model with v_sP square wave

period_peak.m: calculate period of Per mRNA when the simulation become stable (when to be stable need to be modified by yourself)

LG_fixed.mlx: how to use, standard plot examples

LG_full.m and LG_full_light.m: LG model (full)

LG2.mlx: test for full model



TODO:



adjust params to simulate diseases: FASPS, Non-24-hour sleep-wake syndrome, etc.



ablation experiments: 

**no PER protein:** set k_sP = 0; you may calculate period with other variables?

It is reported that set $m$ from 2 to 4 can reproduce oscillations.

**no BMAL1-Bmal1 negative feedback:** set K_IB = 100 nM

**add REV_ERBα:** you can find params in fig 8 (support information), and the model has been implemented. Please make some detailed analysis.



ELSE:

Why this model would generate oscillations? How to explain this mathematically? Any analysis can be done using mathematical approach?



NEXT:

multi-cell models