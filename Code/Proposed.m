clc;
clear;

addpath(genpath('Origin Images'));
addpath(genpath('tools'));
Imgs = {'Lena', 'Baboon', 'Airplane', 'Lake', 'Peppers', 'Boat', 'Barbara', 'Elaine'};

% PVOK = load('result/Proposed_2019_Lena.mat');
% PVOK = PVOK.res;
%%
for tt = 1 : 8
    Iname = Imgs{tt};
    I = double(imread([Iname,'.bmp']));
    
    istr = ['Proposed_2019_',Iname,'.mat'];
    %%
    EdgeInfo = 18 + 2 + 2 + 18 + 20 + 18; %EC + n1 + n2 + LM + T1 + T2 + kend
    R = zeros(8, 10000000);
    cnt = 0;
    for Payload = 5000 + EdgeInfo : 1000 : 60000 + EdgeInfo
        [Payload]
        %%
        OptPSNR = 0;
        OptA = 0;
        OptB = 0;
        OptT1 = 0;
        OptT2 = 0;
        for a = 2 : 5
            for b = 2 : 5
                if a * b >= 2
%                     [Payload a b ]
                    %%
                    [NL, HPVOs, HIPVOs, Mmax, Mmin, Dmax, Dmin] = GenHists(I, a, b);
                    %%
                    [T1, T2] = GetTs(NL, HPVOs, HIPVOs, Payload);
                    %  IPVO-k Embedding
                    if ~(T1 ==0 && T1 == T2)
                        [EC, PSNR, Kend] = Embedding(NL, Mmax, Mmin, Dmax, Dmin, T1, T2, Payload);
                        if PSNR > OptPSNR
                            OptPSNR = PSNR;
                            OptA = a;
                            OptB = b;
                            OptT1 = T1;
                            OptT2 = T2;
                            PSNR = 0;
                        end
                    end
                end
            end
        end
        if OptPSNR == 0
            break;
        end
        cnt = cnt + 1;
        R(:,cnt) = [Payload-EdgeInfo, OptPSNR, OptA, OptB, OptT1, OptT2, Kend]';
    end
    res = R(:,1:cnt);
    save(istr, 'res');
end
%%
% DP
%%
% Embedding
%%
% end