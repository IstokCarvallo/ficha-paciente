$PBExportHeader$w_mant_directo.srw
forward
global type w_mant_directo from window
end type
type st_encabe from statictext within w_mant_directo
end type
type pb_nuevo from picturebutton within w_mant_directo
end type
type pb_lectura from picturebutton within w_mant_directo
end type
type pb_eliminar from picturebutton within w_mant_directo
end type
type pb_insertar from picturebutton within w_mant_directo
end type
type pb_salir from picturebutton within w_mant_directo
end type
type pb_imprimir from picturebutton within w_mant_directo
end type
type pb_grabar from picturebutton within w_mant_directo
end type
type dw_1 from uo_dw within w_mant_directo
end type
end forward

global type w_mant_directo from window
integer width = 3657
integer height = 2304
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 16777215
string icon = "WinLogo!"
event ue_imprimir ( )
event ue_guardar ( )
event ue_buscar ( )
event ue_ordenar ( )
event ue_recuperadatos ( )
event ue_listo ( )
event ue_antesguardar ( )
event ue_nuevo ( )
event ue_borrar ( )
event ue_validaregistro ( )
event ue_primero ( )
event ue_anterior ( )
event ue_siguiente ( )
event ue_ultimo ( )
event ue_controllectura ( )
event ue_controlgrabar ( )
event ue_controlimprimir ( )
event ue_controlnuevo ( )
event ue_controlinsertar ( )
event ue_controlborrar ( )
st_encabe st_encabe
pb_nuevo pb_nuevo
pb_lectura pb_lectura
pb_eliminar pb_eliminar
pb_insertar pb_insertar
pb_salir pb_salir
pb_imprimir pb_imprimir
pb_grabar pb_grabar
dw_1 dw_1
end type
global w_mant_directo w_mant_directo

type variables
protected:
Long		il_fila
String	buscar, ordenar, is_ultimacol, ias_campo[]
Boolean	ib_datos_ok, ib_borrar, ib_ok, ib_traer, &
			ib_deshace = True
Date		id_FechaAcceso
Time		it_HoraAcceso

Menu	im_menu

Str_parms		istr_parms
Str_mant		istr_mant
Str_busqueda	istr_busq
Str_info		istr_info
end variables

forward prototypes
protected function integer wf_modifica ()
public subroutine wf_mueve (string movimiento)
public subroutine wf_bloqueacolumnas (boolean ab_bloquea)
protected function boolean wf_actualiza_db ()
public subroutine wf_replicacion ()
end prototypes

