$PBExportHeader$uo_cuidadora.sru
$PBExportComments$Objeto de Control para tabla de Cuidadora Particular
forward
global type uo_cuidadora from nonvisualobject
end type
end forward

global type uo_cuidadora from nonvisualobject
end type
global uo_cuidadora uo_cuidadora

type variables
String		Nombre, RUT, Telefono
end variables

forward prototypes
public function boolean of_existe (string as_codigo, boolean ab_mensaje, transaction at_transaccion)
end prototypes

public function boolean of_existe (string as_codigo, boolean ab_mensaje, transaction at_transaccion);Boolean	lb_Retorno = True

SELECT	cupa_nrorut, cupa_nombre, upa_nrotel
	INTO	:RUT,  :Nombre, :Telefono
	FROM	dbo.cuidadora
	WHERE	cupa_nrorut	=	:as_Codigo
	USING	at_Transaccion;

If at_Transaccion.SQLCode = -1 Then
	F_ErrorBaseDatos(at_Transaccion, "Lectura de Tabla Servicios Emergencia")
	lb_Retorno	=	False
ElseIf at_Transaccion.SQLCode = 100 Then
	If ab_Mensaje Then
		MessageBox("Atención", "Código de Serv. Emergencia (" + as_Codigo + &
						"), no ha sido creado en tabla respectiva.~r~rIngrese o seleccione otro(s) Código(s).")
	End If
	lb_Retorno	=	False
End If

Return lb_Retorno
end function

on uo_cuidadora.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_cuidadora.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

