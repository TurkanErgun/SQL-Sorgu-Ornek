--1
create proc spPersonelGetir
@personelID int
as
select * from Personeller where PersonelID = @personelID

exec spPersonelGetir 4

--2 Dýþarýdan gönderilen bilgilere göre Nakliyecinin tüm bilgilerini güncelleyen SP yi yazýnýz
--oluþturulmasý
create proc spNakliyeciDuzenle
@nakliyeciID int,
@sirketAdi nvarchar(40),
@telefon nvarchar(24)
as
Update Nakliyeciler set SirketAdi=@sirketAdi,Telefon=@telefon where NakliyeciID = @nakliyeciID
--Kullanýmý
exec spNakliyeciDuzenle 4,'NakliyeciAdi', '(444) 123-1234'
--veya
exec spNakliyeciDuzenle @nakliyeciID=4, @sirketAdi = 'NakliyeciAdi', @telefon ='(333) 123-1234'


--3 Dýþarýdan gönderilen bilgilere göre Nakliyeci kaydeden SP yi yazýnýz
create proc spNakliyeciEkle
@sirketAdi nvarchar(40),
@telefon nvarchar(24)
as
insert into Nakliyeciler (SirketAdi,Telefon) values (@sirketAdi,@telefon)
--Kullanýmý
exec spNakliyeciEkle 'NakliyeciAdi', '(555) 123-1234'
--veya
exec spNakliyeciEkle @sirketAdi = 'NakliyeciAdi', @telefon ='(555) 123-1234'

--select * from Nakliyeciler

--4 Dýþarýdan gönderilen bilgiye göre Nakliyeciyi silen SP yi yazýnýz
--Oluþturulmasý
create proc spNakliyeciSil
@nakliyeciID int
as
delete from Nakliyeciler where NakliyeciID = @nakliyeciID
--Kullanýmý
exec spNakliyeciSil 4
--veya
exec spNakliyeciSil @nakliyeciID=4


--5 Dýþarýdan gönderilen bilgilere göre Nakliyeci kaydeden SP yi yazýnýz. Ayný telefon numarasý varsa kaydetmeyiniz.
create proc spNakliyecilerEkle
@SirketAdi nvarchar(40),
@Telefon nvarchar(24)
as
declare @sayi int
set @sayi = (Select COUNT(*) from Nakliyeciler where Telefon = @Telefon)
if @sayi>0
begin
   print 'Böyle bir telefon numarasý kayýtlý'
end
else
begin
    insert into Nakliyeciler (SirketAdi,Telefon)
	values (@SirketAdi,@Telefon)
	print 'Nakliyeci eklendi.'
end

--6 Gönderilen KategoriID ye göre ürünleri listeleyen SP yi yazýnýz.(UrunID,UrunAdi,KategoriAdi)
--Oluþturulmasý
create proc spUrunlerKategoriID
@kategoriID int
as
select u.UrunID,u.UrunAdi,k.KategoriAdi
from Urunler u inner join Kategoriler k on u.KategoriID = k.KategoriID
where k.KategoriID = @kategoriID
--Kullanýmý
exec spUrunlerKategoriID 2
--veya
exec spUrunlerKategoriID @kategoriID=2

--7 Dýþarýdan gönderilen musteriID ye göre o müþterinin satýn aldýðý ürünleri ve kaç adet satýn aldýðýný listeleyen SP yazýnýz.
-Oluþturulmasý
create PROCEDURE spMusteriUrunAdet 
@MusteriID nchar(5)
AS
SELECT u.UrunAdi, SUM(sd.Miktar) as ToplamAdet FROM Urunler u 
inner join [Satis Detaylari] sd on u.UrunID=sd.UrunID
inner join Satislar s on sd.SatisID = s.SatisID
WHERE s.MusteriID = @MusteriID
GROUP BY u.UrunAdi
--Kullanýmý
exec spMusteriUrunAdet 'ALFKI'
--veya
exec spMusteriUrunAdet @MusteriID='ALFKI'

--8 Dýþarýdan gönderilen iki tarih arasýnda sevk edilen satýþlarý listeleyen SP yi yazýnýz.
--Oluþturulmasý
create proc spSatisIkiTarih
@basTarih smalldatetime,
@bitTarih smalldatetime
as
select * from Satislar where SevkTarihi between @basTarih and @bitTarih
--Kullanýmý
exec spSatisIkiTarih '01.01.1997','02.01.1997'
--veya
exec spSatisIkiTarih @basTarih='01.01.1997',@bitTarih='02.01.1997'

 --9Dýþarýdan gönderilen SatisID ye göre yapýlan satýþýn 
 --(UrunAdi,BirimFiyati,Miktar,Ýndirim,Ýndirimli toplam fiyatý) þeklinde listeleyen SP yi yazýnýz.
 --Oluþturulmasý
