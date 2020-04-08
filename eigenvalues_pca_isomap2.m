


Eval_isomap_loaf = {}; acc_isomap_loaf = {};
landmark_list = [inf];





for LM_ind = 1:length(landmark_list)
    %Matrices for storing eigenvalues of isomap and pca
    Eval_isomap = []; Eval_pca = [];

    %Classifications
    acc_mat_isomap = []; acc_mat_pca = [];

    for i = 1:8

        graspMat = MatList_DS{i};
        graspMat_ind = MatIndList_DS{i};
        
        
        landmark_index = randperm(size(graspMat,1));
        
        if(landmark_list(LM_ind)<inf)
            %Isomap landmark setting. 
            landmark_index = landmark_index(1:landmark_list(LM_ind));

        end
        landmark_index = sort(landmark_index);

        %Extract 29 dimensions
        options.dims = 1:29; options.display = false; 
        options.landmarks = landmark_index ;


        %Comput the pairwise Eucledian distance matrix
        raw_distance = Isomap_L2_distance(graspMat.',graspMat.',1);
        %Find eigenvalues for isomap ('k',29 refers to using 29 nearest neighbors)
        [Y, R, ~,~,eval_isomap_temp] = IsomapII_returnD(raw_distance, 'k', 29, options); 


        %Find eigenvalues for pca
        [~,~,eval_pca_temp] = pca(graspMat);
        
  
        
        for rep = 1:5
            acc_temp= ClassAccuracy_DS_Isomap_Calc(graspMat,graspMat_ind,0,Y);
            acc_mat_isomap = [acc_mat_isomap;acc_temp];   
            acc_temp2 = ClassAccuracy_DS_PC(graspMat,graspMat_ind,0,false);
            acc_mat_pca = [acc_mat_pca;acc_temp2];
            rep
        end
        
        %acc_temp2 = ClassAccuracy_DS_PC(graspMat,graspMat_ind,0.1);
        %acc_mat_pca = [acc_mat_pca;acc_temp2];

        Eval_isomap = [Eval_isomap;eval_isomap_temp.'];
        Eval_pca = [Eval_pca;eval_pca_temp.'];

    end
    
    acc_isomap_loaf{LM_ind} = acc_mat_isomap;
    Eval_isomap_loaf{LM_ind} = Eval_isomap;
    
end

%}

%{
acc_mat_pca = [];
for i = 1:8

    graspMat = MatList_DS{i};
    graspMat_ind = MatIndList_DS{i};
    
    for rep = 1:5
        acc_temp2 = ClassAccuracy_DS_PC(graspMat,graspMat_ind,0.1,false);
        acc_mat_pca = [acc_mat_pca;acc_temp2];
    end
    
end
%}

