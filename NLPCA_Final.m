%MatList_DS = {allGraspMat_BD_DS, allGraspMat_BP_DS, allGraspMat_DM_DS, allGraspMat_EH_DS, allGraspMat_JB_DS, allGraspMat_JF_DS, allGraspMat_LO_DS, allGraspMat_YY_DS};
%MatIndList_DS = {allGraspMat_BD_DS_ind, allGraspMat_BP_DS_ind, allGraspMat_DM_DS_ind, allGraspMat_EH_DS_ind, allGraspMat_JB_DS_ind, allGraspMat_JF_DS_ind, allGraspMat_LO_DS_ind, allGraspMat_YY_DS_ind};


nlpca_netlist = {}; nlpca_nwlist = {};

for i = 1:numel(MatList_DS)
    
    graspMat = MatList_DS{i};
    
    
    [~,net,netw] = nlpca(graspMat.',29);
    
    nlpca_netlist{i} = net;
    nlpca_netwlist{i} = netw;
    
    
    i
end


Eval_nlpca = [];
for i = 1:numel(nlpca_netlist)
    varexp = nlpca_netlist{i}.variance;
    varexp = cumsum(varexp);
    Eval_nlpca = [Eval_nlpca;varexp];
end
