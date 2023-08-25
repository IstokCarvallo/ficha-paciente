$PBExportHeader$w_mant_detalle.srw
forward
global type w_mant_detalle from window
End type
type pb_ultimo from picturebutton within w_mant_detalle
End type
type pb_siguiente from picturebutton within w_mant_detalle
End type
type pb_anterior from picturebutton within w_mant_detalle
End type
type pb_primero from picturebutton within w_mant_detalle
End type
type pb_cancela from picturebutton within w_mant_detalle
End type
type pb_acepta from picturebutton within w_mant_detalle
End type
type pb_salir from picturebutton within w_mant_detalle
End type
type dw_1 from uo_dw within w_mant_detalle
End type
End forward

global type w_mant_detalle from window
integer x = 302
integer y = 308
integer width = 2688
integer height = 1132
boolean titlebar = true
windowtype windowtype = response!
long backcolor = 16777215
string icon = "AppIcon!"
event ue_nuevo ( )
event ue_borrar ( )
event ue_guardar ( )
event ue_buscar ( )
event ue_validaborrar ( )
event ue_recuperadatos ( )
event ue_deshace ( )
event ue_requerido ( )
event ue_listo ( )
event ue_apl ( )
event ue_proteccion ( )
event ue_antesguardar ( )
pb_ultimo pb_ultimo
pb_siguiente pb_siguiente
pb_anterior pb_anterior
pb_primero pb_primero
pb_cancela pb_cancela
pb_acepta pb_acepta
pb_salir pb_salir
dw_1 dw_1
End type
global w_mant_detalle w_mant_detalle

type variables
protected:
Long	il_fila
String	ias_campo[]
Boolean	ib_datos_ok, ib_borrar, ib_ok, ib_traer, &
	ib_deshace = true, ib_modIfica = False

Str_parms		istr_parms
Str_mant		istr_mant
Str_busqueda	istr_busq
End variables

forward prototypes
public subroutine wf_nuevo ()
protected function integer wf_modIfica ()
End prototypes

event ue_nuevo;ib_ok = True

This.TriggerEvent("ue_guardar")
If Message.DoubleParm = -1 Then ib_ok = False

If ib_ok = False Then Return

wf_nuevo()

dw_1.SetFocus()
End event

event ue_guardar;If dw_1.AcceptText() = -1 Then
	Message.DoubleParm = -1 
	Return
End If

SetPointer(HourGlass!)

Message.DoubleParm = 0

w_main.SetMicroHelp("Grabando información...")
TriggerEvent("ue_antesguardar")

If Message.DoubleParm = -1 Then Return
End event

event ue_recuperadatos();w_main.SetMicroHelp("Recuperando Datos...")

SetPointer(HourGlass!)
PostEvent("ue_listo")

If istr_mant.Agrega Then
	pb_Cancela.Enabled	=	False
	pb_Primero.Enabled	=	False
	pb_Anterior.Enabled	=	False
	pb_Siguiente.Enabled	=	False
	pb_Ultimo.Enabled		=	False
	
	wf_nuevo()
	This.Title			= "INGRESO DE REGISTRO"
Else
	If dw_1.RowCount() > 1 Then
		pb_Primero.Enabled	=	True
		pb_Anterior.Enabled	=	True
		pb_Siguiente.Enabled	=	True
		pb_Ultimo.Enabled		=	True
	End If
	
	il_fila	=	istr_mant.dw.GetRow()
	
	dw_1.SetRedraw(False)
	dw_1.SetRow(il_fila)
	dw_1.ScrollToRow(il_fila)
	dw_1.SetRedraw(True)

	If istr_mant.Borra Then
		dw_1.Enabled		=	False
		pb_Salir.Enabled	=	False
		This.Title			=	"ELIMINACION DE REGISTRO"
	ElseIf istr_mant.Solo_Consulta Then
		dw_1.Enabled			=	False
		pb_Acepta.Enabled		=	False
		pb_Cancela.Enabled	=	False
		This.Title				=	"CONSULTA DE REGISTRO"
	Else
		pb_Salir.Enabled	=	False
		This.Title			=	"MANTENCION DE REGISTRO"
	End If
End If
End event

event ue_deshace;ib_deshace = True
End event

event ue_listo();w_main.SetMicroHelp("Listo")
SetPointer(Arrow!)
End event

public subroutine wf_nuevo ();il_fila = dw_1.InsertRow(0)

dw_1.SetRedraw(False)
dw_1.SetRow(il_fila)
dw_1.ScrollToRow(il_fila)
istr_mant.dw.SetRow(il_fila)
istr_mant.dw.ScrolltoRow(il_fila)
istr_mant.dw.SelectRow(0,False)
istr_mant.dw.SelectRow(il_fila,True)
dw_1.SetRedraw(True)
End subroutine

