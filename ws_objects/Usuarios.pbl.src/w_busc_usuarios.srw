$PBExportHeader$w_busc_usuarios.srw
$PBExportComments$Búsqueda de Sucursales.
forward
global type w_busc_usuarios from w_busqueda
end type
end forward

global type w_busc_usuarios from w_busqueda
integer x = 78
integer y = 176
integer width = 2907
integer height = 1808
string title = "Búsqueda de Grupos del Sistema"
boolean resizable = false
end type
global w_busc_usuarios w_busc_usuarios

type variables

end variables

event open;call super::open;istr_busq		=	Message.PowerobjectParm
istr_mant.dw	=	dw_1

IF dw_1.Retrieve() > 0 THEN
	dw_1.SetFocus()
	dw_1.SelectRow(1,True)
	
	is_ordena = 'Código:usua_codigo,Nombre:usua_nombre'
ELSE
	
	MessageBox("Atención","No hay información para mostrar",Exclamation!,Ok!)
	CloseWithReturn(This,istr_busq)
END IF
end event

on w_busc_usuarios.create
call super::create
end on

on w_busc_usuarios.destroy
call super::destroy
end on

event ue_asignacion;istr_busq.argum[1]	=	dw_1.Object.usua_codigo[dw_1.GetRow()]
istr_busq.argum[2]	=	dw_1.Object.usua_nombre[dw_1.GetRow()]

CloseWithReturn(This,istr_busq)
end event

type pb_insertar from w_busqueda`pb_insertar within w_busc_usuarios
boolean visible = false
integer x = 2373
integer taborder = 30
end type

type dw_1 from w_busqueda`dw_1 within w_busc_usuarios
integer x = 73
integer y = 764
integer width = 1911
integer taborder = 20
string dataobject = "dw_mues_admausuarios_sel"
end type

type pb_salir from w_busqueda`pb_salir within w_busc_usuarios
integer x = 2373
integer y = 1440
integer taborder = 40
end type

event pb_salir::clicked;CloseWithReturn(Parent,istr_busq)
end event

type tab_1 from w_busqueda`tab_1 within w_busc_usuarios
integer y = 76
integer width = 2094
integer height = 608
boolean fixedwidth = true
integer selectedtab = 2
end type

type tabpage_1 from w_busqueda`tabpage_1 within tab_1
boolean visible = false
integer width = 2057
integer height = 480
boolean enabled = false
long backcolor = 12632256
string text = "Filtros  "
long tabbackcolor = 12632256
end type

type pb_filtrar from w_busqueda`pb_filtrar within tabpage_1
boolean visible = false
integer x = 1646
integer y = 308
boolean enabled = false
end type

type tabpage_2 from w_busqueda`tabpage_2 within tab_1
integer width = 2057
integer height = 480
string text = "Ordenamiento      "
end type

type pb_acepta from w_busqueda`pb_acepta within tabpage_2
end type

type dw_3 from w_busqueda`dw_3 within tabpage_2
integer y = 40
end type

type dw_2 from w_busqueda`dw_2 within tabpage_2
end type

type tabpage_3 from w_busqueda`tabpage_3 within tab_1
integer width = 2057
integer height = 480
string text = "Búsqueda  "
end type

type sle_argumento2 from w_busqueda`sle_argumento2 within tabpage_3
integer x = 457
end type

event sle_argumento2::getfocus;This.SelectText(1, Len(This.Text))

This.Text						= ""
This.BackColor					= RGB(255,255,255)
This.TabOrder					= 10
sle_argumento1.Text			= ""
sle_argumento1.BackColor	= RGB(166,180,210)
sle_argumento1.TabOrder		= 0
es_numero						= False
is_busca							= "grpo_nombre"
end event

type st_argum2 from w_busqueda`st_argum2 within tabpage_3
integer width = 274
long backcolor = 12632256
string text = "Nombre"
end type

type sle_argumento1 from w_busqueda`sle_argumento1 within tabpage_3
integer x = 457
integer width = 256
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
integer width = 261
long backcolor = 12632256
string text = "Código"
end type

type pb_buscar from w_busqueda`pb_buscar within tabpage_3
integer x = 1851
integer y = 316
end type

