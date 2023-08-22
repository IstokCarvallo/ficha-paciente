$PBExportHeader$w_toolbars.srw
forward
global type w_toolbars from window
end type
type rb_floating from radiobutton within w_toolbars
end type
type rb_bottom from radiobutton within w_toolbars
end type
type rb_right from radiobutton within w_toolbars
end type
type rb_top from radiobutton within w_toolbars
end type
type rb_left from radiobutton within w_toolbars
end type
type cb_2 from commandbutton within w_toolbars
end type
type cb_visible from commandbutton within w_toolbars
end type
type cbx_showtext from checkbox within w_toolbars
end type
type gb_1 from groupbox within w_toolbars
end type
end forward

global type w_toolbars from window
integer x = 850
integer y = 468
integer width = 1184
integer height = 856
boolean titlebar = true
string title = "Barra de Herramientas"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 16777215
string icon = "Question!"
rb_floating rb_floating
rb_bottom rb_bottom
rb_right rb_right
rb_top rb_top
rb_left rb_left
cb_2 cb_2
cb_visible cb_visible
cbx_showtext cbx_showtext
gb_1 gb_1
end type
global w_toolbars w_toolbars

type variables
/* Current application */
application	iapp_application

/* Owning toolbar window */
window		iw_window
end variables

on open;/* Owning toolbar window is passed as reference */
iw_window = message.powerobjectparm

/* Note the current application */
iapp_application = GetApplication ()

/* Set toolbar alignment status */
choose case iw_window.toolbaralignment
	case alignatbottom! 
		rb_bottom.checked = true
	case alignatleft!
		rb_left.checked = true
	case alignatright! 
		rb_right.checked = true
	case alignattop! 
		rb_top.checked = true
	case floating!
		rb_floating.checked = true
end choose

/* Set toolbar visible status */
if iw_window.toolbarvisible then
	cb_visible.text = "&Esconder"
else
	cb_visible.text = "&Mostrar"
end if

/* Set toolbar text mode status */
cbx_showtext.checked = iapp_application.toolbartext 


end on

on w_toolbars.create
this.rb_floating=create rb_floating
this.rb_bottom=create rb_bottom
this.rb_right=create rb_right
this.rb_top=create rb_top
this.rb_left=create rb_left
this.cb_2=create cb_2
this.cb_visible=create cb_visible
this.cbx_showtext=create cbx_showtext
this.gb_1=create gb_1
this.Control[]={this.rb_floating,&
this.rb_bottom,&
this.rb_right,&
this.rb_top,&
this.rb_left,&
this.cb_2,&
this.cb_visible,&
this.cbx_showtext,&
this.gb_1}
end on

on w_toolbars.destroy
destroy(this.rb_floating)
destroy(this.rb_bottom)
destroy(this.rb_right)
destroy(this.rb_top)
destroy(this.rb_left)
destroy(this.cb_2)
destroy(this.cb_visible)
destroy(this.cbx_showtext)
destroy(this.gb_1)
end on

type rb_floating from radiobutton within w_toolbars
integer x = 114
integer y = 476
integer width = 379
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 553648127
string text = "&Flotando"
end type

on clicked;/* Make toolbar float */
iw_window.toolbaralignment = floating!
end on

type rb_bottom from radiobutton within w_toolbars
integer x = 119
integer y = 388
integer width = 315
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 553648127
string text = "&Abajo"
end type

on clicked;/* Align toolbar at bottom */
iw_window.toolbaralignment = alignatbottom!
end on

type rb_right from radiobutton within w_toolbars
integer x = 119
integer y = 300
integer width = 366
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 553648127
string text = "&Derecha"
end type

on clicked;/* Align toolbar at right */
iw_window.toolbaralignment = alignatright!
end on

type rb_top from radiobutton within w_toolbars
integer x = 119
integer y = 212
integer width = 302
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 553648127
string text = "&Arriba"
end type

on clicked;/* Align toolbar at top */
iw_window.toolbaralignment = alignattop!
end on

type rb_left from radiobutton within w_toolbars
integer x = 119
integer y = 116
integer width = 398
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 553648127
string text = "&Izquierda"
end type

on clicked;/* Align toolbar at left */
iw_window.toolbaralignment = alignatleft!
end on

type cb_2 from commandbutton within w_toolbars
integer x = 663
integer y = 216
integer width = 425
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Aceptar"
end type

on clicked;/* Close toolbar configuration window */
Close (parent)
end on

type cb_visible from commandbutton within w_toolbars
integer x = 658
integer y = 72
integer width = 430
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Esconder"
boolean default = true
end type

on clicked;/* Indicate opposite toolbar visible status */
if this.text = "&Esconder" then
	iw_window.toolbarvisible = False
	this.text = "&Mostrar"
else
	iw_window.toolbarvisible = True
	this.text = "&Esconder"
end if
end on

type cbx_showtext from checkbox within w_toolbars
integer x = 55
integer y = 616
integer width = 535
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 553648127
string text = "Muestra Te&xto"
end type

on clicked;/* Set toolbar text mode */
iapp_application.toolbartext = this.checked 

end on

type gb_1 from groupbox within w_toolbars
integer x = 55
integer y = 44
integer width = 507
integer height = 544
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 553648127
string text = "Mover"
end type

