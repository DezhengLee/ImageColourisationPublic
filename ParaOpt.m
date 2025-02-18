clear all
close all
clc

% sigma1 = 100;
% sigma2 = 100;
% p = 1/2;
percentage = 0.5;
delta = 2e-4;
KernelFcn = "Gaussian";
roundScheme = "MinMax";
samplingScheme = "Uniform";
filename = 'D:\MyDesktop\MMSC Materials\Case Study _ SC\Project_Image_Colourisation\ImageColourisationApp\Pics\peppers.png';

% f = objectiveFcn(filename, percentage, sigma1, sigma2, p, delta, KernelFcn, roundScheme, samplingScheme)
f = @(para) objectiveFcn(filename, percentage, para, delta, KernelFcn, roundScheme, samplingScheme);
par0 = [100, 100, 1/2];

options = optimset('Display','iter','PlotFcns',@optimplotfval);
[x,fval,exitflag,output] = fminsearch(f,par0,options)
