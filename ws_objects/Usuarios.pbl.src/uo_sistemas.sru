$PBExportHeader$uo_sistemas.sru
$PBExportComments$Objeto que recupera versiones almacenadas en base de datos
forward
global type uo_sistemas from nonvisualobject
end type
end forward

global type uo_sistemas from nonvisualobject
end type
global uo_sistemas uo_sistemas

type variables
Integer	codigo
String	nombre,abrevi,version1,version2,version3
Date flibe1,flibe2,flibe3
end variables

forward prototypes
public function boolean of_existe (integer ai_codigo, string as_version, boolean ab_mensaje, transaction at_transaccion)
end prototypes

public function boolean of_existe (integer ai_codigo, string as_version, boolean ab_mensaje, transaction at_transaccion);Boolean	lb_Retorno = True

SELECT	sist_codigo,sist_nombre,sist_abrevi,sist_versi1,sist_flibe1
	INTO	:codigo, :nombre, :abrevi, :version1, :flibe1
	FROM	dbo.sistemas
	WHERE	sist_codigo	=	:ai_Codigo
	AND		:as_version in ('*',sist_versi1)
	USING	at_Transaccion;

If at_Transaccion.SQLCode = -1 Then
	F_ErrorBaseDatos(at_Transaccion, "Lectura de Tabla Admasistemas")

	lb_Retorno	=	False
ElseIf at_Transaccion.SQLCode = 100 Then
	lb_Retorno	=	False

	If ab_Mensaje Then
		MessageBox("Atención", "Código de Sistema y/o Versión (" + String(ai_codigo, '000') + " - " + &
						as_version + "), no ha sido creado en tabla respectiva.~r~r" + "Ingrese o seleccione otro(s) Código(s).")
	End If
End If

Return lb_Retorno
end function

on uo_sistemas.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_sistemas.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

