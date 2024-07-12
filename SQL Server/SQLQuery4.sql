--1
create proc spPersonelGetir
@personelID int
as
select * from Personeller where PersonelID = @personelID

exec spPersonelGetir 4

--2 D��ar�dan g�nderilen bilgilere g�re Nakliyecinin t�m bilgilerini g�ncelleyen SP yi yaz�n�z
--olu�turulmas�
create proc spNakliyeciDuzenle
@nakliyeciID int,
@sirketAdi nvarchar(40),
@telefon nvarchar(24)
as
Update Nakliyeciler set SirketAdi=@sirketAdi,Telefon=@telefon where NakliyeciID = @nakliyeciID
--Kullan�m�
exec spNakliyeciDuzenle 4,'NakliyeciAdi', '(444) 123-1234'
--veya
exec spNakliyeciDuzenle @nakliyeciID=4, @sirketAdi = 'NakliyeciAdi', @telefon ='(333) 123-1234'


--3 D��ar�dan g�nderilen bilgilere g�re Nakliyeci kaydeden SP yi yaz�n�z
create proc spNakliyeciEkle
@sirketAdi nvarchar(40),
@telefon nvarchar(24)
as
insert into Nakliyeciler (SirketAdi,Telefon) values (@sirketAdi,@telefon)
--Kullan�m�
exec spNakliyeciEkle 'NakliyeciAdi', '(555) 123-1234'
--veya
exec spNakliyeciEkle @sirketAdi = 'NakliyeciAdi', @telefon ='(555) 123-1234'

--select * from Nakliyeciler

--4 D��ar�dan g�nderilen bilgiye g�re Nakliyeciyi silen SP yi yaz�n�z
--Olu�turulmas�
create proc spNakliyeciSil
@nakliyeciID int
as
delete from Nakliyeciler where NakliyeciID = @nakliyeciID
--Kullan�m�
exec spNakliyeciSil 4
--veya
exec spNakliyeciSil @nakliyeciID=4


--5 D��ar�dan g�nderilen bilgilere g�re Nakliyeci kaydeden SP yi yaz�n�z. Ayn� telefon numaras� varsa kaydetmeyiniz.
create proc spNakliyecilerEkle
@SirketAdi nvarchar(40),
@Telefon nvarchar(24)
as
declare @sayi int
set @sayi = (Select COUNT(*) from Nakliyeciler where Telefon = @Telefon)
if @sayi>0
begin
   print 'B�yle bir telefon numaras� kay�tl�'
end
else
begin
    insert into Nakliyeciler (SirketAdi,Telefon)
	values (@SirketAdi,@Telefon)
	print 'Nakliyeci eklendi.'
end

--6 G�nderilen KategoriID ye g�re �r�nleri listeleyen SP yi yaz�n�z.(UrunID,UrunAdi,KategoriAdi)
--Olu�turulmas�
create proc spUrunlerKategoriID
@kategoriID int
as
select u.UrunID,u.UrunAdi,k.KategoriAdi
from Urunler u inner join Kategoriler k on u.KategoriID = k.KategoriID
where k.KategoriID = @kategoriID
--Kullan�m�
exec spUrunlerKategoriID 2
--veya
exec spUrunlerKategoriID @kategoriID=2

--7 D��ar�dan g�nderilen musteriID ye g�re o m��terinin sat�n ald��� �r�nleri ve ka� adet sat�n ald���n� listeleyen SP yaz�n�z.
-Olu�turulmas�
create PROCEDURE spMusteriUrunAdet 
@MusteriID nchar(5)
AS
SELECT u.UrunAdi, SUM(sd.Miktar) as ToplamAdet FROM Urunler u 
inner join [Satis Detaylari] sd on u.UrunID=sd.UrunID
inner join Satislar s on sd.SatisID = s.SatisID
WHERE s.MusteriID = @MusteriID
GROUP BY u.UrunAdi
--Kullan�m�
exec spMusteriUrunAdet 'ALFKI'
--veya
exec spMusteriUrunAdet @MusteriID='ALFKI'

--8 D��ar�dan g�nderilen iki tarih aras�nda sevk edilen sat��lar� listeleyen SP yi yaz�n�z.
--Olu�turulmas�
create proc spSatisIkiTarih
@basTarih smalldatetime,
@bitTarih smalldatetime
as
select * from Satislar where SevkTarihi between @basTarih and @bitTarih
--Kullan�m�
exec spSatisIkiTarih '01.01.1997','02.01.1997'
--veya
exec spSatisIkiTarih @basTarih='01.01.1997',@bitTarih='02.01.1997'

 --9D��ar�dan g�nderilen SatisID ye g�re yap�lan sat���n 
 --(UrunAdi,BirimFiyati,Miktar,�ndirim,�ndirimli toplam fiyat�) �eklinde listeleyen SP yi yaz�n�z.
 --Olu�turulmas�
