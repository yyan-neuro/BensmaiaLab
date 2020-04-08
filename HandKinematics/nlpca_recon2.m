function data_recon = nlpca_recon2(data,net,num,format,forward)


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