$PBExportHeader$uo_gruposistema.sru
$PBExportComments$Objeto de Control para tabla de Grupos
forward
global type uo_gruposistema from nonvisualobject
end type
end forward

global type uo_gruposistema from nonvisualobject
end type
global uo_gruposistema uo_gruposistema

type variables
String		Nombre
Integer	Sistema, Grupo
End variables

forward prototypes
public function boolean existesistema (string as_codigo, integer ai_sistema, boolean ab_mensaje, transaction at_transaccion)
public function boolean existe (integer ai_codigo, integer ai_grupo, boolean ab_mensaje, transaction at_transaccion)
public function boolean existegrupo (integer ai_empresa, integer ai_sucursal, integer ai_sistema, integer ai_grupo, boolean ab_mensaje, transaction at_transaccion)
End prototypes

public function boolean existesistema (string as_codigo, integer ai_sistema, boolean ab_mensaje, transaction at_transaccion);Boolean	lb_Retorno = True
Integer	li_Grupo

SELECT	grpo_codigo
	INTO	:li_Grupo
	FROM	dba.grupousuario
	WHERE	usua_codigo	=	:as_Codigo
	AND	sist_codigo	=	:ai_Sistema
	USING	at_Transaccion;

If at_Transaccion.SQLCode = -1 Then
	F_ErrorBaseDatos(at_Transaccion, "Lectura de Tabla Grupos de Usuario")

	lb_Retorno	=	False
ElseIf at_Transaccion.SQLCode = 100 Then
	If ab_Mensaje Then
		MessageBox("Atención", "Código de Usuario (" + as_Codigo + "), no está habilitado en Sistema indicado.~r~r" + &
						"Ingrese o seleccione otro(s) Código(s).")
	End If
	lb_Retorno	=	False
End If

Return lb_Retorno
End function

public function boolean existe (integer ai_codigo, integer ai_grupo, boolean ab_mensaje, transaction at_transaccion);Boolean	lb_Retorno = True

SELECT	sist_codigo, grpo_codigo,grpo_nombre
	INTO	:Sistema, :Grupo, :Nombre
	FROM	dba.gruposistema
	WHERE	sist_codigo	=	:ai_Codigo
		And	grpo_codigo = :ai_grupo
	USING	at_Transaccion;

If at_Transaccion.SQLCode = -1 Then
	F_ErrorBaseDatos(at_Transaccion, "Lectura de Tabla Grupos")

	lb_Retorno	=	False
ElseIf at_Transaccion.SQLCode = 100 Then
	If ab_Mensaje Then
		MessageBox("Atención", "Código de Grupo(" + String(ai_Codigo) + "), no ha sido creado en tabla respectiva.~r~r" + &
						"Ingrese o seleccione otro(s) Código(s).")
	End If
	lb_Retorno	=	False
End If

Return lb_Retorno
End function

public function boolean existegrupo (integer ai_empresa, integer ai_sucursal, integer ai_sistema, integer ai_grupo, boolean ab_mensaje, transaction at_transaccion);Boolean	lb_Retorno = True

SELECT	sist_codigo, grpo_codigo,grpo_nombre
	INTO	:Sistema, :Grupo, :Nombre
	FROM	dba.gruposistema
	WHERE	empr_codigo = :ai_empresa
		And	adsu_codigo = :ai_sucursal
		And	sist_codigo	=	:ai_sistema
		And	grpo_codigo = :ai_grupo
	USING	at_Transaccion;

If at_Transaccion.SQLCode = -1 Then
	F_ErrorBaseDatos(at_Transaccion, "Lectura de Tabla Grupos")

	lb_Retorno	=	False
ElseIf at_Transaccion.SQLCode = 100 Then
	If ab_Mensaje Then
		MessageBox("Atención", "Código de Grupo(" + String(ai_Grupo) + "), no ha sido creado en tabla respectiva.~r~r" + &
						"Ingrese o seleccione otro(s) Código(s).")
	End If
	lb_Retorno	=	False
End If

Return lb_Retorno
End function

on uo_gruposistema.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_gruposistema.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

