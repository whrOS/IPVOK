function [OptT1, OptT2] = GetTs(NL, HPVOs, HIPVOs, Payload)

NLs = unique(NL);
NLNum = numel(NLs);

for i = 2 : 1 : numel(HPVOs)
    HPVOs{i} = HPVOs{i} + HPVOs{i-1};
end
for i = 2 : 1 : numel(HIPVOs)
    HIPVOs{i} = HIPVOs{i} + HIPVOs{i-1};
end

% HPVOs{63}
% HIPVOs{113}

% pre-calculation
ED1 = [];
EC1 = [];
ED2 = [];
EC2 = [];
for i = 1 : 1 : numel(HPVOs)
    EC1(i) = HPVOs{i}(1 + 1);
    ED1(i) = 0.5 * HPVOs{i}(1 + 1) + sum(HPVOs{i}(1+2 : end));
    EC2(i) = HIPVOs{i}(0 + 1);
    ED2(i) = 1 * HIPVOs{i}(0 + 1) + 2*sum(HIPVOs{i}(0+2 : end));
end

OptRatio = 1000000;
OptT1 = 0;
OptT2 = 0;

EC = EC1(end) + EC2(end);
if EC < Payload
%     fprintf("No Enough Embedding Capacity: %d < %d \n", EC, Payload);
    return;
end

for i = 1 : 1 : NLNum
    T1 = NLs(i)+1;
    for j = 1 : 1 : NLNum
        T2 = NLs(j)+1;
        if EC1(T1) + EC2(T2) >= Payload
            Ratio = (ED1(T1) + ED2(T2)) / (EC1(T1) + EC2(T2));
            if Ratio < OptRatio
                OptRatio = Ratio;
                OptT1 = T1;
                OptT2 = T2;
            end
        end
    end
end

% [ED1(OptT1) + ED2(OptT2) EC1(OptT1) + EC2(OptT2) OptRatio]
% 
end

