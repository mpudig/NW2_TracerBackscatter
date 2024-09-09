#!/bin/bash

#SBATCH --nodes=4
#SBATCH --ntasks-per-node=48
#SBATCH --cpus-per-task=1
#SBATCH --mem=30GB
#SBATCH --time=96:00:00
#SBATCH --job-name=p0625_SpinUp
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err
#SBATCH --mail-type=END
#SBATCH --mail-user=mp6191@nyu.edu

## Set experiment name here
EXP_NAME=p0625_SpinUp

## Create an output directory /scratch/mp6191/NW2_TracerBackscatter/EXP_NAME and copy experiment files into it
rm -rf $SCRATCH/NW2_TracerBackscatter/$EXP_NAME
mkdir -p $SCRATCH/NW2_TracerBackscatter/$EXP_NAME
cd $SCRATCH/NW2_TracerBackscatter/$EXP_NAME
cp -r ~/NW2_TracerBackscatter/$EXP_NAME/* .

## Run the model
module purge
source ~/NeverWorld2/build/intel/env
srun ~/NeverWorld2/build/intel/ocean_only/repro/MOM6

## Copy slurm files
cp ~/NW2_TracerBackscatter/$EXP_NAME/RESTART/slurm* $SCRATCH/NW2_TracerBackscatter/$EXP_NAME/RESTART
