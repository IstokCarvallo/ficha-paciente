$PBExportHeader$w_info_sistemasgrupos.srw
$PBExportComments$Pantalla de selección múltiple entre sistemas y grupos.
forward
global type w_info_sistemasgrupos from w_para_informes
end type
type st_1 from statictext within w_info_sistemasgrupos
end type
type st_2 from statictext within w_info_sistemasgrupos
end type
type st_3 from statictext within w_info_sistemasgrupos
end type
type st_4 from statictext within w_info_sistemasgrupos
end type
type uo_selgrupo from uo_seleccion_gruposistemas within w_info_sistemasgrupos
end type
type uo_selsistemas from uo_seleccion_sistemas within w_info_sistemasgrupos
end type
end forward

global type w_info_sistemasgrupos from w_para_informes
integer width = 2373
integer height = 1392
string title = "INFORME SISTEMA / GRUPO"
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
uo_selgrupo uo_selgrupo
uo_selsistemas uo_selsistemas
end type
global w_info_sistemasgrupos w_info_sistemasgrupos

type variables
str_mant   istr_mant


DataWindowChild	idwc_sistemas, idwc_grupos



end variables

on w_info_sistemasgrupos.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.uo_selgrupo=create uo_selgrupo
this.uo_selsistemas=create uo_selsistemas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.uo_selgrupo
this.Control[iCurrent+6]=this.uo_selsistemas
end on

on w_info_sistemasgrupos.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.uo_selgrupo)
destroy(this.uo_selsistemas)
end on

event open;call super::open;Boolean	lb_Cerrar = False

If IsNull(uo_SelSistemas.Codigo) Then lb_Cerrar = True
If IsNull(uo_SelGrupo.Codigo) Then lb_Cerrar = True

If lb_Cerrar Then
	Close(This)
Else	
	uo_SelSistemas.of_Seleccion(True, False)
	uo_SelGrupo.of_Seleccion(True, False)
	
	uo_SelGrupo.of_Filtra(gstr_apl.CodigoSistema)
End If
end event

type pb_excel from w_para_informes`pb_excel within w_info_sistemasgrupos
end type

type st_computador from w_para_informes`st_computador within w_info_sistemasgrupos
end type

type st_usuario from w_para_informes`st_usuario within w_info_sistemasgrupos
end type

type st_temporada from w_para_informes`st_temporada within w_info_sistemasgrupos
end type

type p_logo from w_para_informes`p_logo within w_info_sistemasgrupos
end type

type st_titulo from w_para_informes`st_titulo within w_info_sistemasgrupos
integer width = 1463
string text = "Informe Sistemas / Grupos"
end type

type pb_acepta from w_para_informes`pb_acepta within w_info_sistemasgrupos
integer x = 1888
integer y = 532
end type

event pb_acepta::clicked;Long		fila
Integer	li_Seleccion

istr_info.titulo	= "INFORME SISTEMAS / GRUPOS"
istr_info.copias	= 1

OpenWithParm(vinf, istr_info)
vinf.dw_1.DataObject = "dw_info_admasistemasgrupos"
vinf.dw_1.SetTransObject(sqlca)


fila = vinf.dw_1.Retrieve(uo_SelSistemas.Nombre,uo_SelSistemas.Codigo, uo_SelGrupo.Codigo)

IF fila = -1 THEN
	MessageBox( "Error en Base de Datos", "Se ha producido un error en Base de datos : ~n" + sqlca.SQLErrText, StopSign!, Ok!)
ELSEIF fila = 0 THEN
	MessageBox( "No Existe información", "No existe información para este informe.", StopSign!, Ok!)
ELSE
	F_Membrete(vinf.dw_1)
END IF
end event

type pb_salir from w_para_informes`pb_salir within w_info_sistemasgrupos
integer x = 1888
end type

type st_1 from statictext within w_info_sistemasgrupos
integer x = 293
integer y = 592
integer width = 338
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
string text = "Sistema"
boolean focusrectangle = false
end type

type st_2 from statictext within w_info_sistemasgrupos
integer x = 311
integer y = 948
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

type st_3 from statictext within w_info_sistemasgrupos
integer x = 251
integer y = 440
integer width = 1463
integer height = 332
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

type st_4 from statictext within w_info_sistemasgrupos
integer x = 251
integer y = 772
integer width = 1463
integer height = 332
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

type uo_selgrupo from uo_seleccion_gruposistemas within w_info_sistemasgrupos
event destroy ( )
integer x = 590
integer y = 844
integer taborder = 100
boolean bringtotop = true
end type

on uo_selgrupo.destroy
call uo_seleccion_gruposistemas::destroy
end on

type uo_selsistemas from uo_seleccion_sistemas within w_info_sistemasgrupos
event destroy ( )
integer x = 599
integer y = 484
integer taborder = 20
boolean bringtotop = true
end type

on uo_selsistemas.destroy
call uo_seleccion_sistemas::destroy
end on

