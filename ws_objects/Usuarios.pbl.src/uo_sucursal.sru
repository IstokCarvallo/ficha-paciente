$PBExportHeader$uo_sucursal.sru
$PBExportComments$Objeto de Control para tabla de Sucursales.
forward
global type uo_sucursal from nonvisualobject
end type
end forward

global type uo_sucursal from nonvisualobject
end type
global uo_sucursal uo_sucursal

type variables
Integer	ii_Codigo
String	is_Nombre, is_Abreviacion
end variables

forward prototypes
public function boolean existe (integer ai_codigo, boolean ab_mensaje, transaction at_transaccion)
public function boolean existesuc (integer ai_empresa, integer ai_codigo, boolean ab_mensaje, transaction at_transaccion)
end prototypes

public function boolean existe (integer ai_codigo, boolean ab_mensaje, transaction at_transaccion);Boolean	lb_Retorno = True

SELECT	adsu_codigo, adsu_nombre, adsu_abrevi
	INTO	:ii_Codigo, :is_Nombre, :is_Abreviacion
	FROM	dbo.sucursales
	WHERE	adsu_codigo	=	:ai_Codigo
	USING	at_Transaccion;

If at_Transaccion.SQLCode = -1 Then
	F_ErrorBaseDatos(at_Transaccion, "Lectura de Tabla Sucursales")

	lb_Retorno	=	False
ElseIf at_Transaccion.SQLCode = 100 Then
	If ab_Mensaje Then
		MessageBox("Atención", "Código de Sucursal (" + String(ai_Codigo, '00') + &
						"), no ha sido creado en tabla respectiva.~r~rIngrese o seleccione otro(s) Código(s).")
	End If
	lb_Retorno	=	False
End If

Return lb_Retorno
end function

public function boolean existesuc (integer ai_empresa, integer ai_codigo, boolean ab_mensaje, transaction at_transaccion);Boolean	lb_Retorno = True

SELECT	adsu_codigo, adsu_nombre, adsu_abrevi
	INTO	:ii_Codigo, :is_Nombre, :is_Abreviacion
	FROM	dbo.sucursales
	WHERE	empr_codigo = :ai_Empresa
	AND		adsu_codigo	=	:ai_Codigo
	USING	at_Transaccion;

IF at_Transaccion.SQLCode = -1 THEN
	F_ErrorBaseDatos(at_Transaccion, "Lectura de Tabla Sucursales")

	lb_Retorno	=	False
ELSEIF at_Transaccion.SQLCode = 100 THEN
	IF ab_Mensaje THEN
		MessageBox("Atención", "Código de Sucursal (" + String(ai_Codigo, '00') + "), no ha sido creado en tabla respectiva.~r~rIngrese o seleccione otro(s) Código(s).")
	END IF
	lb_Retorno	=	False
END IF

RETURN lb_Retorno
end function

on uo_sucursal.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_sucursal.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