event ue_imprimir();/*
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

event ue_guardar();IF dw_1.AcceptText() = -1 THEN RETURN

SetPointer(HourGlass!)

w_main.SetMicroHelp("Grabando información...")

TriggerEvent("ue_antesguardar")

IF Message.DoubleParm = -1 THEN RETURN

IF wf_actualiza_db() THEN
	w_main.SetMicroHelp("Información Grabada.")
	pb_imprimir.Enabled	= True
ELSE
	w_main.SetMicroHelp("No se puede Grabar información.")
	Message.DoubleParm = -1
	RETURN
END IF
end event

event ue_buscar;f_buscar(dw_1, buscar)
end event

event ue_ordenar;String ls_info

str_parms	parm

parm.string_arg[1]	= ordenar
parm.dw_arg				= dw_1

OpenWithParm(w_columna_orden, parm)

ls_info	= Message.StringParm

dw_1.SetRow(1)

RETURN
end event

event ue_recuperadatos;w_main.SetMicroHelp("Recuperando Datos...")
SetPointer(HourGlass!)
PostEvent("ue_listo")

pb_imprimir.Enabled	=	False
pb_eliminar.Enabled	=	False
pb_grabar.Enabled		=	False
pb_insertar.Enabled	=	True
end event

event ue_listo();String	ls_Objetos, ls_Columna, ls_NumeroTab
Integer	li_Posicion

IF dw_1.RowCount() > 0 THEN
	pb_Imprimir.Enabled	=	True
	
	pb_Eliminar.Enabled	=	Not istr_mant.Solo_Consulta
	pb_Grabar.Enabled		=	Not istr_mant.Solo_Consulta
	pb_Insertar.Enabled	=	Not istr_mant.Solo_Consulta
	
	wf_BloqueaColumnas(istr_mant.Solo_Consulta)
ELSE
	pb_Insertar.Enabled	=	Not istr_mant.Solo_Consulta
END IF

w_main.SetMicroHelp("Listo")
end event

event ue_antesguardar;Long	ll_fila = 1

DO WHILE ll_fila <= dw_1.RowCount()
	IF dw_1.GetItemStatus(ll_fila, 0, Primary!) = New! THEN
		dw_1.DeleteRow(ll_fila)
	ELSE
		ll_fila ++
	END IF
LOOP
end event

event ue_nuevo();il_fila = dw_1.InsertRow(0)

IF il_fila > 0 THEN
	pb_eliminar.Enabled	= True
	pb_grabar.Enabled		= True
END IF

dw_1.ScrollToRow(il_fila)
dw_1.SetRow(il_fila)
dw_1.SetFocus()
dw_1.SetColumn(1)
end event

event ue_borrar;IF dw_1.rowcount() < 1 THEN RETURN

SetPointer(HourGlass!)

ib_borrar = True
w_main.SetMicroHelp("Validando la eliminación...")

Message.DoubleParm = 0

This.TriggerEvent ("ue_validaborrar")

IF Message.DoubleParm = -1 THEN RETURN

IF MessageBox("Eliminación de Registro", "Está seguro de Eliminar este Registro", Question!, YesNo!) = 1 THEN
	IF dw_1.DeleteRow(0) = 1 THEN
		ib_borrar = False
		w_main.SetMicroHelp("Borrando Registro...")
		SetPointer(Arrow!)
	ELSE
		ib_borrar = False
		MessageBox(This.Title,"No se puede borrar actual registro.")
	END IF

 IF dw_1.RowCount() = 0 THEN
		pb_eliminar.Enabled = False
	ELSE
		il_fila = dw_1.GetRow()
	END IF
END IF
end event

event ue_primero;il_fila = 1
	
dw_1.SetRow(il_fila)
dw_1.ScrollToRow(il_fila)
end event

event ue_anterior;Long		ll_fila

ll_fila	= dw_1.GetRow()

IF ll_fila > 1 THEN
	il_fila = ll_fila - 1
	
	dw_1.SetRow(il_fila)
	dw_1.ScrollToRow(il_fila)
END IF
end event

event ue_siguiente;Long		ll_fila

ll_fila	= dw_1.GetRow()

IF ll_fila < dw_1.RowCount() THEN
	il_fila = ll_fila + 1
	
	dw_1.SetRow(il_fila)
	dw_1.ScrollToRow(il_fila)
END IF
end event

event ue_ultimo;il_fila = dw_1.RowCount()
	
dw_1.SetRow(il_fila)
dw_1.ScrollToRow(il_fila)
end event

event ue_controllectura();IF pb_Lectura.Enabled AND pb_Lectura.Visible THEN
	pb_Lectura.TriggerEvent(Clicked!)
END IF
end event

event ue_controlgrabar();IF pb_Grabar.Enabled AND pb_Grabar.Visible THEN
	pb_Grabar.TriggerEvent(Clicked!)
END IF
end event

event ue_controlimprimir();IF pb_Imprimir.Enabled AND pb_Imprimir.Visible THEN
	pb_Imprimir.TriggerEvent(Clicked!)
END IF
end event

event ue_controlnuevo();IF pb_Nuevo.Enabled AND pb_Nuevo.Visible THEN
	pb_Nuevo.TriggerEvent(Clicked!)
END IF
end event

event ue_controlinsertar();IF pb_Insertar.Enabled AND pb_Insertar.Visible THEN
	pb_Insertar.TriggerEvent(Clicked!)
END IF
end event

event ue_controlborrar();IF pb_Eliminar.Enabled AND pb_Eliminar.Visible THEN
	pb_Eliminar.TriggerEvent(Clicked!)
END IF
end event

protected function integer wf_modifica ();IF dw_1.AcceptText() = -1 THEN RETURN -1

IF (dw_1.ModifiedCount() + dw_1.DeletedCount()) > 0 THEN RETURN 0

RETURN 1
end function

public subroutine wf_mueve (string movimiento);IF dw_1.RowCount() > 1 THEN
	dw_1.SetRedraw(False)
	
	CHOOSE CASE movimiento
		CASE "anterior"
			IF il_fila > 1 THEN il_fila --
		
		CASE "siguiente"
			IF il_fila < dw_1.RowCount() THEN il_fila ++
		
		CASE "primero"
			il_fila = 1 
		
		CASE ELSE
			il_fila = dw_1.RowCount()
		
	END CHOOSE

	dw_1.ScrollToRow(il_fila)
	dw_1.SetRow(il_fila)
	dw_1.SetRedraw(True)
END IF
end subroutine

public subroutine wf_bloqueacolumnas (boolean ab_bloquea);String	ls_Objetos, ls_Columna, ls_NumeroTab, ls_Protect = "0", ls_YesNo = 'Yes'
Integer	li_Posicion

IF ab_Bloquea THEN
	ls_Protect	=	"1"
	ls_YesNo		=	'Yes'
END IF

ls_Objetos	=	dw_1.Object.DataWindow.Objects + "~t"

DO WHILE ls_Objetos <> ""
	li_Posicion		=	Pos(ls_Objetos, "~t")
	ls_Columna		=	Left(ls_Objetos, li_Posicion -1)
	ls_Objetos		=	Mid(ls_Objetos, li_Posicion + 1)

	CHOOSE CASE Lower(dw_1.Describe(ls_Columna + ".Type"))
		CASE "column"
			ls_NumeroTab	=	dw_1.Describe(ls_Columna + ".TabSequence")
			
			IF IsNumber(ls_NumeroTab) THEN
				IF Integer(ls_NumeroTab) > 0 THEN
					dw_1.Modify(ls_Columna + ".Protect = " + ls_Protect)
				END IF
			END IF
			
		CASE "button"
			dw_1.Modify(ls_Columna + ".Enabled = " + ls_YesNo)
			
	END CHOOSE
LOOP

RETURN
end subroutine

protected function boolean wf_actualiza_db ();Boolean	lb_AutoCommit, lb_Retorno
DateTime	ldt_FechaHora

ldt_FechaHora		=	F_FechaHora()
dw_1.GrupoFecha	=	ldt_FechaHora

IF Not dw_1.uf_check_required(0) THEN RETURN False

IF Not dw_1.uf_validate(0) THEN RETURN False

lb_AutoCommit		=	sqlca.AutoCommit
sqlca.AutoCommit	=	False

wf_replicacion()

IF dw_1.Update(True, False) = 1 then 
	Commit;
	
	IF sqlca.SQLCode <> 0 THEN
		F_ErrorBaseDatos(sqlca, This.Title)
		lb_Retorno	=	False
	ELSE
		lb_Retorno	=	True
			
		dw_1.ResetUpdate()
	END IF
ELSE
	RollBack;
	
	IF sqlca.SQLCode <> 0 THEN F_ErrorBaseDatos(sqlca, This.Title)
	
	lb_Retorno	=	False
END IF

sqlca.AutoCommit	=	lb_AutoCommit

RETURN lb_Retorno
end function

public subroutine wf_replicacion ();
end subroutine

event closequery;IF Not istr_mant.Solo_Consulta THEN
	CHOOSE CASE wf_modifica()
		CASE -1
			Message.ReturnValue	=	1 
			
		CASE 0
			CHOOSE CASE MessageBox("Grabar registro(s)","Desea Grabar la información ?", Question!, YesNoCancel!)
				CASE 1
					Message.DoubleParm = 0
					This.triggerevent("ue_guardar")
					IF message.doubleparm = -1 THEN Message.ReturnValue = 1
					RETURN
					
				CASE 3
					Message.ReturnValue	=	1
					RETURN
			END CHOOSE
	END CHOOSE
END IF
end event

event open;x				=	0
y				=	0
This.Width	=	dw_1.width + 540
This.Height	=	2470	
im_menu		=	m_principal

IF gs_Ambiente = "Windows" THEN
	This.ParentWindow().ToolBarVisible	=	True
	im_menu.Item[1].Item[6].Enabled		=	True
	im_menu.Item[7].Visible					=	False
END IF

This.Icon									=	Gstr_apl.Icono

dw_1.SetTransObject(sqlca)
dw_1.Modify("datawindow.message.title='Error '+ is_titulo")
dw_1.SetRowFocusIndicator(Hand!)
dw_1.Modify("DataWindow.Footer.Height = 110")

istr_mant.UsuarioSoloConsulta	=	f_OpcionSoloConsulta()
istr_mant.Solo_Consulta			=	istr_mant.UsuarioSoloConsulta

f_GrabaAccesoAplicacion(True, id_FechaAcceso, it_HoraAcceso, This.Title, "Acceso a Aplicación", 1)
								
/* La asignación a las siguientes variables no se hereda, debe ser adicional en ventana descendiente */
buscar			= "Código:Ncodigo,Descripción:Sconcepto"
ordenar			= "Código:codigo,Descripción:concepto"
is_ultimacol	= "columna"
end event

