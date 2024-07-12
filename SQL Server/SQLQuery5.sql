--1 D��ar�dan g�nderilen projeID ye g�re o projede �al��an personel say�s�n� veren sp yaz�n�z(@projeID = 1)
create proc spCalisanPersonelSayisi
@projeID int
as
select COUNT(*) sayi from Gorevlendirme where projeID = @projeID
exec spCalisanPersonelSayisi 1


--2 D��ar�dan g�nderilen zam oran�na g�re �al��an personeller zam yapan sp yaz�n�z(@oran = 10)
create proc spMaasZamOrani
@oran int
as
update Personel set maas = (maas *(100+@oran))/100
where ayrilmaTarihi is null
exec spMaasZamOrani 20
select * from Personel where ayrilmaTarihi is null


--3 ya��ndan k���k �ocu�u olan personelleri listeleyiniz(ad,soyad,telefon)(dated�ff())
--('DAY'-'MOUNTH'-'YEAR',KUCUKTAR�H,BUYUKTAR�H)-GETDATE()
create proc sp3YasCocukListesi
as
select ad,soyad,telefon from Personel where personelID in
(select personelID from Cocuk c where DATEDIFF(YEAR,dogumTarihi,GETDATE())<=3) 
order by ad,soyad
exec sp3YasCocukListesi
--veya
select * from Cocuk where DATEDIFF(MONTH,dogumTarihi,GETDATE())<=3*12
select * from Cocuk where DATEDIFF(DAY,dogumTarihi,GETDATE())<=3*365-- TAM 3 YIL OLSUN DERSE