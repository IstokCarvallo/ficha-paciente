$PBExportHeader$w_depura_admaaplicacces.srw
$PBExportComments$Pantalla de selección múltiple que muestra el acceso de los usuarios al sistema correspondiente.
forward
global type w_depura_admaaplicacces from w_para_informes
end type
type st_1 from statictext within w_depura_admaaplicacces
end type
type st_2 from statictext within w_depura_admaaplicacces
end type
type dw_grupos from datawindow within w_depura_admaaplicacces
end type
type st_3 from statictext within w_depura_admaaplicacces
end type
type dw_usuarios from datawindow within w_depura_admaaplicacces
end type
type st_4 from statictext within w_depura_admaaplicacces
end type
type cbx_grupos from checkbox within w_depura_admaaplicacces
end type
type cbx_usuarios from checkbox within w_depura_admaaplicacces
end type
type st_5 from statictext within w_depura_admaaplicacces
end type
type em_inicio from editmask within w_depura_admaaplicacces
end type
type em_termino from editmask within w_depura_admaaplicacces
end type
type st_6 from statictext within w_depura_admaaplicacces
end type
end forward

global type w_depura_admaaplicacces from w_para_informes
integer width = 2437
integer height = 1504
string title = "CONTROL ACCESOS"
st_1 st_1
st_2 st_2
dw_grupos dw_grupos
st_3 st_3
dw_usuarios dw_usuarios
st_4 st_4
cbx_grupos cbx_grupos
cbx_usuarios cbx_usuarios
st_5 st_5
em_inicio em_inicio
em_termino em_termino
st_6 st_6
end type
global w_depura_admaaplicacces w_depura_admaaplicacces

type variables
str_mant   istr_mant

DataWindowChild	idwc_usuarios, idwc_grupos
end variables

on w_depura_admaaplicacces.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
this.dw_grupos=create dw_grupos
this.st_3=create st_3
this.dw_usuarios=create dw_usuarios
this.st_4=create st_4
this.cbx_grupos=create cbx_grupos
this.cbx_usuarios=create cbx_usuarios
this.st_5=create st_5
this.em_inicio=create em_inicio
this.em_termino=create em_termino
this.st_6=create st_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.dw_grupos
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.dw_usuarios
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.cbx_grupos
this.Control[iCurrent+8]=this.cbx_usuarios
this.Control[iCurrent+9]=this.st_5
this.Control[iCurrent+10]=this.em_inicio
this.Control[iCurrent+11]=this.em_termino
this.Control[iCurrent+12]=this.st_6
end on

on w_depura_admaaplicacces.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_grupos)
destroy(this.st_3)
destroy(this.dw_usuarios)
destroy(this.st_4)
destroy(this.cbx_grupos)
destroy(this.cbx_usuarios)
destroy(this.st_5)
destroy(this.em_inicio)
destroy(this.em_termino)
destroy(this.st_6)
end on

event open;call super::open;Date	ld_FechaInicio	

dw_grupos.GetChild("grpo_codigo", idwc_grupos)
idwc_grupos.SetTransObject(sqlca)
dw_grupos.InsertRow(0)

dw_usuarios.GetChild("usua_codigo", idwc_usuarios)
idwc_usuarios.SetTransObject(sqlca)
dw_usuarios.InsertRow(0)

em_inicio.Text		=	String(ld_FechaInicio)
em_termino.Text	=	String(Today())
end event

type pb_excel from w_para_informes`pb_excel within w_depura_admaaplicacces
integer x = 2034
integer y = 304
end type

type st_computador from w_para_informes`st_computador within w_depura_admaaplicacces
end type

type st_usuario from w_para_informes`st_usuario within w_depura_admaaplicacces
end type

type st_temporada from w_para_informes`st_temporada within w_depura_admaaplicacces
end type

type p_logo from w_para_informes`p_logo within w_depura_admaaplicacces
end type

type st_titulo from w_para_informes`st_titulo within w_depura_admaaplicacces
integer x = 279
integer width = 1632
string text = "Depuración Accesos a Aplicaciones"
end type

type pb_acepta from w_para_informes`pb_acepta within w_depura_admaaplicacces
integer x = 2039
integer y = 568
integer taborder = 70
string picturename = "\Repos\Resources\BTN\Aceptar.png"
string disabledname = "\Repos\Resources\BTN\Aceptar-bn.png"
end type

event pb_acepta::clicked;Integer	li_Grupo
String	ls_Usuario = 'Z'
DateTime	ld_Inicio, ld_Termino

SetPointer(HourGlass!)

IF Not cbx_grupos.checked THEN
	li_Grupo		=	dw_grupos.Object.grpo_codigo[dw_grupos.GetRow()]
END IF

IF Not cbx_usuarios.checked THEN
	ls_Usuario	=	Upper(dw_usuarios.Object.usua_codigo[dw_usuarios.GetRow()])
END IF

ld_Inicio	=	DateTime(Date(em_inicio.Text))
ld_Termino	=	DateTime(Date(em_termino.Text), Time('23:59'))

DELETE	dbo.aplicacceso
	FROM	dbo.aplicacceso ad, dbo.grupousuario us
	WHERE	us.usua_codigo	=	ad.usua_codigo
	AND 	ad.sist_codigo =	us.sist_codigo
	AND	:li_Grupo	IN	(0, us.grpo_codigo)
	AND	:ls_Usuario	IN	('*', Upper(ad.usua_codigo))
	AND	ad.apac_fechaa	BETWEEN :ld_Inicio AND :ld_Termino
	Using SQLca;

MessageBox("Atención","La Depuración se realizó Satisfactoriamente.~r", Exclamation!, Ok!)

SetPointer(Arrow!)
end event

type pb_salir from w_para_informes`pb_salir within w_depura_admaaplicacces
integer x = 2039
integer y = 932
integer taborder = 80
end type

