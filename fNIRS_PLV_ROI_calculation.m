%% fNIRS Resting-State PLV Calculation at ROI Level
% This script extracts ROI-level oxyHb signals from preprocessed fNIRS data
% and computes pairwise PLV (phase-locking value) matrices for each subject.
% The output can be used for group-level statistical analysis.
%
% Requirements:
%   - Input: subject-level .mat files containing variable "oxy" (time x channels)
%   - Output: PLV matrices (ROI x ROI x subjects)

clear; clc; close all;

%% === Step 1: ROI extraction ===
% Define mapping from channels to 12 ROIs
columns_indices = {
    [2, 3, 5, 8, 10],       % 1: DLPFC_L
    [21, 22, 23, 26],       % 2: DLPFC_R
    [4, 7],                 % 3: Broca_L
    [24, 25],               % 4: Broca_R
    [6, 16],                % 5: STG_L
    [38],                   % 6: STG_R
    [9, 12, 13, 15],        % 7: SMC_L
    [27, 28, 29, 30, 31, 32], % 8: SMC_R
    [11],                   % 9: PAC_L
    [33],                   % 10: PAC_R
    [14, 17, 19, 20],       % 11: Wernicke_L
    [35, 36, 37, 39, 40]    % 12: Wernicke_R
};

mat_files = dir('sub*.mat'); % subject files

for file = mat_files'
    data = load(file.name);
    oxy = data.oxy; % time x channels
    
    ROI_oxy = zeros(size(oxy,1), 12);
    for i = 1:length(columns_indices)
        ROI_oxy(:, i) = mean(oxy(:, columns_indices{i}), 2);
    end
    
    [~, name, ~] = fileparts(file.name);
    new_file_name = ['ROI_' name '.mat'];
    save(new_file_name, 'ROI_oxy');
end

%% === Step 2: PLV calculation ===
ConditionDir = pwd; % current folder
Condition_Files = dir(fullfile(ConditionDir,'ROI_sub*.mat')); 
FileNames = {Condition_Files.name};

for sub = 1:length(FileNames)
    load(fullfile(ConditionDir, FileNames{sub}));
    nROIs = size(ROI_oxy,2);
    for i = 1:nROIs
        for j = 1:nROIs
            if i ~= j
                % Hilbert transform to extract phase
                phase_i = angle(hilbert(ROI_oxy(:,i)));
                phase_j = angle(hilbert(ROI_oxy(:,j)));
                % Phase difference
                rp = phase_i - phase_j;
                % PLV computation
                plv_oxy(i,j,sub) = abs(sum(exp(1i*rp)) / length(rp));
            else
                plv_oxy(i,j,sub) = 1; % self-connection set to 1
            end
        end
    end
    waitbar(sub/length(FileNames));
end

save PLVmatrix_resting.mat plv_oxy

%% === Step 3: Group-level average visualization ===
plv_oxy_avg = mean(plv_oxy,3);

figure;
imagesc(1:nROIs, 1:nROIs, plv_oxy_avg);
caxis([0 1]);
colormap('parula');
colorbar;
title('Group-level Average PLV Matrix (ROI x ROI)');
