$PBExportHeader$w_busqueda_admaunidadmini.srw
forward
global type w_busqueda_admaunidadmini from w_busqueda
end type
end forward

global type w_busqueda_admaunidadmini from w_busqueda
integer width = 3433
string title = "Unidades Administrativas"
end type
global w_busqueda_admaunidadmini w_busqueda_admaunidadmini

type variables

end variables

on w_busqueda_admaunidadmini.create
call super::create
end on

on w_busqueda_admaunidadmini.destroy
call super::destroy
end on

event open;call super::open;istr_busq	= Message.PowerObjectParm

is_ordena				= 'Código:adun_codigo,Nombre:adun_nombre'

IF dw_1.Retrieve(Integer(istr_busq.argum[1])) > 0 THEN
	dw_1.SetFocus()
	dw_1.SelectRow(1,True)

	istr_busq.argum[1]	= String(dw_1.GetItemNumber(1, "adun_codigo"))
	istr_busq.argum[2]	= dw_1.GetItemString(1, "adun_nombre")
	istr_busq.argum[3]	= dw_1.GetItemString(1, "adun_abrevi")
ELSE
	MessageBox("Atención","No hay información para mostrar",Exclamation!,Ok!)
	CloseWithReturn(This,istr_busq)
END IF






end event

event ue_asignacion();istr_busq.argum[1] 	= String(dw_1.GetItemNumber(dw_1.GetRow(), "adun_codigo"))
istr_busq.argum[2]	= dw_1.GetItemString(dw_1.GetRow(), "adun_nombre")
istr_busq.argum[3] 	= dw_1.GetItemString(dw_1.GetRow(), "adun_abrevi")

CloseWithReturn(This,istr_busq)

end event

type pb_insertar from w_busqueda`pb_insertar within w_busqueda_admaunidadmini
boolean visible = false
integer x = 2866
integer y = 1012
boolean enabled = false
end type

type dw_1 from w_busqueda`dw_1 within w_busqueda_admaunidadmini
integer width = 2423
string dataobject = "dw_mues_admaunidadadmini"
end type

type pb_salir from w_busqueda`pb_salir within w_busqueda_admaunidadmini
integer x = 2862
integer y = 1316
end type

type tab_1 from w_busqueda`tab_1 within w_busqueda_admaunidadmini
integer width = 2391
long backcolor = 12632256
integer selectedtab = 2
end type

on tab_1.create
call super::create
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
call super::destroy
end on

type tabpage_1 from w_busqueda`tabpage_1 within tab_1
boolean visible = false
integer width = 2354
boolean enabled = false
end type

type pb_filtrar from w_busqueda`pb_filtrar within tabpage_1
boolean visible = false
end type

type tabpage_2 from w_busqueda`tabpage_2 within tab_1
integer width = 2354
end type

type pb_acepta from w_busqueda`pb_acepta within tabpage_2
end type

type dw_3 from w_busqueda`dw_3 within tabpage_2
end type

type dw_2 from w_busqueda`dw_2 within tabpage_2
end type

type tabpage_3 from w_busqueda`tabpage_3 within tab_1
integer width = 2354
end type

type sle_argumento2 from w_busqueda`sle_argumento2 within tabpage_3
end type

event sle_argumento2::getfocus;call super::getfocus;This.SelectText(1, Len(This.Text))

This.Text						= ""
This.BackColor					= RGB(255,255,255)
This.TabOrder					= 10
sle_argumento1.Text			= ""
sle_argumento1.BackColor	= RGB(166,180,210)
sle_argumento1.TabOrder		= 0
es_numero						= False
is_busca							= "adun_nombre"
end event

type st_argum2 from w_busqueda`st_argum2 within tabpage_3
string text = "Nombre"
end type

type sle_argumento1 from w_busqueda`sle_argumento1 within tabpage_3
end type

event sle_argumento1::getfocus;This.SelectText(1, Len(This.Text))

This.BackColor					= RGB(255,255,255)
This.TabOrder					= 10
sle_argumento2.Text			= ""
sle_argumento2.BackColor	= RGB(166,180,210)
sle_argumento2.TabOrder		= 0
es_numero						= True
is_busca							= "adun_codigo"
end event

type st_argum1 from w_busqueda`st_argum1 within tabpage_3
string text = "Código"
end type

type pb_buscar from w_busqueda`pb_buscar within tabpage_3
end type

