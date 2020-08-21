function acc_vec = ClassAccuracy_DS_PC(fullMat,ds_ind,precon,RO)

acc_vec = []; PCNo = 29;

PCM = pca(fullMat);

for i = 1:PCNo
    
    
    
    [tmat,vmat,~,~] = getClassMat_ds(ds_ind,fullMat,precon,RO);
    
    tmat_pc = tmat(:,1:end-1) * PCM(:,end-i+1:end);
    vmat_pc = vmat(:,1:end-1) * PCM(:,end-i+1:end);
    
    tmat_pc = round(tmat_pc,4);
    vmat_pc = round(vmat_pc,4);
    
    Mdl = fitcdiscr(tmat_pc,tmat(:,end),'discrimType','diagLinear');
    label_pred = predict(Mdl,vmat_pc);
    
    
    label_true = vmat(:,end);
    acc = sum(label_pred==label_true)/length(label_true);
    acc_vec = [acc_vec,acc];
    
end



end
