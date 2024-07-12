--1 T�m m��terileri listeleyen sp yi yaz�n�z
create proc spMusterileriGetirrr
as
select * from Musteriler

exec spMusterileriGetirrr

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
insert into Nakliyeciler(SirketAdi,Telefon)
values (@SirketAdi,@Telefon)
--�al��t�r�lmas�
exec spNakliyeciKaydet @SirketAdi='AAA',@Telefon='5551113332'
exec spNakliyeciKaydet 'BBB','5551113332'
--Kontrol
select * from Nakliyeciler order by NakliyeciID desc

--4 D��ar�dan g�nderilen Bilgilere g�re Nakliyecinin t�m bilgilerine g�ncelleyen sp yi yaz�n�z
select * from Nakliyeciler
create  proc spNakliyeciDuzenle
@NakliyeciID int, @SirketAdi nvarchar(40),@Telefon nvarchar(24)
as
update Nakliyeciler set SirketAdi = @SirketAdi,Telefon = @Telefon where NakliyeciID = @NakliyeciID
exec spNakliyeciDuzenle 8,'CBE','0987654321'

--5 D��ar�dan g�nderilen bilgiye g�re Nakliyeciyi silen sp yi yaz�n�z
create proc spNakliyeciSil
@NakliyeciID int
as
delete from Nakliyeciler where NakliyeciID = @NakliyeciID

exec spNakliyeciSil 9

--6
/*alter proc spKullaniciEkle
@ad nvarchar(50),@soyad nvarchar(50),@eposta nvarchar(50)
as
if(Select COUNT(*) from Kullanici where eposta = @eposta)>0
begin
   print('Eposta Kay�tl�')
end
else
begin 
    insert into Kullanici(ad,soyad,eposta)
	values(@ad,@soyad,@eposta)
	print('Eklendi')
end
select * from Personeller

--7
alter proc spKullaniciD�zenle
@ad nvarchar(50),@soyad nvarchar(50),@eposta nvarchar(50),@kullaniciID int
as
if(Select count(*) from Kullanici where eposta and kullaniciID <> @kullaniciID)>0
begin
    print('Eposta Kay�tl�')
end
else
begin
    Update Kullanici set ad = @ad,soyad = @soyad,eposta = @eposta where kullaniciID = @kullaniciID
end
exec spKullaniciD�zenle 'Erdi2','YAL�IN2','erdi@gmail.com', 3

--8
create proc spKullaniciSil
@kullaniciID int 
as
if(Select COUNT(*) from Kullanici where kullaniciID = @kullaniciID)>0
begin
    delete from Kullanici where kullaniciID = @kullaniciID
	 print('Silindi')
end
else
begin
   print('Kullan�c� Bulunamad�')
end*/

--9
create proc spMusteriGetir
@arama nvarchar(50)
as
set @arama = '%' + @arama + '%'
select * from Musteriler where MusteriAdi like @arama or MusteriUnvani like @arama
or SirketAdi like @arama 

exec spMusteriGetir 'Diego'