on w_mant_directo.create
this.st_encabe=create st_encabe
this.pb_nuevo=create pb_nuevo
this.pb_lectura=create pb_lectura
this.pb_eliminar=create pb_eliminar
this.pb_insertar=create pb_insertar
this.pb_salir=create pb_salir
this.pb_imprimir=create pb_imprimir
this.pb_grabar=create pb_grabar
this.dw_1=create dw_1
this.Control[]={this.st_encabe,&
this.pb_nuevo,&
this.pb_lectura,&
this.pb_eliminar,&
this.pb_insertar,&
this.pb_salir,&
this.pb_imprimir,&
this.pb_grabar,&
this.dw_1}
end on

on w_mant_directo.destroy
destroy(this.st_encabe)
destroy(this.pb_nuevo)
destroy(this.pb_lectura)
destroy(this.pb_eliminar)
destroy(this.pb_insertar)
destroy(this.pb_salir)
destroy(this.pb_imprimir)
destroy(this.pb_grabar)
destroy(this.dw_1)
end on

event resize;Integer		li_posic_x, li_posic_y, &
				li_Ancho = 300, li_Alto = 245, li_Siguiente = 255

dw_1.Resize(This.WorkSpaceWidth() - 490,This.WorkSpaceHeight() - dw_1.y - 75)

