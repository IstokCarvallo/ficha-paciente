$PBExportHeader$w_mant_encab_deta.srw
forward
global type w_mant_encab_deta from window
end type
type dw_1 from uo_dw within w_mant_encab_deta
end type
type dw_2 from uo_dw within w_mant_encab_deta
end type
type pb_nuevo from picturebutton within w_mant_encab_deta
end type
type pb_eliminar from picturebutton within w_mant_encab_deta
end type
type pb_grabar from picturebutton within w_mant_encab_deta
end type
type pb_imprimir from picturebutton within w_mant_encab_deta
end type
type pb_salir from picturebutton within w_mant_encab_deta
end type
type pb_ins_det from picturebutton within w_mant_encab_deta
end type
type pb_eli_det from picturebutton within w_mant_encab_deta
end type
type pb_buscar from picturebutton within w_mant_encab_deta
end type
end forward

global type w_mant_encab_deta from window
integer width = 3909
integer height = 2280
boolean titlebar = true
string menuname = "m_principal"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 16777215
string icon = "AppIcon!"
integer animationtime = 400
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
event ue_borra_detalle ( )
event ue_seleccion ( )
event ue_nuevo_detalle ( )
event ue_imprimir ( )
event ue_modifica_detalle ( )
event ue_primero ( )
event ue_anterior ( )
event ue_siguiente ( )
event ue_ultimo ( )
event ue_controlnuevo ( )
event ue_controlgrabar ( )
event ue_controlbuscar ( )
event ue_controleliminar ( )
event ue_controlimprimir ( )
event ue_controlinsertar ( )
event ue_controlborrar ( )
event wf_replicacion ( )
dw_1 dw_1
dw_2 dw_2
pb_nuevo pb_nuevo
pb_eliminar pb_eliminar
pb_grabar pb_grabar
pb_imprimir pb_imprimir
pb_salir pb_salir
pb_ins_det pb_ins_det
pb_eli_det pb_eli_det
pb_buscar pb_buscar
end type
global w_mant_encab_deta w_mant_encab_deta

type variables
protected:
Long		il_fila, il_AnchoDw_1
String	buscar, ordenar, ias_campo[]
Boolean	ib_datos_ok, ib_borrar, ib_ok, ib_traer, &
			ib_deshace = true, ib_ModEncab
Date		id_FechaAcceso
Time		it_HoraAcceso

Menu		im_menu

Str_parms		istr_parms
Str_mant			istr_mant
Str_busqueda	istr_busq
Str_info			istr_info
end variables

forward prototypes
protected function integer wf_modifica ()
public subroutine wf_mueve (string movimiento)
protected function boolean wf_actualiza_db (boolean borrando)
public subroutine wf_bloqueacolumnas (boolean ab_bloquea)
public subroutine wf_replicacion ()
end prototypes

event ue_nuevo;Long		ll_modif1, ll_modif2

ib_ok	= True

istr_mant.Solo_Consulta	=	istr_mant.UsuarioSoloConsulta

IF Not istr_mant.Solo_Consulta THEN
	CHOOSE CASE wf_modifica()
		CASE -1
			ib_ok = False
		CASE 0
			ll_modif1	=	dw_1.GetNextModified(0, Primary!)
			ll_modif2	=	dw_2.GetNextModified(0, Primary!)
		
//			IF ib_ModEncab OR dw_1.GetNextModified(0, Primary!) > 0 THEN
			IF dw_1.RowCount() > 0 THEN
				CHOOSE CASE MessageBox("Grabar registro(s)","Desea Grabar la información ?", Question!, YesNoCancel!)
					CASE 1
						Message.DoubleParm = 0
						This.TriggerEvent("ue_guardar")
						IF message.DoubleParm = -1 THEN ib_ok = False
					CASE 3
						ib_ok	= False
						RETURN
				END CHOOSE
			END IF
	END CHOOSE
END IF

IF Not ib_ok THEN RETURN

dw_1.Reset()

pb_eli_det.Enabled		=	False
pb_ins_det.Enabled		=	False
pb_grabar.Enabled			=	False
pb_eliminar.Enabled		=	False
pb_imprimir.Enabled		=	False
dw_2.Enabled				=	True

dw_2.SetRedraw(False)
dw_2.Reset()
dw_2.InsertRow(0)
dw_2.SetRedraw(True)

dw_2.SetFocus()
end event

