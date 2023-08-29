$PBExportHeader$w_mant_deta_servemergencia.srw
forward
global type w_mant_deta_servemergencia from w_mant_detalle
end type
end forward

global type w_mant_deta_servemergencia from w_mant_detalle
integer width = 2569
integer height = 1056
boolean titlebar = false
end type
global w_mant_deta_servemergencia w_mant_deta_servemergencia

type variables
String	is_rut
end variables

forward prototypes
public function boolean wf_duplicado (string as_columna, string as_valor)
end prototypes

public function boolean wf_duplicado (string as_columna, string as_valor);Boolean	lb_Retorno
Long		ll_Fila
Integer	li_Codigo

li_codigo	= dw_1.Object.seem_codigo[1]

Choose CASE as_columna
	CASE "seem_codigo"
		li_codigo	= Integer(as_valor)
		
End Choose

ll_fila	= istr_mant.dw.Find("seem_codigo = " + String(li_codigo) , 1, istr_mant.dw.RowCount())

If ll_fila > 0 Then
	MessageBox("Error","Registro ya fue ingresado anteriormente",Information!, Ok!)
	lb_Retorno = True
Else
	lb_Retorno = False
End If

Return lb_Retorno
end function

on w_mant_deta_servemergencia.create
call super::create
end on

on w_mant_deta_servemergencia.destroy
call super::destroy
end on

event ue_recuperadatos;call super::ue_recuperadatos;ias_campo[1] = String(dw_1.Object.seem_codigo[il_fila])
ias_campo[2] = dw_1.Object.seem_nombre[il_fila]
ias_campo[3] = dw_1.Object.seem_nrorut[il_fila]
ias_campo[4] = dw_1.Object.seem_abrevi[il_fila]
ias_campo[3] = dw_1.Object.seem_nrotel[il_fila]

If Not istr_mant.Agrega And Not istr_mant.Borra Then 
	dw_1.Object.seem_codigo.Protect = 1
End If
end event

event ue_deshace;call super::ue_deshace;If UpperBound(ias_campo) > 0 Then
	dw_1.SetItem(il_fila, "seem_codigo", Integer(ias_campo[1]))
	dw_1.SetItem(il_fila, "seem_nombre", ias_campo[2])
	dw_1.SetItem(il_fila, "seem_nrorut", ias_campo[3])
	dw_1.SetItem(il_fila, "seem_abrevi", ias_campo[4])
	dw_1.SetItem(il_fila, "seem_nrotel", ias_campo[5])
End If
end event

event ue_antesguardar;call super::ue_antesguardar;Integer	li_cont
String	ls_mensaje, ls_colu[]

If IsNull(dw_1.GetItemNumber(il_fila, "seem_codigo")) Then
	li_cont ++
	ls_mensaje 		= ls_mensaje + "~nCódigo de Servicio Emergencia"
	ls_colu[li_cont]	= "seem_codigo"
End If

If IsNull(dw_1.GetItemString(il_fila, "seem_nombre")) OR dw_1.GetItemString(il_fila, "seem_nombre") = "" Then
	li_cont ++
	ls_mensaje 		= ls_mensaje + "~nDescripción de la Servicio Emergencia"
	ls_colu[li_cont]	= "seem_nombre"
End If

If li_cont > 0 Then
	MessageBox("Error de Consistencia", "Falta el ingreso de :" + ls_mensaje + ".", StopSign!, Ok!)
	dw_1.SetColumn(ls_colu[1])
	dw_1.SetFocus()
	Message.DoubleParm = -1
End If
end event

type pb_ultimo from w_mant_detalle`pb_ultimo within w_mant_deta_servemergencia
end type

type pb_siguiente from w_mant_detalle`pb_siguiente within w_mant_deta_servemergencia
end type

type pb_anterior from w_mant_detalle`pb_anterior within w_mant_deta_servemergencia
end type

type pb_primero from w_mant_detalle`pb_primero within w_mant_deta_servemergencia
end type

type pb_cancela from w_mant_detalle`pb_cancela within w_mant_deta_servemergencia
integer x = 2121
integer y = 392
end type

type pb_acepta from w_mant_detalle`pb_acepta within w_mant_deta_servemergencia
integer x = 2103
integer y = 128
end type

type pb_salir from w_mant_detalle`pb_salir within w_mant_deta_servemergencia
integer x = 2149
integer y = 660
end type

type dw_1 from w_mant_detalle`dw_1 within w_mant_deta_servemergencia
integer y = 112
integer width = 1925
integer height = 800
string dataobject = "dw_mant_servemergencia"
end type

event dw_1::itemchanged;String	ls_Columna, ls_Null

ls_columna = dwo.Name
SetNull(ls_Null)

Choose Case ls_columna
	Case "seem_codigo"
		If wf_Duplicado(ls_columna, data) Then
			This.SetItem(Row, ls_columna, Integer(ls_null))
			Return 1
		End If
		
	Case "seem_nrorut"
		is_rut = F_verrut(data, True)
		If is_rut = "" Then
			This.SetItem(Row, ls_Columna, ls_Null)
			Return 1
		Else
			This.SetItem(Row, ls_Columna, is_rut)
			Return 1
		End If

End Choose
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;If is_rut <> "" Then
	This.Object.seem_nrorut.Format = '@@@.@@@.@@@-@'
	
	If dwo.Name <> "seem_nrorut" Then
		This.SetItem(Row, "seem_nrorut", is_rut)
	End If
End If
end event