type st_1 from statictext within w_depura_admaaplicacces
integer x = 320
integer y = 540
integer width = 270
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 553648127
string text = "Grupo"
boolean focusrectangle = false
end type

type st_2 from statictext within w_depura_admaaplicacces
integer x = 320
integer y = 736
integer width = 270
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 553648127
string text = "Usuario"
boolean focusrectangle = false
end type

type dw_grupos from datawindow within w_depura_admaaplicacces
integer x = 635
integer y = 528
integer width = 974
integer height = 92
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
string dataobject = "dddw_admagrupos"
boolean border = false
boolean livescroll = true
end type

event itemchanged;Integer li_Grupo

li_Grupo	=	Integer(data)

IF li_Grupo <> 0 Then
//	dw_usuarios.GetChild("usua_codigo", idwc_usuarios)
//	idwc_usuarios.SetTransObject(sqlca)
	idwc_usuarios.Retrieve(li_Grupo, gstr_apl.CodigoSistema)
END IF

end event

type st_3 from statictext within w_depura_admaaplicacces
integer x = 251
integer y = 440
integer width = 1632
integer height = 468
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16711680
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_usuarios from datawindow within w_depura_admaaplicacces
integer x = 635
integer y = 720
integer width = 969
integer height = 96
integer taborder = 40
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "dddw_admausuarios"
boolean border = false
boolean livescroll = true
end type

type st_4 from statictext within w_depura_admaaplicacces
integer x = 251
integer y = 912
integer width = 1632
integer height = 356
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16711680
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cbx_grupos from checkbox within w_depura_admaaplicacces
integer x = 635
integer y = 452
integer width = 265
integer height = 68
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 553648127
string text = "Todos"
boolean checked = true
boolean righttoleft = true
end type

event clicked;IF This.Checked THEN
	cbx_usuarios.Enabled											=	False
	cbx_usuarios.Checked										=	True
	dw_usuarios.Object.usua_codigo.BackGround.Color	=	RGB(213,213,255)
	dw_grupos.Enabled											=	False
	dw_grupos.Object.grpo_codigo.BackGround.Color		=	RGB(213,213,255)
ELSE
	cbx_usuarios.Enabled											=	True
	cbx_usuarios.Checked										=	True
	dw_grupos.Enabled											=	True
	dw_grupos.Object.grpo_codigo.BackGround.Color		=	RGB(255,255,255)
	dw_grupos.GetChild("grpo_codigo", idwc_grupos)
	idwc_grupos.SetTransObject(sqlca)
	
	idwc_grupos.Retrieve(gstr_apl.CodigoSistema)
	
	dw_grupos.SetFocus()
END IF
end event

type cbx_usuarios from checkbox within w_depura_admaaplicacces
integer x = 635
integer y = 652
integer width = 265
integer height = 68
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 553648127
boolean enabled = false
string text = "Todos"
boolean checked = true
boolean lefttext = true
boolean righttoleft = true
end type

event clicked;Integer li_Grupo

IF	This.Checked THEN
	dw_usuarios.Enabled										=	False
	dw_usuarios.Object.usua_codigo.BackGround.Color	=	RGB(166,180,210)
ELSE
	dw_usuarios.Enabled										=	True
	dw_usuarios.Object.usua_codigo.BackGround.Color	=	RGB(255,255,255)
	
	li_Grupo	=	dw_grupos.Object.grpo_codigo[dw_grupos.GetRow()]
	
	dw_usuarios.GetChild("usua_codigo", idwc_usuarios)
	idwc_usuarios.SetTransObject(sqlca)
	
	idwc_usuarios.Retrieve(li_Grupo, gstr_apl.CodigoSistema)
	
	dw_usuarios.SetFocus()
END IF
end event

type st_5 from statictext within w_depura_admaaplicacces
integer x = 302
integer y = 992
integer width = 384
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 553648127
string text = "Fecha Inicio"
boolean focusrectangle = false
end type

type em_inicio from editmask within w_depura_admaaplicacces
integer x = 791
integer y = 976
integer width = 503
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean spin = true
end type

event modified;Date	ld_FechaInicio

IF Date(This.Text) > Date(em_termino.Text) THEN
	MessageBox("Atención","No puede ser Mayor a Fecha de Término~r", Exclamation!, Ok!)
	This.Text	=	String(ld_FechaInicio)
	This.SetFocus()
END IF
end event

type em_termino from editmask within w_depura_admaaplicacces
integer x = 791
integer y = 1104
integer width = 503
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean spin = true
end type

event modified;IF Date(This.Text) < Date(em_inicio.Text) THEN
	MessageBox("Atención","No puede ser Menor a Fecha de Inicio~r", Exclamation!, Ok!)
	This.Text	=	String(Today())
	This.SetFocus()
END IF
end event

type st_6 from statictext within w_depura_admaaplicacces
integer x = 302
integer y = 1120
integer width = 453
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 553648127
string text = "Fecha Término"
boolean focusrectangle = false
end type

