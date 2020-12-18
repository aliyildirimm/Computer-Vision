clear all; close all; clc;
imagefiles = dir('images\*.jpg');      
nfiles = length(imagefiles);    % Number of files found
mkdir("results");

for ii = 1 : nfiles
    currentfilename = append('images\', imagefiles(ii).name);
    Iorig = imread(currentfilename);
  
    if(length(size(Iorig))==3)
        Iorig = rgb2gray(Iorig);
        Iorig2 = imnoise(Iorig,'salt & pepper',0.001);
    end
    
    edgeDetectors(Iorig, imagefiles, ii, 0);
    edgeDetectors(Iorig2, imagefiles, ii, 1);
end

% Please comment next line if you want to see all figures.
close all;