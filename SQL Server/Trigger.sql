--Northwind db de çalýþtýrýlan
--Bolge ekleyen trigger 
create trigger triBolgeEkle
on Bolge
after insert
as
begin 
	declare @bolge nvarchar(50)
	set @bolge = (select BolgeTanimi from inserted)--inserted: tabloya insert edilen verilerin tutulduðu tablo
	print (@bolge + ' Adlý yeni bir bolge eklendi')
end
--------------------------------------------------------
--Bolge silen trigger
create trigger triBolgeSil
on Bolge	--Nerde çalýþsýn
after delete	--Ne zaman çalýþacak
as
begin 
	declare @bolge nvarchar(50)		--nvarchar:exec edildiðinde silinen veri ile cümle arasýna boþluk ekler 
	set @bolge = (select BolgeTanimi from deleted)
	print (@bolge + ' adlý bolge silindi')
end
--------------------------------------------------------
--Bolge güncelleyen trigger
create trigger triBolgeDuzenle
on Bolge
after update
as
	declare @bolgeYeni nvarchar(50), @bolgeEski nvarchar(50)
	set @bolgeYeni = (select BolgeTanimi from inserted)
	set @bolgeEski = (select BolgeTanimi from deleted)
	print (trim(@bolgeEski) + 'yerine' + trim (@bolgeYeni) + 'eklendi')
end
/*
UPDATER tablosu yoktur. Update Komutu kendi içinde insert ve delete kullanýr.
Bu nedenden dolayý veriyi inserted ve deleted tablolarýndan alýrýz
Trim: Fazlalýk boþluklarý siler.
*/
-----------------------------------------------------------------------------
--FirmaProjeTakipDB de çalýþtýrýlan
--Silinen kayýtlarý yedekleme
create trigger triIzinSil
on Izin
after delete
as
begin 
	insert into IzýnYedek
	select * from deleted
end
--veriyi sil ve silinen veriyi ekle
-----------------------------------------------------------------------
--5 den fazla kayýt ekleyen trigger
create trigger triIzinEkle
on IzinYedek
after insert
as
begin
	declare @sayi int
	set @sayi = (select count(*) from inserted)
	print (convert(nvarchar(50), @sayi)+'Adet eklendi')
end
