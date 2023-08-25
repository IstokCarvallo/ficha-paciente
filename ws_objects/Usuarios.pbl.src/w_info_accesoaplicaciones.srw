$PBExportHeader$w_info_accesoaplicaciones.srw
$PBExportComments$Informe de acceso a aplicaiones, con seleccion.
forward
global type w_info_accesoaplicaciones from w_para_informes
end type
type st_1 from statictext within w_info_accesoaplicaciones
end type
type st_4 from statictext within w_info_accesoaplicaciones
end type
type st_5 from statictext within w_info_accesoaplicaciones
end type
type em_fecha from editmask within w_info_accesoaplicaciones
end type
type cbx_fecha from checkbox within w_info_accesoaplicaciones
end type
type st_2 from statictext within w_info_accesoaplicaciones
end type
type uo_selgrupo from uo_seleccion_gruposistemas within w_info_accesoaplicaciones
end type
type uo_selusuarios from uo_seleccion_usuarios within w_info_accesoaplicaciones
end type
type st_3 from statictext within w_info_accesoaplicaciones
end type
end forward

global type w_info_accesoaplicaciones from w_para_informes
integer width = 2473
integer height = 1364
string title = "INFORME DE ACCESO A MODULOS"
st_1 st_1
st_4 st_4
st_5 st_5
em_fecha em_fecha
cbx_fecha cbx_fecha
st_2 st_2
uo_selgrupo uo_selgrupo
uo_selusuarios uo_selusuarios
st_3 st_3
end type
global w_info_accesoaplicaciones w_info_accesoaplicaciones

type variables
DatawindowChild	idwc_grupos, idwc_usuarios


str_mant		istr_mant
end variables

on w_info_accesoaplicaciones.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_4=create st_4
this.st_5=create st_5
this.em_fecha=create em_fecha
this.cbx_fecha=create cbx_fecha
this.st_2=create st_2
this.uo_selgrupo=create uo_selgrupo
this.uo_selusuarios=create uo_selusuarios
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.st_5
this.Control[iCurrent+4]=this.em_fecha
this.Control[iCurrent+5]=this.cbx_fecha
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.uo_selgrupo
this.Control[iCurrent+8]=this.uo_selusuarios
this.Control[iCurrent+9]=this.st_3
end on

on w_info_accesoaplicaciones.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.em_fecha)
destroy(this.cbx_fecha)
destroy(this.st_2)
destroy(this.uo_selgrupo)
destroy(this.uo_selusuarios)
destroy(this.st_3)
end on

event open;call super::open;Boolean	lb_Cerrar = False

If IsNull(uo_SelUsuarios.Codigo) Then lb_Cerrar = True
If IsNull(uo_SelGrupo.Codigo) Then lb_Cerrar = True

If lb_Cerrar Then
	Close(This)
Else	
	uo_SelUsuarios.of_Seleccion(True, False)
	uo_SelGrupo.of_Seleccion(True, False)
	
	uo_SelGrupo.of_Filtra(gstr_apl.CodigoSistema)
End If
end event

type pb_excel from w_para_informes`pb_excel within w_info_accesoaplicaciones
integer x = 2126
integer y = 292
end type

type st_computador from w_para_informes`st_computador within w_info_accesoaplicaciones
end type

type st_usuario from w_para_informes`st_usuario within w_info_accesoaplicaciones
end type

type st_temporada from w_para_informes`st_temporada within w_info_accesoaplicaciones
end type

type p_logo from w_para_informes`p_logo within w_info_accesoaplicaciones
end type

type st_titulo from w_para_informes`st_titulo within w_info_accesoaplicaciones
integer width = 1618
string text = "Informe de Acceso a Aplicaciones"
end type

type pb_acepta from w_para_informes`pb_acepta within w_info_accesoaplicaciones
integer x = 1938
integer y = 548
end type

event pb_acepta::clicked;Long		fila
Integer	li_grupo
String		ls_usuarios, ls_Fecha
Date		ld_fecha		

istr_info.titulo	= "INFORME DE ACCESO A APLICACIONES"
istr_info.copias	= 1

OpenWithParm(vinf, istr_info)

IF uo_SelUsuarios.Codigo = '*'THEN	
	vinf.dw_1.DataObject = "dw_info_admaaplicacces_general"
ELSE
	vinf.dw_1.DataObject = "dw_info_admaaplicacces_usuarios"
END IF

IF cbx_fecha.checked	THEN
	ld_Fecha	=	Date('01/01/1900')
ELSE
	ls_Fecha	=	em_fecha.Text
	ld_Fecha	=	Date(ls_Fecha)
END IF

vinf.dw_1.SetTransObject(sqlca)

fila = vinf.dw_1.Retrieve(gstr_apl.NombreSistema, uo_SelUsuarios.Codigo, uo_SelGrupo.Codigo, ld_Fecha, gstr_apl.CodigoSistema)

IF fila = -1 THEN
	MessageBox( "Error en Base de Datos", "Se ha producido un error en Base de datos : ~n" + sqlca.SQLErrText, StopSign!, Ok!)
ELSEIF fila = 0 THEN
	MessageBox( "No Existe información", "No existe información para este informe.", StopSign!, Ok!)
ELSE
	F_Membrete(vinf.dw_1)
END IF
end event

type pb_salir from w_para_informes`pb_salir within w_info_accesoaplicaciones
integer x = 1938
integer y = 852
end type

type st_1 from statictext within w_info_accesoaplicaciones
integer x = 251
integer y = 680
integer width = 1618
integer height = 508
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16711680
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_4 from statictext within w_info_accesoaplicaciones
integer x = 251
integer y = 440
integer width = 1618
integer height = 236
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16711680
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_5 from statictext within w_info_accesoaplicaciones
integer x = 329
integer y = 528
integer width = 434
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
string text = "Fecha Entrada"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fecha from editmask within w_info_accesoaplicaciones
integer x = 800
integer y = 516
integer width = 462
integer height = 88
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
alignment alignment = center!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy "
end type

type cbx_fecha from checkbox within w_info_accesoaplicaciones
integer x = 1440
integer y = 520
integer width = 256
integer height = 80
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
end type

event clicked;IF This.Checked THEN
	em_fecha.DisplayOnly	=	True
	em_fecha.Text			=	""
ELSE
	em_fecha.DisplayOnly	=	False
	em_fecha.Text			=	String(Today(),"dd/mm/yyyy")
END IF
end event

type st_2 from statictext within w_info_accesoaplicaciones
integer x = 485
integer y = 816
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

type uo_selgrupo from uo_seleccion_gruposistemas within w_info_accesoaplicaciones
event destroy ( )
integer x = 800
integer y = 724
integer taborder = 90
boolean bringtotop = true
end type

on uo_selgrupo.destroy
call uo_seleccion_gruposistemas::destroy
end on

type uo_selusuarios from uo_seleccion_usuarios within w_info_accesoaplicaciones
event destroy ( )
integer x = 800
integer y = 940
integer taborder = 60
boolean bringtotop = true
end type

on uo_selusuarios.destroy
call uo_seleccion_usuarios::destroy
end on

type st_3 from statictext within w_info_accesoaplicaciones
integer x = 475
integer y = 1048
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

