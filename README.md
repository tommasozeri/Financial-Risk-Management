# Financial-Risk-Management

**CDS STATISTICS script**%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
This MATLAB script processes, analyzes, and visualizes time series data from an Excel file (CDSSPREADS.xlsx), likely containing Credit Default Swap (CDS) spreads for multiple countries.

How the Code Works
1. Data Loading and Preprocessing
Loads the Excel file into MATLAB as a table.
Converts the "Date" column to a datetime format if necessary.
Replaces any "NaN" string values in the dataset with actual numerical NaN.
Interpolates missing values using linear interpolation.
Sorts the dataset in ascending chronological order.
2. Statistical Analysis for Each Country
For each country (each column except "Date"), the code computes and displays:

Standard deviation (volatility measure).
Skewness (distribution asymmetry).
Kurtosis (distribution shape).
Mean, median, max, and min values.
3. Rolling Volatility Calculation and Plotting
Computes moving standard deviation for three rolling windows (20, 50, and 100 days).
Plots the rolling volatility for each country in a separate figure.
4. Time Series Visualization
Subplot for all countries: Shows the time series of CDS spreads in a grid layout.
Boxplot per country: Displays the statistical distribution of each country's data.
Correlation heatmap: Computes and visualizes the correlation matrix between CDS spreads of different countries.
Individual country plots: Generates separate line plots for each country's time series.
How to Use the Code
Prepare the data: Ensure that CDSSPREADS.xlsx contains a "Date" column and numerical spread values for each country.
Run the script in MATLAB.
Analyze the outputs:
View printed statistics.
Check the volatility trends.
Compare country-wise spread trends using subplots.
Observe correlations in the heatmap.
Interpret the results to understand credit risk behavior and volatility patterns across different countries.
Use Case
This script is useful for financial risk management, particularly in analyzing how different countries' CDS spreads behave over time, their volatility, and their correlations.


**CDS_HISTORICALSERIES Script**%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
This MATLAB script processes time series data from an Excel file (CDSSPREADS.xlsx), typically containing CDS spreads for different countries. The goal is to clean, normalize, align, and visualize the data for comparative analysis.

How the Code Works
Load Data

The script reads the Excel file into a MATLAB table.
Interpolate Missing Values

If any values are missing (NaN), they are filled using linear interpolation.
Filter Out Rows with Remaining Missing Values

After interpolation, any rows still containing NaN values are removed to ensure a clean dataset.
Normalize Each Series

Each time series (except the date column) is scaled to the range [0,1] to make them comparable.
Align Initial Values

The script adjusts each time series so that they all start from zero, allowing a direct comparison of their relative movements over time.
Plot the Normalized and Aligned Data

The script generates a line plot, displaying all time series in a single figure with a legend for each country.
How to Use the Code
Ensure that MATLAB is installed and the Excel file (CDSSPREADS.xlsx) is available in the current working directory.
Run the script in MATLAB.
The output will be a comparative time series plot, showing the evolution of normalized CDS spreads over time.
Expected Output
A graph where each country’s CDS spread follows a common scale.
Helps analyze trends, correlations, and relative performance between countries.

**INTERPOLATED_HS**%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
This MATLAB script reads, processes, and visualizes time series data from an Excel file (CDSSPREADS.xlsx). The purpose is to handle missing values and generate individual plots for each series.

How the Code Works
Load Data

The script imports the Excel file into a MATLAB table.
Interpolate Missing Values

If any values are missing (NaN), they are replaced using linear interpolation.
Plot Individual Time Series

For each column (excluding the date), the script generates a separate plot, showing the historical trend.
How to Use the Code
Ensure that MATLAB is installed and the Excel file (CDSSPREADS.xlsx) is in the working directory.
Run the script.
MATLAB will generate a series of plots, each representing one time series.
Expected Output
Multiple figures, each displaying a different time series.
Helps analyze trends and patterns in the data separately.
