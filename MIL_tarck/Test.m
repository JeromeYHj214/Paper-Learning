clc;clear;close all;
load('a.mat')
n = 3;
R = [100 0;0 100];
Z = em_gmm(a,n,R)
