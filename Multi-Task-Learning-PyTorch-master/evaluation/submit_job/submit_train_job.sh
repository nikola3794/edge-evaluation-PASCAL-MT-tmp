#!/bin/bash
#SBATCH  --output=/srv/beegfs02/scratch/switchtasks/data/NIKOLA/Experiments/_logs_cpu/%j.out
#SBATCH  --cpus-per-task=24
#SBATCH  --mem=40G


echo "CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES}"


# Set Pathsa
PROJECT_ROOT_DIR=/home/nipopovic/switchtask_beegfs02/NIKOLA/edge_evaluation/edge_eval_regular_1/Multi-Task-Learning-PyTorch-master
export PYTHONPATH=${PYTHONPATH}:${PROJECT_ROOT_DIR}
cd ${PROJECT_ROOT_DIR}
pwd

#What is this?
OMP_NUM_THREADS=8

/scratch_net/snapo_second/nipopovic/apps/miniconda3/envs/task_switch/bin/python -u evaluation/eval_edge2.py "$@"