dw_1.x					=	78
st_encabe.x				=	dw_1.x
st_encabe.width		=	dw_1.width

li_posic_x				=	This.WorkSpaceWidth() - 370
IF st_encabe.Visible THEN
	li_posic_y				=	st_encabe.y
ELSE
	li_posic_y				=	dw_1.y
END IF

IF pb_lectura.Visible THEN
	pb_lectura.x				=	li_posic_x
	pb_lectura.y				=	li_posic_y
	pb_lectura.width		=	li_Ancho
	pb_lectura.height		=	li_Alto	
	li_posic_y 				+= li_Siguiente * 1.25
End If

IF pb_nuevo.Visible THEN
	pb_nuevo.x			=	li_posic_x
	pb_nuevo.y			=	li_posic_y
	pb_nuevo.width	=	li_Ancho
	pb_nuevo.height	=	li_Alto
	li_posic_y 			+= li_Siguiente
END IF

IF pb_insertar.Visible THEN
	pb_insertar.x		=	li_posic_x
	pb_insertar.y		=	li_posic_y
	pb_insertar.width	=	li_Ancho
	pb_insertar.height	=	li_Alto
	li_posic_y += li_Siguiente
END IF

IF pb_eliminar.Visible THEN
	pb_eliminar.x			=	li_posic_x
	pb_eliminar.y			=	li_posic_y
	pb_eliminar.width		=	li_Ancho
	pb_eliminar.height	=	li_Alto
	li_posic_y += li_Siguiente
END IF

IF pb_grabar.Visible THEN
	pb_grabar.x				=	li_posic_x
	pb_grabar.y				=	li_posic_y
	pb_grabar.width		=	li_Ancho
	pb_grabar.height		=	li_Alto
	li_posic_y += li_Siguiente
END IF

