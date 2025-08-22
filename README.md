# resting-state-eeg-fnirs-analysis
Analysis codes for multimodal resting-state EEG-fNIRS study on aging-related auditory decline.

This repository contains MATLAB scripts for the multimodal analysis of resting-state EEG-fNIRS data, developed for the study:  
**"Functional Characteristics of Speech Perception Decline in Healthy Aging Based on Resting-State EEG-fNIRS" (Liu et al., 2025, in review).**

## Overview
The analysis pipeline includes:
- **fNIRS connectivity analysis**  
  - Phase-Locking Value (PLV) computation from oxy-Hb signals  
  - Output: subject-level PLV matrices for graph-theoretical analysis
- **EEG preprocessing and microstate analysis**
  - ......
- **Statistical analysis scripts**
  - fNIRS PLV Group-Level Statistics
  - ......

## Current contents
- `fNIRS_PLV_calculation.m` – Compute PLV connectivity matrices from preprocessed fNIRS data.
- `fNIRS_PLV_statistics.m` – fNIRS PLV Group-Level Statistics

## Requirements
- MATLAB R2021b
- Preprocessed `.mat` files (exported from NIRS-KIT for fNIRS)
- ......

## Usage
- **`fNIRS_PLV_calculation.m`**
  - Place your preprocessed `.mat` files in the corresponding folder (e.g., `fNIRS/young/`).
  - Update the script path in `fNIRS_PLV_calculation.m`.
  - Run the script in MATLAB.
  - Output: `PLVmatrix_resting.mat`.
- **`......`**
  - ......
  - ......
  - ......
- **`......`**
  - ......
  - ......
  - ......
