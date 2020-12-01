clear all;close all;clc;
load ex2_X1.mat;

 X1_cad = [];
for i = 1:140
    X1_cad = [X1_cad X1{1,i}];
end

max_val = max(X1_cad);
min_val = min(X1_cad);

X1_cad_ratio = zeros(1, max_val-min_val+1);
%X1_cad_ratio = zeros(1, max_val);
for i = min_val:max_val
   count = length(find( X1_cad == i));
   X1_cad_ratio(i+1-min_val) = count / 140;
end

figure;
set(gcf,'color','white');
b=bar(X1_cad_ratio);
set(gca,'YLim',[0 0.5]);
ylabel('Frequency');
xlabel('Cardinality n');
title('Cardinality histogram');
set(gca,'XTickLabel',{'40','45','50','55','60','65','70','75','80'});
set(b(1),'colorface','r');
