--PA para TEscuela
use BDUniversidad111
go

if OBJECT_ID('spListarEscuela') is not null
	drop proc spListarEscuela
go

create proc spListarEscuela
as
begin
	select CodEscuela, Escuela, Facultad from TEscuela
end
go

exec spListarEscuela
go

if OBJECT_ID('spAgregarEscuela') is not null
	drop proc spAgregarEscuela
go

create proc spAgregarEscuela
	@CodEscuela char(3),
	@Escuela varchar(50),
	@Facultad varchar(50)
as
begin
--CodEscuela no puede ser duplicado
	if not exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		--Escuela no puede ser duplicado
		if not exists(select Escuela from TEscuela where Escuela=@Escuela)
			begin
				insert into TEscuela values(@CodEscuela, @Escuela, @Facultad)
				select CodError=0, Mensaje='Se inserto correctamente escuela'
			end
		else select CodError=1, Mensaje='Error: Escuela duplicada'
	else select CodError=1, Mensaje='Error: CodEscuela duplicado'
end
go

select * from TAlumno
select * from TEscuela