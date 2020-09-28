function [compCount,simVec] = PCSpaceSim_Array(giantMatArray,giantPCArray)
% Calculate the subspace similarity between every pair of movement matrices in giantMatArrray
% Input:
%   giantMatArray: cell array of movement data
%   giantPCArray: cell array of PCs in the same order as giantMatArray
% Output: 
%   compCount: number of of comparisons made
%   simVec: subspace similarity vector. 
caseNo = numel(giantMatArray);
compCount = 0;
simVec = [];
for i = 1:caseNo
   for j = i+1 : caseNo
       if(i == j)
           continue;
       end
       %Select PC Matrices and Data Matrices to compare
       PCM1 = giantPCArray{i}; PCM2 = giantPCArray{j};
       dataM1 = giantMatArray{i};dataM2 = giantMatArray{j};
       
       %Calculate cross-projection similarity
       compVec = PCSpaceSim_Num(PCM1,PCM2,dataM1,dataM2,2);
       compVec2 = PCSpaceSim_Num(PCM2,PCM1,dataM2,dataM1,2);      
       compVec_avg = compVec + compVec2; 
       compVec_avg = compVec_avg/2;
       
       compCount = compCount + 1;
       simVec = [simVec;compVec_avg];

       
       
   end
    
    
end





end
