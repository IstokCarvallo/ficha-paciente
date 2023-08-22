$PBExportHeader$w_info_accesoaplicaciones.srw
$PBExportComments$Informe de acceso a aplicaiones, con seleccion.
forward
global type w_info_accesoaplicaciones from w_para_informes
end type
type st_1 from statictext within w_info_accesoaplicaciones
end type
type st_2 from statictext within w_info_accesoaplicaciones
end type
type dw_usuarios from datawindow within w_info_accesoaplicaciones
end type
type cbx_usuarios from checkbox within w_info_accesoaplicaciones
end type
type st_3 from statictext within w_info_accesoaplicaciones
end type
type dw_grupos from datawindow within w_info_accesoaplicaciones
end type
type cbx_grupos from checkbox within w_info_accesoaplicaciones
end type
type st_4 from statictext within w_info_accesoaplicaciones
end type
type st_5 from statictext within w_info_accesoaplicaciones
end type
type em_fecha from editmask within w_info_accesoaplicaciones
end type
type cbx_fecha from checkbox within w_info_accesoaplicaciones
end type
end forward

global type w_info_accesoaplicaciones from w_para_informes
integer width = 3058
integer height = 1364
string title = "INFORME DE ACCESO A MODULOS"
st_1 st_1
st_2 st_2
dw_usuarios dw_usuarios
cbx_usuarios cbx_usuarios
st_3 st_3
dw_grupos dw_grupos
cbx_grupos cbx_grupos
st_4 st_4
st_5 st_5
em_fecha em_fecha
cbx_fecha cbx_fecha
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
this.st_2=create st_2
this.dw_usuarios=create dw_usuarios
this.cbx_usuarios=create cbx_usuarios
this.st_3=create st_3
this.dw_grupos=create dw_grupos
this.cbx_grupos=create cbx_grupos
this.st_4=create st_4
this.st_5=create st_5
this.em_fecha=create em_fecha
this.cbx_fecha=create cbx_fecha
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.dw_usuarios
this.Control[iCurrent+4]=this.cbx_usuarios
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.dw_grupos
this.Control[iCurrent+7]=this.cbx_grupos
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.st_5
this.Control[iCurrent+10]=this.em_fecha
this.Control[iCurrent+11]=this.cbx_fecha
end on

on w_info_accesoaplicaciones.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_usuarios)
destroy(this.cbx_usuarios)
destroy(this.st_3)
destroy(this.dw_grupos)
destroy(this.cbx_grupos)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.em_fecha)
destroy(this.cbx_fecha)
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

type pb_excel from w_para_informes`pb_excel within w_info_accesoaplicaciones
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
string text = "Informe de Acceso a Aplicaciones"
end type

type pb_acepta from w_para_informes`pb_acepta within w_info_accesoaplicaciones
integer x = 2478
integer y = 540
end type

event pb_acepta::clicked;Long		fila
Integer	li_grupo
String		ls_usuarios, ls_Fecha
Date		ld_fecha		

istr_info.titulo	= "INFORME DE ACCESO A APLICACIONES"
istr_info.copias	= 1

OpenWithParm(vinf, istr_info)

IF cbx_usuarios.checked	THEN	
	ls_Usuarios				=	"*"
	vinf.dw_1.DataObject = "dw_info_admaaplicacces_general"
ELSE
	vinf.dw_1.DataObject = "dw_info_admaaplicacces_usuarios"
	ls_Usuarios				=	dw_usuarios.Object.usua_codigo[dw_usuarios.GetRow()]	
END IF

IF cbx_fecha.checked	THEN
	ld_Fecha	=	Date('01/01/1900')
ELSE
	ls_Fecha	=	em_fecha.Text
	ld_Fecha	=	Date(ls_Fecha)
END IF

IF cbx_grupos.checked	THEN	
	li_Grupo	=	0
ELSE	
	li_Grupo	=	dw_grupos.Object.grpo_codigo[dw_grupos.GetRow()]	
END IF

vinf.dw_1.SetTransObject(sqlca)

fila = vinf.dw_1.Retrieve(gstr_apl.NombreSistema, ls_Usuarios, li_Grupo, ld_Fecha, gstr_apl.CodigoSistema)

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

type pb_salir from w_para_informes`pb_salir within w_info_accesoaplicaciones
integer x = 2478
integer y = 844
end type

type st_1 from statictext within w_info_accesoaplicaciones
integer x = 251
integer y = 680
integer width = 2034
integer height = 364
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

type st_2 from statictext within w_info_accesoaplicaciones
integer x = 329
integer y = 904
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
string text = "Usuarios"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_usuarios from datawindow within w_info_accesoaplicaciones
integer x = 800
integer y = 892
integer width = 974
integer height = 92
integer taborder = 10
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "dddw_admausuarios"
boolean border = false
boolean livescroll = true
end type

event clicked;Integer li_Grupo

li_Grupo	=	dw_grupos.Object.grpo_codigo[dw_grupos.GetRow()]
IF li_Grupo <> 0 Then
	idwc_usuarios.Retrieve(li_Grupo)	
END IF
	
end event

type cbx_usuarios from checkbox within w_info_accesoaplicaciones
integer x = 1833
integer y = 896
integer width = 274
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

type st_3 from statictext within w_info_accesoaplicaciones
integer x = 329
integer y = 744
integer width = 247
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

type dw_grupos from datawindow within w_info_accesoaplicaciones
integer x = 800
integer y = 732
integer width = 987
integer height = 92
integer taborder = 10
boolean bringtotop = true
boolean enabled = false
string title = "none"
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

type cbx_grupos from checkbox within w_info_accesoaplicaciones
integer x = 1833
integer y = 736
integer width = 274
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

type st_4 from statictext within w_info_accesoaplicaciones
integer x = 251
integer y = 440
integer width = 2034
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
integer x = 1833
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

