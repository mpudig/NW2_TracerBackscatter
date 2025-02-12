#!/bin/bash

#SBATCH --nodes=3
#SBATCH --ntasks-per-node=42
#SBATCH --cpus-per-task=1
#SBATCH --mem=25GB
#SBATCH --time=24:00:00
#SBATCH --job-name=p25_noBS_SpinUp
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err
#SBATCH --mail-type=END
#SBATCH --mail-user=mp6191@nyu.edu

## Set experiment name here
EXP_NAME=p25_noBS_SpinUp

## Copy restart file from RESTART to INPUT within same experiment folder
cd $SCRATCH/NW2_TracerBackscatter/$EXP_NAME/
cp RESTART/MOM.res.nc INPUT

## Change input.nml file to accept restart
sed -i "/^         input_filename = 'F'/s/input_filename = 'F'/input_filename = 'r'/g" input.nml

## Run the model
module purge
source ~/NeverWorld2/build/intel/env
srun ~/NeverWorld2/build/intel/ocean_only/repro/MOM6
