$PBExportHeader$w_info_sistemasgrupos.srw
$PBExportComments$Pantalla de selección múltiple entre sistemas y grupos.
forward
global type w_info_sistemasgrupos from w_para_informes
end type
type cbx_sistemas from checkbox within w_info_sistemasgrupos
end type
type cbx_grupos from checkbox within w_info_sistemasgrupos
end type
type dw_sistemas from datawindow within w_info_sistemasgrupos
end type
type st_1 from statictext within w_info_sistemasgrupos
end type
type st_2 from statictext within w_info_sistemasgrupos
end type
type dw_grupos from datawindow within w_info_sistemasgrupos
end type
type st_3 from statictext within w_info_sistemasgrupos
end type
type st_4 from statictext within w_info_sistemasgrupos
end type
end forward

global type w_info_sistemasgrupos from w_para_informes
integer width = 2373
integer height = 1392
string title = "INFORME SISTEMA / GRUPO"
cbx_sistemas cbx_sistemas
cbx_grupos cbx_grupos
dw_sistemas dw_sistemas
st_1 st_1
st_2 st_2
dw_grupos dw_grupos
st_3 st_3
st_4 st_4
end type
global w_info_sistemasgrupos w_info_sistemasgrupos

type variables
str_mant   istr_mant


DataWindowChild	idwc_sistemas, idwc_grupos



end variables

on w_info_sistemasgrupos.create
int iCurrent
call super::create
this.cbx_sistemas=create cbx_sistemas
this.cbx_grupos=create cbx_grupos
this.dw_sistemas=create dw_sistemas
this.st_1=create st_1
this.st_2=create st_2
this.dw_grupos=create dw_grupos
this.st_3=create st_3
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_sistemas
this.Control[iCurrent+2]=this.cbx_grupos
this.Control[iCurrent+3]=this.dw_sistemas
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.dw_grupos
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_4
end on

on w_info_sistemasgrupos.destroy
call super::destroy
destroy(this.cbx_sistemas)
destroy(this.cbx_grupos)
destroy(this.dw_sistemas)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_grupos)
destroy(this.st_3)
destroy(this.st_4)
end on

event open;call super::open;dw_sistemas.GetChild("sist_codigo", idwc_sistemas)
idwc_sistemas.SetTransObject(sqlca)
idwc_sistemas.Retrieve()
dw_sistemas.InsertRow(0)

dw_grupos.GetChild("grpo_codigo", idwc_grupos)
idwc_grupos.SetTransObject(sqlca)
idwc_grupos.Retrieve(gstr_apl.CodigoSistema)
dw_grupos.InsertRow(0)

istr_mant.argumento[1]	=	'0'
istr_mant.argumento[2]	=	'0'
istr_mant.argumento[3]	=	gstr_apl.NombreSistema
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

IF Not cbx_sistemas.checked	THEN
	istr_mant.argumento[1]	=	String(dw_sistemas.Object.sist_codigo[dw_sistemas.GetRow()])
	istr_mant.argumento[3]	=	dw_sistemas.Object.sist_nombre[dw_sistemas.GetRow()]
ELSE
	istr_mant.argumento[1]	=	""
	istr_mant.argumento[3]	=	""
END IF

IF Not cbx_grupos.checked	THEN
	istr_mant.argumento[2]	=	String(dw_grupos.Object.grpo_codigo[dw_grupos.GetRow()])
ELSE
	istr_mant.argumento[2]	=	""
END IF

fila = vinf.dw_1.Retrieve(istr_mant.argumento[3],Integer(istr_mant.argumento[1]),Integer(istr_mant.argumento[2]))

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

type pb_salir from w_para_informes`pb_salir within w_info_sistemasgrupos
integer x = 1888
end type

type cbx_sistemas from checkbox within w_info_sistemasgrupos
integer x = 663
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

event clicked;IF This.Checked THEN
	dw_sistemas.Enabled	=	False
	dw_sistemas.Reset()
	dw_Sistemas.InsertRow(0)
ELSE
	dw_sistemas.Enabled	=	True
	dw_sistemas.SetFocus()
	idwc_sistemas.Retrieve()
END IF

end event

type cbx_grupos from checkbox within w_info_sistemasgrupos
integer x = 672
integer y = 836
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

event clicked;call super::clicked;Integer li_Sistema

IF	This.Checked	THEN
	dw_grupos.Enabled	=	False
	dw_grupos.Reset()
	dw_grupos.InsertRow(0)
ELSE
	IF cbx_grupos.checked THEN	
		MessageBox("Validación de Selección","Debe elegir un Sistema antes de seleccionar el Grupo")
		cbx_grupos.checked	=	True
	ELSE
		dw_grupos.Enabled	=	True
		li_Sistema	=	dw_sistemas.Object.sist_codigo[dw_sistemas.GetRow()]
		dw_grupos.GetChild("grpo_codigo", idwc_grupos)
		idwc_grupos.SetTransObject(sqlca)
		idwc_grupos.Retrieve(li_Sistema)
	END IF
END IF
end event

type dw_sistemas from datawindow within w_info_sistemasgrupos
integer x = 663
integer y = 588
integer width = 974
integer height = 92
integer taborder = 10
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "dddw_admasistemas"
boolean border = false
boolean livescroll = true
end type

event itemchanged;Integer li_Sistema

li_Sistema	=	Integer(data)

IF li_Sistema <> 0 Then
	dw_grupos.Reset()
	dw_grupos.InsertRow(0)
	dw_grupos.GetChild("usua_codigo", idwc_grupos)
	idwc_grupos.SetTransObject(sqlca)
	idwc_grupos.Retrieve(li_Sistema)
END IF

end event

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

type dw_grupos from datawindow within w_info_sistemasgrupos
integer x = 672
integer y = 936
integer width = 992
integer height = 92
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "dddw_admagrupos"
boolean border = false
boolean livescroll = true
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

