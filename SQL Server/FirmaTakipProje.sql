--1
select p. ad,p.dogumYeri,ILce.ad,Il.ad
from Personel p 
inner join Ilce on p.dogumYeri = Ilce.ilceID
inner join Il on Ilce.ilID =Il.ilID

--2
select count(*) as say� from Personel p
inner join Ilce on p.dogumYeri = Ilce.ilceID
inner join Il on Ilce.ilceID = Il.ilID
where Il.ad='SAKARYA'

--3 Proje 1 de �al��an personelleri listeleyiniz(ad,soyad)
select p.ad,p.soyad from Personel p  inner join Gorevlendirme g on p.personelID = g.personelID
inner join Proje pr on pr.projeID = g.projeID
where pr.ad = 'Proje 1'

--4 Proje 1 de �al��an personellerin toplam maa��
select sum(p.maas) as ToplamMaas from Personel p inner join Gorevlendirme g on p.personelID =g.personelID
inner join Proje pr on pr.projeID = g.projeID 
where pr.ad = 'Proje 1'

--5 2015 y�l�nda Ahmet ka� g�n izin kullanm��t�r
--6 2016 y�l�nda ka� ki�i babal�k izni kullanm��t�r

--7 Hastal�k izni kullanan personel say�s� 
select p.personelID, COUNT(*) from Personel p inner join Izin i on p.personelID = i.personelID
inner join IzinTur it on i.izinTurID = it.izinTurID 
where it.izinTurID = 2 group by p.personelID

--8 Personel unvan�na g�re ortalama maa�
select u. ad,AVG(maas) from Personel p inner join Unvan u  on p.unvanID = u.unvanID 
group by u.ad

--9 Hangi birimde ka� personel �al���yor
select b.ad, COUNT(*) as personelSay�s� from Personel p inner join 
Birim b on p.birimID = b.birimID
group by b.ad

--10 Hangi birimde ka� personel i�ten ayr�lm��t�r
select b.ad, COUNT(*) as personelSay�s� from Personel p inner join 
Birim b on p.birimID = b.birimID
where p.ayrilmaTarihi  is not null
group by b.ad

--11 �ocu�u olmayan personelleri listeleyiniz
select * from Personel where personelID not  in  
(select distinct personelID from Cocuk) 

--12 �zin kullanan personelleri yaz�n�z 15.07.2016
select p.ad,p.soyad,u.ad,b.ad from Izin i inner join Personel p on i.personelID = p.personelID
inner join Unvan u on p.unvanID = u.unvanID
inner join Birim b on b.birimID = b.birimID
where baslangicTarihi<='2016.07.15' and bitisTarihi>='2016.07.15'








