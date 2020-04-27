#!/usr/bin/env python3
# Submodule name: bow.py

"""
Submodule to create a bow representation of a collection of texts.

@author: Ulrike Henny-Krahmer

"""

from os.path import join
import pandas as pd
import numpy as np
import glob
import re
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.feature_extraction.text import TfidfVectorizer
# http://scikit-learn.org/stable/modules/generated/sklearn.feature_extraction.text.CountVectorizer.html
# Tokenize the documents and count the occurrences of token and return them as a sparse matrix
# see also http://scikit-learn.org/stable/modules/generated/sklearn.feature_extraction.text.TfidfVectorizer and 
# http://scikit-learn.org/stable/modules/generated/sklearn.feature_extraction.text.TfidfTransformer
# Apply Term Frequency Inverse Document Frequency normalization to a sparse matrix of occurrence counts


def create_bow_model(wdir, corpusdir, outfile, **kwargs):
	"""
	Creates a bow model (a matrix of token counts) from a collection of full text files.
	
	Arguments:
	
	wdir (str): path to the working directory
	corpusdir (str): relative path to the input directory (the collection of text files)
	outfile (str): relative path to the output file (the bow matrix)
	
	optional:
	mfw (int): how many of the most frequent terms to use, if this is 0, all the terms are used 
	mode (str): should the counts be normalized? options: "count" (default), "tf-idf"
	vocab_file (bool): if True, the vocabulary of the corpus is stored as a list in a text file
	stopword_file (str): relative path to a file containing a list of stop words
	"""
	
	print("creating bow model...")
	
	mfw = kwargs.get("mfw", 0)
	mode = kwargs.get("mode", "count")
	vocab_file = kwargs.get("vocab_file", False)
	stopword_file = kwargs.get("stopword_file")
	
	if stopword_file:
		stopwords = pd.read_csv(join(wdir, stopword_file), header=None)
		stopwords = list(stopwords.iloc[:,0])
	
	
	if mode == "tf-idf":
		if mfw == 0:
			if stopword_file:
				vectorizer = TfidfVectorizer(input='filename', stop_words=stopwords)
			else:
				vectorizer = TfidfVectorizer(input='filename')
		else:
			if stopword_file:
				vectorizer = TfidfVectorizer(input='filename', max_features=mfw, stop_words=stopwords)
			else:
				vectorizer = TfidfVectorizer(input='filename', max_features=mfw)
	else:
		if mfw == 0:
			if stopword_file:
				vectorizer = CountVectorizer(input='filename', stop_words=stopwords)
			else:
				vectorizer = CountVectorizer(input='filename')
		else:
			if stopword_file:
				vectorizer = CountVectorizer(input='filename', max_features=mfw, stop_words=stopwords)
			else:
				vectorizer = CountVectorizer(input='filename', max_features=mfw)
	
	
	
	# possible parameters and attributes for the CountVectorizer:
	# lowercase by default
	# stop_words: for a list of stop words
	# token_pattern: regex denoting what constitutes a token
	# ngram_range: tuple (min_n,max_n)
	# analyzer: word, char, char_wb
	# max_df: default 1.0, float in range 0.1.-1.0 or integer (absolute counts), ignore terms that have a document frequency higher than this
	# min_df: default 1, float or integer (absolute counts), ignore terms that have a document frequency lower than this, "cut-off"
	# max_features: only top max features ordered by term frequency across the corpus
	# vocabulary
	# attributes:
	# vocabulary_: a mapping of terms to feature indices
	# stop_words_: terms that were ignored because of max_features, max_df or min_df
	
	
	
	# possible parameters and attributes for the TfidfVectorizer:
	# see also above
	# use_idf: Enable inverse-document-frequency reweighting. Default: true
	# smooth_idf: Smooth idf weights by adding one to document frequencies, as if an extra document was seen containing every term in the collection exactly once. Prevents zero divisions. Default: true
	# sublinear_tf: Apply sublinear tf scaling, i.e. replace tf with 1 + log(tf).
	# idf_: The inverse document frequency (IDF) vector
	
	
	filenames = sorted(glob.glob(join(wdir, corpusdir,"*.txt")))
	
	# bow: sparse representation
	bow = vectorizer.fit_transform(filenames)
	bow = bow.toarray()
	
	#print(bow.size)
	#print(bow.shape)
	
	vocab = vectorizer.get_feature_names()
	
	if (vocab_file == True):
		vocab_fr = pd.DataFrame(data=vocab)
		vocab_fr.to_csv(join(wdir, "vocab.txt"), encoding="UTF-8", header=False, index=False)
		print("created vocabulary file...")
	
	#print(vocab[:100])
	#exit()
	#print(vocab[:100])
	
	# save to file
	idnos = [re.split(r"\.", re.split(r"/", f)[-1])[0] for f in filenames]
	
	bow_frame = pd.DataFrame(columns=vocab, index=idnos, data=bow)
	bow_frame.to_csv(join(wdir, outfile), sep=",", encoding="utf-8")
	
	print("Done! Number of documents and vocabulary: ", bow.shape)
	print("Number of tokens: ", bow.sum())
	
	
create_bow_model("/home/ulrike/Git/conha19/", "txt", "mfw_1000_tfidf_full.csv", mfw=1000, mode="tf-idf", vocab_file=True, stopword_file="mfw_stopwords.txt")
