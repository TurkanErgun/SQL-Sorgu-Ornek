--1 Tüm müþterileri listeleyen sp yi yazýnýz
create proc spMusterileriGetirr
as
select * from Musteriler

exec spMusterileriGetirr

--2 Dýþarýdan gönderilen bilgilere göre Nakliyeci kaydeden sp yazýnýz
select * from Nakliyeciler
insert into Nakliyeciler(SirketAdi,Telefon)
values ('OpenAI','12312311')

--SQL DE DEÐÝÞKEN TANIMLAMA
declare @sayi int
--ÝÇERÝSÝNE DEÐER ATAMA
set @sayi = 10

--3 Dýþarýdan gönderilen bilgilere göre Nakliyeci kaydeden sp yi yaznýnýz
create proc spNakliyeciKaydet
@SirketAdi nvarchar (40), @Telefon nvarchar(24)
as
insert into Nakliyeci