$PBExportHeader$w_maed_admasucursales.srw
$PBExportComments$mantención de Sucursales y Unidades Administrativas.
forward
global type w_maed_admasucursales from w_mant_encab_deta
end type
type dw_usuarios from datawindow within w_maed_admasucursales
end type
end forward

global type w_maed_admasucursales from w_mant_encab_deta
integer width = 3497
integer height = 2356
string title = "MANTENCION DE SUCURSALES Y UNIDADES ADMINISTRATIVAS"
string menuname = ""
event ue_validaborrar_detalle ( )
dw_usuarios dw_usuarios
end type
global w_maed_admasucursales w_maed_admasucursales

type variables
w_mant_deta_admaunidadadmini	iw_mantencion

uo_Sucursal			iuo_Sucursal
end variables

forward prototypes
public subroutine habilitaingreso (string as_columna)
end prototypes

event ue_validaborrar_detalle();Integer	li_Sucursal, li_Unidad
str_mant	lstr_mant

li_Sucursal =	dw_1.Object.adsu_codigo[il_fila]
li_Unidad	=	dw_1.Object.adun_codigo[il_fila]

IF	dw_usuarios.Retrieve(li_Sucursal, li_Unidad) > 0 THEN
	
	IF MessageBox("Atención","Existen Usuarios asociados a la Unidad Administrativa.~r~r"+&
					"Desea revisarlos",Question!,YesNo!) = 1 THEN
		lstr_mant.dw				=	dw_usuarios
		lstr_mant.Argumento[1]	=	dw_usuarios.DataObject
		lstr_mant.Argumento[2]	=	'2894'
		lstr_mant.Argumento[3]	=	'976'
		
		//OpenWithParm(w_mues_integridad,lstr_mant)
		
	END IF
	
	Message.DoubleParm = -1
	
ELSE
	IF MessageBox("Borrar Registro","Desea Borrar la Información ?", Question!, YesNo!) = 1 THEN
		Message.DoubleParm = 1
	ELSE
		Message.DoubleParm = -1
	END IF
END IF

RETURN
end event

public subroutine habilitaingreso (string as_columna);Boolean	lb_Estado = True

IF as_Columna <> "adsu_codigo" AND &
	(dw_2.Object.adsu_codigo[1] = 0 OR IsNull(dw_2.Object.adsu_codigo[1])) THEN
	lb_Estado = False
END IF
	
IF as_Columna <> "adsu_nombre" AND &
	(dw_2.Object.adsu_nombre[1] = "" OR IsNull(dw_2.Object.adsu_nombre[1])) THEN
	lb_Estado = False
END IF

pb_ins_det.Enabled = lb_Estado
end subroutine

on w_maed_admasucursales.create
int iCurrent
call super::create
this.dw_usuarios=create dw_usuarios
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_usuarios
end on

on w_maed_admasucursales.destroy
call super::destroy
destroy(this.dw_usuarios)
end on

event ue_seleccion();call super::ue_seleccion;Str_busqueda	lstr_busq

OpenWithParm(w_busc_admasucursales, lstr_busq)

lstr_busq	=	Message.PowerObjectParm

IF UpperBound(lstr_busq.Argum) > 0 THEN
	istr_mant.Argumento[1] = lstr_busq.Argum[1]
	istr_mant.Argumento[2] = lstr_busq.Argum[2]

	This.TriggerEvent("ue_recuperadatos")
ELSE
	pb_buscar.SetFocus()
END IF
end event

event ue_recuperadatos();call super::ue_recuperadatos;Long ll_fila_e, ll_fila_d, respuesta

DO
	dw_2.SetRedraw(False)
	dw_2.Reset()
	
	ll_fila_e	= dw_2.Retrieve(Integer(istr_mant.Argumento[1]))
	
	IF ll_fila_e = -1 THEN
		respuesta = MessageBox(	"Error en Base de Datos", "No es posible conectar la Base de Datos.", &
										Information!, RetryCancel!)
	ELSE
		istr_mant.Argumento[2]	=	dw_2.Object.adsu_nombre[1]
		DO
			ll_fila_d	= dw_1.Retrieve(Integer(istr_mant.Argumento[1]))

			IF ll_fila_d = -1 THEN
				respuesta = MessageBox(	"Error en Base de Datos", "No es posible conectar la Base de Datos.", &
												Information!, RetryCancel!)
			ELSE
				pb_eliminar.Enabled	= True
				pb_grabar.Enabled		= True
				pb_ins_det.Enabled	= True
			END IF
			
		IF ll_fila_d > 0 THEN
			pb_eli_det.Enabled	= True
			pb_imprimir.Enabled	= True
			dw_1.SetRow(1)
			dw_1.SelectRow(1,True)
			dw_1.SetFocus()
		ELSE
			pb_ins_det.SetFocus()				
		END IF
			
		LOOP WHILE respuesta = 1

		IF respuesta = 2 THEN Close(This)
	END IF
	dw_2.SetRedraw(True)
LOOP WHILE respuesta = 1

IF respuesta = 2 THEN Close(This)
end event

event ue_nuevo;call super::ue_nuevo;dw_2.SetColumn(1)
end event

event ue_nuevo_detalle();call super::ue_nuevo_detalle;istr_mant.Borra	=	False
istr_mant.Agrega	=	True

OpenWithParm(iw_mantencion, istr_mant)

IF dw_1.RowCount() > 0 THEN
	pb_grabar.Enabled		=	True
	pb_eli_det.Enabled	=	True
END IF

