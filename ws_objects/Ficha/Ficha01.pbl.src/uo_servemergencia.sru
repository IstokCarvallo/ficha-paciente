$PBExportHeader$uo_servemergencia.sru
$PBExportComments$Objeto de Control para tabla de Servicios Emergencia
forward
global type uo_servemergencia from nonvisualobject
end type
end forward

global type uo_servemergencia from nonvisualobject
end type
global uo_servemergencia uo_servemergencia

type variables
Integer	Codigo
String		Nombre, RUT, Abreviacion, Telefono
end variables

forward prototypes
public function boolean of_existe (integer ai_codigo, boolean ab_mensaje, transaction at_transaccion)
end prototypes

public function boolean of_existe (integer ai_codigo, boolean ab_mensaje, transaction at_transaccion);Boolean	lb_Retorno = True

SELECT	seem_codigo, seem_nrorut, seem_nombre, seem_abrevi,seem_nrotel
	INTO	:Codigo, :Nombre, :RUT, :Abreviacion, :Telefono
	FROM	dbo.servicioemergencia
	WHERE	isap_codigo	=	:ai_Codigo
	USING	at_Transaccion;

If at_Transaccion.SQLCode = -1 Then
	F_ErrorBaseDatos(at_Transaccion, "Lectura de Tabla Servicios Emergencia")
	lb_Retorno	=	False
ElseIf at_Transaccion.SQLCode = 100 Then
	If ab_Mensaje Then
		MessageBox("Atención", "Código de Serv. Emergencia (" + String(ai_Codigo, '00') + &
						"), no ha sido creado en tabla respectiva.~r~rIngrese o seleccione otro(s) Código(s).")
	End If
	lb_Retorno	=	False
End If

Return lb_Retorno
end function

on uo_servemergencia.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_servemergencia.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

