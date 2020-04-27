#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Filename: run_model.py
# Author: #cf
# Version 0.1.0 (2016-10-17)

"""
Parameter file for model.py. 
"""

import model
from os.path import join


### Set the general working directory.
wdir = "/home/ulrike/Git/hennyu/novelashispanoamericanas/corpus"


### Shared parameters
MalletPath = "/home/ulrike/Programme/mallet-2.0.8RC3/bin/mallet"
#MalletPath = "/media/christof/data/repos/other/Mallet/bin/mallet" # doesn't work right now.
TextFolder = join(wdir, "topicmodel", "corpus_segs")
MalletFolder = join(wdir, "topicmodel", "mallet") 
CorpusFile = join(MalletFolder, "nh.mallet")


### Import parameters (call_mallet_import)
StoplistProject = join(wdir, "topicmodel", "stopwords.txt")
model.call_mallet_import(MalletPath, TextFolder, MalletFolder, CorpusFile, StoplistProject)


### Modeling parameters (call_mallet_model)
NumTopics = [100]
NumIterations = [5000]
OptimizeIntervals = [100]
NumTopWords = 50
NumThreads = 4
ModelFolder = join(wdir, "topicmodel", "mallet")

model.call_mallet_modeling(MalletPath, CorpusFile, ModelFolder, NumTopics, NumIterations, OptimizeIntervals, NumTopWords, NumThreads)
