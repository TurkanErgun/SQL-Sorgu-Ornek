--1 Dýþarýdan gönderilen projeID ye göre o projede çalýþan personel sayýsýný veren sp yazýnýz(@projeID = 1)
create proc spCalisanPersonelSayisi
@projeID int
as
select COUNT(*) sayi from Gorevlendirme where projeID = @projeID
exec spCalisanPersonelSayisi 1


--2 Dýþarýdan gönderilen zam oranýna göre çalýþan personeller zam yapan sp yazýnýz(@oran = 10)
create proc spMaasZamOrani
@oran int
as
update Personel set maas = (maas *(100+@oran))/100
where ayrilmaTarihi is null
exec spMaasZamOrani 20
select * from Personel where ayrilmaTarihi is null


--3 yaþýndan küçük çocuðu olan personelleri listeleyiniz(ad,soyad,telefon)(datedýff())
--('DAY'-'MOUNTH'-'YEAR',KUCUKTARÝH,BUYUKTARÝH)-GETDATE()
create proc sp3YasCocukListesi
as
select ad,soyad,telefon from Personel where personelID in
(select personelID from Cocuk c where DATEDIFF(YEAR,dogumTarihi,GETDATE())<=3) 
order by ad,soyad
exec sp3YasCocukListesi
--veya
select * from Cocuk where DATEDIFF(MONTH,dogumTarihi,GETDATE())<=3*12
select * from Cocuk where DATEDIFF(DAY,dogumTarihi,GETDATE())<=3*365-- TAM 3 YIL OLSUN DERSE