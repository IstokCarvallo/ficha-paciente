$PBExportHeader$w_para_informes.srw
forward
global type w_para_informes from window
end type
type pb_excel from picturebutton within w_para_informes
end type
type st_computador from statictext within w_para_informes
end type
type st_usuario from statictext within w_para_informes
end type
type st_temporada from statictext within w_para_informes
end type
type p_logo from picture within w_para_informes
end type
type st_titulo from statictext within w_para_informes
end type
type pb_acepta from picturebutton within w_para_informes
end type
type pb_salir from picturebutton within w_para_informes
end type
end forward

global type w_para_informes from window
integer x = 599
integer y = 828
integer width = 3333
integer height = 1580
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 16777215
pb_excel pb_excel
st_computador st_computador
st_usuario st_usuario
st_temporada st_temporada
p_logo p_logo
st_titulo st_titulo
pb_acepta pb_acepta
pb_salir pb_salir
end type
global w_para_informes w_para_informes

type variables
Str_info		istr_info
end variables

on w_para_informes.create
this.pb_excel=create pb_excel
this.st_computador=create st_computador
this.st_usuario=create st_usuario
this.st_temporada=create st_temporada
this.p_logo=create p_logo
this.st_titulo=create st_titulo
this.pb_acepta=create pb_acepta
this.pb_salir=create pb_salir
this.Control[]={this.pb_excel,&
this.st_computador,&
this.st_usuario,&
this.st_temporada,&
this.p_logo,&
this.st_titulo,&
this.pb_acepta,&
this.pb_salir}
end on

on w_para_informes.destroy
destroy(this.pb_excel)
destroy(this.st_computador)
destroy(this.st_usuario)
destroy(this.st_temporada)
destroy(this.p_logo)
destroy(this.st_titulo)
destroy(this.pb_acepta)
destroy(this.pb_salir)
end on

event open;x = 0
y = 0

This.Icon					=	Gstr_apl.Icono
st_Temporada.Text	=	Gstr_apl.Referencia + " "
st_Usuario.Text			=	gstr_Us.Nombre + " "
st_Computador.Text	=	gstr_Us.Computador + " "
end event

event resize;Integer		li_posi_x, li_posi_y, li_Ancho = 300, li_Alto = 245, li_Siguiente = 255

p_Logo.x						=	0
p_Logo.y						=	0
st_Temporada.x			=	p_Logo.Width + 50
st_Temporada.y			=	0
st_Temporada.Height		=	p_Logo.Height
st_Temporada.Width		=	This.Width - p_Logo.Width - 90
st_Usuario.x					=	p_Logo.Width + 50
st_Usuario.y					=	72
st_Usuario.Height			=	p_Logo.Height - 72
st_Usuario.Width			=	This.Width - p_Logo.Width - 90
st_Computador.x			=	p_Logo.Width + 50
st_Computador.y			=	144
st_Computador.Height	=	p_Logo.Height - 144
st_Computador.Width		=	This.Width - p_Logo.Width - 90

st_titulo.x					=	251
st_titulo.y					=	316

li_posi_x				= This.WorkSpaceWidth() - 370
li_posi_y				= st_Titulo.y + li_Siguiente

If pb_Acepta.Visible Then
	pb_Acepta.x			=	li_posi_x
	pb_Acepta.y			=	li_posi_y
	pb_Acepta.Width	=	li_Ancho
	pb_Acepta.Height	=	li_Alto
	li_posi_y 			+= li_Siguiente
End If

If pb_Excel.Visible Then
	pb_Excel.x			=	li_posi_x
	pb_Excel.y			=	li_posi_y
	pb_Excel.Width		=	li_Ancho
	pb_Excel.Height		=	li_Alto
	li_posi_y 			+= li_Siguiente
End If

If pb_Salir.Visible Then
	pb_Salir.x			=	li_posi_x
	pb_Salir.y			=	li_posi_y
	pb_Salir.Width		=	li_Ancho
	pb_Salir.Height		=	li_Alto
	li_posi_y 			+= li_Siguiente
End If
end event

type pb_excel from picturebutton within w_para_informes
event mousemove pbm_mousemove
string tag = "Imprime Informe"
boolean visible = false
integer x = 2665
integer y = 284
integer width = 302
integer height = 244
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string picturename = "\Repos\Resources\BTN\Excel.png"
string disabledname = "\Repos\Resources\BTN\Excel-bn.png"
alignment htextalign = right!
boolean map3dcolors = true
string powertiptext = "Imprimir Reporte"
end type