IF pb_imprimir.Visible THEN
	pb_imprimir.x			=	li_posic_x
	pb_imprimir.y			=	li_posic_y
	pb_imprimir.width		=	li_Ancho
	pb_imprimir.height	=	li_Alto
	li_posic_y += li_Siguiente
END IF

pb_salir.x				=	li_posic_x
pb_salir.y				=	dw_1.y + dw_1.Height - li_Siguiente
pb_salir.width			=	li_Ancho
pb_salir.height			=	li_Alto
end event

event close;Boolean	Valida
Window	ventana
Integer	li_vta
 
ventana	= This.ParentWindow().GetFirstSheet()

IF IsValid(ventana) THEN
	li_vta++

	DO
		ventana	= this.ParentWindow().GetNextSheet(ventana)
		valida	= IsValid(ventana)
		IF valida THEN li_vta++
	LOOP WHILE valida
END IF

IF li_vta = 1 AND gs_Ambiente = "Windows" THEN
	This.ParentWindow().ToolBarVisible	= False
	im_menu.Item[1].Item[6].Enabled		= False
	im_menu.Item[7].Visible					= False
END IF

f_GrabaAccesoAplicacion(False, id_FechaAcceso, it_HoraAcceso, "", "", 0)
end event

event mousemove;w_main.SetMicroHelp("Ventana : " + ClassName())
end event

type st_encabe from statictext within w_mant_directo
integer x = 78
integer y = 68
integer width = 2249
integer height = 176
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 16711680
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type pb_nuevo from picturebutton within w_mant_directo
event mousemove pbm_mousemove
string tag = "Limpia para Nuevos Datos"
integer x = 2487
integer y = 416
integer width = 302
integer height = 244
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\Repos\Resources\BTN\Archivo.png"
string disabledname = "\Repos\Resources\BTN\Archivo-bn.png"
alignment htextalign = left!
string powertiptext = "Limpia para Nuevos Datos"
long backcolor = 33543637
end type

event clicked;IF Not istr_mant.Solo_Consulta THEN
	CHOOSE CASE wf_modifica()
		CASE 0
			CHOOSE CASE MessageBox("Grabar registro(s)","Desea Grabar la información ?", Question!, YesNoCancel!)
				CASE 1
					Message.DoubleParm = 0
					Parent.TriggerEvent("ue_guardar")
					IF message.DoubleParm = -1 THEN RETURN
					
				CASE 3
					RETURN
			END CHOOSE
	END CHOOSE
END IF

wf_BloqueaColumnas(False)

dw_1.Reset()

istr_mant.Solo_Consulta	=	istr_mant.UsuarioSoloConsulta
end event

type pb_lectura from picturebutton within w_mant_directo
event mousemove pbm_mousemove
string tag = "Rescatar Información"
integer x = 2496
integer y = 132
integer width = 302
integer height = 244
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\Repos\Resources\BTN\Busqueda.png"
string disabledname = "\Repos\Resources\BTN\Busqueda-bn.png"
alignment htextalign = left!
string powertiptext = "Rescatar Información"
long backcolor = 33543637
end type

event clicked;Parent.PostEvent("ue_recuperadatos")



end event

type pb_eliminar from picturebutton within w_mant_directo
event mousemove pbm_mousemove
string tag = "Eliminar Detalle"
integer x = 2487
integer y = 984
integer width = 302
integer height = 244
integer taborder = 50
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string picturename = "\Repos\Resources\BTN\Signo Menos.png"
string disabledname = "\Repos\Resources\BTN\Signo Menos-bn.png"
alignment htextalign = left!
string powertiptext = "Eliminar Detalle"
long backcolor = 33543637
end type

event clicked;Parent.TriggerEvent("ue_borrar")
end event

type pb_insertar from picturebutton within w_mant_directo
event mousemove pbm_mousemove
string tag = "Ingresar Nuevo Detalle"
integer x = 2482
integer y = 700
integer width = 302
integer height = 244
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string picturename = "\Repos\Resources\BTN\Signo Mas.png"
string disabledname = "\Repos\Resources\BTN\Signo Mas-bn.png"
alignment htextalign = left!
string powertiptext = "Ingresar Nuevo Detalle"
long backcolor = 33543637
end type

