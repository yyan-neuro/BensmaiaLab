function acc_vec = ClassAccuracy_DS_Isomap_Calc(graspMat,ds_ind,precon,Y)

acc_vec = []; PCNo = 29;


graspMat_Isomap = Y.coords{29}; graspMat_Isomap = graspMat_Isomap.';



for i = 1:PCNo
    
    
    [tmat,vmat,~,~] = getClassMat_ds(ds_ind,graspMat_Isomap,precon,false);
    

    
    tmat_pc = tmat(:,end-i:end-1);
    vmat_pc = vmat(:,end-i:end-1);
    
    
    Mdl = fitcdiscr(tmat_pc,tmat(:,end));
    label_pred = predict(Mdl,vmat_pc);
    
    
    label_true = vmat(:,end);
    acc = sum(label_pred==label_true)/length(label_true);
    acc_vec = [acc_vec,acc];
    
end


end
