rng('shuffle');



totalDim = 29; noiseType = 2; dataDimType = 3;
Niter = 1;

cNoiseRatios = [0]; iNoiseRatios = [0];

acc_loaf =  cell(numel(iNoiseRatios),numel(cNoiseRatios),Niter);

for iter_i = 1:Niter
    for i_ind = 1:numel(iNoiseRatios)

        for c_ind = 1:numel(cNoiseRatios)


            cc_sao_bigmat = [];cc_dio_bigmat = [];
            acc_mat = [];

            for i = 1:numel(MatList_DS)





                graspMat = MatList_DS{i}; graspMat_ind = MatIndList_DS{i};
                dataNo = size(graspMat,1);

                switch dataDimType

                    case 1
                        graspMat_d10 = graspMat(:,1:10); 
                        graspMat_d10 = [graspMat_d10,zeros(dataNo,totalDim-10)];
                    case 2
                        graspMat_PC = pca(graspMat);
                        graspMat_d10 = ReconArbPC(graspMat,graspMat_PC(:,1:10));

                    case 3
                        graspMat_d10 = graspMat;
                    case 4
                        [graspMat_DN,graspMat_DN_ind] = Simulation_DeNoise(graspMat,graspMat_ind);
                        graspMat_PC = pca(graspMat_DN);
                        graspMat_d10 = ReconArbPC(graspMat_DN,graspMat_PC(:,1:10));
                        graspMat_ind = graspMat_DN_ind;
                        dataNo = size(graspMat_d10,1);




                end


                %conditional noises
                di = 1; 
                objNo = 1; startMark = 1;
                cNoiseMat = [];


                while(di<=dataNo+1)

                    if(di == dataNo+1 || graspMat_ind(di,1)~=objNo)

                       if(di<=dataNo)
                        objNo =  graspMat_ind(di,1);
                       end

                       switch noiseType
                           case 1
                               vec = randn(totalDim);
                               vec_normo = bsxfun(@times,vec,1./sqrt(sum(vec.^2))) * sqrt(10);
                               SIGMA = vec_normo' * vec_normo;






                               noise_temp = mvnrnd(zeros(1,totalDim),SIGMA,di-startMark);
                               cNoiseMat = [cNoiseMat;noise_temp];


                           case 2
                               %conditional noise with distinct
                               %distribution for each posture
                               graspMat_d10_shuf = graspMat_d10(:,randperm(size(graspMat_d10,2)));
                               SIGMA = cov(graspMat_d10_shuf);
                               SIGMA = SIGMA * cNoiseRatios(c_ind);

                               noise_temp = mvnrnd(zeros(1,totalDim),SIGMA,di-startMark);
                               cNoiseMat = [cNoiseMat;noise_temp];

                           case 3

                               % Reviewer's formualtion
                               noisedir = mvnrnd(zeros(1,totalDim),eye(totalDim))';
                               noisedir = noisedir/norm(noisedir); 



                               LOCALSIGMA = median(var(graspMat))*cNoiseRatios(c_ind);
                               noise_temp = noisedir * normrnd(zeros(1,di-startMark),LOCALSIGMA);
                               noise_temp = noise_temp.';

                               cNoiseMat = [cNoiseMat;noise_temp];



                       end

                       startMark = di;
                    end

                    di = di + 1;

                end

                graspMat_noisy = graspMat_d10 + cNoiseMat;
                %graspMat_noisy = cNoiseMat;

                %Isotropic noises
                iNoise_var_base = median(var(graspMat));

                iNoiseMat =  randn(dataNo,totalDim)* sqrt(iNoiseRatios(i_ind)) * sqrt(iNoise_var_base);

                graspMat_noisy = graspMat_noisy + iNoiseMat;
                %graspMat_noisy = iNoiseMat;

                %classification

                acc_vec = [];
                for c_rep = 1:5
                    %changed here
                    acc_temp = ClassAccuracy_DS_PC(graspMat_noisy,graspMat_ind,0,true);
                    acc_vec = [acc_vec;acc_temp];
                end

                acc_mat = [acc_mat;acc_vec];

                i
            end


            acc_loaf{i_ind,c_ind,iter_i} = acc_mat;



        end


    end

end

