# GWAS_WORKFLOW
# GWAS全基因组关联分析流程

## 目录
- [简介](#简介)
- [准备工作](#准备工作)
  - [软件安装](#软件安装)
  - [数据格式](#数据格式)
- [分析流程](#分析流程)
  - [1. 数据质控](#1-数据质控)
  - [2. 群体结构分析](#2-群体结构分析)
  - [3. 关联分析](#3-关联分析)
  - [4. 结果可视化](#4-结果可视化)
- [示例代码](#示例代码)
- [注意事项](#注意事项)

---

## 简介
基于PLINK/GCTA/GEMMA的GWAS标准分析流程，包含数据质控、群体分层校正、关联分析和结果可视化。

---

## 准备工作

### 软件安装
| 软件         | 功能                     | 安装方式                                                                 |
|--------------|--------------------------|--------------------------------------------------------------------------|
| PLINK 1.9/2.0 | 数据质控、基础关联分析   | `conda install -c bioconda plink` 或 [官网下载](https://www.cog-genomics.org/plink/) |
| GCTA         | 遗传关系矩阵/PCA分析     | [官网下载](https://yanglab.westlake.edu.cn/software/gcta/)               |
| GEMMA        | 混合线性模型分析         | `conda install -c bioconda gemma` 或 [GitHub](https://github.com/genetics-statistics/GEMMA) |
| R + qqman    | 可视化                   | `install.packages("qqman")`                                              |

### 数据格式
- **输入文件**: PLINK二进制格式 (`*.bed`, `*.bim`, `*.fam`)
- **示例数据**:
  ```bash
  wget http://example.com/hapmap_data.zip
  unzip hapmap_data.zip
  plink --file hapmap_data --make-bed --out raw_data
