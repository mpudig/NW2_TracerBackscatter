#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=42
#SBATCH --cpus-per-task=1
#SBATCH --mem=16GB
#SBATCH --time=12:00:00
#SBATCH --job-name=SQG_testing1
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err
#SBATCH --mail-type=END
#SBATCH --mail-user=mp6191@nyu.edu

## Set experiment name here
EXP_NAME=p5_SQG_testing1

## Create an output directory /scratch/mp6191/NW2_TracerBackscatter/EXP_NAME and copy experiment files into it
rm -rf $SCRATCH/NW2_TracerBackscatter/p5_SQG_testing/$EXP_NAME
mkdir -p $SCRATCH/NW2_TracerBackscatter/p5_SQG_testing/$EXP_NAME
cd $SCRATCH/NW2_TracerBackscatter/p5_SQG_testing/$EXP_NAME
cp -r ~/NW2_TracerBackscatter/p5_SQG_testing/$EXP_NAME/* .
cp $SCRATCH/NW2_TracerBackscatter/p5_EBTBS_KHTR0/RESTART/MOM.res.nc $SCRATCH/NW2_TracerBackscatter/p5_SQG_testing/$EXP_NAME/INPUT

## Run the model
module purge
source ~/NeverWorld2/build/intel/env
srun ~/NeverWorld2/build/intel/ocean_only/repro/MOM6

## Copy slurm files
cp ~/NW2_TracerBackscatter/p5_SQG_testing/$EXP_NAME/RESTART/slurm* $SCRATCH/NW2_TracerBackscatter/p5_SQG_testing/$EXP_NAME/RESTART
