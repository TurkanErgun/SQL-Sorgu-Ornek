select 
k.kayitID, y.ad as YilAdi, do.ad as DonemAdi, pt.ad as ProgramTurAdi,
b.ad as BolumAdi, d.ad as DersAdi, d.kod, d.sinif, k.tarih, 
a.ad + ' ' + a.soyad as DersinSorumlusu, st.ad as SinavTurAdi
from Kayit k
inner join SinifKayit sk on k.kayitID = sk.kayitID
inner join SinavTur st on k.sinavTurID = st.sinavTurID
inner join Akademisyen a on k.dersinSorumlusuID = a.akademisyenID
inner join Ders d on k.dersID = d.dersID
inner join Bolum b on k.bolumID = b.bolumID
inner join Yil y on k.yilID = y.yilID
inner join Donem do on k.donemID = do.donemID
inner join ProgramTur pt on k.programTurID = pt.programTurID
---------------------------------------------------------------------
--SinifKayitView adlý view kullanabilirsiniz.
--Size verilen Sütunlar þunlardýr.
create view SinifKayitView
as
select
sk.sinifKayitID, sk.kayitID, saat, 
s.ad as SinifAdi, a.ad + ' ' + a.soyad as GozetmenAdi, s.kapasitesi
from SinifKayit sk 
inner join Sinif s on sk.sinifID = s.sinifID
inner join Akademisyen a on sk.gozetmenID = a.akademisyenID
----------------------------------------------------------------------
select * from KayitView kv
inner join SinifKayitView skv on kv.kayitID = skv.kayitID
----------------------------------------------------------------------
select * from KayitView kv
inner join SinifKayitView skv on kv.kayitID = skv.kayitID
where gozetmenAdi like '%Erdi%'
----------------------------------------------------------------------
--Dýþarýdan gönderilen yil donem ve programTure
--bölümlerde yapýlan sýnavsayýsýný listeleyen
--sp yi yazýnýz. (dolumID, Sayi)
create proc spSayiGetir
@yilID int, @donemID int, @programTurID int
as
select BolumID, count(*) from Kayit
where YilID = @yilID and donemID = @donemID and programTurID = @programTurID
group by bolumID
----------------------------------------------------------------------------
--Dýþarýdan gonderilen tarihteki sýnava giren öðgrenci
--sayýsýný verren spOgrenciSayisiný veren sp yaz
create proc spOgrenciSayisi
@tarih smalldatetime as
select sum(ogrenciSayisi) as Sayi
from Kayit
where tarih = @tarih

exec spOgrenciSayisi 12.04.2024