Create Procedure spSatisDetay 
@SatisID int
AS
SELECT UrunAdi,
    BirimFiyati=ROUND(Od.BirimFiyati, 2),
    Miktar,
    Ýndirim=CONVERT(int, Ýndirim * 100), 
    ÝndirimliToplamFiyati=ROUND(CONVERT(money, Miktar * (1 - Ýndirim) * Od.BirimFiyati), 2)
FROM Urunler P, [Satis Detaylari] Od
WHERE Od.UrunID = P.UrunID and Od.SatisID = @SatisID
--Kullanýmý
exec spSatisDetay 10248
--veya
exec spSatisDetay @SatisID = 10248

--10 Dýþarýdan gönderilen sayý kadar en yüksek fiyata sahip ürünleri listeleyen SP yi yazýnýz. 
--Sayý gönderilmezse 10 adet ürün listeleyiniz.
--Oluþturulmasý
Create Procedure spEnPahaliUrunler
@sayi int = 10
as
SET ROWCOUNT @sayi
SELECT Urunler.UrunAdi AS TenMostExpensiveUrunler, Urunler.BirimFiyati
FROM Urunler
ORDER BY Urunler.BirimFiyati DESC
SET ROWCOUNT 0
--Kullanýmý
exec spEnPahaliUrunler 5 -- 5 tane ürün listelenir
--veya
exec spEnPahaliUrunler @sayi = 5 -- 5 tane ürün listelenir
--veya
exec spEnPahaliUrunler -- 10 tane ürün listelenir



Sql Örnekleri
Ana Sayfa  Stored Procedure Örnekleri - 1
Stored Procedure Örnekleri - 1

Yazar - Erdi YALÇIN
Temmuz 15, 20225 minute read
0



Merhaba Arkadaþlar, 

Saklý yordam (Stored Procedure), kaydedebileceðiniz hazýrlanmýþ bir SQL kodudur, böylece kod tekrar tekrar kullanýlabilir.
Bu nedenle, tekrar tekrar yazdýðýnýz bir SQL sorgunuz varsa, bunu saklý yordam olarak kaydedin ve ardýndan kullanmak için çaðýrýn.
Ayrýca, saklý yordama gönderilen parametre deðerlerine göre hareket edebilmesi için parametreleri bir saklý yordama iletebilirsiniz.
Stored Procedure Yazým Kuralý

Create Procedure procedure_Adi
-- varsa parametreler
as
Sql Kodlarý

Stored Procedure Çaðrýlmasý

exec procedure_Adi --varsa parametreler

Nortwind (Türkçe) veritabaný hakkýnda bilgi almak ve indirmek için Týklayýnýz .
Aþaðýda temel seviyeden ileri seviyeye stored procedure örnekleri mevcuttur.

Ýyi çalýþmalar dilerim.

Örnek Sorgular - 1
Örnek sorgular Northwind (Kuzeyyeli) veritabanýna göre hazýrlanmýþtýr.
Detaylý bilgi için Týklayýnýz.

1- Tüm müþterileri listeleyen SP yazýnýz.
Sorguyu görmek için týklayýnýz

2- Dýþarýdan gönderilen bilgilere göre Nakliyeci kaydeden SP yi yazýnýz
Sorguyu görmek için týklayýnýz

--Oluþturulmasý
create proc spNakliyeciEkle
@sirketAdi nvarchar(40),
@telefon nvarchar(24)
as
insert into Nakliyeciler (SirketAdi,Telefon) values (@sirketAdi,@telefon)
--Kullanýmý
exec spNakliyeciEkle 'NakliyeciAdi', '(555) 123-1234'
--veya
exec spNakliyeciEkle @sirketAdi = 'NakliyeciAdi', @telefon ='(555) 123-1234'



3- Dýþarýdan gönderilen bilgilere göre Nakliyecinin tüm bilgilerini güncelleyen SP yi yazýnýz
Sorguyu görmek için týklayýnýz

4- Dýþarýdan gönderilen bilgiye göre Nakliyeciyi silen SP yi yazýnýz
Sorguyu görmek için týklayýnýz

5- Dýþarýdan gönderilen bilgilere göre Nakliyeci kaydeden SP yi yazýnýz. Ayný telefon numarasý varsa kaydetmeyiniz.
Sorguyu görmek için týklayýnýz

