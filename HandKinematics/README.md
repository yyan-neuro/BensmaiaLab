
Raw data and Core Matlab functions for the paper titled "Unexpected Complexity in Everyday Manual Behaviors"

Instructions:
1. Download Non-linear PCA toobox (http://www.nlpca.org/matlab.html) and Isomap toolbox (https://web.mit.edu/cocosci/isomap/isomap.html)
2. Load "DataDS_Final.mat" for the down-sampled grasp data (100Hz -> 20Hz). Data was downsampled to improve speed for non-linear dimensionality reduction. Original data can be found in Grasp Data.mat.
3. Run NLPCA_final.m for training NLPCA on the grasp data, then run ClassAccuracy_DS_NLPCA.m for classification analysis using the NLPCA components. Run eigenvalues_pca_isomap2.m for performing PCA and Isomap on the grasp data and the associated classification analysis.
4. Run SimulationRealCA2.m and SimulationRealCC2.m for the conditional noise analysis. We used the original, not the down-sampled, data for them. The down-sampled data yielded the same results. 
