#!/bin/bash

#SBATCH --nodes=44
#SBATCH --ntasks-per-node=36
#SBATCH --cpus-per-task=1
#SBATCH --mem=30GB
#SBATCH --time=24:00:00
#SBATCH --job-name=p03125
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err
#SBATCH --mail-type=END
#SBATCH --mail-user=mp6191@nyu.edu

## Set experiment name here
EXP_NAME=p03125

## Create an output directory /scratch/mp6191/NW2_TracerBackscatter/EXP_NAME and copy experiment files into it
rm -rf $SCRATCH/NW2_TracerBackscatter/$EXP_NAME
mkdir -p $SCRATCH/NW2_TracerBackscatter/$EXP_NAME
cd $SCRATCH/NW2_TracerBackscatter/$EXP_NAME
cp -r ~/NW2_TracerBackscatter/$EXP_NAME/* .

cp $SCRATCH/NW2_TracerBackscatter/p03125_SpinUp/RESTART/MOM.res.nc INPUT
cp $SCRATCH/NW2_TracerBackscatter/p03125_SpinUp/RESTART/MOM.res_1.nc INPUT
cp $SCRATCH/NW2_TracerBackscatter/p03125_SpinUp/RESTART/MOM.res_2.nc INPUT
cp $SCRATCH/NW2_TracerBackscatter/p03125_SpinUp/RESTART/MOM.res_3.nc INPUT
cp $SCRATCH/NW2_TracerBackscatter/p03125_SpinUp/RESTART/MOM.res_4.nc INPUT

## Run the model
module purge
source ~/NeverWorld2/build/intel/env
srun ~/NeverWorld2/build/intel/ocean_only/repro/MOM6

## Copy slurm files
cp ~/NW2_TracerBackscatter/$EXP_NAME/RESTART/slurm* $SCRATCH/NW2_TracerBackscatter/$EXP_NAME/RESTART
