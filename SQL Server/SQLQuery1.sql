/*1. birirm fiyatý en yüksek olan ürünün kayegori adýný listeleyiniz.*/
select KategoriAdi from Kategoriler where KategoriID =
(select top 1 KategoriID from Urunler order by BirimFiyati desc)

/*2.Kategori adýnda 'on' geçen kategorilerin urunlerini listeleyiniz.*/
select * from Urunler where kategoriID in
(select KategoriID from Kategoriler where KategoriAdi like '%10%')

/*3.Nancy adlý personelin Brezilyaya sevk ettiði satýslarý listeleyiniz.*/
select * from Satislar where PersonelID=
(select PersonelID from Personeller where Adi='Nancy')
and SevkUlkesi='Brazil'

/*4.Japonyadan kaç farklý ürün tedarik edilmiþtir.*/
select count(*) from Urunler where TedarikciID in
(select TedarikciID from Tedarikciler where Ulke='Japan')

/*5.Konbu adlý üründen kaç adet satýlmýþtýr*/
select sum(Miktar) from [Satis Detaylari]where urunID in
(select UrunID from Urunler where UrunAdi='Konbu')

/*6.1997 yýlýnda yapýlmýþ satýþlarýn en yüksek, 
en düþük ve ortalama nakliye ücretleri ne kadardýr?*/
select
MAX(NakliyeUcreti),MIN(NakliyeUcreti),AVG(NakliyeUcreti)
from Satislar where DATEPART(YEAR,SatisTarihi)=1997

/*7.Tüm ürünleri listeleyiniz. Tablolarý basit birleþtirme ile baðlayýnýz.*/
select /*uzun yazým*/
Urunler.UrunAdi,Kategoriler.KategoriAdi
from Urunler,Kategoriler						
where Urunler.KategoriID = Kategoriler.KategoriID
/*-------------------------------------------------*/
select /*kýsa yazým*/
u.UrunAdi, k.KategoriAdi
from Urunler u, Kategoriler k						
where u.KategoriID = k.KategoriID

/*8.Tüm ürünleri listeleyiniz. */
select 
p.Adi + '' + p.SoyAdi as PersonelAdi, s.*
from Satislar s, Personeller p
where s.PersonelID=p.PersonelID

/*9.*/
select
u.KategoriID,UrunAdi,t.SirketAdi,k.KategoriAdi
from 
Urunler u inner join Kategoriler k on u.KategoriID = k.KategoriID
inner join Tedarikciler t on u.TedarikciID = t.TedarikciID

--10248 ýd li satýþýn urunlerini listeleyiniz.(UrunAdi,Toplam Fiyatý)
select u.UrunAdi, sd.BirimFiyati * sd.Miktar as ToplamFiyat
from [Satis Detaylari] sd
inner join Urunler u on sd.UrunID=u.UrunID
where SatisID = 10248

--En pahalý ve en ucuz ürünü listeleyiniz


/*Bütün müþterilerin ve personellerin adýný soyadýný ve telefon 
numarasýný listeleyiniz*/
select Adi + '' + SoyAdi as Ad, EvTelefonu,'Personel'as Tur from Personeller
union
select MusteriAdi,Telefon,'Müþteri' from Musteriler

-----------------------------Türetilmiþ Tablo-------------------------------
select 
Adi + '' + SoyAdi as Ad, EvTelefonu,'Personel'as Tur from Personeller
union
--(select MusteriAdi,Telefon,'Müþteri' from Musteriler) yenitablo

--11.Personelleri ve baðlý çalýþtýðý kiþileri listeleyiniz
select
p1.Adi,p1.PersonelID,p2.Adi,p2.PersonelID
from Personeller p1
inner join Personeller p2 on p1.PersonelID=p2.BagliCalistigiKisi

--Her bir kategoride kaç adet ürün var?
select 
KategoriID, COUNT(*) as sayi, avg(BirimFiyati) as ortalama
from Urunler group by KategoriID

/*Nancy adlý personelin ülkelere göre kaç adt satýþ sevk ettiðini listeleyiniz.(Sevk 
Ülkesi,Adet)*/
select SevkUlkesi,COUNT(*) from Satislar where PersonelID in 
(select PersonelID from Personeller where Adi='Nancy')
group by SevkUlkesi

--Tüm üürnlerin kaç adet satýldýðýný listeleyiniz.(Ürün Adý, Adet)
select u.UrunAdi,sum(Miktar) as Adet from 
Urunler u inner join [Satis Detaylari] sd
on u.UrunID= sd.UrunID
group by u.UrunAdi