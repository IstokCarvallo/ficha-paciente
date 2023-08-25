$PBExportHeader$w_info_gruposusuarios.srw
$PBExportComments$Pantalla de selección múltiple entre sistemas y grupos.
forward
global type w_info_gruposusuarios from w_para_informes
end type
type st_2 from statictext within w_info_gruposusuarios
end type
type st_3 from statictext within w_info_gruposusuarios
end type
type uo_selgrupo from uo_seleccion_gruposistemas within w_info_gruposusuarios
end type
end forward

global type w_info_gruposusuarios from w_para_informes
integer width = 2249
integer height = 1356
string title = "INFORME GRUPOS / USUARIOS"
st_2 st_2
st_3 st_3
uo_selgrupo uo_selgrupo
end type
global w_info_gruposusuarios w_info_gruposusuarios

type variables
str_mant   istr_mant


DataWindowChild	 idwc_grupos



end variables

on w_info_gruposusuarios.create
int iCurrent
call super::create
this.st_2=create st_2
this.st_3=create st_3
this.uo_selgrupo=create uo_selgrupo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.uo_selgrupo
end on

on w_info_gruposusuarios.destroy
call super::destroy
destroy(this.st_2)
destroy(this.st_3)
destroy(this.uo_selgrupo)
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

type pb_excel from w_para_informes`pb_excel within w_info_gruposusuarios
end type

type st_computador from w_para_informes`st_computador within w_info_gruposusuarios
end type

type st_usuario from w_para_informes`st_usuario within w_info_gruposusuarios
end type

type st_temporada from w_para_informes`st_temporada within w_info_gruposusuarios
end type

type p_logo from w_para_informes`p_logo within w_info_gruposusuarios
end type

type st_titulo from w_para_informes`st_titulo within w_info_gruposusuarios
integer width = 1499
string text = "Informe Grupos / Usuarios"
end type

type pb_acepta from w_para_informes`pb_acepta within w_info_gruposusuarios
integer x = 1897
integer y = 456
end type

event pb_acepta::clicked;Long		fila
Integer	li_Seleccion

istr_info.titulo	= "INFORME GRUPOS / USUARIOS"
istr_info.copias	= 1

OpenWithParm(vinf, istr_info)
vinf.dw_1.DataObject = "dw_info_admagruposusuarios"
vinf.dw_1.SetTransObject(sqlca)


fila = vinf.dw_1.Retrieve(gstr_apl.Nombresistema, gstr_apl.CodigoSistema, uo_SelGrupo.Codigo)

IF fila = -1 THEN
	MessageBox( "Error en Base de Datos", "Se ha producido un error en Base de datos : ~n" + sqlca.SQLErrText, StopSign!, Ok!)
ELSEIF fila = 0 THEN
	MessageBox( "No Existe información", "No existe información para este informe.", StopSign!, Ok!)
ELSE
	F_Membrete(vinf.dw_1)
END IF
end event

type pb_salir from w_para_informes`pb_salir within w_info_gruposusuarios
integer x = 1897
integer y = 736
end type

type st_2 from statictext within w_info_gruposusuarios
integer x = 311
integer y = 616
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

type st_3 from statictext within w_info_gruposusuarios
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

type uo_selgrupo from uo_seleccion_gruposistemas within w_info_gruposusuarios
event destroy ( )
integer x = 603
integer y = 508
integer taborder = 100
boolean bringtotop = true
end type

on uo_selgrupo.destroy
call uo_seleccion_gruposistemas::destroy
end on

