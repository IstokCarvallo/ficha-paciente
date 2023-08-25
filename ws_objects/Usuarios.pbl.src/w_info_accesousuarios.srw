$PBExportHeader$w_info_accesousuarios.srw
$PBExportComments$Pantalla de selección múltiple que muestra el acceso de los usuarios al sistema correspondiente.
forward
global type w_info_accesousuarios from w_para_informes
end type
type st_1 from statictext within w_info_accesousuarios
end type
type st_2 from statictext within w_info_accesousuarios
end type
type st_3 from statictext within w_info_accesousuarios
end type
type st_4 from statictext within w_info_accesousuarios
end type
type uo_selgrupo from uo_seleccion_gruposistemas within w_info_accesousuarios
end type
type uo_selusuarios from uo_seleccion_usuarios within w_info_accesousuarios
end type
end forward

global type w_info_accesousuarios from w_para_informes
integer width = 2304
integer height = 1316
string title = "INFORME DE ACCESO DE USUARIOS"
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
uo_selgrupo uo_selgrupo
uo_selusuarios uo_selusuarios
end type
global w_info_accesousuarios w_info_accesousuarios

type variables
str_mant   istr_mant

DataWindowChild	idwc_usuarios, idwc_grupos



end variables

on w_info_accesousuarios.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.uo_selgrupo=create uo_selgrupo
this.uo_selusuarios=create uo_selusuarios
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.uo_selgrupo
this.Control[iCurrent+6]=this.uo_selusuarios
end on

on w_info_accesousuarios.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.uo_selgrupo)
destroy(this.uo_selusuarios)
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

type pb_excel from w_para_informes`pb_excel within w_info_accesousuarios
end type

type st_computador from w_para_informes`st_computador within w_info_accesousuarios
end type

type st_usuario from w_para_informes`st_usuario within w_info_accesousuarios
end type

type st_temporada from w_para_informes`st_temporada within w_info_accesousuarios
end type

type p_logo from w_para_informes`p_logo within w_info_accesousuarios
end type

type st_titulo from w_para_informes`st_titulo within w_info_accesousuarios
integer x = 265
integer y = 272
integer width = 1499
string text = "Informe Acceso de Usuarios"
end type

type pb_acepta from w_para_informes`pb_acepta within w_info_accesousuarios
integer x = 1947
integer y = 504
end type

event pb_acepta::clicked;Long		fila
Integer	li_Seleccion, li_Grupo
String	ls_Usuario

istr_info.titulo	= "INFORME ACCESO DE USUARIOS"
istr_info.copias	= 1

OpenWithParm(vinf, istr_info)
vinf.dw_1.DataObject	=	"dw_info_admausuaropcio"
vinf.dw_1.SetTransObject(sqlca)

fila = vinf.dw_1.Retrieve(gstr_apl.CodigoSistema,gstr_apl.NombreSistema,uo_SelGrupo.Codigo, uo_SelUsuarios.Codigo)

IF fila = -1 THEN
	MessageBox( "Error en Base de Datos", "Se ha producido un error en Base de datos : ~n" + sqlca.SQLErrText, StopSign!, Ok!)
ELSEIF fila = 0 THEN
	MessageBox( "No Existe información", "No existe información para este informe.", StopSign!, Ok!)
ELSE
	F_Membrete(vinf.dw_1)
END IF
end event

type pb_salir from w_para_informes`pb_salir within w_info_accesousuarios
integer x = 1957
integer y = 868
end type

type st_1 from statictext within w_info_accesousuarios
integer x = 311
integer y = 616
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
string text = "Grupo"
boolean focusrectangle = false
end type

type st_2 from statictext within w_info_accesousuarios
integer x = 338
integer y = 996
integer width = 288
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

type st_3 from statictext within w_info_accesousuarios
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
long textcolor = 16777215
long backcolor = 16711680
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_4 from statictext within w_info_accesousuarios
integer x = 251
integer y = 796
integer width = 1499
integer height = 356
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 16711680
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_selgrupo from uo_seleccion_gruposistemas within w_info_accesousuarios
event destroy ( )
integer x = 585
integer y = 532
integer taborder = 100
boolean bringtotop = true
end type

on uo_selgrupo.destroy
call uo_seleccion_gruposistemas::destroy
end on

type uo_selusuarios from uo_seleccion_usuarios within w_info_accesousuarios
event destroy ( )
integer x = 626
integer y = 880
integer taborder = 70
boolean bringtotop = true
end type

on uo_selusuarios.destroy
call uo_seleccion_usuarios::destroy
end on

