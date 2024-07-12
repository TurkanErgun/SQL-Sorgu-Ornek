--Northwind db de �al��t�r�lan
--Bolge ekleyen trigger 
create trigger triBolgeEkle
on Bolge
after insert
as
begin 
	declare @bolge nvarchar(50)
	set @bolge = (select BolgeTanimi from inserted)--inserted: tabloya insert edilen verilerin tutuldu�u tablo
	print (@bolge + ' Adl� yeni bir bolge eklendi')
end
--------------------------------------------------------
--Bolge silen trigger
create trigger triBolgeSil
on Bolge	--Nerde �al��s�n
after delete	--Ne zaman �al��acak
as
begin 
	declare @bolge nvarchar(50)		--nvarchar:exec edildi�inde silinen veri ile c�mle aras�na bo�luk ekler 
	set @bolge = (select BolgeTanimi from deleted)
	print (@bolge + ' adl� bolge silindi')
end
--------------------------------------------------------
--Bolge g�ncelleyen trigger
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
UPDATER tablosu yoktur. Update Komutu kendi i�inde insert ve delete kullan�r.
Bu nedenden dolay� veriyi inserted ve deleted tablolar�ndan al�r�z
Trim: Fazlal�k bo�luklar� siler.
*/
-----------------------------------------------------------------------------
--FirmaProjeTakipDB de �al��t�r�lan
--Silinen kay�tlar� yedekleme
create trigger triIzinSil
on Izin
after delete
as
begin 
	insert into Iz�nYedek
	select * from deleted
end
--veriyi sil ve silinen veriyi ekle
-----------------------------------------------------------------------
--5 den fazla kay�t ekleyen trigger
create trigger triIzinEkle
on IzinYedek
after insert
as
begin
	declare @sayi int
	set @sayi = (select count(*) from inserted)
	print (convert(nvarchar(50), @sayi)+'Adet eklendi')
end
