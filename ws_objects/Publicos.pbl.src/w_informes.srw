$PBExportHeader$w_informes.srw
forward
global type w_informes from window
end type
type pb_salir from picturebutton within w_informes
end type
type pb_imprimir from picturebutton within w_informes
end type
type dw_herr from datawindow within w_informes
end type
type dw_barra from datawindow within w_informes
end type
type dw_1 from datawindow within w_informes
end type
type gb_1 from groupbox within w_informes
end type
type gb_2 from groupbox within w_informes
end type
type gb_3 from groupbox within w_informes
end type
type gb_4 from groupbox within w_informes
end type
type gb_5 from groupbox within w_informes
end type
type gb_6 from groupbox within w_informes
end type
type wstr_ano_benef from structure within w_informes
end type
end forward

type wstr_ano_benef from structure
    integer ano
    integer beneficio
end type

shared variables

end variables

global type w_informes from window
boolean visible = false
integer width = 3712
integer height = 2532
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
windowtype windowtype = popup!
long backcolor = 16777215
string icon = "AppIcon!"
event ue_mouse pbm_mousemove
event ue_listo ( )
pb_salir pb_salir
pb_imprimir pb_imprimir
dw_herr dw_herr
dw_barra dw_barra
dw_1 dw_1
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
gb_5 gb_5
gb_6 gb_6
end type
global w_informes w_informes

type variables
str_info istr_info
String	is_colname
Boolean 	ib_flag = True
end variables

forward prototypes
public subroutine monitorposicion (integer xpos, integer ypos)
end prototypes

event ue_listo();IF gs_Ambiente = 'Windows' AND ib_flag THEN
	dw_1.ModIfy('DataWindow.Print.Preview = Yes')
	dw_1.ModIfy('DataWindow.Print.Preview.Zoom = 100')
	
	IF dw_1.Object.DataWindow.Print.Orientation = '1' THEN
		This.width = 5100//LandScape
	ELSE
		This.width = 3900//Portrait
	END IF
	
	IF dw_1.RowCount() > 0 THEN
		This.Visible	= 	True
		This.Enabled	= 	True
	END IF
	
END IF
end event

public subroutine monitorposicion (integer xpos, integer ypos);Long		ll_x, ll_y

ll_x		=	PixelsToUnits(xpos, XPixelsToUnits!)
ll_y		=	PixelsToUnits(ypos, yPixelsToUnits!)

IF ll_x > dw_barra.x AND ll_y > dw_barra.y THEN
	dw_barra.Visible	=	True
	
ELSE
	dw_barra.Visible	=	False
	dw_herr.Visible	=	False
END IF
end subroutine

event open;This.Icon	= Mid(gstr_apl.bmp,1,Pos(gstr_apl.bmp,'.'))+'ico'

istr_info	=	Message.PowerObjectParm
This.Title	=	istr_info.Titulo

//IF Isnull(istr_info.orden) OR istr_info.orden = 0 THEN
//	pb_ordenar.Visible	=	False
//END IF

IF IsNull(istr_info.Multiple) THEN istr_info.Multiple = False

This.Width	=	3920
This.Height	=	3000

F_Membrete(dw_1)

dw_barra.InsertRow(0)
dw_herr.InsertRow(0)
end event

on w_informes.create
this.pb_salir=create pb_salir
this.pb_imprimir=create pb_imprimir
this.dw_herr=create dw_herr
this.dw_barra=create dw_barra
this.dw_1=create dw_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_5=create gb_5
this.gb_6=create gb_6
this.Control[]={this.pb_salir,&
this.pb_imprimir,&
this.dw_herr,&
this.dw_barra,&
this.dw_1,&
this.gb_1,&
this.gb_2,&
this.gb_3,&
this.gb_4,&
this.gb_5,&
this.gb_6}
end on

on w_informes.destroy
destroy(this.pb_salir)
destroy(this.pb_imprimir)
destroy(this.dw_herr)
destroy(this.dw_barra)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.gb_6)
end on

event resize;dw_1.X					=	30
dw_1.y					=	30
dw_1.Width				=	This.Width 	- 140
dw_1.Height				=	This.Height - 220
dw_barra.y				=	(dw_1.y + dw_1.Height) - (dw_barra.Height + 80)
dw_barra.x				=	(dw_1.x + dw_1.Width) - (dw_barra.Width + 80)
dw_herr.y				=	(dw_barra.y - dw_herr.Height)
dw_herr.x				=	(dw_barra.x + dw_barra.Width) - (dw_herr.Width)
end event

event close;ib_flag			=	False
end event

