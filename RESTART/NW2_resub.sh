#!/bin/bash

#SBATCH --nodes=3
#SBATCH --ntasks-per-node=42
#SBATCH --cpus-per-task=1
#SBATCH --mem=16GB
#SBATCH --time=12:00:00
#SBATCH --job-name=p25_SQG_testing1
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err
#SBATCH --mail-type=END
#SBATCH --mail-user=mp6191@nyu.edu

## Set experiment name here
EXP_NAME=p25_SQG_testing1

## Copy restart file from RESTART to INPUT within same experiment folder
cd $SCRATCH/NW2_TracerBackscatter/p25_SQG_testing/$EXP_NAME
cp RESTART/MOM.res.nc INPUT

## Change input.nml file to accept restart
sed -i "/^         input_filename = 'F'/s/input_filename = 'F'/input_filename = 'r'/g" input.nml

## Change name of ocean stats                                                                                                                                                                               
sed -i 's/ENERGYFILE = "ocean.stats"/ENERGYFILE = "ocean.stats_1"/g' MOM_override

## Run the model
module purge
source ~/NeverWorld2/build/intel/env
srun ~/NeverWorld2/build/intel/ocean_only/repro/MOM6
