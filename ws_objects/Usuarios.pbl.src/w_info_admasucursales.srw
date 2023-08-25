$PBExportHeader$w_info_admasucursales.srw
$PBExportComments$Informe de Sucursales y Unidades Administrativas.
forward
global type w_info_admasucursales from w_para_informes
end type
type st_2 from statictext within w_info_admasucursales
end type
type st_3 from statictext within w_info_admasucursales
end type
type uo_selgrupo from uo_seleccion_gruposistemas within w_info_admasucursales
end type
type cbx_solosuc from checkbox within w_info_admasucursales
end type
end forward

global type w_info_admasucursales from w_para_informes
integer width = 2345
integer height = 1356
st_2 st_2
st_3 st_3
uo_selgrupo uo_selgrupo
cbx_solosuc cbx_solosuc
end type
global w_info_admasucursales w_info_admasucursales

type variables
DataWindowChild		idwc_Sucursal

uo_Sucursal		iuo_Sucursal
end variables

on w_info_admasucursales.create
int iCurrent
call super::create
this.st_2=create st_2
this.st_3=create st_3
this.uo_selgrupo=create uo_selgrupo
this.cbx_solosuc=create cbx_solosuc
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.uo_selgrupo
this.Control[iCurrent+4]=this.cbx_solosuc
end on

on w_info_admasucursales.destroy
call super::destroy
destroy(this.st_2)
destroy(this.st_3)
destroy(this.uo_selgrupo)
destroy(this.cbx_solosuc)
end on

event open;call super::open;Boolean	lb_Cerrar = False

If IsNull(uo_SelGrupo.Codigo) Then lb_Cerrar = True

If lb_Cerrar Then
	Close(This)
Else	
	uo_SelGrupo.of_Seleccion(True, False)
	
	uo_SelGrupo.of_Filtra(gstr_apl.CodigoSistema)
End If
end event

type pb_excel from w_para_informes`pb_excel within w_info_admasucursales
integer x = 1957
integer y = 944
end type

type st_computador from w_para_informes`st_computador within w_info_admasucursales
end type

type st_usuario from w_para_informes`st_usuario within w_info_admasucursales
end type

type st_temporada from w_para_informes`st_temporada within w_info_admasucursales
end type

type p_logo from w_para_informes`p_logo within w_info_admasucursales
end type

type st_titulo from w_para_informes`st_titulo within w_info_admasucursales
integer width = 1499
string text = "Informe Sucursales y Unidades Administrativas"
end type

type pb_acepta from w_para_informes`pb_acepta within w_info_admasucursales
integer x = 1970
integer y = 384
end type

event pb_acepta::clicked;Long		ll_Fila
Integer	li_Seleccion, li_Sucursal, li_UnidAdmini

istr_info.titulo	= "INFORME SUCURSALES Y UNIDADES ADMINISTRATIVAS"
istr_info.copias	= 1

OpenWithParm(vinf, istr_info)
vinf.dw_1.DataObject = "dw_info_admaunidadadmini"
vinf.dw_1.SetTransObject(sqlca)

IF Not cbx_solosuc.Checked THEN li_UnidAdmini	=	1

ll_Fila = vinf.dw_1.Retrieve(uo_SelGrupo.Codigo, li_UnidAdmini)

IF ll_Fila = -1 THEN
	MessageBox( "Error en Base de Datos", "Se ha producido un error en Base de datos : ~n" + sqlca.SQLErrText, StopSign!, Ok!)
ELSEIF ll_Fila = 0 THEN
	MessageBox( "No Existe información", "No existe información para este informe.", StopSign!, Ok!)
ELSE
	F_Membrete(vinf.dw_1)
END IF
end event

type pb_salir from w_para_informes`pb_salir within w_info_admasucursales
integer x = 1966
integer y = 668
end type

type st_2 from statictext within w_info_admasucursales
integer x = 347
integer y = 612
integer width = 283
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
string text = "Grupos"
boolean focusrectangle = false
end type

type st_3 from statictext within w_info_admasucursales
integer x = 251
integer y = 440
integer width = 1499
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

type uo_selgrupo from uo_seleccion_gruposistemas within w_info_admasucursales
event destroy ( )
integer x = 645
integer y = 520
integer height = 180
integer taborder = 100
boolean bringtotop = true
end type

on uo_selgrupo.destroy
call uo_seleccion_gruposistemas::destroy
end on

type cbx_solosuc from checkbox within w_info_admasucursales
integer x = 997
integer y = 524
integer width = 549
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
string text = "Sólo Sucursales"
end type

