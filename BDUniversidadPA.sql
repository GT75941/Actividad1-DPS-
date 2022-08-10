------------------ TEscuela
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
	@codEscuela char(3),
	@Escuela varchar(50),
	@Facultad varchar(50)
as
begin
	if not exists(select CodEscuela from TEscuela where CodEscuela=@codEscuela)
		if not exists(select Escuela from TEscuela where Escuela=@Escuela)
			begin
				insert into TEscuela values(@codEscuela, @Escuela, @Facultad)
				select CodError=0, Mensaje='Se inserto correctamente escuela'
			end
		else select CodError=1, Mensaje='Error: Escuela duplicada'
	else select CodError=1, Mensaje='Error: CodEscuela duplicado'
end
go

if OBJECT_ID('spBorrarEscuela') is not NULL
	drop PROCEDURE spBorrarEscuela
go

create proc spBorrarEscuela
	@codEscuela CHAR(3)
as
begin
	if exists(select CodEscuela from TEscuela where CodEscuela=@codEscuela)
		begin
			delete from TEscuela WHERE CodEscuela=@codEscuela
			select CodError=0, Mensaje='Se elimino correctamente la escuela'
		end
	else SELECT CodError=1, Mensaje='Error: La escuela no existente'
end
go

if OBJECT_ID('spActualizarEscuela') is not null
	drop proc spActualizarEscuela
go

create proc spActualizarEscuela
	@codEscuela char(3),
	@escuela varchar(50),
	@facultad varchar(50)
as
begin
	if exists(select CodEscuela from TEscuela where CodEscuela=@codEscuela)
		begin
			update TEscuela Set Escuela=@escuela, Facultad=@facultad where CodEscuela=@codEscuela
			select CodError=0, Mensaje='Se Actualizo correctamente'
		end
	else select CodError=1, Mensaje='Error: La escuela no se pudo ubicar'
end
go

if OBJECT_ID('spBuscarEscuela') is not null
	drop proc spBuscarEscuela
go

create proc spBuscarEscuela
    @codEscuela char(3)
as
begin
    if exists(select CodEscuela from TEscuela where CodEscuela=@codEscuela)
		begin
			select CodEscuela, Escuela, Facultad from TEscuela where CodEscuela=@codEscuela
			select CodError=0, Mensaje='Se ubicao la escuela correctamente'
		end
	else select CodError=1, Mensaje='Error: La escuela no existente'
end
go

------------------ TAlumno
use BDUniversidad111
go

if OBJECT_ID('spListarAlumno') is not null
	drop proc spListarAlumno
go

create proc spListarAlumno
as
begin
	select CodAlumno, Apellidos, Nombres, LugarNac, FechaNac, CodEscuela from TAlumno
end
go

if OBJECT_ID('spAgregarAlumno') is not null
	drop proc spAgregarAlumno
go

create proc spAgregarAlumno
    @codAlumno char(5),
    @apellido varchar(50),
    @nombre varchar(50),
    @lNacimiento varchar(50),
    @fNacimiento datetime,
    @codEscuela char(3)
as
begin
    if not exists(select CodAlumno from TAlumno where CodAlumno=@codAlumno)
		if not exists(select Apellidos from TAlumno where Apellidos=@apellido)
			begin
				insert into TAlumno values(@codAlumno, @apellido, @nombre, @lNacimiento, @fNacimiento, @codEscuela)
				select CodError=0, Mensaje='Se pudo insertar correctamente'
			end
		else select CodError=1, Mensaje='Error: Se encontro duplicidad en Apellido'
	else select CodError=1, Mensaje='Error: Se encontro duplicidad en CodAlumno'
end
go

if OBJECT_ID('spBorrarAlumno') is not null
	drop proc spBorrarAlumno
go

create proc spBorrarAlumno
    @codAlumno char(5)
as
begin
    if exists(select CodAlumno from TAlumno where CodAlumno=@codAlumno)
	begin
        delete from TAlumno where CodAlumno=@codAlumno
        select CodError=0, Mensaje='Se pudo elimiar exitosamente al alumno'
    end
	else select CodError=1, Mensaje='Error: El alumno no existe'
end
go

if OBJECT_ID('spActualizarAlumno') is not null
	drop proc spActualizarAlumno
go

create proc spActualizarAlumno
    @codAlumno char(5),
    @apellido varchar(50),
    @nombre varchar(50),
    @lNacimiento varchar(50),
    @fNacimiento datetime,
    @codEscuela char(3)
as
begin
	if exists(select CodAlumno from TAlumno where CodAlumno=@codAlumno)
		begin
			update TAlumno Set Apellidos=@apellido, Nombres=@nombre, LugarNac=@lNacimiento, FechaNac=@fNacimiento, CodEscuela=@codEscuela where CodAlumno=@codAlumno
			select CodError=0, Mensaje='Se pudo actualizar exitosamente al alumno'
		end
	else select CodError=1, Mensaje='Error: El alumno no existe'
end
go

if OBJECT_ID('spBuscarAlumno') is not null
	drop proc spBuscarAlumno
go

create proc spBuscarAlumno
    @codAlumno char(5)
as
begin
    if exists(select CodEscuela from TAlumno where CodAlumno=@codAlumno)
		begin
			select CodAlumno, Apellidos, Nombres, LugarNac, FechaNac, CodEscuela from TAlumno where CodAlumno=@codAlumno
			select CodError=0, Mensaje='Se pudo ubicar existosamente al alumno'
		end
	else select CodError=1, Mensaje='Error: El alumno no existe'
end
go

-- Consultas Escuela

exec spListarEscuela
go

select * from TAlumno
select * from TEscuela

exec spAgregarEscuela 'E06','Bioinformatica','letras'
exec spAgregarEscuela 'E07','Contabilidad','numeros'
exec spListarEscuela
go

exec spBorrarEscuela 'E07'
exec spListarEscuela
go

exec spActualizarEscuela 'E06','Contabilidad','Economia'
exec spListarEscuela
go

exec spBuscarEscuela 'E06'
go

--Consultas Alumno

exec spListarAlumno
go

exec spAgregarAlumno 'A1716','Enrique','Gonzalo','Lima','2008-06-06 12:35:29','E01'

exec spAgregarAlumno 'B1717','Huamani','Jose','tacna','2010-05-05 12:35:29','E02'
exec spListarAlumno
go

exec spBorrarAlumno 'B1717'
exec spBorrarAlumno 'A1716'
exec spListarAlumno
go

exec spActualizarAlumno 'B1717','Huamani','Ramon','Oropesa','2011-05-05 01:35:29','E02'
exec spListarAlumno
go

exec spBuscarAlumno 'B1717'
go