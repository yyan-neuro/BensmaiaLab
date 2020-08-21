function acc_vec = ClassAccuracy_DS_NLPCA(graspMat,ds_ind,net,precon,fw)

acc_vec = [];  dimNum = 29;

for i = 0:dimNum-1
    
    [tmat,vmat,~,~] = getClassMat_ds(ds_ind,graspMat,precon,false);
    
    if(fw)
        tmat_pc = nlpca_recon2(tmat(:,1:end-1),net,i,true,true); 
        vmat_pc = nlpca_recon2(vmat(:,1:end-1),net,i,true,true);
    else
        tmat_pc = nlpca_recon2(tmat(:,1:end-1),net,i,true,false); 
        vmat_pc = nlpca_recon2(vmat(:,1:end-1),net,i,true,false);        
        
    end
    

    
    
    Mdl = fitcdiscr(tmat_pc,tmat(:,end),'discrimType','pseudoLinear');
    label_pred = predict(Mdl,vmat_pc);
    
    
    label_true = vmat(:,end);
    acc = sum(label_pred==label_true)/length(label_true);
    acc_vec = [acc_vec,acc];
    
end
%{
plot(1:length(acc_vec),acc_vec,'-o');
xlabel('PC Number');
ylabel('Accuracy / percent');
ylim([0,1]);
%}
end
