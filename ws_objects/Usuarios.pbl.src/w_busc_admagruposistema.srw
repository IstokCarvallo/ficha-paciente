$PBExportHeader$w_busc_admagruposistema.srw
forward
global type w_busc_admagruposistema from w_busqueda
end type
end forward

global type w_busc_admagruposistema from w_busqueda
end type
global w_busc_admagruposistema w_busc_admagruposistema

on w_busc_admagruposistema.create
call super::create
end on

on w_busc_admagruposistema.destroy
call super::destroy
end on

event open;call super::open;istr_busq	= Message.PowerobjectParm
istr_mant.argumento[1] = istr_busq.argum[3] //cod. sistema

istr_mant.dw =  dw_1

IF dw_1.Retrieve(Integer(istr_mant.argumento[1])) > 0 THEN
	dw_1.SetFocus()
	dw_1.SelectRow(1,True)
	is_ordena				= 'Código:grpo_codigo,Nombre:grpo_nombre'
ELSE
	
	MessageBox("Atención","No hay información para mostrar",Exclamation!,Ok!)
	CloseWithReturn(This,istr_busq)
END IF
end event

event ue_asignacion();istr_busq.argum[1]	=	String(dw_1.Object.grpo_codigo[dw_1.GetRow()])
istr_busq.argum[2]	=	String(dw_1.Object.grpo_nombre[dw_1.GetRow()])
istr_busq.argum[3]	=	String(dw_1.Object.sist_codigo[dw_1.GetRow()])

CloseWithReturn(This,istr_busq)
end event

type pb_insertar from w_busqueda`pb_insertar within w_busc_admagruposistema
boolean visible = false
boolean enabled = false
end type

type dw_1 from w_busqueda`dw_1 within w_busc_admagruposistema
string dataobject = "dw_mues_admagruposistema"
end type

event dw_1::doubleclicked;IF row > 0 THEN
	Parent.PostEvent("ue_asignacion")
END IF
end event

type pb_salir from w_busqueda`pb_salir within w_busc_admagruposistema
end type

event pb_salir::clicked;CloseWithReturn(parent,istr_busq)
end event

type tab_1 from w_busqueda`tab_1 within w_busc_admagruposistema
integer selectedtab = 2
end type

type tabpage_1 from w_busqueda`tabpage_1 within tab_1
boolean visible = false
boolean enabled = false
long backcolor = 12632256
long tabbackcolor = 12632256
end type

type pb_filtrar from w_busqueda`pb_filtrar within tabpage_1
boolean visible = false
boolean enabled = false
boolean default = false
end type

type tabpage_2 from w_busqueda`tabpage_2 within tab_1
end type

type pb_acepta from w_busqueda`pb_acepta within tabpage_2
end type

type dw_3 from w_busqueda`dw_3 within tabpage_2
end type

type dw_2 from w_busqueda`dw_2 within tabpage_2
end type

type tabpage_3 from w_busqueda`tabpage_3 within tab_1
end type

type sle_argumento2 from w_busqueda`sle_argumento2 within tabpage_3
end type

event sle_argumento2::getfocus;This.SelectText(1, Len(This.Text))

This.Text						= ""
This.BackColor					= RGB(255,255,255)
This.TabOrder					= 10
sle_argumento1.Text			= ""
sle_argumento1.BackColor	= RGB(166,180,210)
sle_argumento1.TabOrder		= 0
es_numero						= False
is_busca							= "grpo_codigo"
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
es_numero						= False
is_busca							= "grpo_codigo"
end event

type st_argum1 from w_busqueda`st_argum1 within tabpage_3
string text = "Código"
end type

type pb_buscar from w_busqueda`pb_buscar within tabpage_3
end type

