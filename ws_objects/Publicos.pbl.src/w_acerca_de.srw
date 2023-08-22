$PBExportHeader$w_acerca_de.srw
forward
global type w_acerca_de from window
end type
type pb_1 from picturebutton within w_acerca_de
end type
type p_2 from picture within w_acerca_de
end type
type shl_1 from statichyperlink within w_acerca_de
end type
type st_1 from statictext within w_acerca_de
end type
type st_sistema from statictext within w_acerca_de
end type
type st_otro from statictext within w_acerca_de
end type
type p_mono from picture within w_acerca_de
end type
type st_libera from statictext within w_acerca_de
end type
type st_version from statictext within w_acerca_de
end type
type ln_1 from line within w_acerca_de
end type
type ln_2 from line within w_acerca_de
end type
end forward

global type w_acerca_de from window
integer x = 567
integer y = 304
integer width = 2144
integer height = 1532
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 16777215
string icon = "Information!"
pb_1 pb_1
p_2 p_2
shl_1 shl_1
st_1 st_1
st_sistema st_sistema
st_otro st_otro
p_mono p_mono
st_libera st_libera
st_version st_version
ln_1 ln_1
ln_2 ln_2
end type
global w_acerca_de w_acerca_de

on w_acerca_de.create
this.pb_1=create pb_1
this.p_2=create p_2
this.shl_1=create shl_1
this.st_1=create st_1
this.st_sistema=create st_sistema
this.st_otro=create st_otro
this.p_mono=create p_mono
this.st_libera=create st_libera
this.st_version=create st_version
this.ln_1=create ln_1
this.ln_2=create ln_2
this.Control[]={this.pb_1,&
this.p_2,&
this.shl_1,&
this.st_1,&
this.st_sistema,&
this.st_otro,&
this.p_mono,&
this.st_libera,&
this.st_version,&
this.ln_1,&
this.ln_2}
end on

on w_acerca_de.destroy
destroy(this.pb_1)
destroy(this.p_2)
destroy(this.shl_1)
destroy(this.st_1)
destroy(this.st_sistema)
destroy(this.st_otro)
destroy(this.p_mono)
destroy(this.st_libera)
destroy(this.st_version)
destroy(this.ln_1)
destroy(this.ln_2)
end on

event open;This.Icon					=	Gstr_apl.Icono
p_mono.OriginalSize	=	False
p_mono.PictureName	=	Gstr_apl.bmp
st_sistema.text			=	Gstr_apl.titulo
st_1.text					=	Gstr_apl.instalacion
st_libera.text			=	Gstr_apl.liberacion
st_version.text			=	"Versión " + Gstr_apl.version
end event

type pb_1 from picturebutton within w_acerca_de
integer x = 1682
integer y = 1100
integer width = 393
integer height = 328
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\Repos\Resources\BTN\Aceptar.png"
end type

event clicked;Close (parent)
end event

type p_2 from picture within w_acerca_de
integer x = 713
integer y = 832
integer width = 677
integer height = 456
boolean focusrectangle = false
end type

type shl_1 from statichyperlink within w_acerca_de
boolean visible = false
integer x = 475
integer y = 1292
integer width = 1106
integer height = 108
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "HyperLink!"
long textcolor = 16711680
long backcolor = 553648127
string text = "www.MIcasa.net"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_acerca_de
boolean visible = false
integer y = 64
integer width = 2103
integer height = 148
integer textsize = -26
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean italic = true
long textcolor = 32896
long backcolor = 553648127
alignment alignment = center!
boolean focusrectangle = false
end type

type st_sistema from statictext within w_acerca_de
integer x = 361
integer y = 312
integer width = 1746
integer height = 168
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 553648127
boolean enabled = false
string text = "SISTEMA"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_otro from statictext within w_acerca_de
integer y = 724
integer width = 2103
integer height = 120
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 553648127
boolean enabled = false
string text = "Producto licenciado para :"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_mono from picture within w_acerca_de
integer x = 78
integer y = 300
integer width = 242
integer height = 216
boolean border = true
boolean focusrectangle = false
end type

type st_libera from statictext within w_acerca_de
integer y = 628
integer width = 2103
integer height = 88
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 553648127
boolean enabled = false
string text = "Fecha de Liberación de Versión"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_version from statictext within w_acerca_de
integer x = 361
integer y = 488
integer width = 1746
integer height = 92
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 553648127
boolean enabled = false
string text = "Versión 1.0"
alignment alignment = center!
boolean focusrectangle = false
end type

type ln_1 from line within w_acerca_de
integer linethickness = 5
integer beginy = 608
integer endx = 2103
integer endy = 608
end type

type ln_2 from line within w_acerca_de
long linecolor = 16777215
integer linethickness = 5
integer beginy = 612
integer endx = 2103
integer endy = 612
end type