event ue_borrar;IF dw_2.RowCount() < 1 THEN RETURN

SetPointer(HourGlass!)

ib_borrar = True
w_main.SetMicroHelp("Validando la eliminación...")

Message.DoubleParm = 0

This.TriggerEvent ("ue_validaborrar")

IF Message.DoubleParm = -1 THEN RETURN

IF dw_1.RowCount() > 0 THEN dw_1.RowsMove(1,dw_1.RowCount(),Primary!,dw_1,1,Delete!)

IF dw_2.DeleteRow(0) = 1 THEN
		ib_borrar = False
		w_main.SetMicroHelp("Borrando Registro...")
		IF wf_actualiza_db(True) THEN
			w_main.SetMicroHelp("Registro Borrado...")
			This.TriggerEvent("ue_nuevo")
			SetPointer(Arrow!)
		ELSE
			w_main.SetMicroHelp("Registro no Borrado...")
		END IF			
ELSE
	ib_borrar = False
	MessageBox(This.Title,"No se puede borrar actual registro.")
END IF
end event

event ue_guardar;IF dw_1.AcceptText() = -1 THEN RETURN

SetPointer(HourGlass!)

w_main.SetMicroHelp("Grabando información...")

Message.DoubleParm = 0

TriggerEvent("ue_antesguardar")

IF Message.DoubleParm = -1 THEN RETURN

IF wf_actualiza_db(False) THEN
	w_main.SetMicroHelp("Información Grabada.")
	pb_eliminar.Enabled	= True
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

event ue_validaborrar;IF MessageBox("Borrar Registro","Desea Borrar la Información ?", Question!, YesNo!) = 1 THEN
	Message.DoubleParm = 1
ELSE
	Message.DoubleParm = -1
END IF

RETURN
end event

event ue_recuperadatos();/*En este script se debe extender el código, controlando la recuperacion de datos de dw_1 */

w_main.SetMicroHelp("Recuperando Datos...")
SetPointer(HourGlass!)
PostEvent("ue_listo")

pb_eliminar.Enabled		= False
pb_grabar.Enabled			= False
pb_eli_det.Enabled		= False
end event

event ue_deshace;ib_deshace = True
TriggerEvent("ue_recuperadatos")

end event

event ue_listo();IF dw_1.RowCount() > 0 THEN
	pb_Imprimir.Enabled	=	True
	pb_Eliminar.Enabled	=	True
	
	dw_2.Enabled			=	Not istr_mant.Solo_Consulta
	pb_Eliminar.Enabled	=	Not istr_mant.Solo_Consulta
	pb_Grabar.Enabled		=	Not istr_mant.Solo_Consulta
	pb_ins_det.Enabled	=	Not istr_mant.Solo_Consulta
	pb_eli_det.Enabled	=	Not istr_mant.Solo_Consulta
	
	wf_BloqueaColumnas(istr_mant.Solo_Consulta)
ELSE
	pb_ins_det.Enabled	=	Not istr_mant.Solo_Consulta
END IF
end event

event ue_borra_detalle;/* Este Script debe ser traspasado a la ventana descendiente, pués normalmente se adicionan controles y asignaciones
	de argumentos.*/

//IF dw_1.rowcount() < 2 THEN RETURN
//
//SetPointer(HourGlass!)
//
//ib_borrar = True
//w_main.SetMicroHelp("Validando la eliminación de detalle...")
//
//Message.DoubleParm = 0
//
//This.TriggerEvent ("ue_validaborrar_detalle")
//
//IF Message.DoubleParm = -1 THEN RETURN
//
//istr_mant.borra	= True
//istr_mant.agrega	= False
//
//OpenWithParm(iw_mantencion, istr_mant)
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
// IF dw_1.RowCount() = 0 THEN pb_eli_det.Enabled = False
//END IF
//
//istr_mant.borra	 = False
end event

event ue_seleccion;Integer	li_opcion
dwitemstatus stat

ib_ok	= True

IF dw_1.AcceptText() = -1 THEN li_opcion = -1
IF dw_2.AcceptText() = -1 THEN li_opcion = -1
IF dw_1.ModifiedCount() > 0 THEN 
	li_opcion = 1
ELSEIF dw_2.ModifiedCount() > 0 THEN
	stat = dw_2.GetItemStatus(1,0,Primary!)
	
	IF (stat = New! or stat = Newmodified!) and dw_1.RowCount() = 0 THEN 
		li_opcion = 1
	ELSE
		li_opcion = 0
	END IF
