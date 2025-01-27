#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=1
#SBATCH --mem=8GB
#SBATCH --time=00:2:00
#SBATCH --job-name=p5_noBS_KHTR0_dye
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err
#SBATCH --mail-type=END
#SBATCH --mail-user=mp6191@nyu.edu

## Set experiment name here
EXP_NAME=p5_noBS_KHTR0_dye

## Create an output directory /scratch/mp6191/NW2_TracerBackscatter/EXP_NAME and copy experiment files into it
rm -rf $SCRATCH/NW2_TracerBackscatter/$EXP_NAME
mkdir -p $SCRATCH/NW2_TracerBackscatter/$EXP_NAME
cd $SCRATCH/NW2_TracerBackscatter/$EXP_NAME
cp -r ~/NW2_TracerBackscatter/$EXP_NAME/* .
mv $SCRATCH/NW2_TracerBackscatter/$EXP_NAME/INPUT/MOM.res.dye.nc $SCRATCH/NW2_TracerBackscatter/$EXP_NAME/INPUT/MOM.res.nc

## Run the model
module purge
source ~/NeverWorld2/build/intel/env
srun ~/NeverWorld2/build/intel/ocean_only/repro/MOM6

## Copy slurm files
cp ~/NW2_TracerBackscatter/$EXP_NAME/RESTART/slurm* $SCRATCH/NW2_TracerBackscatter/$EXP_NAME/RESTART
