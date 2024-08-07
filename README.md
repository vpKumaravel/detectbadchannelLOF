# detectbadchannelLOF
The repository contains the EEGLAB plugin to detect and remove EEG bad channels using the Local Outlier Factor (LOF) algorithm. It is a part of the Newborn EEG Artifact Removal (NEAR) pipeline.

# How to use NEAR Channel Rejection Tool (9/2/2022) <br />

NEAR detects bad channels using 3 methods (indicated as 3 checkboxes in the GUI). <br />

![image](https://user-images.githubusercontent.com/48288235/153261271-4a48755a-cc89-472f-8442-b93d390524b8.png)

**1) Remove Flatlines:** Tick the checkbox if you want to detect and remove flat-line (constant amplitude) channels. The method is borrowed from Clean_RawData Plugin. By default, the method looks for channels that have at least 5 seconds of flat-lines . We strongly recommend this method to be included in your artifacts rejection scheme with the default 5s value.

**2) Remove Outliers (LOF Method):** Tick the checkbox if you want to detect bad channels using a robust algorithm: Local Outlier Factor (LOF). In theory, if a channel has an LOF score greater than 1, it should be "bad". 

**2a)** The textbox "LOF Cut-off" indicates the cut-off threshold to detect bad channels. We suggest finding optimal threshold using training-testing split. For example, we found 2.5 to be optimal on our Newborn datasets. Look for scripts in the \tuneLOF folder for a template script to find optimal threshold. In general, we observed that for adult EEG, this threshold can be around 1.5, for Infants EEG, around 2 and for Newborns, around 2.5.

**2b)** LOF computes distance metric to compute the final LOF scores. We observed that 'euclidean' distance metric performs slightly worse than 'seuclidean' (Standard Euclidean). Hence, it appears as the default option. We suggest the same for your datasets and you can safely use this setting as it is.

**2c)** Adaptive thresholding scheme is introduced to deal with "that" one subject with a totally different distribution compared to the rest. The default threshold might remove a lot more channels for this dataset. By default, the toolbox will increase the LOF Cut-off value by 1 if the current cut-off removes more than 10% of total numbe of channels. Alternatively, if you do not want to change the threshold according to the % of bad channels, you can leave this text box empty or []. We suggest NOT using adaptive thresholding in your first run, and you can evaluate the list of bad channels removed with the static threshold (e.g., 2.5). From the results, you can see if adaptive thresholding is useful for you or not.

**3) Detect Motion Noise (Spectral Analysis):** Tick this checkbox if you want to perform a frequency analysis (using windowed-periodogram approach) to detect bad channels contaminated with motion noise (that usually in the low-frequency range). We observed that this method didn't bring any significant changes to the overall bad channel detection performance, so we keep it optional. 

**3a)** You enter the frequency band you think important to detect bad channels (for adults, it can be [20 40] Hz, as an example).
**3b)** Enter the window length in seconds 
**3c)** Enter the overlapping factor (between 0 and 1, 0 indicates [no overlapping])
**3d)** Enter the SD threshold to detect bad channels from the computed power values.

Okay, we have now set the parameters. Now, click on "OK". 
(It might take a few minutes to set up parallel toolbox in MATLAB, when you run for the first time).

Note that LOF is computed only on "non-flat-line" channels i.e., channels detected by method 1) will not be included for LOF analysis, because they are just [flat].

![image](https://user-images.githubusercontent.com/48288235/153265410-ca83a801-5ec3-4abd-8a10-3479a05cec1c.png)


As an output of LOF algorithm, you see a simple bar plot as above. For each channel on X axis, you see the LOF score on Y axis. This will give you idea on the quality of your overall signal.


![image](https://user-images.githubusercontent.com/48288235/153265845-b7057d69-f0ab-4c63-8ad3-169ae4cd737a.png)

In compliance with other EEGLAB plugins, NEAR provides a scroll plot as shown above. The "bad" channels detected are marked in red (you find the flat channel 76, and an unknown jumping electrode in the screenshot, detected as bad by NEAR).

Then, you simply click on **REJECT** button. You will find another window like the one below:

![image](https://user-images.githubusercontent.com/48288235/153266592-39b304c0-ce61-46bf-8d32-3460065ec24a.png)

Now, you find all the "RED" channels listed over here. You might add or remove some of the channels, as you wish. On click of "Ok" button, a new dataset free from bad channels would be created! Enjoy!

**How to run NEAR Bad Channel Rejection Tool in Command-Line?**

```Matlab
[EEG, flat_ch, lof_ch, periodo_ch, LOF_vec, thresh_lof_update] = NEAR_getBadChannels(EEG, 1, 5, 1, 2.5, 'seuclidean', 10, 0,[], [], [], [], 0);
badChans = sort(unique(union(flat_ch, lof_ch)));
EEG = pop_select(EEG, 'nochannel', badChans);
```

(please use command-line execution with prompt attention on the parameters!)

### Update (16-07-2024)

The LOF algorithm is now available also on MNE-Python to use for EEG and MEG bad channel detection. Let me know how good is it for MEG data.

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version. <br />

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. <br />

You should have received a copy of the GNU General Public License along with this program; if not, see http://www.gnu.org/licenses/.

Disclaimer: This software does not come with any warranty. It is meant only for research purposes and not clinical diagnosis.

### Tutorials

(0) To tune LOF threshold, please refer to the tutorial [here](https://github.com/vpKumaravel/vpkumaravel.github.io/wiki/How-to-tune-LOF-threshold-parameter%3F)

(1) To tune ASR parameters for your dataset, please refer to the scripts [here](https://github.com/vpKumaravel/vpkumaravel.github.io/wiki/How-to-tune-ASR-parameter%3F).

(2) To use NEAR as an end-to-end automated pipeline, please refer to this tutorial [page](https://github.com/vpKumaravel/vpkumaravel.github.io/wiki/Step%E2%80%90by-step-Tutorial-on-Newborns-EEG-Artifact-Removal-(NEAR)-pipeline).

### Citation 

1) BibTeX

```
@article{NEAR2022,
  title={NEAR: An artifact removal pipeline for human newborn EEG data},
  author={V.P. Kumaravel, E.Farella, E.Parise, and M.Buiatti},
  journal={Developmental Cognitive Neuroscience (Special Issue: EEG Methods for Developmental Cognitive Neuroscientists: A Tutorial Approach)},
  doi={https://doi.org/10.1016/j.dcn.2022.101068},
  year={2022}
}


@Article{LOF2022,
AUTHOR = {Kumaravel, Velu Prabhakar and Buiatti, Marco and Parise, Eugenio and Farella, Elisabetta},
TITLE = {Adaptable and Robust EEG Bad Channel Detection Using Local Outlier Factor (LOF)},
JOURNAL = {Sensors},
VOLUME = {22},
YEAR = {2022},
NUMBER = {19},
ARTICLE-NUMBER = {7314},
URL = {https://www.mdpi.com/1424-8220/22/19/7314},
DOI = {10.3390/s22197314}
}
```

### Papers used LOF for EEG Bad Channel Detection

[1] Bursting with Potential: How Sensorimotor Beta Bursts Develop from Infancy to Adulthood
Holly Rayson, Maciej J. Szul, Perla El-Khoueiry, Ranjan Debnath, Marine Gautier-Martins, Pier F. Ferrari, Nathan Fox, James J. Bonaiuto
Journal of Neuroscience 6 December 2023, 43 (49) 8487-8503; DOI: 10.1523/JNEUROSCI.0886-23.2023
