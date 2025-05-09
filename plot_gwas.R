#!/usr/bin/env Rscript
args <- commandArgs(trailingOnly=TRUE)
library(qqman)

# 读取关联分析结果
gwas <- read.table(args[1], header=TRUE)

# 生成曼哈顿图
png("manhattan.png", width=1000, height=400)
manhattan(gwas, chr="CHR", bp="BP", p="P", snp="SNP")
dev.off()

# 生成QQ图
png("qqplot.png", width=600, height=600)
qq(gwas$P)
dev.off()