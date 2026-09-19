import pandas as pd
import matplotlib.pyplot as plt
df=pd.read_csv("Amazon_Cleaned_Dataset.csv",low_memory=False)
'''
#DISTRIBUTION OF PRODUCT CATEGORY
Category=df["Category"].value_counts()
print(Category)

Category.plot(kind='bar')
plt.title("Category Distribution")
plt.show()

#DISTRIBUTION OF PRODUCT SIZE
Size=df["Size"].value_counts()
print(Size)

Size.plot(kind='bar')
plt.title("Size Distribution")
plt.show()

#DISTRIBUTION OF STATUS

Status=df["Status"].value_counts()
print(Status)

Status.plot(kind='pie')
plt.title("Status Distribution")
plt.show()

#COUNT OF ORDERS BASED ON SHIP-CITY
city_orders=df["ship-city"].value_counts()
print(city_orders)

city_orders.head(10).plot(kind='bar')       #Top 10 cities visualization
plt.title("Top 10 cities based on orders")
plt.xlabel("City")
plt.ylabel("Number of orders")
plt.show()


#COUNT OF ORDERS BASED ON SHIP-STATE
state_orders=df["ship-state"].value_counts()
print(state_orders)

state_orders.head(10).plot(kind='bar')       #Top 10 states visualization
plt.title("Top 10 states based on orders")
plt.xlabel("State")
plt.ylabel("Number of orders")
plt.show()
'''

#COUNT OF PRODUCT SIZE BASED ON PRODUCT CATEGORY

size_category=df.groupby(["Category","Size"]).size()
print(size_category)

size_category.head(10).plot(kind='bar',figsize=(12,6))       # visualization
plt.title("Count of product size based on product category")
plt.xlabel("Category and Size")
plt.ylabel("Count")
plt.show()