Create Procedure spSatisDetay 
@SatisID int
AS
SELECT UrunAdi,
    BirimFiyati=ROUND(Od.BirimFiyati, 2),
    Miktar,
    �ndirim=CONVERT(int, �ndirim * 100), 
    �ndirimliToplamFiyati=ROUND(CONVERT(money, Miktar * (1 - �ndirim) * Od.BirimFiyati), 2)
FROM Urunler P, [Satis Detaylari] Od
WHERE Od.UrunID = P.UrunID and Od.SatisID = @SatisID
--Kullan�m�
exec spSatisDetay 10248
--veya
exec spSatisDetay @SatisID = 10248

--10 D��ar�dan g�nderilen say� kadar en y�ksek fiyata sahip �r�nleri listeleyen SP yi yaz�n�z. 
--Say� g�nderilmezse 10 adet �r�n listeleyiniz.
--Olu�turulmas�
Create Procedure spEnPahaliUrunler
@sayi int = 10
as
SET ROWCOUNT @sayi
SELECT Urunler.UrunAdi AS TenMostExpensiveUrunler, Urunler.BirimFiyati
FROM Urunler
ORDER BY Urunler.BirimFiyati DESC
SET ROWCOUNT 0
--Kullan�m�
exec spEnPahaliUrunler 5 -- 5 tane �r�n listelenir
--veya
exec spEnPahaliUrunler @sayi = 5 -- 5 tane �r�n listelenir
--veya
exec spEnPahaliUrunler -- 10 tane �r�n listelenir



Sql �rnekleri
Ana Sayfa  Stored Procedure �rnekleri - 1
Stored Procedure �rnekleri - 1

Yazar - Erdi YAL�IN
Temmuz 15, 20225 minute read
0



Merhaba Arkada�lar, 

Sakl� yordam (Stored Procedure), kaydedebilece�iniz haz�rlanm�� bir SQL kodudur, b�ylece kod tekrar tekrar kullan�labilir.
Bu nedenle, tekrar tekrar yazd���n�z bir SQL sorgunuz varsa, bunu sakl� yordam olarak kaydedin ve ard�ndan kullanmak i�in �a��r�n.
Ayr�ca, sakl� yordama g�nderilen parametre de�erlerine g�re hareket edebilmesi i�in parametreleri bir sakl� yordama iletebilirsiniz.
Stored Procedure Yaz�m Kural�

Create Procedure procedure_Adi
-- varsa parametreler
as
Sql Kodlar�

Stored Procedure �a�r�lmas�

exec procedure_Adi --varsa parametreler

Nortwind (T�rk�e) veritaban� hakk�nda bilgi almak ve indirmek i�in T�klay�n�z .
A�a��da temel seviyeden ileri seviyeye stored procedure �rnekleri mevcuttur.

�yi �al��malar dilerim.

�rnek Sorgular - 1
�rnek sorgular Northwind (Kuzeyyeli) veritaban�na g�re haz�rlanm��t�r.
Detayl� bilgi i�in T�klay�n�z.

1- T�m m��terileri listeleyen SP yaz�n�z.
Sorguyu g�rmek i�in t�klay�n�z

2- D��ar�dan g�nderilen bilgilere g�re Nakliyeci kaydeden SP yi yaz�n�z
Sorguyu g�rmek i�in t�klay�n�z

--Olu�turulmas�
create proc spNakliyeciEkle
@sirketAdi nvarchar(40),
@telefon nvarchar(24)
as
insert into Nakliyeciler (SirketAdi,Telefon) values (@sirketAdi,@telefon)
--Kullan�m�
exec spNakliyeciEkle 'NakliyeciAdi', '(555) 123-1234'
--veya
exec spNakliyeciEkle @sirketAdi = 'NakliyeciAdi', @telefon ='(555) 123-1234'



3- D��ar�dan g�nderilen bilgilere g�re Nakliyecinin t�m bilgilerini g�ncelleyen SP yi yaz�n�z
Sorguyu g�rmek i�in t�klay�n�z

4- D��ar�dan g�nderilen bilgiye g�re Nakliyeciyi silen SP yi yaz�n�z
Sorguyu g�rmek i�in t�klay�n�z

5- D��ar�dan g�nderilen bilgilere g�re Nakliyeci kaydeden SP yi yaz�n�z. Ayn� telefon numaras� varsa kaydetmeyiniz.
Sorguyu g�rmek i�in t�klay�n�z

