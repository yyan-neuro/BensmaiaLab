function data_pc = ReconArbPC(data,PCM)
% Reconstruct the data with an arbitrary set of PCs. 
% Input:
%   data: original data
%   PCM: a set of PCs. Each column is one PC
% Output: 
%   data_pc: reconstructed data

%Demean the data
data_mean = mean(data);
data_dm = bsxfun(@minus,data,data_mean);


%Compute the reconstructed trajectories and adding the mean
data_pc = data_dm * (PCM * PCM');
data_pc = bsxfun(@plus,data_pc,data_mean);

end
