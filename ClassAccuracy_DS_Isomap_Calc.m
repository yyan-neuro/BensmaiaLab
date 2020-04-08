function acc_vec = ClassAccuracy_DS_Isomap_Calc(graspMat,ds_ind,precon,Y)

acc_vec = []; PCNo = 29;

%{
landmark_index = randperm(size(graspMat,1)); landmark_index = landmark_index(1:50);
landmark_index = sort(landmark_index);
options.dims = 1:29; options.display = false; options.landmarks = landmark_index ;

D = Isomap_L2_distance(graspMat.',graspMat.',1);
[Y, R, ~,~] = IsomapII_returnD(D, 'k', 29, options);
%}
graspMat_Isomap = Y.coords{29}; graspMat_Isomap = graspMat_Isomap.';



for i = 1:PCNo
    
    
    [tmat,vmat,~,~] = getClassMat_ds(ds_ind,graspMat_Isomap,precon,false);
    
    %{
    tmat_pc = tmat(:,1:end-30+i);
    vmat_pc = vmat(:,1:end-30+i);
    %}
    
    tmat_pc = tmat(:,end-i:end-1);
    vmat_pc = vmat(:,end-i:end-1);
    
    
    Mdl = fitcdiscr(tmat_pc,tmat(:,end));
    label_pred = predict(Mdl,vmat_pc);
    
    
    label_true = vmat(:,end);
    acc = sum(label_pred==label_true)/length(label_true);
    acc_vec = [acc_vec,acc];
    
end

%{
plot(1:PCNo,acc_vec,'LineWidth',1.5);
xlabel('PC Number');
ylabel('Accuracy / percent');
ylim([0,1]);
hold on;
%}
end