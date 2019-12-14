Factor Analysis Inference
---
[Xihe Xie](https://github.com/axiezai)


Origina `Matlab` code provided by Dr. Srikantan Nagarajan.

This is a variational Bayesian expectation maximization algorithm (VB-EM) for inferring the factor analysis model $y = ax + v$.

Files:
 - `bfa.m` original `Matlab` code.
 - `vb_factor_analysis.ipynb` the IPython notebook implementation showing an example with AEF MEG dataset.
 - `environment.yml` is the basic requirements to run the IPython notebook.

### Set-up:
Most Python users should have the following packages installed:
 - numpy
 - matplotlib
 - scipy
 - qt

If you do not, then clone this repository and set up the conda environment with the command: `conda env create -f environment.yml`

### Usage:
Be careful with the IPython magic for `matplotlib`, it should only be called once. The notebook defaults to `%matplotlib inline` where the plots are produced after each cell is run in the notebook, but because notebooks can't update plots in a for-loop (I couldn't figure out the animation capabilities yet), we have to call `%matplotlib qt` once before running the EM portion of the code, then a pop-up window will appear that displays the updating plots. If you are repeatedly running a cell with the EM update plots, remove `%matplotlib qt` the second time you run it.

The notebook starts by loading the data, then goes on a step-by-step walk-through of the factor analysis code, the entire algorithm is then compiled into one function in the end.

The final function is named `bfa` with the following descriptions:
```
def bfa(y, num_fa, num_it, mixing_matrix = None, noise_precision = None):
    """
    Bayesian Factor analysis with expectation maximization algorithm
    
    Args:
        - y (array): Nsensor x Ntime data 
        - num_fa (int): number of factors in factor analysis
        - num_it (int): number of iterations for EM updates
        - mixing_matrix (array): The factor loading matrix A in the factor analysis model. If stays as default value of None, the function initializes with SVD of autocorrelation of y
        - noise_precision (array): the noise precision matrix, also defaults to None and can be initialized.
    
    Outputs: (everything gets plotted)
        - mixing_matrix
        - noise_precision
        - xbar - x after update rules are applied.
        - igamma - the variance matrix
    """
```
There is an example where we make use of the `bfa` function that initializes with a random mixing matrix.
