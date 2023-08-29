$PBExportHeader$w_mant_tabla.srw
forward
global type w_mant_tabla from window
end type
type dw_1 from uo_dw within w_mant_tabla
end type
type st_encabe from statictext within w_mant_tabla
end type
type pb_lectura from picturebutton within w_mant_tabla
end type
type pb_nuevo from picturebutton within w_mant_tabla
end type
type pb_insertar from picturebutton within w_mant_tabla
end type
type pb_eliminar from picturebutton within w_mant_tabla
end type
type pb_grabar from picturebutton within w_mant_tabla
end type
type pb_imprimir from picturebutton within w_mant_tabla
end type
type pb_salir from picturebutton within w_mant_tabla
end type
end forward

global type w_mant_tabla from window
integer width = 3214
integer height = 2244
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 16777215
event ue_imprimir ( )
event ue_nuevo ( )
event ue_borrar ( )
event ue_guardar ( )
event ue_buscar ( )
event ue_ordenar ( )
event ue_validaborrar ( )
event ue_recuperadatos ( )
event ue_deshace ( )
event ue_requerido ( )
event ue_listo ( )
event ue_antesguardar ( )
event ue_cerrar ( )
event ue_modifica ( )
event ue_primero ( )
event ue_anterior ( )
event ue_siguiente ( )
event ue_ultimo ( )
event ue_controllectura ( )
event ue_controlborrar ( )
event ue_controlgrabar ( )
event ue_controlimprimir ( )
event ue_controlnuevo ( )
event ue_controlinsertar ( )
dw_1 dw_1
st_encabe st_encabe
pb_lectura pb_lectura
pb_nuevo pb_nuevo
pb_insertar pb_insertar
pb_eliminar pb_eliminar
pb_grabar pb_grabar
pb_imprimir pb_imprimir
pb_salir pb_salir
end type
global w_mant_tabla w_mant_tabla

type variables
protected:
Long		il_fila
String	buscar, ordenar
Boolean	ib_datos_ok, ib_borrar, ib_ok, ib_traer, &
			ib_deshace = True
Date		id_FechaAcceso
Time		it_HoraAcceso

Menu		im_menu

Str_parms		istr_parms
Str_mant		istr_mant
Str_busqueda	istr_busq
Str_info		istr_info
end variables

forward prototypes
protected function integer wf_modifica ()
public subroutine wf_mueve (string movimiento)
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
//	ELSE
//		F_ImprimeInformePdf(vinf.dw_1, "TituloInforme")
//	END IF
//END IF
end event

event ue_nuevo;/* Este Script debe ser traspasado a la ventana descendiente, pués normalmente se adicionan controles y asignaciones
	de argumentos. */

//istr_mant.borra			= False
//istr_mant.agrega			= True
//istr_mant.argumento[1]	= parametro de entrada
//
//OpenWithParm(iw_mantencion, istr_mant)	// La Ventana iw_mantencion debe ser una Variable de Instancia del Tipo de
//														// ventana del mantenedor de la tabla.
//
//IF dw_1.RowCount() > 0 AND pb_eliminar.Enabled = FALSE THEN
//	pb_eliminar.Enabled	= TRUE
//	pb_grabar.Enabled		= TRUE
//END IF
//
//dw_1.SetRow(il_fila)
//dw_1.SelectRow(il_fila,True)
end event

event ue_borrar;/* Este Script debe ser traspasado a la ventana descendiente, pués normalmente se adicionan controles y asignaciones
	de argumentos. */

//IF dw_1.rowcount() < 1 THEN RETURN
//
//SetPointer(HourGlass!)
//
//ib_borrar = True
//w_main.SetMicroHelp("Validando la eliminación...")
//
//Message.DoubleParm = 0
//
//This.TriggerEvent ("ue_validaborrar")
//
//IF Message.DoubleParm = -1 THEN RETURN
//
//istr_mant.borra		= True
//istr_mant.agrega	= False
//
//OpenWithParm(iw_mantencion, istr_mant)  // La Ventana iw_mantencion debe ser una Variable de Instancia del Tipo de
														// ventana del mantenedor de la tabla.
//
//istr_mant = Message.PowerObjectParm
//
//IF istr_mant.respuesta = 1 THEN
//	IF dw_1.DeleteRow(0) = 1 THEN
//		ib_borrar = False
//		w_main.SetMicroHelp("Borrando Registro...")
//		SetPointer(Arrow!)
//	ELSE
//		ib_borrar = False
//		MessageBox(This.Title,"No se puede borrar actual registro.")
//	END IF
//
// IF dw_1.RowCount() = 0 THEN
//		pb_eliminar.Enabled = False
//	ELSE
//		il_fila = dw_1.GetRow()
//		dw_1.SelectRow(il_fila,True)
//	END IF
//END IF
//
//istr_mant.borra	 = False
end event