type pb_salir from picturebutton within w_informes
boolean visible = false
integer x = -32768
integer y = 12312
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "none"
boolean originalsize = true
alignment htextalign = left!
end type

type pb_imprimir from picturebutton within w_informes
boolean visible = false
integer x = -32768
integer y = 12312
integer width = 402
integer height = 224
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "none"
boolean originalsize = true
alignment htextalign = left!
end type

type dw_herr from datawindow within w_informes
event ue_mousemove pbm_dwnmousemove
boolean visible = false
integer x = 3031
integer y = 1504
integer width = 192
integer height = 424
integer taborder = 90
string title = "none"
string dataobject = "dw_menu_imprimir_herr"
boolean border = false
boolean livescroll = true
end type

event ue_mousemove;String	ls_columna, ls_tag
Integer	li_item
ls_columna	=	dwo.Name

IF Right(ls_columna, 1) <> Right(is_colname, 1) THEN
	FOR li_item = 1 TO 3
		This.Modify ( "t_" + String(li_item) + ".Visible='0'" )
	NEXT
	is_colname	=	ls_columna
END IF

CHOOSE CASE  ls_columna
	CASE "p_1"
		ls_tag	=	"Potrait/Landscape"
		This.Modify ( "t_1.Visible='1'" )
		
	CASE "p_2"
		ls_tag	=	"Ajuste Pagina"
		This.Modify ( "t_2.Visible='1'" )
		
	CASE "p_3"
		ls_tag	=	"Ajuste Pagina"
		This.Modify ( "t_3.Visible='1'" )
		
END CHOOSE
end event

event clicked;String	ls_columna

ls_columna	=	dwo.Name

CHOOSE CASE  ls_columna
	CASE "p_1"
		IF dw_1.Object.DataWindow.Print.Orientation = '1' OR dw_1.Object.DataWindow.Print.Orientation = '0' THEN
			dw_1.Object.DataWindow.Print.Orientation = '2'
		ELSE
			dw_1.Object.DataWindow.Print.Orientation = '1'
		END IF
		
	CASE "p_2"
		String	ls_zoom
		Integer	li_zoom
		str_zoom	lstr_zoom
		
		lstr_zoom.idw_obj = dw_1
		
		ls_zoom	=	dw_1.object.datawindow.zoom
		
		IF IsNumber(ls_zoom) THEN
			lstr_zoom.zoom = Integer(ls_zoom)
		END IF
		
		OpenWithParm (w_zoom, lstr_zoom)
		
		li_zoom = message.DoubleParm
		
	CASE "p_3"
		SetPointer(HourGlass!)
		
		IF dw_1.Describe("datawindow.print.preview.rulers") = "no" THEN
			dw_1.Modify ("datawindow.print.preview.rulers = yes")
		ELSE
			dw_1.Modify ("datawindow.print.preview.rulers = no")
		END IF
		RETURN 0
		
END CHOOSE
end event

type dw_barra from datawindow within w_informes
event ue_mouseover pbm_dwnmousemove
event ue_mousemove pbm_dwnmousemove
boolean visible = false
integer x = 2071
integer y = 1928
integer width = 1152
integer height = 144
integer taborder = 100
string title = "none"
string dataobject = "dw_menu_imprimir"
boolean maxbox = true
boolean border = false
boolean livescroll = true
end type

event ue_mousemove;String	ls_columna, ls_tag
Integer	li_item
ls_columna	=	dwo.Name

If ls_columna <> is_colname Then
	FOR li_item = 1 TO 6
		This.Modify ( "t_" + String(li_item) + ".Visible='0'" )
	NEXT
	is_colname	=	ls_columna
End If

Choose Case  ls_columna
	Case "p_imprime"
		ls_tag	=	"Imprimir"
		This.Modify ( "t_4.Visible='1'" )
		
	Case "p_zoom_mas"
		ls_tag	=	"Zoom In"
		This.Modify ( "t_1.Visible='1'" )
				
	Case "p_zoom_menos"
		ls_tag	=	"Zoom Out"
		This.Modify ( "t_2.Visible='1'" )
		
	Case "p_guarda"
		ls_tag	=	"Guardar"
		This.Modify ( "t_3.Visible='1'" )
		
	Case "p_correo"
		ls_tag	=	"Enviar Mail"
		This.Modify ( "t_5.Visible='1'" )
		
	Case "p_herramienta"
		ls_tag	=	"Herramientas"
		This.Modify ( "t_6.Visible='1'" )
		
END Choose

end event

event clicked;String	ls_columna
Integer	li_yini, li_yact, li_Retorno
ls_columna	=	dwo.Name