protected function integer wf_modIfica ();If dw_1.accepttext() = -1 Then Return -1
If (dw_1.modIfiedcount() + dw_1.deletedcount()) > 0 Then Return 0
Return 1
End function

event open;x	= 100
y	= 450


This.Icon	=	Gstr_apl.Icono

PostEvent("ue_recuperadatos")

istr_mant = Message.PowerObjectParm

dw_1.SetTransObject(sqlca)
istr_mant.dw.ShareData(dw_1)
End event

event closequery;If Not istr_mant.Borra Then

	If istr_mant.Agrega AND istr_mant.Respuesta <> 1 Then 
		dw_1.DeleteRow(il_fila)
		
		If dw_1.RowCount() > 0 Then
			dw_1.SelectRow(0, False)
			dw_1.SelectRow(dw_1.RowCount(), True)
		End If
		
		Return
	End If

	If ib_ModIfica AND istr_mant.Respuesta = 1 Then
		This.TriggerEvent("ue_guardar")
		
		If Message.DoubleParm = -1 Then Message.ReturnValue = 1
		
		Return
	ElseIf istr_mant.Respuesta = 2 Then
		This.TriggerEvent("ue_deshace")
	End If
End If
End event

on w_mant_detalle.create
this.pb_ultimo=create pb_ultimo
this.pb_siguiente=create pb_siguiente
this.pb_anterior=create pb_anterior
this.pb_primero=create pb_primero
this.pb_cancela=create pb_cancela
this.pb_acepta=create pb_acepta
this.pb_salir=create pb_salir
this.dw_1=create dw_1
this.Control[]={this.pb_ultimo,&
this.pb_siguiente,&
this.pb_anterior,&
this.pb_primero,&
this.pb_cancela,&
this.pb_acepta,&
this.pb_salir,&
this.dw_1}
End on

on w_mant_detalle.destroy
destroy(this.pb_ultimo)
destroy(this.pb_siguiente)
destroy(this.pb_anterior)
destroy(this.pb_primero)
destroy(this.pb_cancela)
destroy(this.pb_acepta)
destroy(this.pb_salir)
destroy(this.dw_1)
End on

event resize;Integer		li_posic_x, li_posic_y, li_Ancho = 300, li_Alto = 245, li_Siguiente = 255

This.Height			=	dw_1.Height + 300
This.Width			=	dw_1.width + 600

dw_1.x				=	78
dw_1.y				=	100	

li_posic_x			=	This.WorkSpaceWidth() - 400
li_posic_y			=	108

pb_acepta.width	=	li_Ancho
pb_acepta.height	=	li_Alto
pb_acepta.x			=	li_posic_x
pb_acepta.y			=	li_posic_y

pb_cancela.x		=	pb_acepta.x
pb_cancela.y		=	pb_acepta.y + li_Siguiente
pb_cancela.width	=	li_Ancho
pb_cancela.height	=	li_Alto

pb_salir.x			=	pb_acepta.x
pb_salir.y			=	pb_cancela.y + li_Siguiente
pb_salir.width		=	li_Ancho
pb_salir.height		=	li_Alto
End event

event mousemove;w_main.SetMicroHelp("Ventana : " + ClassName())
End event

type pb_ultimo from picturebutton within w_mant_detalle
event mousemove pbm_mousemove
string tag = "Final"
integer x = 434
integer width = 119
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\Repos\Resources\BTN\Ultimo.png"
string disabledname = "\Repos\Resources\BTN\Ultimo-bn.png"
alignment htextalign = left!
string powertiptext = "Final"
End type

event clicked;dw_1.SetRedraw(False)

Parent.TriggerEvent("ue_deshace")

il_fila	=	dw_1.RowCount()

istr_mant.dw.SetRow(il_fila)
istr_mant.dw.ScrollToRow(il_fila)

Parent.TriggerEvent("ue_recuperadatos")

dw_1.SetRedraw(True)
End event

type pb_siguiente from picturebutton within w_mant_detalle
event mousemove pbm_mousemove
string tag = "Siguiente"
integer x = 315
integer width = 119
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\Repos\Resources\BTN\Siguiente.png"
string disabledname = "\Repos\Resources\BTN\Siguiente-bn.png"
alignment htextalign = left!
string powertiptext = "Siguiente"
End type

event clicked;If il_fila <= dw_1.RowCount() Then
	dw_1.SetRedraw(False)

	Parent.TriggerEvent("ue_deshace")

	il_fila	++
	
	istr_mant.dw.SetRow(il_fila)
	istr_mant.dw.ScrollToRow(il_fila)

	Parent.TriggerEvent("ue_recuperadatos")

	dw_1.SetRedraw(True)
