$PBExportHeader$w_zoom.srw
$PBExportComments$Ampliación o reducción de visualización de un Informe en Datawindow
forward
global type w_zoom from window
end type
type cb_cancelar from commandbutton within w_zoom
end type
type cb_aplicar from commandbutton within w_zoom
end type
type cb_aceptar from commandbutton within w_zoom
end type
type dw_preview from datawindow within w_zoom
end type
type em_zoom from editmask within w_zoom
end type
type st_1 from statictext within w_zoom
end type
type rb_25 from radiobutton within w_zoom
end type
type rb_50 from radiobutton within w_zoom
end type
type rb_75 from radiobutton within w_zoom
end type
type rb_100 from radiobutton within w_zoom
end type
type rb_150 from radiobutton within w_zoom
end type
type rb_200 from radiobutton within w_zoom
end type
type gb_zoom from groupbox within w_zoom
end type
type gb_1 from groupbox within w_zoom
end type
end forward

global type w_zoom from window
integer width = 2533
integer height = 1324
boolean titlebar = true
string title = "Zoom"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 16777215
cb_cancelar cb_cancelar
cb_aplicar cb_aplicar
cb_aceptar cb_aceptar
dw_preview dw_preview
em_zoom em_zoom
st_1 st_1
rb_25 rb_25
rb_50 rb_50
rb_75 rb_75
rb_100 rb_100
rb_150 rb_150
rb_200 rb_200
gb_zoom gb_zoom
gb_1 gb_1
end type
global w_zoom w_zoom

type variables
str_zoom	istr_zoom
end variables

on w_zoom.create
this.cb_cancelar=create cb_cancelar
this.cb_aplicar=create cb_aplicar
this.cb_aceptar=create cb_aceptar
this.dw_preview=create dw_preview
this.em_zoom=create em_zoom
this.st_1=create st_1
this.rb_25=create rb_25
this.rb_50=create rb_50
this.rb_75=create rb_75
this.rb_100=create rb_100
this.rb_150=create rb_150
this.rb_200=create rb_200
this.gb_zoom=create gb_zoom
this.gb_1=create gb_1
this.Control[]={this.cb_cancelar,&
this.cb_aplicar,&
this.cb_aceptar,&
this.dw_preview,&
this.em_zoom,&
this.st_1,&
this.rb_25,&
this.rb_50,&
this.rb_75,&
this.rb_100,&
this.rb_150,&
this.rb_200,&
this.gb_zoom,&
this.gb_1}
end on

on w_zoom.destroy
destroy(this.cb_cancelar)
destroy(this.cb_aplicar)
destroy(this.cb_aceptar)
destroy(this.dw_preview)
destroy(this.em_zoom)
destroy(this.st_1)
destroy(this.rb_25)
destroy(this.rb_50)
destroy(this.rb_75)
destroy(this.rb_100)
destroy(this.rb_150)
destroy(this.rb_200)
destroy(this.gb_zoom)
destroy(this.gb_1)
end on

event open;integer	li_initialzoom

istr_zoom = Message.PowerObjectParm

IF IsNull(istr_zoom.idw_obj) Or Not IsValid (istr_zoom.idw_obj) THEN
	istr_zoom.zoom = -1
	Close (This)
END IF

li_initialzoom = istr_zoom.zoom
istr_zoom.zoom = 0

dw_preview.dataobject = istr_zoom.idw_obj.dataobject
istr_zoom.idw_obj.RowsCopy(1,istr_zoom.idw_obj.RowCount(),Primary!,dw_preview,1,Primary!)
dw_preview.object.datawindow.print.preview = True

CHOOSE CASE li_initialzoom
	CASE 200
		rb_200.checked = True

	CASE 150
		rb_150.checked = True

	CASE 100
		rb_100.checked = True

	CASE 75
		rb_75.checked = True

	CASE 50
		rb_50.checked = True

	CASE 25
		rb_25.checked = True

END CHOOSE

em_zoom.Text = String (li_initialzoom) + "%"
dw_preview.object.datawindow.zoom = li_initialzoom
end event

type cb_cancelar from commandbutton within w_zoom
integer x = 1998
integer y = 1096
integer width = 448
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
string text = "&Cancelar"
end type

event clicked;CloseWithReturn (Parent, 0)
end event

