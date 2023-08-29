$PBExportHeader$w_mant_deta_admagrupos.srw
$PBExportComments$Mantención de Detalle Usuarios por Grupo.
forward
global type w_mant_deta_admagrupos from w_mant_detalle
end type
end forward

global type w_mant_deta_admagrupos from w_mant_detalle
integer width = 2359
integer height = 1068
end type
global w_mant_deta_admagrupos w_mant_deta_admagrupos

forward prototypes
public function boolean duplicado (string data)
end prototypes

public function boolean duplicado (string data);Integer 	li_registro, li_registro2
String	ls_usuario

ls_usuario = Data

SELECT	Count(*)
	INTO	:li_registro
	FROM	dbo.grupousuario
	WHERE	sist_codigo	=	:istr_mant.argumento[1]
	AND	grpo_codigo	=	:istr_mant.argumento[2]
	AND	usua_codigo	=	:ls_usuario;

If sqlca.sqlcode = -1 Then
	F_ErrorBaseDatos(sqlca,"No se pudo leer la Tabla ADMAUSUARIOS")
	Return TRUE
ElseIf li_registro>0 Then
	MessageBox("","Usuario Ya Fué Registrado")
	Return TRUE
End If

Return FALSE
		
End function

on w_mant_deta_admagrupos.create
call super::create
end on

on w_mant_deta_admagrupos.destroy
call super::destroy
end on

event ue_recuperadatos();call super::ue_recuperadatos;dw_1.SetItem(il_fila, "sist_codigo", Integer(istr_mant.Argumento[1]))
dw_1.SetItem(il_fila, "sist_nombre", istr_mant.Argumento[4])
dw_1.SetItem(il_fila, "grpo_codigo", Integer(istr_mant.Argumento[2]))
dw_1.SetItem(il_fila, "grpo_nombre", istr_mant.Argumento[3])

ias_Campo[1]	=	String(dw_1.Object.grpo_codigo[il_Fila])
ias_Campo[2]	=	dw_1.Object.usua_codigo[il_Fila]
End event

event ue_nuevo();call super::ue_nuevo;dw_1.SetItem(il_fila, "sist_codigo", Integer(istr_mant.Argumento[1]))
dw_1.SetItem(il_fila, "sist_nombre", istr_mant.Argumento[4])
dw_1.SetItem(il_fila, "grpo_codigo", Integer(istr_mant.Argumento[2]))
dw_1.SetItem(il_fila, "grpo_nombre", istr_mant.Argumento[3])
End event

event ue_antesguardar();call super::ue_antesguardar;Integer	li_cont
String	ls_mensaje, ls_colu[]

If IsNull(dw_1.GetItemString(il_fila, "USUA_CODIGO")) OR dw_1.GetItemString(il_fila, "USUA_CODIGO") = "" Then
	li_cont ++
	ls_mensaje 			= ls_mensaje + "~nCódigo de Usuario"
	ls_colu[li_cont]	= "USUA_CODIGO"
End If

If li_cont > 0 Then
	MessageBox("Error de Consistencia", "Falta el ingreso de :" + ls_mensaje + ".", StopSign!, Ok!)
	dw_1.SetColumn(ls_colu[1])
	dw_1.SetFocus()
	Message.DoubleParm = -1
End If
End event

type pb_ultimo from w_mant_detalle`pb_ultimo within w_mant_deta_admagrupos
integer x = 325
end type

type pb_siguiente from w_mant_detalle`pb_siguiente within w_mant_deta_admagrupos
integer x = 242
end type

type pb_anterior from w_mant_detalle`pb_anterior within w_mant_deta_admagrupos
integer x = 160
end type

type pb_primero from w_mant_detalle`pb_primero within w_mant_deta_admagrupos
end type

type pb_cancela from w_mant_detalle`pb_cancela within w_mant_deta_admagrupos
integer x = 1925
end type

type pb_acepta from w_mant_detalle`pb_acepta within w_mant_deta_admagrupos
integer x = 1938
integer y = 140
end type

type pb_salir from w_mant_detalle`pb_salir within w_mant_deta_admagrupos
integer x = 1934
integer y = 640
end type

type dw_1 from w_mant_detalle`dw_1 within w_mant_deta_admagrupos
integer x = 82
integer y = 104
integer width = 1737
integer height = 792
string dataobject = "dw_mant_grupousuarios"
end type

event dw_1::itemchanged;call super::itemchanged;String Columna, ls_nula, ls_nombre

uo_Usuarios		luo_AdmaUsuarios
luo_AdmaUsuarios	=	Create uo_Usuarios

Columna = dwo.Name
SetNull(ls_Nula)

CHOOSE CASE Columna
	CASE "usua_codigo"
		If duplicado(Data) Then
			This.SetItem(il_fila,Columna,"")
			Return 1
		Else
			istr_mant.argumento[2] = String(dw_1.Object.grpo_codigo[1])
			istr_mant.argumento[3] = dw_1.Object.grpo_nombre[1]
			
			If luo_AdmaUsuarios.of_Existe(Data,True,Sqlca) Then
				dw_1.SetItem(il_fila, "usua_nombre", luo_AdmaUsuarios.nombre)
			End If
		End If		
End CHOOSE

End event

