$PBExportHeader$uo_formapago.sru
$PBExportComments$Objeto de Control para tabla de Forma Pago.
forward
global type uo_formapago from nonvisualobject
end type
end forward

global type uo_formapago from nonvisualobject
end type
global uo_formapago uo_formapago

type variables
Integer	Codigo
String		Nombre, RUT, Abreviacion
end variables

forward prototypes
public function boolean of_existe (integer ai_codigo, boolean ab_mensaje, transaction at_transaccion)
end prototypes

public function boolean of_existe (integer ai_codigo, boolean ab_mensaje, transaction at_transaccion);Boolean	lb_Retorno = True

SELECT	fopa_codigo, fopa_nombre
	INTO	:Codigo, :Nombre
	FROM	dbo.formapago
	WHERE	fopa_codigo =	:ai_Codigo
	USING	at_Transaccion;

If at_Transaccion.SQLCode = -1 Then
	F_ErrorBaseDatos(at_Transaccion, "Lectura de Tabla Forma Pago")
	lb_Retorno	=	False
ElseIf at_Transaccion.SQLCode = 100 Then
	If ab_Mensaje Then
		MessageBox("Atención", "Código de Forma Pago (" + String(ai_Codigo, '00') + &
						"), no ha sido creado en tabla respectiva.~r~rIngrese o seleccione otro(s) Código(s).")
	End If
	lb_Retorno	=	False
End If

Return lb_Retorno
end function

on uo_formapago.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_formapago.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

