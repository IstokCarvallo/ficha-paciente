$PBExportHeader$w_depura_admaaplicacces.srw
$PBExportComments$Pantalla de selección múltiple que muestra el acceso de los usuarios al sistema correspondiente.
forward
global type w_depura_admaaplicacces from w_para_informes
end type
type st_1 from statictext within w_depura_admaaplicacces
end type
type st_2 from statictext within w_depura_admaaplicacces
end type
type st_3 from statictext within w_depura_admaaplicacces
end type
type st_4 from statictext within w_depura_admaaplicacces
end type
type st_5 from statictext within w_depura_admaaplicacces
end type
type em_inicio from editmask within w_depura_admaaplicacces
end type
type em_termino from editmask within w_depura_admaaplicacces
end type
type st_6 from statictext within w_depura_admaaplicacces
end type
type uo_selusuarios from uo_seleccion_usuarios within w_depura_admaaplicacces
end type
type uo_selgrupo from uo_seleccion_gruposistemas within w_depura_admaaplicacces
end type
end forward

global type w_depura_admaaplicacces from w_para_informes
integer width = 2437
integer height = 1504
string title = "CONTROL ACCESOS"
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
em_inicio em_inicio
em_termino em_termino
st_6 st_6
uo_selusuarios uo_selusuarios
uo_selgrupo uo_selgrupo
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
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.em_inicio=create em_inicio
this.em_termino=create em_termino
this.st_6=create st_6
this.uo_selusuarios=create uo_selusuarios
this.uo_selgrupo=create uo_selgrupo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.st_5
this.Control[iCurrent+6]=this.em_inicio
this.Control[iCurrent+7]=this.em_termino
this.Control[iCurrent+8]=this.st_6
this.Control[iCurrent+9]=this.uo_selusuarios
this.Control[iCurrent+10]=this.uo_selgrupo
end on

on w_depura_admaaplicacces.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.em_inicio)
destroy(this.em_termino)
destroy(this.st_6)
destroy(this.uo_selusuarios)
destroy(this.uo_selgrupo)
end on

event open;call super::open;Boolean	lb_Cerrar = False
Date		ld_FechaInicio	

If IsNull(uo_SelUsuarios.Codigo) Then lb_Cerrar = True
If IsNull(uo_SelGrupo.Codigo) Then lb_Cerrar = True

If lb_Cerrar Then
	Close(This)
Else	
	uo_SelUsuarios.of_Seleccion(True, False)
	uo_SelGrupo.of_Seleccion(True, False)
	
	uo_SelGrupo.of_Filtra(gstr_apl.CodigoSistema)
		
	em_inicio.Text		=	String(ld_FechaInicio)
	em_termino.Text	=	String(Today())
End If
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

event pb_acepta::clicked;DateTime	ld_Inicio, ld_Termino

SetPointer(HourGlass!)

ld_Inicio	=	DateTime(Date(em_inicio.Text))
ld_Termino	=	DateTime(Date(em_termino.Text), Time('23:59'))

DELETE	dbo.aplicacceso
	FROM	dbo.aplicacceso ad, dbo.grupousuario us
	WHERE	us.usua_codigo	=	ad.usua_codigo
	AND 	ad.sist_codigo =	us.sist_codigo
	AND	:uo_SelGrupo.Codigo	IN	(-1, us.grpo_codigo)
	AND	:uo_SelUsuarios.Codigo	IN	('*', Upper(ad.usua_codigo))
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
integer y = 548
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
integer x = 311
integer y = 780
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

type uo_selusuarios from uo_seleccion_usuarios within w_depura_admaaplicacces
integer x = 635
integer y = 672
integer taborder = 50
boolean bringtotop = true
end type

on uo_selusuarios.destroy
call uo_seleccion_usuarios::destroy
end on

type uo_selgrupo from uo_seleccion_gruposistemas within w_depura_admaaplicacces
integer x = 635
integer y = 456
integer taborder = 80
boolean bringtotop = true
end type

on uo_selgrupo.destroy
call uo_seleccion_gruposistemas::destroy
end on