event clicked;Parent.TriggerEvent("ue_nuevo")
end event

type pb_salir from picturebutton within w_mant_directo
event mousemove pbm_mousemove
string tag = "Salir [Cerrar Ventana Activa]"
integer x = 2487
integer y = 1836
integer width = 302
integer height = 244
integer taborder = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean cancel = true
string picturename = "\Repos\Resources\BTN\Apagar.png"
string disabledname = "\Repos\Resources\BTN\Apagar-bn.png"
alignment htextalign = left!
string powertiptext = "Salir [Cerrar Ventana Activa]"
long backcolor = 33543637
end type

event clicked;Close(Parent)
end event

type pb_imprimir from picturebutton within w_mant_directo
event mousemove pbm_mousemove
string tag = "Imprimir Información"
integer x = 2496
integer y = 1552
integer width = 302
integer height = 244
integer taborder = 70
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string picturename = "\Repos\Resources\BTN\Imprimir.png"
string disabledname = "\Repos\Resources\BTN\Imprimir-bn.png"
alignment htextalign = left!
string powertiptext = "Imprimir Información"
long backcolor = 33543637
end type

event clicked;Parent.TriggerEvent("ue_imprimir")
end event

type pb_grabar from picturebutton within w_mant_directo
event mousemove pbm_mousemove
string tag = "Grabar Información"
integer x = 2487
integer y = 1268
integer width = 302
integer height = 244
integer taborder = 60
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string picturename = "\Repos\Resources\BTN\Guardar.png"
string disabledname = "\Repos\Resources\BTN\Guardar-bn.png"
alignment htextalign = left!
string powertiptext = "Grabar Información"
long backcolor = 33543637
end type

event clicked;Parent.TriggerEvent("ue_guardar")
end event

type dw_1 from uo_dw within w_mant_directo
event ue_tecla pbm_dwnkey
integer x = 78
integer y = 268
integer width = 2249
integer height = 592
integer taborder = 30
boolean border = false
boolean livescroll = true
end type

event rowfocuschanged;call super::rowfocuschanged;ib_datos_ok = True

IF This.RowCount() < 1 OR CurrentRow = 0 OR ib_borrar THEN
	ib_datos_ok = False
ELSE
	il_fila = CurrentRow
END IF
end event

event losefocus;call super::losefocus;AcceptText()
end event

event clicked;call super::clicked;IF Row > 0 THEN
	il_Fila	=	Row

	This.SetRow(il_fila)
END IF

RETURN 0
end event

event dwnkey;call super::dwnkey;This.SetRedraw(False)
//This.AcceptText()

CHOOSE CASE key
	CASE KeyRightArrow!, KeyLeftArrow!
		This.SetRedraw(True)
		RETURN -1
		
	CASE KeyDownArrow!, KeyUpArrow!
		Message.DoubleParm = 0
		
		Parent.TriggerEvent("ue_validaregistro")
		
		IF Message.DoubleParm = -1 THEN
			This.SetRedraw(True)
			RETURN -1
		ELSEIF Key = KeyDownArrow! AND il_fila = dw_1.RowCount() THEN
			Parent.TriggerEvent("ue_nuevo")
		END IF
		
	CASE KeyTab!
		IF is_ultimacol = This.GetColumnName() AND il_fila = dw_1.RowCount() THEN
			Message.DoubleParm = 0
			
			Parent.TriggerEvent("ue_validaregistro")
			
			IF Message.DoubleParm = -1 THEN
				This.SetRedraw(True)
				RETURN -1
			ELSE
				Parent.TriggerEvent("ue_nuevo")
				
				This.SetFocus()
				This.SetRedraw(True)
				RETURN -1
			END IF
		END IF

END CHOOSE

This.SetRedraw(True)

RETURN 0
end event

event ue_seteafila;call super::ue_seteafila;il_fila	= This.GetRow()
end event

event itemerror;RETURN 1
end event

event itemfocuschanged;call super::itemfocuschanged;IF IsValid(w_main) THEN
	w_main.SetMicroHelp(dwo.Tag)
END IF
end event

