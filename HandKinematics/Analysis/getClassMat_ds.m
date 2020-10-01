function [tmat,vmat,tmat_verify,vmat_verify] = getClassMat_ds(ds_ind,ds_mat,precon,RO)
% Get randomized training and testing data for classification
% Input:
%   ds_ind: movement data description
%   ds_mat: movement data matrix
%   pre_con: number of seconds before contact. Determines the timestamp of the hand postures used in classification. 
%   RO: boolean argument. True indicates no down-sampling has taken place. 
% Output: 
%   tmat, vmat: training data and testing data. 
%   tmat_verify and vmat_verify: the data description associated with the training data and testing data. Used for debugging purposes. 
tmat = []; vmat = [];
tmat_verify = []; vmat_verify = [];


numObj = length(unique(ds_ind(:,1))); 

if(RO)
    %for raw data
    ind_minus = precon * 100;
else
    %for down-sampled data
    ind_minus = precon*20;
end




i = 1;
object = 1; vtrial = randi(5);
while (i<=size(ds_ind,1)-ind_minus)
    
    if(ds_ind(i,1)~=object)        
        object = ds_ind(i,1);
        vtrial = randi(5);
    end
    
    
    ind_ahead = i+ind_minus+1;
    
    if(ind_ahead > size(ds_ind,1)||ds_ind(ind_ahead,2)~=ds_ind(i,2))
        
        if(ds_ind(i,2)==vtrial)
            
            vmat = [vmat;[ds_mat(i,:),ds_ind(i,1)]];            
            vmat_verify = [vmat_verify;ds_ind(i,:)];     

        else
            tmat = [tmat;[ds_mat(i,:),ds_ind(i,1)]];        
            tmat_verify = [tmat_verify;ds_ind(i,:)];            
         
           
        end
        
        i = ind_ahead;
        continue;
        
    end
    
    
    i = i+1;
    
    
end




tmat = tmat(randperm(size(tmat,1)),:);
vmat = vmat(randperm(size(vmat,1)),:);



end
