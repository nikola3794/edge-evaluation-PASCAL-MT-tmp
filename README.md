# About this repository

This repository is a quick and not so pretty solution for reproducing the edge evaluation on the PASCAL_MT data set. The evaluation protocol is implemented in the seism library (https://github.com/jponttuset/seism). This codebase actually uses the project https://github.com/SimonVandenhende/Multi-Task-Learning-PyTorch , as a way to call the seism evaluation library. The seism library implements the edge evaluation using MATLAB, and thus it is required to have it installed.

# How to use

* Open the script root/seism-master/src/gt_wrappers/db_root_dir.m. Set the variable db_root_dir to the path where the edge labels are stored as .mat files. In the .mat files, the pascal-context semantic segmentation classes should actually be stored, because edges are defined as borders between semantic classes. The .mat files should actually be inside a directory called "trainval" which is inside the db_root_dir path. 

* Open the script root/Multi-Task-Learning-PyTorch-master/utils/mypath.py. Set the variable db_root to the directory of the PASCAL_MT dataset. Set the variable seism_root to the root of the seism-master directory from this codebase (root/seism-master).

* Open the script root/Multi-Task-Learning-PyTorch-master/evaluation/eval_edge2.py. Set the variable edge_pred_paths to a list of paths of directories where the predicted edges of the validation set are saved as .png images. The predicted edge .png images need to be of the same size as the original input image.

* Open the script root/Multi-Task-Learning-PyTorch-master/evaluation/seism/pr_curves_base.m. Make sure that the variable gt_set has a value 'val', so that only validation data points are evaluated.

* With a python3 interpreter, run the script root/Multi-Task-Learning-PyTorch-master/evaluation/eval_edge2.py 

