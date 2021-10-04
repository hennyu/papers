#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Analysis of subtitles of novels referring to identity ("novela original", "novela americana", etc.)

@author: Ulrike Henny-Krahmer

Created in January 2021.
"""

import pandas as pd
from os.path import join
from os import rename


wdir = "/home/ulrike/Git/papers/original_american_romtag21"
stylo_path = join(wdir, "stylo")

# move files to secondary_set for stylo

md = pd.read_csv(join(wdir, "metadata.csv"), index_col=0)
idnos_secondary_set = md.loc[md["subgenre-novela-cubana"]=="none"].index

for idno in idnos_secondary_set:
	filename = idno + ".txt"
	rename(join(stylo_path, "primary_set", filename), join(stylo_path, "secondary_set", filename))
	
print("done")
