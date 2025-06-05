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
**Power calculation** 
*Power.m* – Computes and plots spectral power in theta/alpha bands.
**plotting**
*ConnGraphPlot.m*, *SpectPlot.m*, *TopoPlot.m* – Produce visualizations of the results.
You can find the paper here: https://doi.org/10.1101/2025.03.10.642502
