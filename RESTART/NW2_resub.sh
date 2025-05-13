#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=42
#SBATCH --cpus-per-task=1
#SBATCH --mem=10GB
#SBATCH --time=4:00:00
#SBATCH --job-name=p5_noBS_KHTR0_SpinUp
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err
#SBATCH --mail-type=END
#SBATCH --mail-user=mp6191@nyu.edu

## Set experiment name here
EXP_NAME=p5_noBS_KHTR0_SpinUp

## Copy restart file from RESTART to INPUT within same experiment folder
cd $SCRATCH/NW2_TracerBackscatter/$EXP_NAME/
cp RESTART/MOM.res.nc INPUT

## Change input.nml file to accept restart
sed -i "/^         input_filename = 'F'/s/input_filename = 'F'/input_filename = 'r'/g" input.nml

## Change name of ocean stats
sed -i 's/ENERGYFILE = "ocean.stats_3"/ENERGYFILE = "ocean.stats_4"/g' MOM_override

## Run the model
module purge
source ~/NeverWorld2/build/intel/env
srun ~/NeverWorld2/build/intel/ocean_only/repro/MOM6
