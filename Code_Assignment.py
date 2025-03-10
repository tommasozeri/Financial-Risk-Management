# %% [markdown]
# CDS 5 Years Italy

# %%
import pandas as pd
import matplotlib.pyplot as plt

# Load and clean the data
data = pd.read_csv('ITGV5YUSAC=R Overview.csv')
data[['Date', 'Price']] = data['Date;Price'].str.split(';', expand=True)
data.drop('Date;Price', axis=1, inplace=True)
data['Date'] = pd.to_datetime(data['Date'])
data['Price'] = pd.to_numeric(data['Price'], errors='coerce')

# Function to find outliers using the IQR method
def find_outliers(series):
    q1 = series.quantile(0.25)
    q3 = series.quantile(0.75)
    iqr = q3 - q1
    lower_bound = q1 - 1.5 * iqr
    upper_bound = q3 + 1.5 * iqr
    return series[(series < lower_bound) | (series > upper_bound)]

# Plotting the box plot for price data
plt.figure(figsize=(10, 5))
data['Price'].plot(kind='box', vert=False, patch_artist=True, showfliers=True,
                   flierprops={'marker': 'o', 'color': 'red', 'markerfacecolor': 'green', 'markersize': 6})
plt.title('Price Data Distribution')
plt.xlabel('Price')
plt.grid(True)
plt.tight_layout()
plt.show()

# %%
# Detecting outliers
outliers = find_outliers(data['Price'])

# Finding the top 5 highest outliers
top_5_outliers = data.loc[data['Price'].isin(outliers)].nlargest(5, 'Price')
top_5_lowest_outliers = data.loc[data['Price'].isin(outliers)].nsmallest(5, 'Price')

# Printing outliers and statistical summary
print("Outliers:\n", outliers)

# %%

print("Statistical Summary:\n", data['Price'].describe())
print("Skewness: ", data['Price'].skew())
print("Kurtosis: ", data['Price'].kurtosis())

# %%
# Print the top 5 highest outliers with their dates
print("Top 5 highest outliers:")
print(top_5_outliers[['Date', 'Price']])

# Print the top 5 lowest outliers with their dates
print("Top 5 lowest outliers:")
print(top_5_lowest_outliers[['Date', 'Price']])


