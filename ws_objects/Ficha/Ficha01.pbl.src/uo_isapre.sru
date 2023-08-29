$PBExportHeader$uo_isapre.sru
$PBExportComments$Objeto de Control para tabla de Isapres
forward
global type uo_isapre from nonvisualobject
end type
end forward

global type uo_isapre from nonvisualobject
end type
global uo_isapre uo_isapre

type variables
Integer	Codigo
String		Nombre, RUT, Abreviacion
end variables

forward prototypes
public function boolean of_existe (integer ai_codigo, boolean ab_mensaje, transaction at_transaccion)
end prototypes

public function boolean of_existe (integer ai_codigo, boolean ab_mensaje, transaction at_transaccion);Boolean	lb_Retorno = True

SELECT	isap_codigo, isap_nombre, isap_nrorut, isap_abrevi
	INTO	:Codigo, :Nombre, :RUT, :Abreviacion
	FROM	dbo.isapre
	WHERE	isap_codigo	=	:ai_Codigo
	USING	at_Transaccion;

If at_Transaccion.SQLCode = -1 Then
	F_ErrorBaseDatos(at_Transaccion, "Lectura de Tabla Isapres")
	lb_Retorno	=	False
ElseIf at_Transaccion.SQLCode = 100 Then
	If ab_Mensaje Then
		MessageBox("Atención", "Código de Isapres (" + String(ai_Codigo, '00') + &
						"), no ha sido creado en tabla respectiva.~r~rIngrese o seleccione otro(s) Código(s).")
	End If
	lb_Retorno	=	False
End If

Return lb_Retorno
end function

on uo_isapre.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_isapre.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

