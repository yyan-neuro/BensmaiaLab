function simVec = PCSpaceSim_Num(PCM1,PCM2,dataM1,dataM2,method)


simVec = zeros(1,size(PCM1,2));

for i = 1:length(simVec)
    
    if(method==1)
        %Subspace similarity based on principal angle
        ang = subspacea(PCM1(:,1:i),PCM2(:,1:i));
        ang = mean(ang);
   
        simVec(i) = ang;
    elseif(method==2)
        %Cross-projection subspace similarity
        spacedim = i;
        
        %Reconstruct dataset 1 based on dataset 2's PCs
        dataM1_recon2 = ReconArbPC(dataM1,PCM2(:,1:spacedim)); 
        
        %Calculate the total variance of the reconstructed data
        [~,~,lat12] = pca(dataM1_recon2);
        lat12 = sum(lat12(1:spacedim));
        
        %Compare with the variance of the original data
        [~,~,lat11] = pca(dataM1); lat11 = sum(lat11(1:spacedim));
        simVec(i) = lat12/lat11;        
        
        
    end
end




end