function [NL, HPVOs, HIPVOs, Mmax, Mmin, Dmax, Dmin] = GenHists(I, a, b)

[A, B] = size(I);
Tmax = 2048;
HPVOs = cell(1,Tmax); % T = 0 - Tmax
for i = 1:Tmax
    HPVOs{i} = zeros(1,256);
end
HIPVOs = cell(1,Tmax); % T = 0 - Tmax
for i = 1:Tmax
    HIPVOs{i} = zeros(1,256);
end

HH = zeros(1,256);
HHH = zeros(1,256);
aa = 0;

NL = zeros(floor((A-2)/a),floor((B-2)/b));
Mmax = zeros(floor((A-2)/a),floor((B-2)/b));
Mmin = zeros(floor((A-2)/a),floor((B-2)/b));
Dmax = zeros(floor((A-2)/a),floor((B-2)/b));
Dmin = zeros(floor((A-2)/a),floor((B-2)/b));
for i = 1:floor((A-2)/a)
    for j = 1:floor((B-2)/b)
        for ii = 1:a+1
            for jj = 1:b+2
                if ii == a+1 || jj == b+1 || jj == b+2
                    NL(i,j) = NL(i,j) + abs(I(a*(i-1)+ii,b*(j-1)+jj) - I(a*(i-1)+ii+1,b*(j-1)+jj));
                end
            end
        end
        for ii = 1:a+2
            for jj = 1:b+1
                if ii == a+1 || ii == a+2 || jj == b+1
                    NL(i,j) = NL(i,j) + abs(I(a*(i-1)+ii,b*(j-1)+jj) - I(a*(i-1)+ii,b*(j-1)+jj+1));
                end
            end
        end
        if NL(i,j) < Tmax
            X = I(a*(i-1)+1:a*i,b*(j-1)+1:b*j);
            X = X(:);
            [Y, In] = sort(X);
            % dmax
            if Y(a*b) > Y(a*b-1) % PVO
                % >= 1
                dmax = Y(a*b) - Y(a*b-1);
                HPVOs{NL(i,j)+1}(dmax+1) = HPVOs{NL(i,j)+1}(dmax+1) + 1;
                Mmax(i,j) = 1;
            else % Y(a*b) = Y(a*b-1) IPVO
                if Y(a*b-2) ~= Y(a*b-1)
                    if a*b == 4 && Y(4) == Y(3) && Y(2) == Y(1)
                        aa = aa  + 1;
                        dmax =  -1;
                        Mmax(i,j) = 3;
                    else
                        if In(a*b-2) < min(In(a*b), In(a*b-1)) % In(a*b-2) < In(a*b) and In(a*b-2) < In(a*b-1)
                            % Y(a*b)/Y(a*b-1) - Y(a*b-2) >= 0
                            dmax = Y(a*b) - Y(a*b-2);
                            HH(dmax+1) = HH(dmax+1) + 1;
                        else % In(a*b-2) > In(a*b) or In(a*b-2) > In(a*b-1)
                            % Y(a*b)/Y(a*b-1) - Y(a*b-2) >= 1
                            dmax = Y(a*b) - Y(a*b-2)-1;
                            HHH(dmax+1) = HHH(dmax+1) + 1;
                        end
                        HIPVOs{NL(i,j)+1}(dmax+1) = HIPVOs{NL(i,j)+1}(dmax+1) + 1;
                        Mmax(i,j) = 2;
                    end
                end
            end
            Dmax(i,j) = dmax;
            % dmin
            if Y(2) > Y(1) % PVO
                % >= 1
                dmin = Y(2) - Y(1);
                HPVOs{NL(i,j)+1}(dmin+1) = HPVOs{NL(i,j)+1}(dmin+1) + 1;
                Mmin(i,j) = 1;
            else % Y(2) = Y(1) IPVO
                if a*b == 4 && Y(4) == Y(3) && Y(2) == Y(1)
                    Mmin(i,j) = 3;
                    dmin = 0;
                else
                    if In(3) > max(In(2), In(1)) % In(3) > In(1) and In(3) < In(2)
                        % Y(3) - Y(1)/Y(2) >= 0
                        dmin = Y(3) - Y(1);
                        HH(dmin+1) = HH(dmin+1) + 1;
                    else % In(3) < In(1) or In(3) < In(2)
                        % Y(3) - Y(1)/Y(2) >= 1
                        dmin = Y(3) - Y(1)-1;
                        HHH(dmin+1) = HHH(dmin+1) + 1;
                    end
                    Mmin(i,j) = 2;
                end
                HIPVOs{NL(i,j)+1}(dmin+1) = HIPVOs{NL(i,j)+1}(dmin+1) + 1;
            end
            Dmin(i,j) = dmin;
            
        end
    end
end
aa
end