event clicked;/*
Este código no se hereda y debe ser sobreescrito a la ventana descendiente,
pués normalmente se adicionan controles y asignaciones de argumentos.
*/
//SetPointer(HourGlass!)
//
//Long		ll_fila, ll_cierre
//String 	ls_path, ls_file
//
//dw_1.SetTransObject(sqlca)
//
//ll_fila = dw_1.Retrieve()
//
//IF ll_fila = -1 THEN
//	MessageBox( "Error en Base de Datos", "Se ha producido un error en Base de datos : ~n" + sqlca.SQLErrText, StopSign!, Ok!)
//ELSEIF ll_fila = 0 THEN
//	MessageBox( "No Existe información", "No existe información para este informe.", StopSign!, Ok!)
//ELSE
//
//	If GetFileSaveName( "Seleccione archivo",  ls_path, ls_file, "Excel", ".XLS Files (*.xls),*.xls" , "C:\") = -1 Then
//		MessageBox('Error', 'No se encontro archivo solicitdo.' , StopSign!, OK! )
//		Return -1
//	End If
//
//	If dw_1.SaveAs(ls_File, Excel8!, True) = -1 Then
//		MessageBox('Error', 'No se pùdo generar archivo ('+ ls_file +') con informción solicitda.' , StopSign!, OK! )
//		Return -1
//	Else
//		MessageBox('Atencion', 'Archivo ('+ ls_file +') generado satisfactoriamente.' , Information!, OK! )
//	End If
//END IF
//
//SetPointer(Arrow!)
//
end event

type st_computador from statictext within w_para_informes
integer x = 2062
integer y = 144
integer width = 923
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
long textcolor = 65535
long backcolor = 16711680
boolean enabled = false
string text = "Computador"
alignment alignment = right!
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_usuario from statictext within w_para_informes
integer x = 2062
integer y = 76
integer width = 923
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
long textcolor = 65535
long backcolor = 16711680
boolean enabled = false
string text = "Usuario"
alignment alignment = right!
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_temporada from statictext within w_para_informes
integer x = 2062
integer width = 923
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Comic Sans MS"
long textcolor = 65535
long backcolor = 16711680
boolean enabled = false
string text = "Temporada"
alignment alignment = right!
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type p_logo from picture within w_para_informes
integer width = 430
integer height = 296
boolean enabled = false
string picturename = "\Repos\Resources\LOGO\Logo.png"
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
boolean map3dcolors = true
end type

type st_titulo from statictext within w_para_informes
integer x = 251
integer y = 316
integer width = 2034
integer height = 100
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 16711680
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type pb_acepta from picturebutton within w_para_informes
event mousemove pbm_mousemove
string tag = "Imprime Informe"
integer x = 2679
integer y = 552
integer width = 302
integer height = 244
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean default = true
string picturename = "\Repos\Resources\BTN\imprimir.png"
string disabledname = "\Repos\Resources\BTN\imprimir-bn.png"
alignment htextalign = right!
boolean map3dcolors = true
string powertiptext = "Imprimir Reporte"
end type

event mousemove;w_main.SetMicroHelp("Imprimir información")
end event

event clicked;/*
Este código no se hereda y debe ser sobreescrito a la ventana descendiente,
pués normalmente se adicionan controles y asignaciones de argumentos.
*/
//Long			ll_Fila
//String		ls_Informe
//
//istr_info.Titulo	=	"TITULO DEL INFORME"
//istr_info.copias	=	1
//
//OpenWithParm(vinf, istr_info)
//
//vinf.dw_1.DataObject = "dw_"
//
//vinf.dw_1.SetTransObject(sqlca)
//
//ll_Fila = vinf.dw_1.Retrieve()
//
//IF ll_Fila = -1 THEN
//	MessageBox( "Error en Base de Datos", "Se ha producido un error en Base " + &
//					"de datos : ~n" + sqlca.SQLErrText, StopSign!, Ok!)
//ELSEIF ll_Fila = 0 THEN
//	MessageBox( "No Existe información", "No existe información para este informe.", &
//					StopSign!, Ok!)
//ELSE
//	IF gs_Ambiente = 'Windows' THEN
//		vinf.dw_1.Modify('DataWindow.Print.Preview = Yes')
//		vinf.dw_1.Modify('DataWindow.Print.Preview.Zoom = 75')
//	
//		vinf.Visible	= True
//		vinf.Enabled	= True
//	END IF
//END IF
end event

type pb_salir from picturebutton within w_para_informes
event mousemove pbm_mousemove
string tag = "Salir de la Ventana"
integer x = 2670
integer y = 876
integer width = 302
integer height = 244
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean cancel = true
string picturename = "\Repos\Resources\BTN\Apagar.png"
string disabledname = "\Repos\Resources\BTN\Apagar-bn.png"
alignment htextalign = right!
boolean map3dcolors = true
string powertiptext = "Salir (Cerrar Ventana Activa)"
end type

event mousemove;w_main.SetMicroHelp("Salir [Cerrar Ventana Activa]")
end event

event clicked;Close(Parent)
end event

