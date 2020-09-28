function [cc_sao_mat,cc_dio_mat] = simulationCC_DSData(graspMat,graspMat_ind)
% Calculate the correlation coefficients between PC scores of trials from the same grasped object or different grasped objects. 
% Input:
%   graspMat: movement data
%   graspMat_ind: data description
% Output: 
%   cc_sao_mat: Correlation coefficients between PC scores of trials from the same grasped object
%   cc_dio_mat; Correlation coefficients between PC scores of trials from different grasped objects. 
PCM = pca(graspMat);
objNo = numel(unique(graspMat_ind(:,1)));
dataNo = size(graspMat,1);


tid_max = 0;
for i = 1:max(graspMat_ind(:,3))
    tid_No = sum(graspMat_ind(:,3)==i);
    
    if(tid_No < objNo * 5)
        tid_max = i-1;
        break;
    end
    
end



cc_sao_mat = [];cc_dio_mat = [];

for i = 1:size(PCM,2)
    
    cc_sao_vec = []; cc_dio_vec = [];
    trialMat_PC = [];
    di = 1; startMark = 1; trialNo = 1;
    while(di<=dataNo+1)

        if(di == dataNo+1 || graspMat_ind(di,2)~=trialNo)

           if(di<=dataNo)
            trialNo =  graspMat_ind(di,2);
           end
           
           
            trialVec = graspMat(startMark:di-1,:) * PCM(:,i);
            trialMat_PC = [trialMat_PC,trialVec(1:tid_max)];

           startMark = di;
        end

        di = di + 1;

    end
    
    trialMat_PC = round(trialMat_PC,4);
    trialMat_cc = corr(trialMat_PC);
    for tNo = 1:5:objNo*5

        %Select same-object correlation coefficients
        
        
        cc_sao_temp = trialMat_cc(tNo:tNo+4,tNo:tNo+4);
        
        temp_x = ones(size(cc_sao_temp,1),1) *( 1:size(cc_sao_temp,2));
        temp_y = (1:size(cc_sao_temp,1))' * ones(1,size(cc_sao_temp,2));
        cc_sao_temp = cc_sao_temp(temp_y>temp_x);
        
        cc_sao_vec = [cc_sao_vec;cc_sao_temp];


        %Randomly select different-object trials
        dio_ind = 1:objNo*5; dio_ind(tNo:tNo+4) = [];
        dio_ind = dio_ind(randperm(numel(dio_ind)));
        dio_ind = dio_ind(1:5);
        %Select different-object correlation coefficients
        cc_dio_temp = trialMat_cc(dio_ind,tNo:tNo+4);
        cc_dio_temp = reshape(cc_dio_temp,[numel(cc_dio_temp),1]);
        cc_dio_vec = [cc_dio_vec;cc_dio_temp];


    end
    
    cc_sao_mat = [cc_sao_mat,cc_sao_vec];
    cc_dio_mat = [cc_dio_mat,cc_dio_vec];
    
end






end
