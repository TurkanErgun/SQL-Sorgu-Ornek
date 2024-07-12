create proc spVerileriGetir
@kullaniciID int
as
select * from Veri where @kullaniciID=@kullaniciID