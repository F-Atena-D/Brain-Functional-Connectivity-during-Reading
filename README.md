# Brain-Functional-Connectivity-during-Reading

Here are the key analysis and plotting MATLAB scripts for the "Brain Functional Connectivity during Reading" project. These scripts include:   
**Connectivity computation**  
*PLV_Calc.m* – Computes phase locking value (PLV) across EEG channels. Loads preprocessed EEG data, filters it, and removes facial channels.  
*eegPLV.m* – A helper function implementing PLV computation with detailed documentation, including an example on how to call it.  
**Graph analyses**  
*Graph_Density.m* – Calculates graph density from PLV matrices.  
*Graph_Path.m* – Calculates shortest path lengths using averagePathLength and visualizes the results.  
*Graph_Similarity.m* – Computes graph similarity (Jaccard index).  
*averagePathLength.m* – Implements the Floyd–Warshall algorithm for average path length calculation.  
*Density_FreqBand.m* – Calculates and plots normalized density in alpha, beta, and gamma frequency bands.
*DensityPic.m* – For the picture‑naming task, computes density over time for several subjects, normalizes each subject’s curve, and plots the mean normalized density.  
*SimilarityPic.m* – Similar to DensityPic, but computes the Jaccard similarity of each time point to a template graph during picture naming, then normalizes and plots the average curve.   
**Power calculation**   
*Power.m* – Computes and plots spectral power in theta/alpha bands.  
**plotting**  
*ConnGraphPlot.m*, *SpectPlot.m*, *TopoPlot.m* – Produce visualizations of the results.  
**Other Matlab Files**   
*CentCalc.m* – Computes eigenvector centrality for each subject and time point, averages centrality by brain region, plots the time series, and performs ANOVA on regional centrality values.  
*ConnPercent.m* – Determines which connections increase significantly between early, middle, and late portions of a trial using rank‑sum tests, counts intra‑ and inter‑regional edges, and generates bar plots of the percentages.  
*CrossCov_FreqBand.m* – Calculates cross‑covariance between the normalized density in theta and the densities in alpha, beta, and gamma bands, plotting the results with error bars.  
*DensThreshold.m* – Examines how varying the threshold for binarizing PLV matrices affects graph density.   

This repository is the companion of the following paper: 
Delavari, F., Ekves, Z., Hancock, R., Altmann, G. T. M., & Santaniello, S. (2025). EEG-derived brain connectivity in theta/alpha frequency bands increases during reading of individual words. *Cognitive Neurodynamics*. https://doi.org/10.1007/s11571-025-10280-8
