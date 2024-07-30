import json
import pandas as pd
from sklearn.neighbors import NearestNeighbors
import joblib

with open('turkey_tourist_attractions.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

rows = []
for city, attractions in data.items():
    for attraction in attractions:
        row = {
            "city": city,
            "name": attraction["name"],
            "latitude": attraction["geometry"]["location"]["lat"],
            "longitude": attraction["geometry"]["location"]["lng"],
            "address": attraction["formatted_address"],
            "rating": attraction.get("rating", 0),
            "user_ratings_total": attraction.get("user_ratings_total", 0)
        }
        rows.append(row)

df = pd.DataFrame(rows)

df = df.drop_duplicates(subset=['city', 'name', 'address'])

X = df[['latitude', 'longitude']]
neigh = NearestNeighbors(n_neighbors=5)
neigh.fit(X)

joblib.dump(neigh, 'knn_model.joblib')
df.to_csv('tourist_attractions.csv', index=False, encoding='utf-8-sig')
