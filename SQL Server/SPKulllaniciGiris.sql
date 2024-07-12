create proc spKullaniciGiris
@eposta nvarchar(50),
@sifre nvarchar(50)
as
select * from Kullanici where eposta=@eposta and sifre=@sifre
