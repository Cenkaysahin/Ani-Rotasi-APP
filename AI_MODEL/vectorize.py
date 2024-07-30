from sklearn.feature_extraction.text import CountVectorizer
from sklearn.neighbors import NearestNeighbors
import joblib

# Örnek eğitim verileri
texts = [
    "ADANA seyhan", "ADANA yüreğir", "ADANA çukurova",
    "ANKARA ulus", "ANKARA altındağ", "ANKARA çankaya", "ANKARA keçiören", "ANKARA sincan",
    "ANTALYA muratpaşa", "ANTALYA yatlimanı", "ANTALYA aksu", "ANTALYA konyaaltı", "ANTALYA antalya merkez",
    "BURSA yıldırım", "BURSA osmangazi", "BURSA kestel",
    "İSTANBUL fatih", "İSTANBUL beşiktaş", "İSTANBUL beyoğlu", "İSTANBUL üsküdar",
    "İZMİR konak", "İZMİR çiğli", "İZMİR balçova", "İZMİR karşıyaka", "İZMİR bornova",
    "KONYA karatay", "KONYA selçuklu", "KONYA meram",
    "KAYSERİ melikgazi", "KAYSERİ kocasinan", "KAYSERİ talas",
    "MUĞLA muğla merkez", "MUĞLA bodrum", "MUĞLA marmaris", "MUĞLA köyceğiz", "MUĞLA ula",
    "TRABZON trabzon merkez", "TRABZON ortahisar", "TRABZON maçka", "TRABZON düzköy", "TRABZON çaykara", "TRABZON boztepe", "TRABZON akçaabat"
]

# Vektörleştiriciyi eğitme
vectorizer = CountVectorizer()
X = vectorizer.fit_transform(texts)

# Modeli eğitme
model = NearestNeighbors(n_neighbors=5)
model.fit(X)

# Modeli ve vektörleştiriciyi kaydetme
joblib.dump(model, 'knn_model.joblib')
joblib.dump(vectorizer, 'vectorizer.joblib')
