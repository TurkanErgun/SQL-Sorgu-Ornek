/*Doðum yeri Sakarya olan personellerin sayýsýný gösteren sorgu*/
select
count(*) as sayý
from Personel p
inner join Ilce on p.dogumTarihi=Ilce.ilceID
inner join Il on Ilce.ilID = Il.ilID
where Il.ad = 'Sakarya'
-----------------------------------------------------------------
/*Personelelrin doðum yerlerini gösteren sorgu*/
select
p.ad,p.dogumYeri,Ilce.ad,Il.ad
from Personel p
inner join Ilce on p.dogumYeri = Ilce.ilceID
inner join Il on Ilce.ilID = Il.ilID
-----------------------------------------------------------------
/*Proje 1 de çalýþan personelleri listeleyiniz*/
select
p.ad,p.soyad
from Personel p 
inner join Gorevlendirme g on p.personelID = g.personelID
inner join Proje pr on g.projeID = pr.projeID
where pr.ad = 'Proje 1'
-----------------------------------------------------------------
/*Proje 1 de çalýþan personellerin maaþlarýnýn toplamýný listeleten  sorgu*/
select
sum(p.maas) ToplamMaas
from Personel p 
inner join Gorevlendirme g on p.personelID = g.personelID
inner join Proje pr on g.projeID = pr.projeID
where pr.ad = 'Proje 1'
------------------------------------------------------------------
/*Hastalýk türünde izin alan personelleri listeleyiniz*/
select * from Personel p
inner join Izin i on p.personelID = i.personelID
inner join IzinTur it on i.izinTurID = it.izinTurID
where it.izinTurID = 2
------------------------------------------------------------------
/*Personelin ünvanýna göre oratalama maaþ*/
select
--p.ad,p.soyad,p.maas,u.ad,u.unvanID,p.personelID
u.ad,avg(maas)
from Personel p
inner join Unvan u on p.unvanID = u.unvanID
group by u.ad
------------------------------------------------------------------
/*Ýzin kullanan personelleri listeleyiniz. 15.07.2016*/
select
p.ad,p.soyad
from Izin i
inner join Personel p on i.personelID = p.personelID
where 
baslangicTarihi<='2016.07.15' and bitisTarihi>='2016.07.15'
-----------------------------------------------------------------
select
p.ad,p.soyad,u.ad,b.ad
from Izin i
inner join Personel p on i.personelID = p.personelID
inner join Unvan u on p.unvanID = u.unvanID
inner join Birim b on b.birimID = p.birimID
where 
baslangicTarihi<='2016.07.15' and bitisTarihi>='2016.07.15'