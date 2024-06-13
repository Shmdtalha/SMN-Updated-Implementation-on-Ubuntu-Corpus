# SMN-Updated Implementation on Ubuntu Corpus
This repository includes the updated implementation of Sequential Matching Network: A New Architecture for Multi-turn Response Selection in Retrieval-Based Chatbots(SMN)

## Download Files
Be sure to download all of these files and place them in the main directory if you wish to test the model with samples. Please note that this is not provided in English. \
[SMN additional files](https://drive.google.com/drive/folders/1QpaUd-sdVBGijSwV2wSJE-7J7568X-cv?usp=sharing)

## Requirements
gensim \
theano

## Theano Modifications
There are a few modifications required before preprocessing. You may replace the lines directly in the files. The script has been provided to display modifications.
```python
with open('/usr/local/lib/python3.10/dist-packages/theano/configdefaults.py', 'r') as file:
    lines = file.readlines()

# Modify line 1284
lines[1283] = "            blas_info = np.distutils.__config__.blas_ilp64_opt_info\n"

with open('/usr/local/lib/python3.10/dist-packages/theano/configdefaults.py', 'w') as file:
    file.writelines(lines)

with open('/usr/local/lib/python3.10/dist-packages/theano/scalar/basic.py', 'r') as file:
    lines = file.readlines()

# Modify line 2323
lines[2322] = "        self.ctor = bool\n"

with open('/usr/local/lib/python3.10/dist-packages/theano/scalar/basic.py', 'w') as file:
    file.writelines(lines)
```
Another important modification is changing `import cPickle` to `import _pickle as cPickle` in all files
## Preprocessing
Now that the word2vec model and Theano are in place, you may begin preprocessing.
```python
 !theano_src/preprocess.py
```
This will return a .bin file that is crucial for training.

## Training
```python
!python theano_src/SMN_Last.py
```
## Evaluation
You must first set the `train_flag = False` to skip training and provide metrics.
```python
!python theano_src/SMN_Last.py
```

## Acknowledgements
[SMN GitHub Repository](https://github.com/MarkWuNLP/MultiTurnResponseSelection) \
[Sequential Matching Network: A New Architecture for Multi-turn Response Selection in Retrieval-Based Chatbots](https://aclanthology.org/P17-1046.pdf)