ELSE
	li_opcion = 1
END IF

CHOOSE CASE li_opcion
	CASE -1
		ib_ok = False
	CASE 0
		CHOOSE CASE MessageBox("Grabar registro(s)","Desea Grabar la información ?", Question!, YesNoCancel!)
			CASE 1
				Message.DoubleParm = 0
				This.triggerevent("ue_guardar")
				IF message.doubleparm = -1 THEN ib_ok = False
				RETURN
			CASE 3
				ib_ok	= False
				RETURN
		END CHOOSE
END CHOOSE

IF ib_ok = False THEN RETURN
end event

event ue_nuevo_detalle;/* Este Script debe ser traspasado a la ventana descendiente, pués normalmente se adicionan controles y asignaciones
	de argumentos. */
	
//istr_mant.borra			= False
//istr_mant.agrega			= True
//istr_mant.argumento[1]	= parametro de entrada
//
//OpenWithParm(w_mantencion, istr_mant)
end event

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

event ue_modifica_detalle;//IF dw_1.RowCount() > 0 THEN
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

event ue_controlnuevo();IF pb_Nuevo.Enabled AND pb_Nuevo.Visible THEN
	pb_Nuevo.TriggerEvent(Clicked!)
END IF
end event

event ue_controlgrabar();IF pb_Grabar.Enabled AND pb_Grabar.Visible THEN
	pb_Grabar.TriggerEvent(Clicked!)
END IF
end event

event ue_controlbuscar();IF pb_Buscar.Enabled AND pb_Buscar.Visible THEN
	pb_Buscar.TriggerEvent(Clicked!)
END IF
end event

event ue_controleliminar();IF pb_Eliminar.Enabled AND pb_Eliminar.Visible THEN
	pb_Eliminar.TriggerEvent(Clicked!)
END IF
end event

event ue_controlimprimir();IF pb_Imprimir.Enabled AND pb_Imprimir.Visible THEN
	pb_Imprimir.TriggerEvent(Clicked!)
END IF
end event

event ue_controlinsertar();IF pb_Ins_Det.Enabled AND pb_Ins_Det.Visible THEN
	pb_Ins_Det.TriggerEvent(Clicked!)
END IF
end event

event ue_controlborrar();IF pb_Eli_Det.Enabled AND pb_Eli_Det.Visible THEN
	pb_Eli_Det.TriggerEvent(Clicked!)
END IF
end event

protected function integer wf_modifica ();IF dw_1.AcceptText() = -1 THEN RETURN -1
IF dw_2.AcceptText() = -1 THEN RETURN -1
IF (dw_1.ModifiedCount() + dw_1.DeletedCount()) > 0 THEN RETURN 0
IF dw_2.ModifiedCount() > 0 THEN RETURN 0

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

	dw_1.ScrolltoRow(il_fila)
	dw_1.SetRow(il_fila)
	dw_1.SelectRow(0,False)
	dw_1.SelectRow(il_fila,True)
	dw_1.SetRedraw(True)
END IF
end subroutine

protected function boolean wf_actualiza_db (boolean borrando);Boolean	lb_AutoCommit, lb_Retorno
DateTime	ldt_FechaHora

ldt_FechaHora		=	F_FechaHora()
dw_1.GrupoFecha	=	ldt_FechaHora
dw_2.GrupoFecha	=	ldt_FechaHora

IF Not dw_2.uf_check_required(0) THEN RETURN False

IF Not dw_1.uf_validate(0) THEN RETURN False

lb_AutoCommit		=	sqlca.AutoCommit
sqlca.AutoCommit	=	False

wf_replicacion()

IF Borrando THEN
	IF dw_1.Update(True, False) = 1 THEN
		IF dw_2.Update(True, False) = 1 THEN
			Commit;
			
			IF sqlca.SQLCode <> 0 THEN
				F_ErrorBaseDatos(sqlca, This.Title)
				
				RollBack;
			ELSE
				lb_Retorno	=	True
				
				dw_1.ResetUpdate()
				dw_2.ResetUpdate()
			END IF
		ELSE
			F_ErrorBaseDatos(sqlca, This.Title)
			
			RollBack;
		END IF
	ELSE
		F_ErrorBaseDatos(sqlca, This.Title)
	END IF
