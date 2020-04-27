#!/usr/bin/env python3
# Submodule name: data_selection.py

"""
Submodule to select rows of feature tables of the whole corpus based on the metadata file for the reduced corpus.

@author: Ulrike Henny-Krahmer

"""

import pandas as pd
from os.path import join

def select_entries(wdir, md_file, feat_file, outfile):
	"""
	Select only those rows from the feature matrices whose IDs are in the metadata table.
	
	Arguments:
	wdir (str): path to the working directory
	md_file (str): relative path to the metadata file
	feat_file (str): relative path to the file containing the full feature matrix
	outfile (str): relative path to the output file for the reduced feature matrix
	"""
	
	md = pd.read_csv(join(wdir, md_file), index_col=0)
	idnos = list(md.index)
	
	features = pd.read_csv(join(wdir, feat_file), index_col=0)
	features_reduced = features.loc[idnos]
	
	features_reduced.to_csv(join(wdir, outfile), encoding="UTF-8")
	
	print("Done")
	
	
select_entries("/home/ulrike/Git/papers/family_resemblance_dsrom19/", "corpus_metadata/metadata.csv", "features/mfw_1000_tfidf_full.csv", "features/mfw_1000_tfidf.csv")
	
	