End If
End event

type pb_anterior from picturebutton within w_mant_detalle
event mousemove pbm_mousemove
string tag = "Anterior"
integer x = 197
integer width = 119
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\Repos\Resources\BTN\Anterior.png"
string disabledname = "\Repos\Resources\BTN\Anterior-bn.png"
alignment htextalign = left!
string powertiptext = "Anterior"
End type

event clicked;If il_fila > 1 Then
	dw_1.SetRedraw(False)

	Parent.TriggerEvent("ue_deshace")

	il_fila	--

	istr_mant.dw.SetRow(il_fila)
	istr_mant.dw.ScrollToRow(il_fila)

	Parent.TriggerEvent("ue_recuperadatos")

	dw_1.SetRedraw(True)
End If
End event

type pb_primero from picturebutton within w_mant_detalle
event mousemove pbm_mousemove
string tag = "Inicio"
integer x = 78
integer width = 119
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\Repos\Resources\BTN\Primero.png"
string disabledname = "\Repos\Resources\BTN\Primero-bn.png"
alignment htextalign = left!
string powertiptext = "Inicio"
End type

event clicked;dw_1.SetRedraw(False)

Parent.TriggerEvent("ue_deshace")

il_fila	=	1

istr_mant.dw.SetRow(il_fila)
istr_mant.dw.ScrollToRow(il_fila)

Parent.TriggerEvent("ue_recuperadatos")

dw_1.SetRedraw(True)
End event

type pb_cancela from picturebutton within w_mant_detalle
event mousemove pbm_mousemove
string tag = "Rechazar Acción"
integer x = 2217
integer y = 408
integer width = 302
integer height = 244
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\Repos\Resources\BTN\Cancelar.png"
string disabledname = "\Repos\Resources\BTN\Cancelar-bn.png"
alignment htextalign = left!
string powertiptext = "Rechazar Acción"
long backcolor = 553648127
End type

event clicked;istr_mant.respuesta = 2

CloseWithReturn(Parent, istr_mant)
End event

type pb_acepta from picturebutton within w_mant_detalle
event mousemove pbm_mousemove
string tag = "Aceptar Acción"
integer x = 2226
integer y = 124
integer width = 302
integer height = 244
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean default = true
string picturename = "\Repos\Resources\BTN\Aceptar.png"
string disabledname = "\Repos\Resources\BTN\Aceptar-bn.png"
alignment htextalign = left!
string powertiptext = "Aceptar Acción"
long backcolor = 553648127
End type

event clicked;istr_mant.respuesta = 1

If istr_mant.agrega Then
	Parent.TriggerEvent("ue_nuevo")
Else
	If Not istr_mant.Borra Then
		Parent.TriggerEvent("ue_antesguardar")
		If Message.DoubleParm = -1 Then Return
	End If
	
	CloseWithReturn(Parent, istr_mant)
End If
End event

type pb_salir from picturebutton within w_mant_detalle
event mousemove pbm_mousemove
string tag = "Salir"
integer x = 2222
integer y = 672
integer width = 302
integer height = 244
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean cancel = true
string picturename = "\Repos\Resources\BTN\Apagar.png"
string disabledname = "\Repos\Resources\BTN\Apagar-bn.png"
alignment htextalign = left!
string powertiptext = "Salir"
long backcolor = 553648127
End type

event clicked;istr_mant.respuesta = 0

CloseWithReturn(Parent, istr_mant)
End event

type dw_1 from uo_dw within w_mant_detalle
integer x = 87
integer y = 120
integer width = 2021
integer height = 680
integer taborder = 10
boolean vscrollbar = false
boolean border = false
End type

event itemerror;Return 1
End event

event rowfocuschanged;call super::rowfocuschanged;ib_datos_ok = true
If rowcount() < 1 or getrow() = 0 or ib_borrar Then 
	ib_datos_ok = false
Else
	SetRow(il_fila)
	ScrolltoRow(il_fila)
End If
End event

on losefocus;call uo_dw::losefocus;accepttext()
End on

event itemchanged;ib_modIfica = True
//
/* Las siguientes sentencias son ejemplo de los controles que debe tener el evento */
//Integer	li_null
//String	ls_columna
//
//SetNull(li_null)
//
//ls_columna = GetColumnName()
//
//CHOOSE CASE ls_columna
//	
//	CASE ""
//		If Duplicado(data,1) OR NoExiste...(data) Then
//			This.SetItem(il_fila, ls_columna, li_null)
//			Return 1
//		End If
//		
//End CHOOSE
End event

event itemfocuschanged;call super::itemfocuschanged;If IsValid(w_main) Then
	w_main.SetMicroHelp(dwo.Tag)
End If
End event