event ue_guardar;IF dw_1.AcceptText() = -1 THEN RETURN

SetPointer(HourGlass!)

w_main.SetMicroHelp("Grabando información...")

Message.DoubleParm = 0

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

event ue_buscar;f_buscar(dw_1,buscar)
end event

event ue_ordenar;String ls_info

str_parms	parm

parm.string_arg[1]	= ordenar
parm.dw_arg				= dw_1

OpenWithParm(w_columna_orden, parm)

ls_info	= Message.StringParm

dw_1.SetRow(1)
dw_1.SelectRow(0,false)
dw_1.SelectRow(1,true)

RETURN
end event

event ue_recuperadatos;w_main.SetMicroHelp("Recuperando Datos...")
SetPointer(HourGlass!)
PostEvent("ue_listo")

pb_imprimir.Enabled	= False
pb_eliminar.Enabled	= False
pb_grabar.Enabled		= False
pb_insertar.Enabled	= True
end event

event ue_deshace;ib_deshace = True
TriggerEvent("ue_recuperadatos")

end event

event ue_listo;IF dw_1.RowCount() > 0 THEN
	pb_Imprimir.Enabled	=	True
	
	IF istr_mant.Solo_Consulta THEN
		pb_Eliminar.Enabled	=	False
		pb_Grabar.Enabled		=	False
		pb_Insertar.Enabled	=	False
	ELSE
		pb_Eliminar.Enabled	=	True
		pb_Grabar.Enabled		=	True
		pb_Insertar.Enabled	=	True
	END IF
ELSE
	IF istr_mant.Solo_Consulta THEN
		pb_Insertar.Enabled	=	False
	ELSE
		pb_Insertar.Enabled	=	True
	END IF
END IF

w_main.SetMicroHelp("Listo")

SetPointer(Arrow!)
end event

event ue_cerrar;Close(This)
end event

event ue_modifica;//IF dw_1.RowCount() > 0 THEN
//	istr_mant.agrega	= False
//	istr_mant.borra	= False
//
//	OpenWithParm(iw_mantencion, istr_mant)
//END IF
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

event ue_controlborrar();IF pb_Eliminar.Enabled AND pb_Eliminar.Visible THEN
	pb_Eliminar.TriggerEvent(Clicked!)
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

protected function integer wf_modifica ();if dw_1.accepttext() = -1 then return -1
if (dw_1.modifiedcount() + dw_1.deletedcount()) > 0 then return 0
return 1
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

	dw_1.ScrolltoRow(il_fila)
	dw_1.SetRow(il_fila)
	dw_1.SelectRow(0,False)
	dw_1.SelectRow(il_fila,True)
	dw_1.SetRedraw(True)
END IF
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
			Message.ReturnValue = 1 
		CASE 0
			CHOOSE CASE MessageBox("Grabar registro(s)","Desea Grabar la información ?", Question!, YesNoCancel!)
				CASE 1
					Message.DoubleParm = 0
					This.triggerevent("ue_guardar")
					IF message.doubleparm = -1 THEN Message.ReturnValue = 1
					RETURN
				CASE 3
					Message.ReturnValue = 1
					RETURN
			END CHOOSE
	END CHOOSE
END IF
end event

event open;x				= 0
y				= 0
This.Width	= dw_1.width + 540
This.Height	= 2470
im_menu		= m_principal

This.Icon									=	Gstr_apl.Icono

IF gs_Ambiente = "Windows" THEN
	This.ParentWindow().ToolBarVisible	=	True
	im_menu.Item[1].Item[6].Enabled		=	True
	im_menu.Item[7].Visible					=	False
END IF

dw_1.SetTransObject(sqlca)
dw_1.Modify("datawindow.message.title='Error '+ is_titulo")
dw_1.SetRowFocusIndicator(Hand!)
dw_1.Modify("DataWindow.Footer.Height = 110")

istr_mant.dw						=	dw_1
istr_mant.UsuarioSoloConsulta	=	f_OpcionSoloConsulta()
istr_mant.Solo_Consulta			=	istr_mant.UsuarioSoloConsulta

