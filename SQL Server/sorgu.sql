--S�nav� canland�rma 
/*Basit derece s�nav sorusu*/
/*
Soru 1: D��ar�dan g�nderilen ProjeID ye g�re o projede �al��an personel
say�s�n� veren SP  yaz�n�z. (@projeID = 1) (Zorluk Derecesi : 3)
*/
 create proc spCalisanPersonelSayisi
 @projeID int
 as
 select count(*) sayi from G�revlendirme where ProjeID = @projeID
 ---------------------------------------------------------------------------------
/*
Soru 2: D��ar�dan g�nderilen zam oran�na g�re �al��anlara zam 
yapam SP yaz�n�z. (@oran = 10) (Zorluk Derecesi : 4)
*/
create proc spMaasZamOrani
@oran int
as
update Personel set maas = (maas * (100 + @oran))/100
where ayrilmaTarihi is null
exec spMaasZamOrani 20
--select * from Personel where ayrilmaTarihi is null	/*�al��anlar� listelemek i�in*/
--declare @oran int = 10
--select *,maas=(maas * (100 + @oran))/100 from Personel
-----------------------------------------------------------------------------------
/*
Soru 3: 3 ya��ndan k���k �ocu�u olan personelleri listeleyiniz.
(ad,soyad,telefon) (Zorluk Derecesi : 4) (datediff)
*/
create proc sp3YasCocukListesi
as
select ad,soyad,telefon from personel where personelID in
(select personelID from Cocuk c
where datediff(year,c.dogumTarihi,getdate())<=3)

exec spYasCocukListesi
--select * from Cocuk where datediff(year,dogumTarihi,getdate())<=3*12	/*ay versyon*/
--select * from Cocuk where datediff(year,dogumTarihi,getdate())<=3*365	/*g�n versyon*/
----------------------------------------------------------------------------------
--datediff('day'-'mount'-'year',kucukTarih,buyukTarih)-getdate()