ELSE
	IF dw_2.Update(True, False) = 1 THEN
		IF dw_1.Update(True, False) = 1 THEN
			Commit;
			
			IF sqlca.SQLCode <> 0 THEN
				F_ErrorBaseDatos(sqlca, This.Title)
				
				RollBack;
			ELSE
				lb_Retorno	=	True
				
				dw_1.ResetUpdate()
				dw_2.ResetUpdate()
			END IF
		ELSE
			F_ErrorBaseDatos(sqlca, This.Title)
			
			RollBack;
		END IF
	ELSE
		F_ErrorBaseDatos(sqlca, This.Title)
	END IF
END IF

sqlca.AutoCommit	=	lb_AutoCommit

RETURN lb_Retorno
end function

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

public subroutine wf_replicacion ();
end subroutine

event closequery;IF Not istr_mant.Solo_Consulta THEN
	CHOOSE CASE wf_modifica()
		CASE -1
			Message.ReturnValue = 1 
		CASE 0
			IF dw_1.RowCount() > 0 THEN
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
			END IF
	END CHOOSE
END IF
end event

event open;x				=	0
y				=	0
This.Height	=	2500

im_menu		=	m_principal
This.Icon									=	Gstr_apl.Icono

IF gs_Ambiente = "Windows" THEN
	This.ParentWindow().ToolBarVisible	=	True
	im_menu.Item[1].Item[6].Enabled		=	True
	im_menu.Item[7].Visible					=	False
END IF

dw_1.SetTransObject(sqlca)
dw_2.SetTransObject(sqlca)
dw_1.Modify("datawindow.message.title='Error '+ is_titulo")
dw_1.SetRowFocusIndicator(Hand!)
dw_1.Modify("DataWindow.Footer.Height = 110")

istr_mant.dw						=	dw_1
istr_mant.UsuarioSoloConsulta	=	f_OpcionSoloConsulta()
pb_nuevo.PostEvent(Clicked!)

f_GrabaAccesoAplicacion(True, id_FechaAcceso, it_HoraAcceso, This.Title, "Acceso a Aplicación", 1)
								
/* La asignación a las siguientes variables no se hereda, debe ser adicional en ventana descendiente */
buscar	= "Código:Ncodigo,Descripción:Sconcepto"
ordenar	= "Código:codigo,Descripción:concepto"
end event

on w_mant_encab_deta.create
if this.MenuName = "m_principal" then this.MenuID = create m_principal
this.dw_1=create dw_1
this.dw_2=create dw_2
this.pb_nuevo=create pb_nuevo
this.pb_eliminar=create pb_eliminar
this.pb_grabar=create pb_grabar
this.pb_imprimir=create pb_imprimir
this.pb_salir=create pb_salir
this.pb_ins_det=create pb_ins_det
this.pb_eli_det=create pb_eli_det
this.pb_buscar=create pb_buscar
this.Control[]={this.dw_1,&
this.dw_2,&
this.pb_nuevo,&
this.pb_eliminar,&
this.pb_grabar,&
this.pb_imprimir,&
this.pb_salir,&
this.pb_ins_det,&
this.pb_eli_det,&
this.pb_buscar}
end on

on w_mant_encab_deta.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.pb_nuevo)
destroy(this.pb_eliminar)
destroy(this.pb_grabar)
destroy(this.pb_imprimir)
destroy(this.pb_salir)
destroy(this.pb_ins_det)
destroy(this.pb_eli_det)
destroy(this.pb_buscar)
end on

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

event resize;Integer	maximo, li_posic_x, li_posic_y, li_visible = 0, &
			li_Ancho = 300, li_Alto = 245, li_Siguiente = 255

IF dw_2.width > il_AnchoDw_1 THEN
	maximo		=	dw_2.width
ELSE
	dw_1.width	=	This.WorkSpaceWidth() - 500
	maximo		=	dw_1.width
END IF

dw_2.x					=	37 + Round((maximo - dw_2.width) / 2, 0)
dw_2.y					=	37

dw_1.x					=	37 + Round((maximo - dw_1.width) / 2, 0)
dw_1.y					=	64 + dw_2.Height
dw_1.height				=	This.WorkSpaceHeight() - dw_1.y - 41

li_posic_x				=	This.WorkSpaceWidth() - 370
li_posic_y				=	78

