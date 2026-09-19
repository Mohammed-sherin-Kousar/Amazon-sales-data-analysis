import pandas as pd
import numpy as np
df=pd.read_csv("Amazon dataset.csv",low_memory=False)
print(df.head())
print(df.info())
print(df.isnull().sum())
#1.IDENTIFY AND HANDLE MISSING VALUES
text_cols=["Courier Status","ship-city","ship-state","promotion-ids"]
df[text_cols]=df[text_cols].fillna("Unknown")
print(df.info())
print(df[text_cols].isnull().sum())
num_cols=['Amount']
df[num_cols]=df[num_cols].fillna(df[num_cols].mean())
print(df[num_cols].isnull().sum())
#2.IDENTIFY AND REMOVE DUPLICATES
print("Duplicates",df.duplicated().sum())
df.drop_duplicates()
#3.CORRECT INCONSISTENT FORMATING IN COLUMNS
#Converting Amount into numeric-
#df["Amount"]=pd.to_numeric(df["Amount"],errors="coerce")
#print(df["Amount"])
#print(df.info())
df["Amount"] = df["Amount"].astype(int)
print(df["Amount"].dtype)
print(df.info())
#converting Qty into numeric
df["Qty"]=pd.to_numeric(df["Qty"],errors="coerce")
print(df.info())
#converting order date
df["Date"]=pd.to_datetime(df["Date"])
print(df.info())
#4.STANDRADIZED CATEGORICAL VALUE
df["Status"]=df["Status"].str.strip().str.upper()
print(df["Status"])
df["Category"]=df["Category"].str.strip().str.title()
print(df["Category"])
df["ship-city"]=df["ship-city"].str.strip().str.title()
print(df["ship-city"])
df["ship-state"]=df["ship-state"].str.strip().str.title()
print(df["ship-state"])
#5.TREATING OUTLIERS
Q1=df["Amount"].quantile(0.25)
Q3=df["Amount"].quantile(0.75)

IQR=Q3-Q1

lower=Q1-1.5*IQR
upper=Q3+1.5*IQR

df["Outlier_Flag"]=np.where(
    (df["Amount"]<lower) | (df["Amount"]>upper),
    "Yes",
    "No"
    )
print(df[["Amount","Outlier_Flag"]].head())
print(df[df["Outlier_Flag"]=="Yes"])
print(df["Outlier_Flag"].value_counts())
print(df.columns)
#6.DERIVED COLUMNS
df["Month"]=df["Date"].dt.month
print(df["Month"])
df["Year"]=df["Date"].dt.year
print(df["Year"])
df["Day"]=df["Date"].dt.day
print(df["Day"])
df["Weekday"]=df["Date"].dt.day_name()
print(df["Weekday"])

df["Revenue"]=df["Amount"]*df["Qty"]
print(df["Revenue"])

#7.CLEANED DATASET
df.to_csv("Amazon_Cleaned_Dataset.csv",index=False)
print("Cleaning completed successfully")
