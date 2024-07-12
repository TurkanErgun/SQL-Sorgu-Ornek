/*1. birirm fiyat� en y�ksek olan �r�n�n kayegori ad�n� listeleyiniz.*/
select KategoriAdi from Kategoriler where KategoriID =
(select top 1 KategoriID from Urunler order by BirimFiyati desc)

/*2.Kategori ad�nda 'on' ge�en kategorilerin urunlerini listeleyiniz.*/
select * from Urunler where kategoriID in
(select KategoriID from Kategoriler where KategoriAdi like '%10%')

/*3.Nancy adl� personelin Brezilyaya sevk etti�i sat�slar� listeleyiniz.*/
select * from Satislar where PersonelID=
(select PersonelID from Personeller where Adi='Nancy')
and SevkUlkesi='Brazil'

/*4.Japonyadan ka� farkl� �r�n tedarik edilmi�tir.*/
select count(*) from Urunler where TedarikciID in
(select TedarikciID from Tedarikciler where Ulke='Japan')

/*5.Konbu adl� �r�nden ka� adet sat�lm��t�r*/
select sum(Miktar) from [Satis Detaylari]where urunID in
(select UrunID from Urunler where UrunAdi='Konbu')

/*6.1997 y�l�nda yap�lm�� sat��lar�n en y�ksek, 
en d���k ve ortalama nakliye �cretleri ne kadard�r?*/
select
MAX(NakliyeUcreti),MIN(NakliyeUcreti),AVG(NakliyeUcreti)
from Satislar where DATEPART(YEAR,SatisTarihi)=1997

/*7.T�m �r�nleri listeleyiniz. Tablolar� basit birle�tirme ile ba�lay�n�z.*/
select /*uzun yaz�m*/
Urunler.UrunAdi,Kategoriler.KategoriAdi
from Urunler,Kategoriler						
where Urunler.KategoriID = Kategoriler.KategoriID
/*-------------------------------------------------*/
select /*k�sa yaz�m*/
u.UrunAdi, k.KategoriAdi
from Urunler u, Kategoriler k						
where u.KategoriID = k.KategoriID

/*8.T�m �r�nleri listeleyiniz. */
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

--10248 �d li sat���n urunlerini listeleyiniz.(UrunAdi,Toplam Fiyat�)
select u.UrunAdi, sd.BirimFiyati * sd.Miktar as ToplamFiyat
from [Satis Detaylari] sd
inner join Urunler u on sd.UrunID=u.UrunID
where SatisID = 10248

--En pahal� ve en ucuz �r�n� listeleyiniz


/*B�t�n m��terilerin ve personellerin ad�n� soyad�n� ve telefon 
numaras�n� listeleyiniz*/
select Adi + '' + SoyAdi as Ad, EvTelefonu,'Personel'as Tur from Personeller
union
select MusteriAdi,Telefon,'M��teri' from Musteriler

-----------------------------T�retilmi� Tablo-------------------------------
select 
Adi + '' + SoyAdi as Ad, EvTelefonu,'Personel'as Tur from Personeller
union
--(select MusteriAdi,Telefon,'M��teri' from Musteriler) yenitablo

--11.Personelleri ve ba�l� �al��t��� ki�ileri listeleyiniz
select
p1.Adi,p1.PersonelID,p2.Adi,p2.PersonelID
from Personeller p1
inner join Personeller p2 on p1.PersonelID=p2.BagliCalistigiKisi

--Her bir kategoride ka� adet �r�n var?
select 
KategoriID, COUNT(*) as sayi, avg(BirimFiyati) as ortalama
from Urunler group by KategoriID

/*Nancy adl� personelin �lkelere g�re ka� adt sat�� sevk etti�ini listeleyiniz.(Sevk 
�lkesi,Adet)*/
select SevkUlkesi,COUNT(*) from Satislar where PersonelID in 
(select PersonelID from Personeller where Adi='Nancy')
group by SevkUlkesi

--T�m ��rnlerin ka� adet sat�ld���n� listeleyiniz.(�r�n Ad�, Adet)
select u.UrunAdi,sum(Miktar) as Adet from 
Urunler u inner join [Satis Detaylari] sd
on u.UrunID= sd.UrunID
group by u.UrunAdi