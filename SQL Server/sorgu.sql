--Sýnavý canlandýrma 
/*Basit derece sýnav sorusu*/
/*
Soru 1: Dýþarýdan gönderilen ProjeID ye göre o projede çalýþan personel
sayýsýný veren SP  yazýnýz. (@projeID = 1) (Zorluk Derecesi : 3)
*/
 create proc spCalisanPersonelSayisi
 @projeID int
 as
 select count(*) sayi from Görevlendirme where ProjeID = @projeID
 ---------------------------------------------------------------------------------
/*
Soru 2: Dýþarýdan gönderilen zam oranýna göre çalýþanlara zam 
yapam SP yazýnýz. (@oran = 10) (Zorluk Derecesi : 4)
*/
create proc spMaasZamOrani
@oran int
as
update Personel set maas = (maas * (100 + @oran))/100
where ayrilmaTarihi is null
exec spMaasZamOrani 20
--select * from Personel where ayrilmaTarihi is null	/*Çalýþanlarý listelemek için*/
--declare @oran int = 10
--select *,maas=(maas * (100 + @oran))/100 from Personel
-----------------------------------------------------------------------------------
/*
Soru 3: 3 yaþýndan küçük çocuðu olan personelleri listeleyiniz.
(ad,soyad,telefon) (Zorluk Derecesi : 4) (datediff)
*/
create proc sp3YasCocukListesi
as
select ad,soyad,telefon from personel where personelID in
(select personelID from Cocuk c
where datediff(year,c.dogumTarihi,getdate())<=3)

exec spYasCocukListesi
--select * from Cocuk where datediff(year,dogumTarihi,getdate())<=3*12	/*ay versyon*/
--select * from Cocuk where datediff(year,dogumTarihi,getdate())<=3*365	/*gün versyon*/
----------------------------------------------------------------------------------
--datediff('day'-'mount'-'year',kucukTarih,buyukTarih)-getdate()