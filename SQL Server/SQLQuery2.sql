--1 T�m m��terileri listeleyen sp yi yaz�n�z
create proc spMusterileriGetirr
as
select * from Musteriler

exec spMusterileriGetirr

--2 D��ar�dan g�nderilen bilgilere g�re Nakliyeci kaydeden sp yaz�n�z
select * from Nakliyeciler
insert into Nakliyeciler(SirketAdi,Telefon)
values ('OpenAI','12312311')

--SQL DE DE���KEN TANIMLAMA
declare @sayi int
--��ER�S�NE DE�ER ATAMA
set @sayi = 10

--3 D��ar�dan g�nderilen bilgilere g�re Nakliyeci kaydeden sp yi yazn�n�z
create proc spNakliyeciKaydet
@SirketAdi nvarchar (40), @Telefon nvarchar(24)
as
insert into Nakliyeci