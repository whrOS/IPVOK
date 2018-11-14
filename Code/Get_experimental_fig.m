% compare different result
% @author Wang Yangyang
% 

addpath(genpath('tools'));
dbstop if error;
clear;
clc;
disp('show result');

names = {
    { 'Lena';     40000; };
    { 'Baboon';   14000; };
    { 'Airplane'; 53000; }; 
    { 'Boat';     27000; };
    { 'Peppers';  32000; };
    { 'Lake';     27000; };
    { 'Barbara';  33000; };
    { 'Elaine';   25000; };
};

mtds = {
%     {'JRTIP'; '2019'; ':o';  'k'};
    {'PVO';  '2013'; ':o'; 'r'}; 
    {'IPVO'; '2013'; ':o';  'b'};
    {'PVOK'; '2014'; ':o';  'g'};
    {'Proposed'; '2019'; '-o';  'k'};
%     {'PairwisePVO'; '2018'; '-o';  'b'};
%     {'PPVO'; '2016'; ':o';  'b'};
%     {'APPVO'; '2018'; '-o';  'k'};
%     {'SachnevEC'; '2009'; '-o';  'c'};
%     {'M2WPVO'; '2018'; '-v';  'y'};
};

for i = 1 : length(names)
    comp_main(names{i}{1}, mtds, names{i}{2});
end


