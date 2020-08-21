
Raw data and Core Matlab functions for the paper titled "Unexpected Complexity in Everyday Manual Behaviors"

Instructions:
1. Download Non-linear PCA toobox (http://www.nlpca.org/matlab.html) and Isomap toolbox (https://web.mit.edu/cocosci/isomap/isomap.html)
2. Load "DataDS_Final.mat" for the down-sampled grasp data (100Hz -> 20Hz). Data was downsampled to improve speed for non-linear dimensionality reduction. Original data can be found in Grasp Data.mat and ASL Data.mat.
3. Run NLPCA_final.m for training NLPCA on the grasp data, then run ClassAccuracy_DS_NLPCA.m for classification analysis using the NLPCA components. Run eigenvalues_pca_isomap2.m for performing PCA and Isomap on the grasp data and the associated classification analysis.
4. Run SimulationRealCA2.m and SimulationRealCC2.m for the conditional noise analysis. We used the original, not the down-sampled, data for them. The down-sampled data yielded the same results. 

Notes on data:

1. The grasp and ASL data here only contain the movement segment from "finger starts moving" to "100ms before contact" in each trial. We performed our analysis (dimensionality reduction, classification etc.) on these segments because we want to isolate the volitional movements not affected by object contours. As such, the "precon" argument in the classifciation functions are all set to 0, as the "0" here is exactly 100ms before contact. 
2. Grasp data organization: each cell is the combined kinematics matrix of a subject. Each row is an observation and each column is a distinct joint angle. The index matrix (from MatIndList) provides detailed information of the kinematics matrix. It has three columns: 1st column: object index. 2nd column: trial index. 3rd column: timestamp in that trial. 