6- Gönderilen KategoriID ye göre ürünleri listeleyen SP yi yazýnýz.(UrunID,UrunAdi,KategoriAdi)
Sorguyu görmek için týklayýnýz

--Oluþturulmasý
create proc spUrunlerKategoriID
@kategoriID int
as
select u.UrunID,u.UrunAdi,k.KategoriAdi
from Urunler u inner join Kategoriler k on u.KategoriID = k.KategoriID
where k.KategoriID = @kategoriID
--Kullanýmý
exec spUrunlerKategoriID 2
--veya
exec spUrunlerKategoriID @kategoriID=2



7- Dýþarýdan gönderilen musteriID ye göre o müþterinin satýn aldýðý ürünleri ve kaç adet satýn aldýðýný listeleyen SP yazýnýz.
Sorguyu görmek için týklayýnýz

--Oluþturulmasý
create PROCEDURE spMusteriUrunAdet 
@MusteriID nchar(5)
AS
SELECT u.UrunAdi, SUM(sd.Miktar) as ToplamAdet FROM Urunler u 
inner join [Satis Detaylari] sd on u.UrunID=sd.UrunID
inner join Satislar s on sd.SatisID = s.SatisID
WHERE s.MusteriID = @MusteriID
GROUP BY u.UrunAdi
--Kullanýmý
exec spMusteriUrunAdet 'ALFKI'
--veya
exec spMusteriUrunAdet @MusteriID='ALFKI'



8- Dýþarýdan gönderilen iki tarih arasýnda sevk edilen satýþlarý listeleyen SP yi yazýnýz.
Sorguyu görmek için týklayýnýz

9- Dýþarýdan gönderilen SatisID ye göre yapýlan satýþýn UrunAdi,BirimFiyati,Miktar,Ýndirim,Ýndirimli toplam fiyatý þeklinde listeleyen SP yi yazýnýz.
Sorguyu görmek için týklayýnýz

--Oluþturulmasý
Create Procedure spSatisDetay 
@SatisID int
AS
SELECT UrunAdi,
    BirimFiyati=ROUND(Od.BirimFiyati, 2),
    Miktar,
    Ýndirim=CONVERT(int, Ýndirim * 100), 
    ÝndirimliToplamFiyati=ROUND(CONVERT(money, Miktar * (1 - Ýndirim) * Od.BirimFiyati), 2)
FROM Urunler P, [Satis Detaylari] Od
WHERE Od.UrunID = P.UrunID and Od.SatisID = @SatisID
--Kullanýmý
exec spSatisDetay 10248
--veya
exec spSatisDetay @SatisID = 10248



10- Dýþarýdan gönderilen sayý kadar en yüksek fiyata sahip ürünleri listeleyen SP yi yazýnýz. Sayý gönderilmezse 10 adet ürün listeleyiniz.
Sorguyu görmek için týklayýnýz

--Oluþturulmasý
Create Procedure spEnPahaliUrunler
@sayi int = 10
as
SET ROWCOUNT @sayi
SELECT Urunler.UrunAdi AS TenMostExpensiveUrunler, Urunler.BirimFiyati
FROM Urunler
ORDER BY Urunler.BirimFiyati DESC
SET ROWCOUNT 0
--Kullanýmý
exec spEnPahaliUrunler 5 -- 5 tane ürün listelenir
--veya
exec spEnPahaliUrunler @sayi = 5 -- 5 tane ürün listelenir
--veya
exec spEnPahaliUrunler -- 10 tane ürün listelenir



--11 Dýþarýdan gönderilen iki tarih arasýnda satýþý yapýlan indirimli ürünlerin 
--UrunAdi, Ýndirim, SatisTarihi þeklinde listeleyen SP yi yazýnýz.
--Oluþturulmasý
Create Procedure spIkiTarihArasiIndirimliUrunler
@basTarih smalldatetime,
@bitTarih smalldatetime
as
Select 
u.UrunAdi,sd.Ýndirim,s.SatisTarihi
from Urunler u 
inner join [Satis Detaylari] sd on u.UrunID = sd.UrunID 
inner join Satislar s on s.SatisID = sd.SatisID
where sd.Ýndirim > 0 and
s.satisTarihi between @basTarih and @bitTarih
--Kullanýmý
exec spIkiTarihArasiIndirimliUrunler @basTarih = '01.01.1996', @bitTarih='12.12.1996'
--veya
exec spIkiTarihArasiIndirimliUrunler '01.01.1996','12.12.1996'

