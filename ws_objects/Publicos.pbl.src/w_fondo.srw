$PBExportHeader$w_fondo.srw
$PBExportComments$Fondo de Ventana Principal (Logos y Datos)
forward
global type w_fondo from window
end type
type p_logoempresa from picture within w_fondo
end type
type st_titref from statictext within w_fondo
end type
type st_txtref from statictext within w_fondo
end type
type st_txtsuc from statictext within w_fondo
end type
type st_txtcom from statictext within w_fondo
end type
type st_txtver from statictext within w_fondo
end type
type st_txtcon from statictext within w_fondo
end type
type st_txtins from statictext within w_fondo
end type
type st_txtusu from statictext within w_fondo
end type
type st_titver from statictext within w_fondo
end type
type st_titcom from statictext within w_fondo
end type
type st_titcon from statictext within w_fondo
end type
type st_titsuc from statictext within w_fondo
end type
type st_titins from statictext within w_fondo
end type
type st_titusu from statictext within w_fondo
end type
end forward

global type w_fondo from window
integer width = 4878
integer height = 2456
boolean enabled = false
windowtype windowtype = child!
windowstate windowstate = maximized!
long backcolor = 553648127
string icon = "AppIcon!"
integer transparency = 100
windowanimationstyle closeanimation = rightslide!
p_logoempresa p_logoempresa
st_titref st_titref
st_txtref st_txtref
st_txtsuc st_txtsuc
st_txtcom st_txtcom
st_txtver st_txtver
st_txtcon st_txtcon
st_txtins st_txtins
st_txtusu st_txtusu
st_titver st_titver
st_titcom st_titcom
st_titcon st_titcon
st_titsuc st_titsuc
st_titins st_titins
st_titusu st_titusu
end type
global w_fondo w_fondo

type variables
uo_medidas_escritorio	iuo_medidas
end variables

on w_fondo.create
this.p_logoempresa=create p_logoempresa
this.st_titref=create st_titref
this.st_txtref=create st_txtref
this.st_txtsuc=create st_txtsuc
this.st_txtcom=create st_txtcom
this.st_txtver=create st_txtver
this.st_txtcon=create st_txtcon
this.st_txtins=create st_txtins
this.st_txtusu=create st_txtusu
this.st_titver=create st_titver
this.st_titcom=create st_titcom
this.st_titcon=create st_titcon
this.st_titsuc=create st_titsuc
this.st_titins=create st_titins
this.st_titusu=create st_titusu
this.Control[]={this.p_logoempresa,&
this.st_titref,&
this.st_txtref,&
this.st_txtsuc,&
this.st_txtcom,&
this.st_txtver,&
this.st_txtcon,&
this.st_txtins,&
this.st_txtusu,&
this.st_titver,&
this.st_titcom,&
this.st_titcon,&
this.st_titsuc,&
this.st_titins,&
this.st_titusu}
end on

on w_fondo.destroy
destroy(this.p_logoempresa)
destroy(this.st_titref)
destroy(this.st_txtref)
destroy(this.st_txtsuc)
destroy(this.st_txtcom)
destroy(this.st_txtver)
destroy(this.st_txtcon)
destroy(this.st_txtins)
destroy(this.st_txtusu)
destroy(this.st_titver)
destroy(this.st_titcom)
destroy(this.st_titcon)
destroy(this.st_titsuc)
destroy(this.st_titins)
destroy(this.st_titusu)
end on

event resize;Integer	li_AnchoLogo, li_AltoLogo, li_Ancho = 2000
Decimal	ld_Factor
Long		li_HeightAc = 0
This.x	=	1
This.y	=	1
//iuo_medidas.cargamedidas()
//This.Width				= 	PixelsToUnits(iuo_medidas.il_Right - 300, XPixelsToUnits!)
ld_Factor				=	li_Ancho / p_LogoEmpresa.Width

p_LogoEmpresa.Width	=	2000	//p_LogoEmpresa.Width * ld_Factor
p_LogoEmpresa.Height	=	1550	//p_LogoEmpresa.Height * ld_Factor
p_LogoEmpresa.x		=	132
p_LogoEmpresa.y		=	132

li_HeightAc 				=	p_logoempresa.y + (p_logoempresa.Height / 2)

st_txtcon.x				=	This.WorkSpaceWidth() - st_txtcon.Width - 10
st_txtins.x				=	st_txtcon.x
st_txtsuc.x 				=	st_txtcon.x
st_txtusu.x				=	st_txtcon.x
st_txtcom.x				=	st_txtcon.x
st_txtver.x				=	st_txtcon.x
st_txtref.x				=	st_txtcon.x

st_titcon.x				=	This.WorkSpaceWidth() - st_txtcon.Width - st_titcon.Width - 4
st_titins.x				=	st_titcon.x
st_titsuc.x 				=	st_titcon.x
st_titusu.x				=	st_titcon.x
st_titcom.x				=	st_titcon.x
st_titver.x				=	st_titcon.x
st_titref.x				=	st_titcon.x

st_txtref.y				=	li_HeightAc
st_titref.y				=	st_txtref.y
li_HeightAc				=	li_HeightAc + st_txtver.Height + 8