f_GrabaAccesoAplicacion(True, id_FechaAcceso, it_HoraAcceso, This.Title, "Acceso a Aplicación", 1)
								
/* La asignación a las siguientes variables no se hereda, debe ser adicional en ventana descendiente */
buscar	= "Código:Ncodigo,Descripción:Sconcepto"
ordenar	= "Código:codigo,Descripción:concepto"

end event

on w_mant_tabla.create
this.dw_1=create dw_1
this.st_encabe=create st_encabe
this.pb_lectura=create pb_lectura
this.pb_nuevo=create pb_nuevo
this.pb_insertar=create pb_insertar
this.pb_eliminar=create pb_eliminar
this.pb_grabar=create pb_grabar
this.pb_imprimir=create pb_imprimir
this.pb_salir=create pb_salir
this.Control[]={this.dw_1,&
this.st_encabe,&
this.pb_lectura,&
this.pb_nuevo,&
this.pb_insertar,&
this.pb_eliminar,&
this.pb_grabar,&
this.pb_imprimir,&
this.pb_salir}
end on

on w_mant_tabla.destroy
destroy(this.dw_1)
destroy(this.st_encabe)
destroy(this.pb_lectura)
destroy(this.pb_nuevo)
destroy(this.pb_insertar)
destroy(this.pb_eliminar)
destroy(this.pb_grabar)
destroy(this.pb_imprimir)
destroy(this.pb_salir)
end on

event resize;Integer		li_posic_x, li_posic_y, li_visible, &
				li_Ancho = 300, li_Alto = 245, li_Siguiente = 255

dw_1.Resize(This.WorkSpaceWidth() - 490,This.WorkSpaceHeight() - dw_1.y - 75)

dw_1.x					=	78
st_encabe.width		=	dw_1.width

IF st_encabe.Visible THEN
	li_posic_y				=	st_encabe.y
ELSE
	li_posic_y				=	dw_1.y
END IF

li_posic_x				=	This.WorkSpaceWidth() - 370

pb_lectura.x				=	li_posic_x
pb_lectura.y				=	li_posic_y
pb_lectura.width		=	li_Ancho
pb_lectura.height		=	li_Alto
li_posic_y 				+= li_Siguiente * 1.25

IF pb_nuevo.Visible THEN
	pb_nuevo.x			=	li_posic_x
	pb_nuevo.y			=	li_posic_y
	pb_nuevo.width	=	li_Ancho
	pb_nuevo.height	=	li_Alto
	li_visible++
	li_posic_y 			+= li_Siguiente
END IF

IF pb_insertar.Visible THEN
	pb_insertar.x		=	li_posic_x
	pb_insertar.y		=	li_posic_y
	pb_insertar.width	=	li_Ancho
	pb_insertar.height	=	li_Alto
	li_visible ++
	li_posic_y += li_Siguiente
END IF

IF pb_eliminar.Visible THEN
	pb_eliminar.x			=	li_posic_x
	pb_eliminar.y			=	li_posic_y
	pb_eliminar.width		=	li_Ancho
	pb_eliminar.height	=	li_Alto
	li_visible ++
	li_posic_y += li_Siguiente
END IF

IF pb_grabar.Visible THEN
	pb_grabar.x				=	li_posic_x
	pb_grabar.y				=	li_posic_y
	pb_grabar.width		=	li_Ancho
	pb_grabar.height		=	li_Alto
	li_visible ++
	li_posic_y += li_Siguiente
END IF

IF pb_imprimir.Visible THEN
	pb_imprimir.x			=	li_posic_x
	pb_imprimir.y			=	li_posic_y
	pb_imprimir.width		=	li_Ancho
	pb_imprimir.height	=	li_Alto
	li_visible ++
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
		ventana	= This.ParentWindow().GetNextSheet(ventana)
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

type dw_1 from uo_dw within w_mant_tabla
event ue_tecla pbm_dwnkey
integer x = 110
integer y = 348
integer width = 2469
integer height = 1236
integer taborder = 30
boolean border = false
boolean livescroll = true
end type

event rowfocuschanged;call super::rowfocuschanged;ib_datos_ok = True

IF rowcount() < 1 OR getrow() = 0 OR ib_borrar THEN
	ib_datos_ok = False
ELSE
	il_fila = getrow()
	This.SelectRow(0,False)
	This.SelectRow(il_fila,True)
END IF

RETURN 0
end event

event losefocus;call super::losefocus;AcceptText()

This.SelectRow(0, False)

RETURN 0
end event

