# resting-state-eeg-fnirs-analysis
Analysis codes for multimodal resting-state EEG-fNIRS study on aging-related auditory decline.

This repository contains MATLAB scripts for the multimodal analysis of resting-state EEG-fNIRS data, developed for the study:  
**"Functional Characteristics of Speech Perception Decline in Healthy Aging Based on Resting-State EEG-fNIRS" (Liu et al., 2025, in review).**

## Overview
The analysis pipeline includes:
- **fNIRS connectivity analysis**  
  - Phase-Locking Value (PLV) computation from oxy-Hb signals  
  - Output subject-level PLV matrices for graph-theoretical analysis
- **EEG microstate analysis**
  - preprocesses resting-state EEG data
  - 
- **Statistical analysis scripts**
  - fNIRS PLV Group-Level Statistics
  - ......

## Current contents
- `fNIRS_PLV_calculation.m` – Compute PLV connectivity matrices from preprocessed fNIRS data.
- `fNIRS_PLV_ROI_calculation.m` – extracts ROI-level oxyHb signals from preprocessed fNIRS data and computes pairwise PLV matrices for each subject.
- `fNIRS_PLV_statistics.m` – fNIRS PLV Group-Level Statistics
- `EEG_preprocessing.m` – preprocesses resting-state EEG data
- `EEG_microstate_preprocessing.m` – preprocesses EEG data for microstate analysis

## Requirements
- MATLAB R2021b
- Preprocessed `.mat` files (exported from NIRS-KIT for fNIRS)
- EEGLAB
- Cartool software
