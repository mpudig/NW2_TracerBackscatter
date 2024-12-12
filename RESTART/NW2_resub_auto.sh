#!/bin/bash

#SBATCH --nodes=44
#SBATCH --ntasks-per-node=36
#SBATCH --cpus-per-task=1
#SBATCH --mem=30GB
#SBATCH --time=18:00:00
#SBATCH --job-name=p03125
#SBATCH --output=slurm_%j.out
#SBATCH --error=slurm_%j.err
#SBATCH --mail-type=END
#SBATCH --mail-user=mp6191@nyu.edu

## Set experiment name here
EXP_NAME=p03125

# Define the number of times to resubmit
N=4

# Job counter (keeps track of how many times the job has run)
counter=0

# Loop to resubmit the job N times
while [ $counter -lt $N ]; do
    echo "Job is running. Iteration: $((counter + 1))"

    ### Copy restart file from RESTART to INPUT within same experiment folder 
    cd $SCRATCH/NW2_TracerBackscatter/$EXP_NAME/
    cp RESTART/MOM.res.nc INPUT
    cp RESTART/MOM.res_1.nc INPUT
    cp RESTART/MOM.res_2.nc INPUT
    cp RESTART/MOM.res_3.nc INPUT
    cp RESTART/MOM.res_4.nc INPUT
    
    ### Change input.nml file to accept restart   
    sed -i "/^         input_filename = 'F'/s/input_filename = 'F'/input_filename = 'r'/g" input.nml

    ### Run the model
    module purge
    source ~/NeverWorld2/build/intel/env
    srun ~/NeverWorld2/build/intel/ocean_only/repro/MOM6

    ### Move slurm files to restart
    mv slurm* RESTART
    
    # Increment the counter
    ((counter++))

    # Optional: Wait before resubmitting if needed, e.g., to avoid race conditions
    sleep 1

    # Resubmit the same job after it finishes (using `sbatch` to resubmit the script)
    if [ $counter -lt $N ]; then
	# Resubmit the current script (the $0 refers to the script itself, so SLURM will submit another instance of the same job, and the dependency is to make sure the next job only runs after the previous one completes successfully)
        sbatch --dependency=afterok:$SLURM_JOB_ID $0
        echo "Resubmitting job. Current iteration: $counter"
        exit 0  # Exit to prevent further execution in the current job's instance
    fi
done

# When the loop finishes, the job has been resubmitted N times.
echo "Job has been resubmitted $N times, exiting."
