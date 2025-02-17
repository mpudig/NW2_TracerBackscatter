#!/bin/bash

#SBATCH --nodes=3
#SBATCH --ntasks-per-node=42
#SBATCH --cpus-per-task=1
#SBATCH --mem=15GB
#SBATCH --time=8:00:00
#SBATCH --job-name=p25_SQG_testing1
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err
#SBATCH --mail-type=END
#SBATCH --mail-user=mp6191@nyu.edu

## Set experiment name here
EXP_NAME=p25_SQG_testing1

## Create an output directory /scratch/mp6191/NW2_TracerBackscatter/EXP_NAME and copy experiment files into it
rm -rf $SCRATCH/NW2_TracerBackscatter/p25_SQG_testing/$EXP_NAME
mkdir -p $SCRATCH/NW2_TracerBackscatter/p25_SQG_testing/$EXP_NAME
cd $SCRATCH/NW2_TracerBackscatter/p25_SQG_testing/$EXP_NAME
cp -r ~/NW2_TracerBackscatter/p25_SQG_testing/$EXP_NAME/* .
cp ~/NW2_TracerBackscatter/p25_SQG_testing/p25_SQGBS_interp_IC_thickness.nc INPUT/

## Run the model
module purge
source ~/NeverWorld2/build/intel/env
srun ~/NeverWorld2/build/intel/ocean_only/repro/MOM6

## Copy slurm files
cp ~/NW2_TracerBackscatter/p25_SQG_testing/$EXP_NAME/RESTART/slurm* $SCRATCH/NW2_TracerBackscatter/p25_SQG_testing/$EXP_NAME/RESTART
