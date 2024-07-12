create proc spVeriEkle
@kullaniciID int,
@eposta nvarchar(50),
@sifre nvarchar(50),
@aciklama nvarchar(200)
as
insert into Veri(KullaniciID,tarih,eposta,sifre,aciklama)
values(@kullaniciID,GETDATE(),@eposta,@sifre,@aciklama)