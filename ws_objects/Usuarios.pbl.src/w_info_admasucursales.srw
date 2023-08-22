$PBExportHeader$w_info_admasucursales.srw
$PBExportComments$Informe de Sucursales y Unidades Administrativas.
forward
global type w_info_admasucursales from w_para_informes
end type
type cbx_todos from checkbox within w_info_admasucursales
end type
type st_2 from statictext within w_info_admasucursales
end type
type dw_sucursal from datawindow within w_info_admasucursales
end type
type st_3 from statictext within w_info_admasucursales
end type
type cbx_solosuc from checkbox within w_info_admasucursales
end type
end forward

global type w_info_admasucursales from w_para_informes
integer width = 2345
integer height = 1356
cbx_todos cbx_todos
st_2 st_2
dw_sucursal dw_sucursal
st_3 st_3
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
this.cbx_todos=create cbx_todos
this.st_2=create st_2
this.dw_sucursal=create dw_sucursal
this.st_3=create st_3
this.cbx_solosuc=create cbx_solosuc
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_todos
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.dw_sucursal
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.cbx_solosuc
end on

on w_info_admasucursales.destroy
call super::destroy
destroy(this.cbx_todos)
destroy(this.st_2)
destroy(this.dw_sucursal)
destroy(this.st_3)
destroy(this.cbx_solosuc)
end on

event open;call super::open;dw_sucursal.GetChild("adsu_codigo", idwc_Sucursal)
idwc_Sucursal.SetTransObject(sqlca)
idwc_Sucursal.Retrieve()

dw_sucursal.InsertRow(0)

dw_sucursal.Enabled	= False
dw_sucursal.Object.adsu_codigo.BackGround.Color	=	RGB(166,180,210)

iuo_Sucursal	=	Create uo_Sucursal
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

IF Not cbx_todos.Checked THEN
	li_Sucursal	=	dw_sucursal.Object.adsu_codigo[1]
END IF

IF Not cbx_solosuc.Checked THEN
	li_UnidAdmini	=	1
END IF

ll_Fila = vinf.dw_1.Retrieve(li_Sucursal, li_UnidAdmini)

IF ll_Fila = -1 THEN
	MessageBox( "Error en Base de Datos", "Se ha producido un error en Base " + &
					"de datos : ~n" + sqlca.SQLErrText, StopSign!, Ok!)
ELSEIF ll_Fila = 0 THEN
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

type pb_salir from w_para_informes`pb_salir within w_info_admasucursales
integer x = 1966
integer y = 668
end type

type cbx_todos from checkbox within w_info_admasucursales
integer x = 713
integer y = 492
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
	dw_sucursal.Enabled										=	False
	dw_sucursal.Object.adsu_codigo.BackGround.Color	=	RGB(213,213, 255)
	
	dw_sucursal.Reset()
	dw_sucursal.InsertRow(0)
ELSE
	dw_sucursal.Enabled										=	True
	dw_sucursal.Object.adsu_codigo.BackGround.Color	=	RGB(255, 255, 255)

	dw_sucursal.GetChild("adsu_codigo", idwc_Sucursal)
	idwc_Sucursal.SetTransObject(sqlca)
	idwc_Sucursal.Retrieve(gstr_apl.CodigoSistema)
END IF
end event

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

type dw_sucursal from datawindow within w_info_admasucursales
integer x = 704
integer y = 608
integer width = 960
integer height = 92
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "dddw_admasucursales"
boolean border = false
boolean livescroll = true
end type

event itemchanged;String	ls_Nula

SetNull(ls_Nula)

IF Not iuo_Sucursal.Existe(Integer(Data), True, sqlca) THEN
	This.SetItem(1, "adsu_codigo", ls_Nula)
	
	RETURN 1
END IF
end event

event itemerror;RETURN 1
end event

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

type cbx_solosuc from checkbox within w_info_admasucursales
integer x = 1129
integer y = 480
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

