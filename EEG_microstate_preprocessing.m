%% EEG Microstate Preprocessing Script
% This script preprocesses EEG data for microstate analysis:
%   1. Band-pass filtering (2–20 Hz)
%   2. Downsampling to 100 Hz
%   3. Save preprocessed data
%
% Requirements:
%   - EEGLAB (tested with version 2021.x)
%   - Input: .set files (raw or preprocessed EEG)
%   - Output: .set files (filtered + resampled)
%

clear; clc;

%% Define paths (modify if needed)
data_path = './EEG/microstate/input/';      % input folder with .set files
save_path = './EEG/microstate/output/';     % output folder
if ~exist(save_path, 'dir'); mkdir(save_path); end

cd(data_path);
files = dir('*.set');
fn = {files.name};

%% Processing loop
for i = 1:length(fn)
    % Load dataset
    EEG = pop_loadset('filename', fn{i}, 'filepath', data_path);
    EEG = eeg_checkset(EEG);

    % --- Step 1: Band-pass filter (2–20 Hz) ---
    EEG = pop_eegfiltnew(EEG, [], 2, [], true, [], 1);   % high-pass at 2 Hz
    EEG = pop_eegfiltnew(EEG, [], 20, [], false, [], 1); % low-pass at 20 Hz

    % --- Step 2: Downsample to 100 Hz ---
    EEG = pop_resample(EEG, 100);

    % --- Step 3: Save output ---
    [~, name, ~] = fileparts(fn{i});
    EEG = pop_saveset(EEG, 'filename', [name '_filtered.set'], 'filepath', save_path);
end
