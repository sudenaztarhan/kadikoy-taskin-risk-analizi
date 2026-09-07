## Proje Hakkında

Bu proje, İstanbul'un Kadıköy ilçesinde taşkın riskinin değerlendirilmesi amacıyla geliştirilmiş CBS tabanlı bir analiz çalışmasıdır.

Çalışma kapsamında, farklı uzaktan algılama ve sayısal arazi verileri PostgreSQL/PostGIS ortamında bir araya getirilerek taşkın riskini temsil eden bir risk modeli oluşturulmuştur. Analizde **NDWI, Sayısal Yükseklik Modeli (DEM), eğim (Slope) ve akış birikimi (Flow Accumulation)** olmak üzere dört temel mekânsal parametre kullanılmıştır.

Her bir parametre, taşkın oluşumuna etkisi dikkate alınarak farklı risk sınıflarına ayrılmış ve bu sınıflara risk puanları atanmıştır. Parametrelerden elde edilen puanların toplanmasıyla, toplam taşkın riskini gösteren bir raster veri üretilmiştir.

Projenin temel amacı, farklı raster veri kaynaklarının **PostGIS kullanılarak işlenmesi, ortak bir analiz gridinde birleştirilmesi ve mekânsal risk sınıflandırmasının SQL tabanlı olarak gerçekleştirilmesi** süreçlerini ortaya koymaktır.

Çalışmada kullanılan başlıca teknolojiler ve araçlar:

* **QGIS** — raster ve vektör verilerin hazırlanması ve görselleştirilmesi
* **PostgreSQL / PostGIS** — mekânsal verilerin depolanması ve raster analizlerinin gerçekleştirilmesi
* **SQL** — raster sınıflandırma, yeniden örnekleme, mozaikleme ve risk puanlarının birleştirilmesi
* **Sentinel-2** — NDWI üretiminde kullanılan uzaktan algılama verisi
* **DEM** — yükseklik ve topoğrafik değerlendirmeler
* **Slope** — arazi eğiminin değerlendirilmesi
* **Flow Accumulation** — yüzey akışının birikme eğiliminin değerlendirilmesi

### Veri Gizliliği

Çalışmanın analiz aşamasında mahalle ve yapı verilerinden de yararlanılmış olmakla birlikte, **kurumsal veri gizliliği ve paylaşım kısıtlamaları nedeniyle bu verilere ait dosyalar ve bu veriler üzerinden üretilen mahalle ve yapı bazlı sonuçlar GitHub repository'sinde paylaşılmamaktadır.**

Bu nedenle repository, paylaşımına izin verilen **NDWI, DEM, Slope ve Flow Accumulation** verileri ile bu verilere yönelik analiz kodlarını içermektedir.

Bu düzenleme, projenin teknik analiz sürecinin açık bir şekilde paylaşılmasını sağlarken, gizlilik kapsamında bulunan mekânsal verilerin korunmasını amaçlamaktadır.
