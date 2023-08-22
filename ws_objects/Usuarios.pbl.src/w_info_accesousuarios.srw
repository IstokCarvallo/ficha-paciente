$PBExportHeader$w_info_accesousuarios.srw
$PBExportComments$Pantalla de selección múltiple que muestra el acceso de los usuarios al sistema correspondiente.
forward
global type w_info_accesousuarios from w_para_informes
end type
type cbx_usuarios from checkbox within w_info_accesousuarios
end type
type cbx_grupos from checkbox within w_info_accesousuarios
end type
type st_1 from statictext within w_info_accesousuarios
end type
type st_2 from statictext within w_info_accesousuarios
end type
type dw_grupos from datawindow within w_info_accesousuarios
end type
type st_3 from statictext within w_info_accesousuarios
end type
type dw_usuarios from datawindow within w_info_accesousuarios
end type
type st_4 from statictext within w_info_accesousuarios
end type
end forward

global type w_info_accesousuarios from w_para_informes
integer width = 2304
integer height = 1316
string title = "INFORME DE ACCESO DE USUARIOS"
cbx_usuarios cbx_usuarios
cbx_grupos cbx_grupos
st_1 st_1
st_2 st_2
dw_grupos dw_grupos
st_3 st_3
dw_usuarios dw_usuarios
st_4 st_4
end type
global w_info_accesousuarios w_info_accesousuarios

type variables
str_mant   istr_mant

DataWindowChild	idwc_usuarios, idwc_grupos



end variables

on w_info_accesousuarios.create
int iCurrent
call super::create
this.cbx_usuarios=create cbx_usuarios
this.cbx_grupos=create cbx_grupos
this.st_1=create st_1
this.st_2=create st_2
this.dw_grupos=create dw_grupos
this.st_3=create st_3
this.dw_usuarios=create dw_usuarios
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_usuarios
this.Control[iCurrent+2]=this.cbx_grupos
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.dw_grupos
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.dw_usuarios
this.Control[iCurrent+8]=this.st_4
end on

on w_info_accesousuarios.destroy
call super::destroy
destroy(this.cbx_usuarios)
destroy(this.cbx_grupos)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_grupos)
destroy(this.st_3)
destroy(this.dw_usuarios)
destroy(this.st_4)
end on

event open;call super::open;dw_grupos.GetChild("grpo_codigo", idwc_grupos)
idwc_grupos.SetTransObject(sqlca)
idwc_grupos.Retrieve(gstr_apl.CodigoSistema)
dw_grupos.InsertRow(0)

dw_usuarios.GetChild("usua_codigo", idwc_usuarios)
idwc_usuarios.SetTransObject(sqlca)
idwc_usuarios.Retrieve(0,gstr_apl.CodigoSistema)
dw_usuarios.InsertRow(0)

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

IF Not cbx_grupos.checked	THEN
	li_Grupo	=	dw_grupos.Object.grpo_codigo[dw_grupos.GetRow()]
ELSE
	li_Grupo	=	0
END IF

IF Not cbx_usuarios.checked	THEN
	ls_Usuario	=	dw_usuarios.Object.usua_codigo[dw_usuarios.GetRow()]
ELSE
   ls_Usuario	=	'*'
END IF

fila = vinf.dw_1.Retrieve(gstr_apl.CodigoSistema,gstr_apl.NombreSistema,li_Grupo,ls_Usuario)

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

type pb_salir from w_para_informes`pb_salir within w_info_accesousuarios
integer x = 1957
integer y = 868
end type

type cbx_usuarios from checkbox within w_info_accesousuarios
integer x = 681
integer y = 872
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

event clicked;call super::clicked;Integer li_Grupo

IF	This.Checked	THEN
	dw_usuarios.Enabled	=	False
	dw_usuarios.Reset()
	dw_usuarios.InsertRow(0)
ELSE
	IF cbx_grupos.checked THEN	
		MessageBox("Validación de Selección","Debe elegir un Grupo antes de seleccionar el Usuario")
		cbx_usuarios.checked	=	True
	ELSE
		dw_usuarios.Enabled	=	True
		li_Grupo	=	dw_grupos.Object.grpo_codigo[dw_grupos.GetRow()]
		dw_usuarios.GetChild("usua_codigo", idwc_usuarios)
		idwc_usuarios.SetTransObject(sqlca)
		idwc_usuarios.Retrieve(li_Grupo,gstr_apl.CodigoSistema)
	END IF
END IF
end event

type cbx_grupos from checkbox within w_info_accesousuarios
integer x = 672
integer y = 512
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

type dw_grupos from datawindow within w_info_accesousuarios
integer x = 672
integer y = 612
integer width = 969
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
	dw_usuarios.Reset()
	dw_usuarios.InsertRow(0)
	dw_usuarios.GetChild("usua_codigo", idwc_usuarios)
	idwc_usuarios.SetTransObject(sqlca)
	idwc_usuarios.Retrieve(li_Grupo,gstr_apl.CodigoSistema)
END IF

end event

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

type dw_usuarios from datawindow within w_info_accesousuarios
integer x = 681
integer y = 992
integer width = 969
integer height = 96
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "dddw_admausuarios"
boolean border = false
boolean livescroll = true
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