Choose Case  ls_columna
	Case "p_imprime"
		str_mant	lstr_mant
		
		li_retorno 		=	0
		lstr_mant.dw	=	dw_1
		
		OpenWithParm (w_imprimir, lstr_mant)
		
		li_retorno 	= 	message.DoubleParm
		
		If IsNull ( li_retorno ) Then
			li_retorno = 0  
		End If
		
		If li_retorno < 0 Then
			MessageBox ( "ATENCION", "Problemas con su Impresora",StopSign! )
		End If

	Case "p_zoom_menos"
		SetPointer(HourGlass!)
		dw_1.Object.DataWindow.print.preview.Zoom = String(Integer(dw_1.Object.DataWindow.print.preview.Zoom) - 10)
		SetPointer(Arrow!)
				
	Case "p_zoom_mas"
		SetPointer(HourGlass!)
		dw_1.Object.DataWindow.print.preview.Zoom = String(Integer(dw_1.Object.DataWindow.print.preview.Zoom) + 10)
		SetPointer(Arrow!)
		
	Case "p_guarda"
		If dw_1.SaveAs() = 1 Then
			MessageBox("Generación de Archivo","Se ha generado el Archivo")
			Return
		Else
			MessageBox("Atención","Ocurrió un error al generar el Archivo.~r~n"+&
							"Revise permisos sobre carpeta o espacio en disco.")
			Return
		End If
		
	Case "p_correo"
		String		ls_Nombre, ls_NomReporte, ls_Archivo, ls_DirectorioAct 
		Long			ll_Fila, ll_consignatario, ll_Archivo
		Boolean		lb_Existe
		str_parms	lstr_parms
		
		SetPointer(HourGlass!)
		
		ls_DirectorioAct=GetCurrentDirectory()
			
		ls_Archivo									=	ls_DirectorioAct + '\Reporte' + &
															String(today(),'yyyymmdd')+'.pdf'
		lstr_parms.string_arg[ll_Archivo+3]	=	ls_Archivo
		
		dw_1.SaveAs(ls_Archivo, PDF!  , True)
		
		ChangeDirectory ( ls_DirectorioAct )
		
		ll_Archivo	=	1 
		ls_NomReporte					=	'Reportes' + String(today(),'yyyymmdd')
		lstr_parms.string_arg[1]	=	String(1)
		lstr_parms.string_arg[2]	=	ls_NomReporte
		lstr_parms.string_arg[3]	=	String(1)
		
		lstr_parms.string_arg[ll_Archivo+3]	=	ls_Archivo
		
		ChangeDirectory(ls_DirectorioAct)
		
		OpenWithParm(w_correo, lstr_parms)
		
		DO WHILE ll_Archivo>0 
			lb_Existe	=	FileExists(lstr_parms.string_arg[ll_Archivo + 3])
			If lb_Existe Then
				FileDelete(lstr_parms.string_arg[ll_Archivo + 3])
			End If
			ll_Archivo --
		LOOP
		
		ChangeDirectory ( ls_DirectorioAct )

		SetPointer(Arrow!)
		
	Case "p_herramienta"
		dw_herr.Visible = NOT dw_herr.Visible 

End Choose
end event

type dw_1 from datawindow within w_informes
event mousemove pbm_dwnmousemove
integer x = 37
integer y = 32
integer width = 3278
integer height = 2120
integer taborder = 10
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "WinLogo!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event mousemove;Monitorposicion(xpos, ypos)
end event

event retrieveend;IF RowCount > 0 THEN Parent.TriggerEvent("ue_listo")
end event

event retrievestart;Parent.PostEvent("ue_listo")
IF istr_info.Multiple THEN RETURN 2
end event

type gb_1 from groupbox within w_informes
boolean visible = false
integer x = 4155
integer y = 324
integer width = 480
integer height = 400
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "none"
end type

type gb_2 from groupbox within w_informes
boolean visible = false
integer x = 4256
integer y = 944
integer width = 480
integer height = 400
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "none"
end type

type gb_3 from groupbox within w_informes
boolean visible = false
integer x = 4366
integer y = 1496
integer width = 480
integer height = 400
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "none"
end type

type gb_4 from groupbox within w_informes
boolean visible = false
integer x = 4288
integer y = 80
integer width = 480
integer height = 400
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "none"
end type

type gb_5 from groupbox within w_informes
boolean visible = false
integer x = 4142
integer y = 1600
integer width = 480
integer height = 400
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "none"
end type

type gb_6 from groupbox within w_informes
boolean visible = false
integer x = 4846
integer y = 792
integer width = 480
integer height = 400
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "none"
end type

