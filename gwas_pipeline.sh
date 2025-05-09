#!/bin/bash

# 1. 数据质控 (QC)
plink \
    --bfile raw_data \          # 输入PLINK二进制格式文件
    --maf 0.05 \                # 过滤次要等位基因频率 <5%
    --mind 0.1 \                # 过滤样本缺失率 >10%
    --geno 0.1 \                # 过滤SNP缺失率 >10%
    --hwe 1e-6 \                # 过滤哈迪-温伯格平衡检验p值 <1e-6
    --make-bed \                # 输出处理后的二进制文件
    --out clean_data

# 2. 群体结构分析 (PCA)
gcta64 \                        # 使用GCTA计算遗传关系矩阵(GRM)
    --bfile clean_data \
    --make-grm \
    --out grm_matrix

gcta64 \                        # 进行PCA分析
    --grm grm_matrix \
    --pca 20 \                  # 提取前20个主成分
    --out pca_result

# 3. 关联分析 (以线性模型为例)
plink \
    --bfile clean_data \
    --linear \                  # 线性回归模型（数量性状）
    --covar pca_result.eigenvec \ # 加入PCA结果作为协变量
    --adjust \                  # 多重检验校正
    --out gwas_results

# 使用GEMMA进行混合线性模型
gemma \
    -bfile clean_data \
    -gk 1 \                     # 生成Kinship矩阵
    -o kinship_matrix

gemma \
    -bfile clean_data \
    -k kinship_matrix.sXX.txt \ # 使用Kinship矩阵
    -lmm 1 \                    # 混合线性模型
    -c pca_result.eigenvec \    # 协变量文件
    -o gemma_results

# 4. 结果可视化（R脚本）
Rscript plot_gwas.R gwas_results.assoc