$PBExportHeader$uo_usuarios.sru
$PBExportComments$Objeto de Control para tabla de Usuarios
forward
global type uo_usuarios from nonvisualobject
end type
end forward

global type uo_usuarios from nonvisualobject
end type
global uo_usuarios uo_usuarios

type variables
String		Nombre, Codigo
Integer	Sucursal, Unidad, Administrador
end variables

forward prototypes
public function boolean of_existe (string as_codigo, boolean ab_mensaje, transaction at_transaccion)
end prototypes

public function boolean of_existe (string as_codigo, boolean ab_mensaje, transaction at_transaccion);Boolean	lb_Retorno = True

SELECT	usua_codigo, usua_nombre, adsu_codigo, adun_codigo, usua_admini
	INTO	:Codigo, :Nombre, :Sucursal, :Unidad, :Administrador
	FROM	dbo.usuarios
	WHERE	usua_codigo	=	:as_Codigo
	USING	at_Transaccion;

IF at_Transaccion.SQLCode = -1 THEN
	F_ErrorBaseDatos(at_Transaccion, "Lectura de Tabla Usuarios")

	lb_Retorno	=	False
ELSEIF at_Transaccion.SQLCode = 100 THEN
	IF ab_Mensaje THEN
		MessageBox("Atención", "Código de Usuario(" + as_Codigo + &
						"), no ha sido creado en tabla respectiva.~r~rIngrese o seleccione otro(s) Código(s).")
	END IF
	lb_Retorno	=	False
END IF

RETURN lb_Retorno
end function

on uo_usuarios.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_usuarios.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