type cb_aplicar from commandbutton within w_zoom
integer x = 1998
integer y = 980
integer width = 448
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
boolean enabled = false
string text = "A&plicar"
end type

event clicked;f_Global_Replace(em_zoom.text, "%", "")

IF IsNumber (em_zoom.text) THEN
	istr_zoom.Zoom	=	Integer(em_zoom.text)
ELSE
	RETURN
END IF

istr_zoom.idw_obj.Object.DataWindow.Zoom	=	istr_zoom.Zoom

This.Enabled = False
end event

type cb_aceptar from commandbutton within w_zoom
integer x = 1998
integer y = 856
integer width = 448
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
string text = "&Aceptar"
end type

event clicked;TriggerEvent(cb_aplicar,Clicked!)

CloseWithReturn (Parent, 0)
end event

type dw_preview from datawindow within w_zoom
integer x = 69
integer y = 88
integer width = 1824
integer height = 1064
integer taborder = 30
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type em_zoom from editmask within w_zoom
string tag = "Ingrese el valor del porcentaje de aumento o disminución de la visión real."
integer x = 2075
integer y = 704
integer width = 283
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
string mask = "###"
boolean spin = true
double increment = 5
string minmax = "10~~200"
end type

type st_1 from statictext within w_zoom
integer x = 2075
integer y = 640
integer width = 283
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
long textcolor = 8388608
long backcolor = 553648127
string text = "Porcentaje"
boolean focusrectangle = false
end type

type rb_25 from radiobutton within w_zoom
integer x = 2075
integer y = 528
integer width = 283
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
long textcolor = 8388608
long backcolor = 553648127
string text = "25 %"
end type

event type long clicked(integer m);IF This.Checked THEN
	cb_aplicar.Enabled = True
END IF

dw_preview.object.datawindow.zoom = 25

em_zoom.Text = "25%"

RETURN 0
end event

type rb_50 from radiobutton within w_zoom
integer x = 2075
integer y = 448
integer width = 283
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
long textcolor = 8388608
long backcolor = 553648127
string text = "50 %"
end type

event clicked;IF This.Checked THEN
	cb_aplicar.Enabled = True
END IF

dw_preview.object.datawindow.zoom = 50

em_zoom.Text = "50%"
end event

type rb_75 from radiobutton within w_zoom
integer x = 2075
integer y = 364
integer width = 283
integer height = 84
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
long textcolor = 8388608
long backcolor = 553648127
string text = "75 %"
end type

event clicked;IF This.Checked THEN
	cb_aplicar.Enabled = True
END IF

dw_preview.object.datawindow.zoom = 75

em_zoom.Text = "75%"
end event

type rb_100 from radiobutton within w_zoom
integer x = 2075
integer y = 284
integer width = 283
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
long textcolor = 8388608
long backcolor = 553648127
string text = "100 %"
end type

event clicked;IF This.Checked THEN
	cb_aplicar.Enabled = True
END IF

dw_preview.object.datawindow.zoom = 100

em_zoom.Text = "100%"
end event

type rb_150 from radiobutton within w_zoom
integer x = 2075
integer y = 204
integer width = 283
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
long textcolor = 8388608
long backcolor = 553648127
string text = "150 %"
end type

event clicked;IF This.Checked THEN
	cb_aplicar.Enabled = True
END IF

dw_preview.object.datawindow.zoom = 150

em_zoom.Text = "150%"
end event

type rb_200 from radiobutton within w_zoom
integer x = 2075
integer y = 124
integer width = 283
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
long textcolor = 8388608
long backcolor = 553648127
string text = "200 %"
end type

event clicked;IF This.Checked THEN
	cb_aplicar.Enabled = True
END IF

dw_preview.object.datawindow.zoom = 200

em_zoom.Text = "200%"
end event

type gb_zoom from groupbox within w_zoom
integer x = 1979
integer y = 32
integer width = 480
integer height = 784
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
long textcolor = 8388608
long backcolor = 553648127
string text = "Zoom a"
end type

type gb_1 from groupbox within w_zoom
integer x = 37
integer y = 32
integer width = 1897
integer height = 1156
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
long textcolor = 8388608
long backcolor = 553648127
string text = "Presentación preliminar"
end type

