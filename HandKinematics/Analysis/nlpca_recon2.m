function data_recon = nlpca_recon2(data,net,num,format,forward)
% Reconstruct data using NLPCA dimensions
% Input:
%   data: original data
%   net: trained NLPCA autoencoder
%   num: cutoff dimensions
%   format: boolean argument. Determine if we need to transpose the data. NLPCA package takes data in the form of attribute x time.
%   forward: boolean argument. Determine if we remove NLPCA dimensions from the end (removed in ascending order of variance).
% Output: 
%   data_recon: reconstructed data. 


if(format)
   data = data.'; 
end

scores = nlpca_get_components(net,data);

if(num>0)
    if(forward)
        scores_zo_size = size(scores(num+1:end,:));
        scores(num+1:end,:) = zeros(scores_zo_size);
    else
        scores_zo_size = size(scores(1:num,:));
        scores(1:num,:) = zeros(scores_zo_size);
    end
end

data_recon = nlpca_get_data(net,scores);
data_recon = data_recon.';

end
