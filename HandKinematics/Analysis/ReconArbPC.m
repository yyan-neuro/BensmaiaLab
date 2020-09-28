function data_pc = ReconArbPC(data,PCM)

%Demean the data
data_mean = mean(data);
data_dm = bsxfun(@minus,data,data_mean);


%Compute the reconstructed trajectories and adding the mean
data_pc = data_dm * (PCM * PCM');
data_pc = bsxfun(@plus,data_pc,data_mean);

end