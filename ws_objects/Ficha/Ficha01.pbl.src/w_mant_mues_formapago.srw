﻿$PBExportHeader$w_mant_mues_formapago.srw
forward
global type w_mant_mues_formapago from w_mant_directo
end type
end forward

global type w_mant_mues_formapago from w_mant_directo
integer width = 2555
string title = "MAESTRO PAISES"
string icon = "AppIcon!"
end type
global w_mant_mues_formapago w_mant_mues_formapago

type variables

end variables

forward prototypes
public function boolean wf_duplicado (string codigo)
end prototypes

public function boolean wf_duplicado (string codigo);Long		ll_fila

ll_fila	= dw_1.Find("fopa_codigo = " + Codigo , 1, dw_1.RowCount())

If ll_fila > 0 and ll_fila <> il_fila Then
	MessageBox("Error","Código de País ya fue ingresada anteriormente",Information!, Ok!)
	Return True
Else
	Return False
End If
end function

on w_mant_mues_formapago.create
call super::create
end on

on w_mant_mues_formapago.destroy
call super::destroy
end on

event open;call super::open;buscar			= "Código:Nfopa_codigo,Nombre:Sfopa_nombre"
ordenar			= "Código:fopa_codigo,Nombre:fopa_nombre"
end event

event ue_recuperadatos;call super::ue_recuperadatos;Long		ll_fila, respuesta

DO
	ll_fila	= dw_1.Retrieve()
	
	IF ll_fila	= -1 THEN
		respuesta	= MessageBox("Error en Base de Datos", "No es posible conectar la Base de Datos.", &
											Information!, RetryCancel!)
	ELSEIF ll_fila > 0 THEN
		dw_1.SetRow(1)
		dw_1.SetFocus()
		pb_imprimir.Enabled	= True		
		pb_insertar.Enabled	= True
		pb_eliminar.Enabled	= True
		pb_grabar.Enabled		= True
		
		il_fila					= 1
	ELSE
		pb_insertar.Enabled	= True
		pb_insertar.SetFocus()
	END IF
LOOP WHILE respuesta = 1

IF respuesta = 2 THEN Close(This)
	
end event

event ue_imprimir;Long	fila
str_info lstr_info

lstr_info.titulo	= "MAESTRO PAISES"
lstr_info.copias	= 1

OpenWithParm(vinf, lstr_info)
vinf.dw_1.DataObject	= "dw_info_FormaPago"
vinf.dw_1.SetTransObject(sqlca)
fila	= vinf.dw_1.Retrieve()

If fila	= -1 Then
	MessageBox("Error en Base de Datos", "Se ha Producido un error en Basede Datos : ~n" + sqlca.SQLErrText, StopSign!, OK!)
ElseIf fila	= 0 Then
	MessageBox("No Existe Información", "No Existe Información para este Informa.", StopSign!, OK!)
Else
	F_Membrete(vinf.dw_1)
	If gs_Ambiente = 'Windows' Then
		vinf.dw_1.ModIfy('DataWindow.Print.Preview	= Yes')
		vinf.dw_1.ModIfy('DataWindow.Print.Preview.Zoom	= 75')
		vinf.Visible	= True
		vinf.Enabled	= True
	End If
End If
end event

event ue_validaregistro;call super::ue_validaregistro;Integer	li_cont
String   ls_mensaje, ls_colu[]

If IsNull(dw_1.Object.fopa_codigo[il_fila]) Then
	li_cont ++
	ls_mensaje		= ls_mensaje + "~nCódigo de Pais"
	ls_colu[li_cont]	= "pais_codigo"
End If

If IsNull(dw_1.Object.fopa_nombre[il_fila]) Or dw_1.Object.fopa_nombre[il_fila] = "" Then
	li_cont ++
	ls_mensaje		= ls_mensaje + "~nDescripción de Forma PAgo"
	ls_colu[li_cont]	= "fopa_nombre"
End If

If li_cont > 0 Then
	MessageBox("Error de Consistencia", "Falta el Ingreso de :" + ls_mensaje + ".", StopSign!, Ok!)
	dw_1.SetColumn(ls_colu[1])
	dw_1.SetFocus()
	Message.DoubleParm = -1
End If	
end event

type st_encabe from w_mant_directo`st_encabe within w_mant_mues_formapago
boolean visible = false
integer x = 27
integer y = 76
integer width = 142
integer height = 136
boolean enabled = true
end type

type pb_nuevo from w_mant_directo`pb_nuevo within w_mant_mues_formapago
integer x = 2135
integer y = 408
integer taborder = 50
end type

event pb_nuevo::clicked;call super::clicked;dw_1.Reset()

end event

type pb_lectura from w_mant_directo`pb_lectura within w_mant_mues_formapago
integer x = 2121
integer y = 60
integer taborder = 40
end type

type pb_eliminar from w_mant_directo`pb_eliminar within w_mant_mues_formapago
integer x = 2135
integer y = 828
integer taborder = 80
end type

type pb_insertar from w_mant_directo`pb_insertar within w_mant_mues_formapago
integer x = 2121
integer y = 620
integer taborder = 70
end type

type pb_salir from w_mant_directo`pb_salir within w_mant_mues_formapago
integer x = 2130
integer y = 1860
integer taborder = 110
end type

type pb_imprimir from w_mant_directo`pb_imprimir within w_mant_mues_formapago
integer x = 2135
integer y = 1348
integer taborder = 100
end type

type pb_grabar from w_mant_directo`pb_grabar within w_mant_mues_formapago
integer x = 2144
integer y = 1060
integer taborder = 90
end type

type dw_1 from w_mant_directo`dw_1 within w_mant_mues_formapago
integer y = 64
integer width = 2002
integer height = 444
integer taborder = 60
string dataobject = "dw_mant_mues_formapago"
end type

event dw_1::itemchanged;call super::itemchanged;String	ls_Null, ls_Columna

SetNull(ls_Null)
ls_Columna = dwo.name

Choose Case ls_Columna
	Case "fopa_codigo"		
		If wf_Duplicado(data) Then
			This.SetItem(il_fila, ls_Columna, Integer(ls_Null))
			Return 1
		End If
End Choose

pb_grabar.Enabled		= True

end event

