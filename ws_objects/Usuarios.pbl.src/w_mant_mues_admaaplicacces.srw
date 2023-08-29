$PBExportHeader$w_mant_mues_admaaplicacces.srw
$PBExportComments$Ventana que muestra el estado de los accesos a las aplicaciones.
forward
global type w_mant_mues_admaaplicacces from w_mant_tabla
end type
type em_timer from editmask within w_mant_mues_admaaplicacces
end type
type st_1 from statictext within w_mant_mues_admaaplicacces
end type
end forward

global type w_mant_mues_admaaplicacces from w_mant_tabla
integer width = 3982
string title = "VISOR DE ACCESO A APLICACIONES"
windowstate windowstate = maximized!
em_timer em_timer
st_1 st_1
end type
global w_mant_mues_admaaplicacces w_mant_mues_admaaplicacces

on w_mant_mues_admaaplicacces.create
int iCurrent
call super::create
this.em_timer=create em_timer
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_timer
this.Control[iCurrent+2]=this.st_1
end on

on w_mant_mues_admaaplicacces.destroy
call super::destroy
destroy(this.em_timer)
destroy(this.st_1)
end on

event open;x				=	0
y				=	0
This.Width	=	dw_1.width + 640
This.Height	=	2500
im_menu		=	m_principal

This.Icon									=	Gstr_apl.Icono
This.ParentWindow().ToolBarVisible	=	True
im_menu.Item[1].Item[6].Enabled		=	True
im_menu.Item[7].Visible					=	True

dw_1.SetTransObject(sqlca)
dw_1.Modify("datawindow.message.title='Error '+ is_titulo")
dw_1.Modify("DataWindow.Footer.Height = 110")

istr_mant.dw	= dw_1

buscar	= "Código:usua_codigo,Descripción:apac_desapl"
ordenar	= "Código:usua_codigo,FechaAcceso:apac_fechaa,Descripcion:apac_desapl"

f_GrabaAccesoAplicacion(True, id_FechaAcceso, it_HoraAcceso, This.Title, "Acceso a Aplicación", 1)

em_timer.SetFocus()
dw_1.Retrieve()
Timer(5)
end event

event timer;call super::timer;TriggerEvent("ue_recuperadatos")
end event

event ue_recuperadatos;dw_1.Retrieve()
end event

type dw_1 from w_mant_tabla`dw_1 within w_mant_mues_admaaplicacces
integer y = 328
integer width = 3045
integer height = 1472
integer taborder = 40
string dataobject = "dw_mues_admaaplicacces"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

type st_encabe from w_mant_tabla`st_encabe within w_mant_mues_admaaplicacces
integer height = 200
end type

type pb_lectura from w_mant_tabla`pb_lectura within w_mant_mues_admaaplicacces
integer x = 3529
integer y = 176
end type

type pb_nuevo from w_mant_tabla`pb_nuevo within w_mant_mues_admaaplicacces
boolean visible = false
integer x = 3529
integer y = 432
integer taborder = 30
end type

type pb_insertar from w_mant_tabla`pb_insertar within w_mant_mues_admaaplicacces
boolean visible = false
integer x = 3529
integer y = 612
integer taborder = 50
end type

type pb_eliminar from w_mant_tabla`pb_eliminar within w_mant_mues_admaaplicacces
boolean visible = false
integer x = 3529
integer y = 792
integer taborder = 60
end type

type pb_grabar from w_mant_tabla`pb_grabar within w_mant_mues_admaaplicacces
boolean visible = false
integer x = 3529
integer y = 972
integer taborder = 70
end type

type pb_imprimir from w_mant_tabla`pb_imprimir within w_mant_mues_admaaplicacces
boolean visible = false
integer x = 3529
integer y = 1152
integer taborder = 80
end type

type pb_salir from w_mant_tabla`pb_salir within w_mant_mues_admaaplicacces
integer x = 3506
integer y = 1524
integer taborder = 90
end type

type em_timer from editmask within w_mant_mues_admaaplicacces
integer x = 1079
integer y = 124
integer width = 201
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "5"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "###"
end type

event modified;Integer li_Timer

li_Timer	=	Integer(em_Timer.Text)

IF li_Timer > 0 THEN	
	Timer(li_Timer)
END IF
end event

type st_1 from statictext within w_mant_mues_admaaplicacces
integer x = 713
integer y = 136
integer width = 261
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 553648127
string text = "Intervalo"
boolean focusrectangle = false
end type