6- G�nderilen KategoriID ye g�re �r�nleri listeleyen SP yi yaz�n�z.(UrunID,UrunAdi,KategoriAdi)
Sorguyu g�rmek i�in t�klay�n�z

--Olu�turulmas�
create proc spUrunlerKategoriID
@kategoriID int
as
select u.UrunID,u.UrunAdi,k.KategoriAdi
from Urunler u inner join Kategoriler k on u.KategoriID = k.KategoriID
where k.KategoriID = @kategoriID
--Kullan�m�
exec spUrunlerKategoriID 2
--veya
exec spUrunlerKategoriID @kategoriID=2



7- D��ar�dan g�nderilen musteriID ye g�re o m��terinin sat�n ald��� �r�nleri ve ka� adet sat�n ald���n� listeleyen SP yaz�n�z.
Sorguyu g�rmek i�in t�klay�n�z

--Olu�turulmas�
create PROCEDURE spMusteriUrunAdet 
@MusteriID nchar(5)
AS
SELECT u.UrunAdi, SUM(sd.Miktar) as ToplamAdet FROM Urunler u 
inner join [Satis Detaylari] sd on u.UrunID=sd.UrunID
inner join Satislar s on sd.SatisID = s.SatisID
WHERE s.MusteriID = @MusteriID
GROUP BY u.UrunAdi
--Kullan�m�
exec spMusteriUrunAdet 'ALFKI'
--veya
exec spMusteriUrunAdet @MusteriID='ALFKI'



8- D��ar�dan g�nderilen iki tarih aras�nda sevk edilen sat��lar� listeleyen SP yi yaz�n�z.
Sorguyu g�rmek i�in t�klay�n�z

9- D��ar�dan g�nderilen SatisID ye g�re yap�lan sat���n UrunAdi,BirimFiyati,Miktar,�ndirim,�ndirimli toplam fiyat� �eklinde listeleyen SP yi yaz�n�z.
Sorguyu g�rmek i�in t�klay�n�z

--Olu�turulmas�
Create Procedure spSatisDetay 
@SatisID int
AS
SELECT UrunAdi,
    BirimFiyati=ROUND(Od.BirimFiyati, 2),
    Miktar,
    �ndirim=CONVERT(int, �ndirim * 100), 
    �ndirimliToplamFiyati=ROUND(CONVERT(money, Miktar * (1 - �ndirim) * Od.BirimFiyati), 2)
FROM Urunler P, [Satis Detaylari] Od
WHERE Od.UrunID = P.UrunID and Od.SatisID = @SatisID
--Kullan�m�
exec spSatisDetay 10248
--veya
exec spSatisDetay @SatisID = 10248



10- D��ar�dan g�nderilen say� kadar en y�ksek fiyata sahip �r�nleri listeleyen SP yi yaz�n�z. Say� g�nderilmezse 10 adet �r�n listeleyiniz.
Sorguyu g�rmek i�in t�klay�n�z

--Olu�turulmas�
Create Procedure spEnPahaliUrunler
@sayi int = 10
as
SET ROWCOUNT @sayi
SELECT Urunler.UrunAdi AS TenMostExpensiveUrunler, Urunler.BirimFiyati
FROM Urunler
ORDER BY Urunler.BirimFiyati DESC
SET ROWCOUNT 0
--Kullan�m�
exec spEnPahaliUrunler 5 -- 5 tane �r�n listelenir
--veya
exec spEnPahaliUrunler @sayi = 5 -- 5 tane �r�n listelenir
--veya
exec spEnPahaliUrunler -- 10 tane �r�n listelenir



--11 D��ar�dan g�nderilen iki tarih aras�nda sat��� yap�lan indirimli �r�nlerin 
--UrunAdi, �ndirim, SatisTarihi �eklinde listeleyen SP yi yaz�n�z.
--Olu�turulmas�
Create Procedure spIkiTarihArasiIndirimliUrunler
@basTarih smalldatetime,
@bitTarih smalldatetime
as
Select 
u.UrunAdi,sd.�ndirim,s.SatisTarihi
from Urunler u 
inner join [Satis Detaylari] sd on u.UrunID = sd.UrunID 
inner join Satislar s on s.SatisID = sd.SatisID
where sd.�ndirim > 0 and
s.satisTarihi between @basTarih and @bitTarih
--Kullan�m�
exec spIkiTarihArasiIndirimliUrunler @basTarih = '01.01.1996', @bitTarih='12.12.1996'
--veya
exec spIkiTarihArasiIndirimliUrunler '01.01.1996','12.12.1996'