st_txtcon.y				=	li_HeightAc
st_titcon.y				=	st_txtcon.y
li_HeightAc				=	li_HeightAc + st_txtcon.Height + 8

st_txtins.y				=	li_HeightAc
st_titins.y				=	st_txtins.y
li_HeightAc				=	li_HeightAc + st_txtins.Height + 8

st_txtsuc.y				=	li_HeightAc
st_titsuc.y				=	st_txtsuc.y
li_HeightAc				=	li_HeightAc + st_txtsuc.Height + 8

st_txtusu.y				=	li_HeightAc
st_titusu.y				=	st_txtusu.y
li_HeightAc				=	li_HeightAc + st_txtusu.Height + 8

st_txtcom.y				=	li_HeightAc
st_titcom.y				= 	st_txtcom.y	
li_HeightAc				=	li_HeightAc + st_txtcom.Height + 8

st_txtver.y				=	li_HeightAc
st_titver.y				=	st_txtver.y
end event

event open;iuo_medidas		=	Create uo_medidas_escritorio

st_txtref.Text	=	gstr_apl.referencia
st_txtusu.Text	=	gstr_us.nombre
st_txtcom.Text	=	gstr_us.computador
st_txtins.Text	=	gstr_apl.instal
st_txtcon.Text	=	gstr_apl.Odbc
st_txtver.Text	=	gstr_apl.version

p_LogoEmpresa.PictureName	=	"\\Repos\Resources\LOGOS\Logo_300.png"

end event

type p_logoempresa from picture within w_fondo
integer x = 133
integer y = 132
integer width = 2002
integer height = 1552
string picturename = "\Repos\Resources\LOGOS\Logo_300.png"
boolean focusrectangle = false
end type

type st_titref from statictext within w_fondo
integer x = 2281
integer y = 1120
integer width = 475
integer height = 120
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
boolean italic = true
long textcolor = 8388608
long backcolor = 16777215
string text = "Referencia"
boolean focusrectangle = false
end type

type st_txtref from statictext within w_fondo
integer x = 2770
integer y = 1120
integer width = 1755
integer height = 120
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
boolean italic = true
long textcolor = 8388608
long backcolor = 16777215
boolean focusrectangle = false
end type

type st_txtsuc from statictext within w_fondo
boolean visible = false
integer x = 2770
integer y = 1504
integer width = 1755
integer height = 120
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
boolean italic = true
long textcolor = 8388608
long backcolor = 16777215
boolean focusrectangle = false
end type

type st_txtcom from statictext within w_fondo
integer x = 2770
integer y = 1632
integer width = 1755
integer height = 120
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
boolean italic = true
long textcolor = 8388608
long backcolor = 16777215
boolean focusrectangle = false
end type

type st_txtver from statictext within w_fondo
integer x = 2770
integer y = 1760
integer width = 1755
integer height = 120
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
boolean italic = true
long textcolor = 8388608
long backcolor = 16777215
boolean focusrectangle = false
end type

type st_txtcon from statictext within w_fondo
integer x = 2770
integer y = 1888
integer width = 1755
integer height = 120
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
boolean italic = true
long textcolor = 8388608
long backcolor = 16777215
boolean focusrectangle = false
end type

type st_txtins from statictext within w_fondo
integer x = 2770
integer y = 1248
integer width = 1755
integer height = 120
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
boolean italic = true
long textcolor = 8388608
long backcolor = 16777215
boolean focusrectangle = false
end type

type st_txtusu from statictext within w_fondo
integer x = 2770
integer y = 1376
integer width = 1755
integer height = 120
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
boolean italic = true
long textcolor = 8388608
long backcolor = 16777215
boolean focusrectangle = false
end type

type st_titver from statictext within w_fondo
integer x = 2281
integer y = 1760
integer width = 475
integer height = 120
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
boolean italic = true
long textcolor = 8388608
long backcolor = 16777215
string text = "Versión"
boolean focusrectangle = false
end type

type st_titcom from statictext within w_fondo
integer x = 2281
integer y = 1632
integer width = 475
integer height = 120
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
boolean italic = true
long textcolor = 8388608
long backcolor = 16777215
string text = "Nombre Pc"
boolean focusrectangle = false
end type

type st_titcon from statictext within w_fondo
integer x = 2281
integer y = 1888
integer width = 475
integer height = 120
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
boolean italic = true
long textcolor = 8388608
long backcolor = 16777215
string text = "Conexión"
boolean focusrectangle = false
end type

type st_titsuc from statictext within w_fondo
boolean visible = false
integer x = 2281
integer y = 1504
integer width = 475
integer height = 120
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
boolean italic = true
long textcolor = 8388608
long backcolor = 16777215
string text = "Sucursal"
boolean focusrectangle = false
end type

type st_titins from statictext within w_fondo
boolean visible = false
integer x = 2281
integer y = 1248
integer width = 475
integer height = 120
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
boolean italic = true
long textcolor = 8388608
long backcolor = 16777215
string text = "Instalación"
boolean focusrectangle = false
end type

type st_titusu from statictext within w_fondo
integer x = 2281
integer y = 1376
integer width = 475
integer height = 120
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
boolean italic = true
long textcolor = 8388608
long backcolor = 16777215
string text = "Usuario"
boolean focusrectangle = false
end type

