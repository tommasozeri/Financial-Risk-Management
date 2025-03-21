# Financial-Risk-Management

**1)CDS STATISTICS script**%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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


**CDS Time Series script**%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

**INTERPOLATED_HS** %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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


%%%%% **2)Analysis of the Relationship Between CDS and Economic Variables - script** %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

This code performs a statistical analysis to study the relationship between Credit Default Swap prices for various countries and a series of economic and financial variables. It utilizes the R programming language and several libraries for data import, manipulation, analysis, and visualization.

Requirements
To run the code, you need to have the following R libraries installed:
```r
install.packages(c("readxl", "dplyr", "tidyr", "ggplot2", "nlme", "tibble", "purrr", "splines"))
```
Data Import
The code imports data from Excel and CSV files containing information on CDS, oil and gas prices, the EUR-GBP exchange rate, government bond spreads, and financial stress indices (CISS, VIX). The datasets include:
- CDS for various countries: UK, Turkey, Italy, Spain, Greece, France, Germany
- Oil and gas prices.
- EUR/GBP exchange rates.
- Government bond spreads between various countries and Germany**.
- Financial stress indicators: CISS (Composite Index for Systemic Stress) and EURO STOXX50 (provides a blue-chip representation of supersector leaders in the Euro-Zone).

Data Cleaning and Preparation
After importing, the code performs the following operations:
- Converts dates to `Date` format and selects only the relevant column of the closing price of the time series data. Then it renames columns for better readability.
- Merges datasets based on date, retaining only common rows and converts variables to numeric format for statistical analysis.

**Linear Regression Models** %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A separate linear regression is performed for each country, where the dependent variable is the CDS price, while the independent variables include:
- Oil and gas prices.
- Exchange rates.
- Government bond spreads (Spread with the BUND Bond and the selected countries, while for Germany we used the Spread to the US 10 Year Treasury Bond.
- Financial stress indices cited before.
The regression functions incorporate cubic splines (`bs()`) and natural polynomial functions (`ns()`) to capture nonlinear relationships between variables, where the knots where decided looking at the scatter plots below in the code.
Linear Rgeression summaries were also printed for better readability and analysis and shown to be later used in the paper.

%%% **Visualization of Results** %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
To better understand the relationship between CDS and economic variables and use them to decide the knots for the functions decided later scatter plots (`ggplot2`) are created to show the relationship between:
- CDS vs Oil price.
- CDS vs EUR/GBP exchange rate.
- CDS vs Gas price.
- CDS vs Government bond spreads.
- CDS vs Financial stress indices (CISS, VIX).
After this, some other scatter plots, including the linear regression line in red, were plotted to assess the differences between the values predicted by the model and the values of actual CDS prices. This was done also to assess the accuracy of the predictions.

This script was really useful because it highlited the correlation between the CDS prices and the various varible s that we included in the regression which were picked by us in a way that they would also reflect the different macroeconomic conditions that had affected the time period that was taken into consideration in the analysis. 

%%% **3)UK ANALYSIS** %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

## Overview
This repository contains three Python scripts that perform financial risk analysis using economic indicators. The scripts estimate the coefficients for a Z-Score model, calculate the Z-Score for given economic conditions, and use regression analysis to predict Credit Default Swaps (CDS) values based on Z-Scores.

---

## 1. Estimation of Z-Score Coefficients

### **File**: `estimate_zscore_coefficients.py`

### **Description**
This script estimates the coefficients for the Z-Score model using historical economic data and an Ordinary Least Squares (OLS) regression. The regression analyzes the relationship between a country's default risk and key macroeconomic variables.

### **Usage**
1. Ensure you have Python installed with the required libraries: `pandas` and `statsmodels`.
2. Run the script to print the regression summary, which includes the estimated coefficients.

### **Purpose**
The estimated coefficients are used in the second script to compute the Z-Score, an indicator of default risk.

---

## 2. Calculation of Z-Score

### **File**: `calculate_zscore.py`

### **Description**
This script calculates the Z-Score for specific years based on macroeconomic data and the previously estimated regression coefficients.

### **Usage**
1. Ensure you have Python installed with `pandas`.
2. Update the script with the estimated coefficients from the first script.
3. Run the script to compute and print the Z-Score for each year in the dataset.

### **Purpose**
The Z-Score is a key metric for assessing a country's financial stability and default risk.

---

## 3. Regression Analysis of CDS and Z-Score & Predictions

### **File**: `cds_zscore_regression.py`

### **Description**
This script performs a regression analysis between Credit Default Swaps (CDS) and Z-Score values. It also predicts future Z-Scores and CDS values based on historical trends.

### **Usage**
1. Ensure you have Python installed with `pandas`, `scipy`, `sklearn`, and `numpy`.
2. Run the script to:
   - Perform a linear regression of CDS against Z-Score.
   - Calculate the adjusted Z-Score based on regression coefficients.
   - Predict Z-Score and CDS values for the next five years.
   - Display statistical evaluation metrics of the regression models.

### **Purpose**
This analysis helps in understanding the relationship between Z-Score and CDS values, providing insights into future financial stability and credit risk.

---

## Requirements
Ensure you have the following Python libraries installed:
```bash
pip install pandas statsmodels scipy scikit-learn numpy
```

---



