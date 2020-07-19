# A New Benchmark and Method for the Evaluation of Chest Wall Detection in Digital Mammography
## Introduction
This is an implementation of a chest wall detection method in digital mammography as described in our paper 
[A New Benchmark and Method for the Evaluation of Chest Wall Detection in Digital Mammography](https://sites.google.com/view/cvia/cwall). 
The implementation allows users to segment the pectoral muscle in a publicly available dataset and compute the performance measurements.

As described in our paper, we compute the performance in the whole Inbreast dataset and in the sixty percent of the dataset. For further details, please refer to 
[Supplementary material](https://sites.google.com/view/cvia/cwall).
## How to run the code
First, run *setup.m* to configure the method. Second, you can run the *step01.m* to 
evaluate the method in the whole dataset or run the step02.m to evaluate the performance in the 60% of the dataset.
In step01.m and *step02.m* it is necessary to specify the new path where the dataset is allocated. For this purpose, add the local Inbreast 
path in the variable *newpath*. For example, as follows
```
newpath='C:\Users\Desktop\gafricano\INbreast';
```
## Updates
**(2020/07/19)** Two images were removed from the dataset because of bad manuall annotation   
## Reference 
If you found this code useful, please cite our paper as:

G. Africano, O. Arponen, A. Sassi, I. Rinta-Kiikka, A. Lääperi and S. Pertuz,
A New Benchmark and Method for the Evaluation of Chest Wall Detection in Digital Mammography, 
In Annual International Conference of the IEEE Engineering in Medicine and Biology Society (accepted), 2020