IF pb_buscar.Visible THEN
	pb_buscar.x				=	li_posic_x
	pb_buscar.y				=	li_posic_y
	pb_buscar.width		=	li_Ancho
	pb_buscar.height		=	li_Alto
	li_visible ++
	li_posic_y += li_Siguiente
END IF

IF pb_nuevo.Visible THEN
	pb_nuevo.x				=	li_posic_x
	pb_nuevo.y				=	li_posic_y
	pb_nuevo.width		=	li_Ancho
	pb_nuevo.height		=	li_Alto
	li_visible ++
	li_posic_y += li_Siguiente
END IF

IF	pb_eliminar.Visible THEN
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

IF pb_salir.Visible THEN
	pb_salir.x				=	li_posic_x
	pb_salir.y				=	li_posic_y
	pb_salir.width			=	li_Ancho
	pb_salir.height		=	li_Alto
	li_visible ++
	li_posic_y += li_Siguiente
END IF

pb_eli_det.x				=	li_posic_x
pb_eli_det.y				=	dw_1.y + dw_1.Height - li_Siguiente
pb_eli_det.width		=	li_Ancho
pb_eli_det.height		=	li_Alto

pb_ins_det.x			=	li_posic_x
pb_ins_det.y			=	pb_eli_det.y - li_Siguiente - 10
pb_ins_det.width		=	li_Ancho
pb_ins_det.height		=	li_Alto
end event

event mousemove;w_main.SetMicroHelp("Ventana : " + ClassName())
end event

type dw_1 from uo_dw within w_mant_encab_deta
integer x = 114
integer y = 972
integer width = 2875
integer height = 652
integer taborder = 0
boolean titlebar = true
string title = "Detalle de "
boolean hscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;call super::clicked;IF Row > 0 THEN
	il_fila = Row
	This.SelectRow(0,False)
	This.SetRow(il_fila)
	This.SelectRow(il_fila,True)
END IF

RETURN 0
end event

event doubleclicked;call super::doubleclicked;Parent.TriggerEvent("ue_modifica_detalle")

RETURN 0
end event

event losefocus;call super::losefocus;AcceptText()

This.SelectRow(0, False)

RETURN 0
end event

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

event type long dwnkey(keycode key, unsignedlong keyflags);call super::dwnkey;il_fila = This.GetRow()

This.SetRedraw(False)

CHOOSE CASE key
	CASE KeyEnter!
		Parent.PostEvent("ue_modifica_detalle")

	CASE KeyRightArrow!, KeyLeftArrow!
		This.SetRedraw(True)
		RETURN -1
		
	CASE KeyDownArrow!, KeyUpArrow!, KeyPageUp!, KeyPageDown!, KeyEnd!, KeyHome!
		Parent.PostEvent("ue_seteafila")

END CHOOSE

This.SetRedraw(True)

RETURN 0
end event

event getfocus;call super::getfocus;IF il_fila > 0 THEN This.SelectRow(il_fila, True)

RETURN 0
end event

event type long ue_seteafila(unsignedlong wparam, long lparam);call super::ue_seteafila;il_fila	= This.GetRow()

This.SelectRow(0, False)
This.SelectRow(il_fila, True)

RETURN 0
end event

event itemfocuschanged;call super::itemfocuschanged;IF IsValid(w_main) THEN
	w_main.SetMicroHelp(dwo.Tag)
END IF
end event

event constructor;call super::constructor;il_AnchoDw_1	=	This.Width
end event

type dw_2 from uo_dw within w_mant_encab_deta
event ue_tecla pbm_dwnkey
integer x = 64
integer y = 76
integer width = 1728
integer height = 380
integer taborder = 70
boolean vscrollbar = false
boolean border = false
end type

event rowfocuschanged;ib_datos_ok = true
if rowcount() < 1 or getrow() = 0 or ib_borrar then 
	ib_datos_ok = false
else
	il_fila = getrow()
end if

RETURN 0
end event

event losefocus;call super::losefocus;AcceptText()

RETURN 0
end event

event doubleclicked;call super::doubleclicked;/* Este Script debe ser traspasado a la ventana descendiente, pués normalmente se adicionan controles y asignaciones
	de argumentos. */

//IF Row > 0 THEN
//	istr_mant.agrega = False
// istr_mant.argumento[1] = parametro de entrada
//	OpenWithParm(w_mant, istr_mant)
//END IF
//
//RETURN 0
end event

event clicked;call super::clicked;IF Row > 0 THEN
	il_fila = Row
	This.SetRow(il_fila)