dw_1.SetRow(il_fila)
dw_1.SelectRow(il_fila, True)
end event

event open;call super::open;iuo_Sucursal	=	Create uo_Sucursal
dw_usuarios.SetTransObject(SQLCA)

buscar	=	"Código:Nadun_codigo,Nombre:Sadun_nombre,Abreviación:Sadun_abrevi"
ordenar	=	"Código:adun_codigo,Nombre:adun_nombre,Abreviación:adun_abrevi"


end event

event ue_modifica_detalle();call super::ue_modifica_detalle;IF dw_1.RowCount()>0 THEN
	istr_mant.Agrega			=	False
	istr_mant.Borra			=	False	
	
	OpenWithParm(iw_mantencion, istr_mant)
END IF
end event

event ue_borra_detalle;IF dw_1.rowcount() < 1 THEN RETURN

SetPointer(HourGlass!)

ib_borrar = True
w_main.SetMicroHelp("Validando la eliminación de detalle...")

Message.DoubleParm = 0

This.TriggerEvent ("ue_validaborrar_detalle")

IF Message.DoubleParm = -1 THEN RETURN

istr_mant.borra	= True
istr_mant.agrega	= False

OpenWithParm(iw_mantencion, istr_mant)

istr_mant = Message.PowerObjectParm

IF istr_mant.respuesta = 1 THEN
	IF dw_1.DeleteRow(0) = 1 THEN
		ib_borrar = False

		w_main.SetMicroHelp("Borrando Registro...")
		SetPointer(Arrow!)
	ELSE
		ib_borrar = False
		MessageBox(This.Title,"No se puede borrar actual registro.")
	END IF
 IF dw_1.RowCount() = 0 THEN pb_eli_det.Enabled = False
END IF

istr_mant.borra	 = False
end event

event ue_imprimir;Long		ll_Filas

istr_info.titulo	=	"INFORME DE SUCURSALES Y UNIDADES ADMINISTRATIVAS"
istr_info.copias	=	1

OpenWithParm(vinf,istr_info)
vinf.dw_1.DataObject	=	"dw_info_admaunidadadmini"
vinf.dw_1.SetTransObject(sqlca)
ll_Filas	=	vinf.dw_1.Retrieve(Integer(istr_mant.Argumento[1]), 1)

IF ll_Filas = -1 THEN
	MessageBox( "Error en Base de Datos", "Se ha producido un error en Base " + &
					"de datos : ~n" + sqlca.SQLErrText, StopSign!, Ok!)
ELSEIF ll_Filas = 0 THEN
	MessageBox( "No Existe información", "No existe información para este informe.", &
					StopSign!, Ok!)
ELSE
	F_Membrete(vinf.dw_1)
	If gs_Ambiente = 'Windows' Then
		vinf.dw_1.Modify('DataWindow.Print.Preview = Yes')
		vinf.dw_1.Modify('DataWindow.Print.Preview.Zoom = 75')
	
		vinf.Visible	=	True
		vinf.Enabled	=	True
	End If
END IF
end event

type dw_1 from w_mant_encab_deta`dw_1 within w_maed_admasucursales
integer x = 50
integer y = 844
integer width = 2368
integer height = 848
string title = "Detalle de Unidades Administrativas"
string dataobject = "dw_mues_admaunidadadmini"
end type

type dw_2 from w_mant_encab_deta`dw_2 within w_maed_admasucursales
integer x = 133
integer y = 20
integer width = 1847
integer height = 688
string dataobject = "dw_mant_admasucursal"
end type

event dw_2::itemchanged;call super::itemchanged;String	ls_Columna, ls_Nula

SetNull(ls_Nula)

ls_Columna	=	dwo.Name

CHOOSE CASE ls_Columna	
	CASE "adsu_codigo"		
		istr_mant.Argumento[1]	=	Data
		IF iuo_Sucursal.of_Existe(Integer(Data), False, sqlca) THEN
			Parent.TriggerEvent("ue_recuperadatos")
		END IF
	
	CASE "adsu_nombre"
		istr_mant.Argumento[2]	=	Data
		
END CHOOSE

HabilitaIngreso(ls_Columna)
end event

type pb_nuevo from w_mant_encab_deta`pb_nuevo within w_maed_admasucursales
integer x = 2583
integer y = 328
end type

type pb_eliminar from w_mant_encab_deta`pb_eliminar within w_maed_admasucursales
integer x = 2583
integer y = 508
end type

type pb_grabar from w_mant_encab_deta`pb_grabar within w_maed_admasucursales
integer x = 2583
integer y = 692
end type

type pb_imprimir from w_mant_encab_deta`pb_imprimir within w_maed_admasucursales
integer x = 2592
integer y = 936
end type

type pb_salir from w_mant_encab_deta`pb_salir within w_maed_admasucursales
integer x = 2574
integer y = 1140
end type

type pb_ins_det from w_mant_encab_deta`pb_ins_det within w_maed_admasucursales
integer x = 2587
integer y = 1392
end type

type pb_eli_det from w_mant_encab_deta`pb_eli_det within w_maed_admasucursales
integer x = 2560
integer y = 1632
end type

type pb_buscar from w_mant_encab_deta`pb_buscar within w_maed_admasucursales
integer x = 2583
integer y = 148
end type

type dw_usuarios from datawindow within w_maed_admasucursales
boolean visible = false
integer y = 1844
integer width = 2894
integer height = 260
integer taborder = 100
boolean bringtotop = true
string title = "none"
string dataobject = "dw_mues_admausuarios_unidadsucursal"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

