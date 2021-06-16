# This code is referenced from 
# https://github.com/facebookresearch/astmt/
# 
# Copyright (c) Facebook, Inc. and its affiliates.
# All rights reserved.
# 
# License: Attribution-NonCommercial 4.0 International

import os


PROJECT_ROOT_DIR = os.path.dirname(os.path.abspath(__file__)).split('/')[0]


class MyPath(object):
    """
    User-specific path configuration.
    """
    @staticmethod
    def db_root_dir(database=''):
        db_root = 'PASCAL_MT_PATH'

        return db_root

    @staticmethod
    def seism_root():
        seism_root = 'SEISM_ROOT_MASTER'

        return seism_root
