%% EEG Resting-State Preprocessing Script
% This script preprocesses resting-state EEG data:
%   1. Remove unused channels
%   2. Apply high-pass, low-pass, and notch filters
%   3. Resample to 500 Hz
%   4. Save preprocessed data in .set format
%
% Requirements:
%   - EEGLAB (tested with version 2021.x)
%   - Input: .set files (raw EEG data)
%   - Output: preprocessed .set files
%
% Author: [Your Name]
% Repository: resting-state-eeg-fnirs-analysis

clear; clc;

%% Define paths (modify according to your dataset)
data_path = './EEG/raw/';              % input folder with .set files
save_path = './EEG/preprocessed/';     % output folder for preprocessed files
if ~exist(save_path, 'dir'); mkdir(save_path); end

cd(data_path);
files = dir('*.set');
fn = {files.name};

%% Preprocessing for each subject
for i = 1:length(fn)
    % Load raw EEG
    EEG = pop_loadset('filename', fn{i}, 'filepath', data_path);
    EEG = eeg_checkset(EEG);

    % --- Step 1: Remove unused channels ---
    EEG = pop_select(EEG, 'nochannel', {'CB1','CB2','M1','M2'});

    % --- Step 2: Filtering ---
    % High-pass filter (0.1 Hz)
    EEG = pop_eegfiltnew(EEG, [], 0.1, [], true, [], 1);
    % Low-pass filter (100 Hz)
    EEG = pop_eegfiltnew(EEG, [], 100, [], false, [], 1);
    % Notch filter (48–52 Hz)
    EEG = pop_eegfiltnew(EEG, 48, 52, [], 1, [], 1);

    % --- Step 3: Resample ---
    EEG = pop_resample(EEG, 500);

    % --- Optional: Keep only certain epochs ---
    % EEG = pop_selectevent(EEG, 'type',200,'deleteevents','off','deleteepochs','on');

    % --- Step 4: Save preprocessed data ---
    [~, name, ~] = fileparts(fn{i});
    EEG = pop_saveset(EEG, 'filename', [name '_preprocessed.set'], 'filepath', save_path);
end