END IF

RETURN 0
end event

event itemerror;RETURN 1
end event

event constructor;call super::constructor;InsertRow(0)

RETURN 0
end event

event itemchanged;//ib_ModEncab	=	True
end event

event itemfocuschanged;call super::itemfocuschanged;IF IsValid(w_main) THEN
	w_main.SetMicroHelp(dwo.Tag)
END IF
end event

type pb_nuevo from picturebutton within w_mant_encab_deta
event mousemove pbm_mousemove
string tag = "Limpia para Nuevos Datos"
integer x = 3301
integer y = 344
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
boolean map3dcolors = true
string powertiptext = "Limpia para Nuevos Datos"
long backcolor = 33543637
end type

event clicked;Parent.TriggerEvent("ue_nuevo")
end event

type pb_eliminar from picturebutton within w_mant_encab_deta
event mousemove pbm_mousemove
string tag = "Eliminar Información"
integer x = 3301
integer y = 600
integer width = 302
integer height = 244
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string picturename = "\Repos\Resources\BTN\Basura.png"
string disabledname = "\Repos\Resources\BTN\Basura-bn.png"
alignment htextalign = left!
boolean map3dcolors = true
string powertiptext = "Eliminar Información"
long backcolor = 33543637
end type

event clicked;Parent.TriggerEvent("ue_borrar")
end event

type pb_grabar from picturebutton within w_mant_encab_deta
event mousemove pbm_mousemove
string tag = "Grabar Información"
integer x = 3301
integer y = 856
integer width = 302
integer height = 256
integer taborder = 40
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
boolean map3dcolors = true
string powertiptext = "Grabar Información"
long backcolor = 33543637
end type

event clicked;Parent.TriggerEvent("ue_guardar")
end event

type pb_imprimir from picturebutton within w_mant_encab_deta
event mousemove pbm_mousemove
string tag = "Imprimir información"
integer x = 3136
integer y = 1048
integer width = 302
integer height = 244
integer taborder = 50
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
boolean map3dcolors = true
string powertiptext = "Imprimir información"
long backcolor = 33543637
end type

event clicked;Parent.TriggerEvent("ue_imprimir")
end event

type pb_salir from picturebutton within w_mant_encab_deta
event mousemove pbm_mousemove
string tag = "Salir (Cerrar Ventana Activa)"
integer x = 3296
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
boolean cancel = true
string picturename = "\Repos\Resources\BTN\Apagar.png"
string disabledname = "\Repos\Resources\BTN\Apagar-bn.png"
alignment htextalign = left!
boolean map3dcolors = true
string powertiptext = "Salir [Cerrar Ventana Activa]"
long backcolor = 33543637
end type

event clicked;Close(Parent)
end event

type pb_ins_det from picturebutton within w_mant_encab_deta
event mousemove pbm_mousemove
string tag = "Ingresar Detalle"
integer x = 3305
integer y = 1500
integer width = 302
integer height = 244
integer taborder = 80
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
boolean map3dcolors = true
string powertiptext = "Ingresar Detalle"
long backcolor = 33543637
end type

event clicked;Parent.TriggerEvent("ue_nuevo_detalle")
end event

type pb_eli_det from picturebutton within w_mant_encab_deta
event mousemove pbm_mousemove
string tag = "Eliminar Detalle"
integer x = 3305
integer y = 1756
integer width = 302
integer height = 244
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string picturename = "\Repos\Resources\BTN\Signo Menos.png"
string disabledname = "\Repos\Resources\BTN\Signo Menos-bn.png"
alignment htextalign = left!
boolean map3dcolors = true
string powertiptext = "Eliminar Detalle"
long backcolor = 33543637
end type

event clicked;Parent.TriggerEvent("ue_borra_detalle")
end event

type pb_buscar from picturebutton within w_mant_encab_deta
event mousemove pbm_mousemove
string tag = "Buscar Información"
integer x = 3296
integer y = 88
integer width = 302
integer height = 244
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\Repos\Resources\BTN\Busqueda.png"
string disabledname = "\Repos\Resources\BTN\Busqueda-bn.png"
alignment htextalign = left!
boolean map3dcolors = true
string powertiptext = "Buscar Información"
long textcolor = 16777215
long backcolor = 33543637
end type

event clicked;Parent.TriggerEvent("ue_seleccion")
end event

