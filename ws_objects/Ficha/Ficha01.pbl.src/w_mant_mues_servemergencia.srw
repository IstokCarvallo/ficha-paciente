$PBExportHeader$w_mant_mues_servemergencia.srw
forward
global type w_mant_mues_servemergencia from w_mant_tabla
end type
end forward

global type w_mant_mues_servemergencia from w_mant_tabla
integer width = 3296
integer height = 1916
string title = "ZONAS"
end type
global w_mant_mues_servemergencia w_mant_mues_servemergencia

type variables
w_mant_deta_servemergencia iw_mantencion
end variables

forward prototypes
public subroutine wf_replicacion ()
end prototypes

public subroutine wf_replicacion ();




end subroutine

event ue_nuevo;call super::ue_nuevo;istr_mant.Borra		= False
istr_mant.Agrega	= True

OpenWithParm(iw_mantencion, istr_mant)

If dw_1.RowCount() > 0 And Not pb_eliminar.Enabled Then 
	pb_eliminar.Enabled	= True
	pb_grabar.Enabled	= True
End If

dw_1.SetRow(il_fila)
dw_1.SelectRow(il_fila,True)
end event

event ue_imprimir;SetPointer(HourGlass!)

Long		fila
str_info	lstr_info

lstr_info.titulo	= "MAESTRO DE SERVICOS EMERGENCIA"
lstr_info.copias	= 1

OpenWithParm(vinf,lstr_info)
vinf.dw_1.DataObject = "dw_info_servemergencia"
vinf.dw_1.SetTransObject(sqlca)
fila = vinf.dw_1.Retrieve()

If fila = -1 Then
	MessageBox( "Error en Base de Datos", "Se ha producido un error en Base " + &
					"de datos : ~n" + sqlca.SQLErrText, StopSign!, Ok!)
ElseIf fila = 0 Then
	MessageBox( "No Existe información", "No existe información para este informe.", StopSign!, Ok!)
Else
	F_Membrete(vinf.dw_1)
End If

SetPointer(Arrow!)
end event

event ue_recuperadatos;call super::ue_recuperadatos;Long	ll_fila, respuesta

Do
	ll_fila	= dw_1.Retrieve()
	
	If ll_fila = -1 Then
		respuesta = MessageBox("Error en Base de Datos", "No es posible conectar la Base de Datos.", &
										Information!, RetryCancel!)
	ElseIf ll_fila > 0 Then
		dw_1.SetRow(1)
		dw_1.SelectRow(1,True)
		dw_1.SetFocus()
		pb_imprimir.Enabled	= True
		pb_eliminar.Enabled	= True
		pb_grabar.Enabled		= True
	Else
		pb_insertar.SetFocus()
	End If

Loop While respuesta = 1

If respuesta = 2 Then Close(This)
end event

on w_mant_mues_servemergencia.create
call super::create
end on

on w_mant_mues_servemergencia.destroy
call super::destroy
end on

event ue_borrar;If dw_1.rowcount() < 1 Then Return

SetPointer(HourGlass!)

ib_borrar = True
w_main.SetMicroHelp("Validando la eliminación...")

Message.DoubleParm = 0

This.TriggerEvent ("ue_validaborrar")

If Message.DoubleParm = -1 Then Return

istr_mant.Borra		= True
istr_mant.Agrega	= False

OpenWithParm(iw_mantencion, istr_mant)

istr_mant = Message.PowerObjectParm

If istr_mant.respuesta = 1 Then
	If dw_1.DeleteRow(0) = 1 Then
		ib_borrar = False
		w_main.SetMicroHelp("Borrando Registro...")
		SetPointer(Arrow!)
	Else
		ib_borrar = False
		MessageBox(This.Title,"No se puede borrar actual registro.")
	End If
	
	If dw_1.RowCount() 		= 0 Then
		pb_eliminar.Enabled	= False
	Else
		il_fila = dw_1.GetRow()
		dw_1.SelectRow(il_fila,True)
	End If
End If

istr_mant.borra	 = False
end event

event open;call super::open;buscar	= "Código:Nseem_codigo,Nombre:Sseem_nombre"
ordenar	= "Código:seem_codigo,Nombre:seem_nombre"


end event

event ue_modifica;call super::ue_modifica;If dw_1.RowCount() > 0 Then
	istr_mant.Agrega	= False
	istr_mant.Borra		= False

	OpenWithParm(iw_mantencion, istr_mant)
End If
end event

type dw_1 from w_mant_tabla`dw_1 within w_mant_mues_servemergencia
integer x = 87
integer y = 108
integer width = 2715
integer height = 1164
string dataobject = "dw_mues_servemergencia"
boolean hscrollbar = true
end type

type st_encabe from w_mant_tabla`st_encabe within w_mant_mues_servemergencia
boolean visible = false
integer x = 123
end type

type pb_lectura from w_mant_tabla`pb_lectura within w_mant_mues_servemergencia
integer x = 2894
integer y = 72
end type

type pb_nuevo from w_mant_tabla`pb_nuevo within w_mant_mues_servemergencia
boolean visible = false
integer x = 2894
integer y = 372
end type

type pb_insertar from w_mant_tabla`pb_insertar within w_mant_mues_servemergencia
integer x = 2894
integer y = 816
end type

type pb_eliminar from w_mant_tabla`pb_eliminar within w_mant_mues_servemergencia
integer x = 2894
integer y = 560
end type

type pb_grabar from w_mant_tabla`pb_grabar within w_mant_mues_servemergencia
integer x = 2894
integer y = 988
end type

type pb_imprimir from w_mant_tabla`pb_imprimir within w_mant_mues_servemergencia
integer x = 2894
integer y = 1204
end type

type pb_salir from w_mant_tabla`pb_salir within w_mant_mues_servemergencia
integer x = 2894
integer y = 1496
end type