event doubleclicked;call super::doubleclicked;If Row = 0 Then Return

Parent.TriggerEvent("ue_modifica")

RETURN 0
end event

event clicked;call super::clicked;IF Row > 0 THEN
	il_fila = Row
	This.SelectRow(0,False)
	This.SetRow(il_fila)
	This.SelectRow(il_fila,True)
END IF

RETURN 0
end event

event type long dwnkey(keycode key, unsignedlong keyflags);call super::dwnkey;il_fila = This.GetRow()

This.SetRedraw(False)

CHOOSE CASE key
	CASE KeyEnter!
		Parent.TriggerEvent("ue_modifica")

	CASE KeyRightArrow!, KeyLeftArrow!
		This.SetRedraw(True)
		RETURN -1
		
	CASE KeyDownArrow!, KeyUpArrow!, KeyPageUp!, KeyPageDown!, KeyEnd!, KeyHome!
		Parent.PostEvent("ue_seteafila")

END CHOOSE

This.SetRedraw(True)

RETURN 0
end event

event type long ue_seteafila(unsignedlong wparam, long lparam);call super::ue_seteafila;il_fila	= This.GetRow()

This.SelectRow(0, False)
This.SelectRow(il_fila, True)

RETURN 0
end event

event getfocus;call super::getfocus;IF il_fila > 0 THEN This.SelectRow(il_fila, True)

RETURN 0
end event

event itemfocuschanged;call super::itemfocuschanged;IF IsValid(w_main) THEN
	w_main.SetMicroHelp(dwo.Tag)
END IF
end event

type st_encabe from statictext within w_mant_tabla
integer x = 110
integer y = 64
integer width = 2473
integer height = 256
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

type pb_lectura from picturebutton within w_mant_tabla
event mousemove pbm_mousemove
string tag = "Rescatar Información"
integer x = 2866
integer y = 104
integer width = 302
integer height = 244
integer taborder = 10
boolean bringtotop = true
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

event clicked;Parent.TriggerEvent("ue_recuperadatos")
end event

type pb_nuevo from picturebutton within w_mant_tabla
event mousemove pbm_mousemove
string tag = "Limpia para Nuevos Datos"
integer x = 2871
integer y = 404
integer width = 302
integer height = 244
integer taborder = 20
boolean bringtotop = true
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
				
				CASE 2
					Message.DoubleParm	=	0
	
				CASE 3
					Message.DoubleParm	=	-1
					RETURN
			END CHOOSE
			
	END CHOOSE
END IF

dw_1.Reset()

istr_mant.Solo_Consulta	=	istr_mant.UsuarioSoloConsulta
end event

type pb_insertar from picturebutton within w_mant_tabla
event mousemove pbm_mousemove
string tag = "Ingresar Detalle"
integer x = 2866
integer y = 656
integer width = 302
integer height = 244
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string picturename = "\Repos\Resources\BTN\Signo Mas.png"
string disabledname = "\Repos\Resources\BTN\Signo Mas-bn.png"
alignment htextalign = left!
string powertiptext = "Ingresar Detalle"
long backcolor = 33543637
end type

event clicked;Parent.TriggerEvent("ue_nuevo")
end event

type pb_eliminar from picturebutton within w_mant_tabla
event mousemove pbm_mousemove
string tag = "Eliminar Detalle"
integer x = 2866
integer y = 908
integer width = 302
integer height = 248
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string picturename = "\Repos\Resources\BTN\Signo Menos.png"
string disabledname = "\Repos\Resources\BTN\Signo Menos-BN.png"
alignment htextalign = left!
string powertiptext = "Eliminar Detalle"
long backcolor = 33543637
end type

event clicked;Parent.TriggerEvent("ue_borrar")
end event

type pb_grabar from picturebutton within w_mant_tabla
event mousemove pbm_mousemove
string tag = "Grabar Información"
integer x = 2857
integer y = 1164
integer width = 302
integer height = 244
integer taborder = 60
boolean bringtotop = true
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

type pb_imprimir from picturebutton within w_mant_tabla
event mousemove pbm_mousemove
string tag = "Imprimir Información"
integer x = 2871
integer y = 1416
integer width = 302
integer height = 244
integer taborder = 70
boolean bringtotop = true
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

type pb_salir from picturebutton within w_mant_tabla
event mousemove pbm_mousemove
string tag = "Salir [Cerrar Ventana Activa]"
integer x = 2866
integer y = 1828
integer width = 302
integer height = 244
integer taborder = 80
boolean bringtotop = true
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

