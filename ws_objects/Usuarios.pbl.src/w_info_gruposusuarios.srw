$PBExportHeader$w_info_gruposusuarios.srw
$PBExportComments$Pantalla de selección múltiple entre sistemas y grupos.
forward
global type w_info_gruposusuarios from w_para_informes
end type
type cbx_grupos from checkbox within w_info_gruposusuarios
end type
type st_2 from statictext within w_info_gruposusuarios
end type
type dw_grupos from datawindow within w_info_gruposusuarios
end type
type st_3 from statictext within w_info_gruposusuarios
end type
end forward

global type w_info_gruposusuarios from w_para_informes
integer width = 2249
integer height = 1356
string title = "INFORME GRUPOS / USUARIOS"
cbx_grupos cbx_grupos
st_2 st_2
dw_grupos dw_grupos
st_3 st_3
end type
global w_info_gruposusuarios w_info_gruposusuarios

type variables
str_mant   istr_mant


DataWindowChild	 idwc_grupos



end variables

on w_info_gruposusuarios.create
int iCurrent
call super::create
this.cbx_grupos=create cbx_grupos
this.st_2=create st_2
this.dw_grupos=create dw_grupos
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_grupos
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.dw_grupos
this.Control[iCurrent+4]=this.st_3
end on

on w_info_gruposusuarios.destroy
call super::destroy
destroy(this.cbx_grupos)
destroy(this.st_2)
destroy(this.dw_grupos)
destroy(this.st_3)
end on

event open;call super::open;dw_grupos.GetChild("grpo_codigo", idwc_grupos)
idwc_grupos.SetTransObject(sqlca)
idwc_grupos.Retrieve(gstr_apl.CodigoSistema)
dw_grupos.InsertRow(0)

istr_mant.argumento[1]	=	'0'
istr_mant.argumento[2]	=	'0'
istr_mant.argumento[3]	=	gstr_apl.NombreSistema
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

IF Not cbx_grupos.checked	THEN
	istr_mant.argumento[1]	=	String(dw_grupos.Object.grpo_codigo[dw_grupos.GetRow()])
END IF

fila = vinf.dw_1.Retrieve(gstr_apl.Nombresistema, gstr_apl.CodigoSistema,Integer(istr_mant.argumento[1]))

IF fila = -1 THEN
	MessageBox( "Error en Base de Datos", "Se ha producido un error en Base " + &
					"de datos : ~n" + sqlca.SQLErrText, StopSign!, Ok!)
ELSEIF fila = 0 THEN
	MessageBox( "No Existe información", "No existe información para este informe.", &
					StopSign!, Ok!)
ELSE
	F_Membrete(vinf.dw_1)
	If gs_Ambiente = 'Windows' Then
		vinf.dw_1.Modify('DataWindow.Print.Preview = Yes')
		vinf.dw_1.Modify('DataWindow.Print.Preview.Zoom = 75')
	
		vinf.Visible	= True
		vinf.Enabled	= True
	End If
END IF
end event

type pb_salir from w_para_informes`pb_salir within w_info_gruposusuarios
integer x = 1897
integer y = 736
end type

type cbx_grupos from checkbox within w_info_gruposusuarios
integer x = 658
integer y = 488
integer width = 265
integer height = 68
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

event clicked;IF This.Checked	THEN
	dw_grupos.Enabled	=	False
	dw_grupos.Reset()
	dw_grupos.InsertRow(0)
ELSE
	dw_grupos.Enabled	=	True		
	dw_grupos.GetChild("grpo_codigo", idwc_grupos)
	idwc_grupos.SetTransObject(sqlca)
	idwc_grupos.Retrieve(gstr_apl.CodigoSistema)
END IF
end event

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

type dw_grupos from datawindow within w_info_gruposusuarios
integer x = 649
integer y = 608
integer width = 974
integer height = 92
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "dddw_admagrupos"
boolean border = false
boolean livescroll = true
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

