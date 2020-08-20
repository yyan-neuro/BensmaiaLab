

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
