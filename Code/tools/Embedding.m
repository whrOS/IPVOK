function [EC, PSNR, Kend] = Embedding(NL, Mmax, Mmin, Dmax, Dmin, T1, T2, Payload)

[A, B] = size(NL);

flag = 0;
EC = 0;
ED = 0;
for i = 1 : 1 : A
    if flag == 1
        break;
    end
    for j = 1 : 1 : B
        if NL(i,j) < T1
            % dmax
            if Mmax(i,j) == 1 % PVO
                if Dmax(i,j) == 1
                    EC = EC + 1;
                    ED = ED + 0.5;
                else % Dmax(i,j) > 1
                    ED = ED + 1;
                end
            end
            % dmin
            if Mmin(i,j) == 1 % PVO
                if Dmin(i,j) == 1
                    EC = EC + 1;
                    ED = ED + 0.5;
                else % Dmin(i,j) > 1
                    ED = ED + 1;
                end
            end
        end
        if NL(i,j) < T2
            % dmax
            if Mmax(i,j) == 2 % IPVO
                if Dmax(i,j) == 0
                    EC = EC + 1;
                    ED = ED + 1;
                else % Dmax(i,j) > 0
                    ED = ED + 2;
                end
            end
            % dmin
            if Mmin(i,j) == 2 % IPVO
                if Dmin(i,j) == 0
                    EC = EC + 1;
                    ED = ED + 1;
                else % Dmin(i,j) > 0
                    ED = ED + 2;
                end
            end
            if Mmin(i,j) == 3 % IPVO
                if Dmin(i,j) == 0
                    EC = EC + 1;
                    ED = ED + 1;
                else % Dmin(i,j) > 0
                    ED = ED + 2;
                end
            end
        end
        if EC >= Payload
            Kend = [i,j];
            PSNR = 10*log10(512*512*255^2 / ED);
            flag = 1;
            break;
        end
    end
end

end

