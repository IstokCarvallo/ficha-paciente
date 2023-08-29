$PBExportHeader$w_maed_admagruposistemas.srw
$PBExportComments$Ventana de mantencion de grupos y usuarios.
forward
global type w_maed_admagruposistemas from w_mant_encab_deta
end type
end forward

global type w_maed_admagruposistemas from w_mant_encab_deta
integer width = 2967
integer height = 1968
string title = "MANTENCION DE GRUPOS Y USUARIOS"
string menuname = ""
event ue_validaborrar_detalle ( )
end type
global w_maed_admagruposistemas w_maed_admagruposistemas

type variables
w_mant_deta_admagrupos	iw_mantencion

DataStore	ids_AdmaAplicacces, ids_AdmaUsuarOpcio
end variables

forward prototypes
protected function boolean wf_actualiza_db (boolean borrando)
public function boolean duplicado (string data)
public function boolean existegrupo (string as_grupo)
public subroutine habilitaencab (boolean habilita)
public subroutine habilitaingreso (string as_columna)
public function boolean noexistegrupo (string as_columna, string as_valor)
public subroutine elimgrupousuario (string usuario, integer codaplica)
end prototypes

event ue_validaborrar_detalle();Long		ll_Fila
String	ls_Codigo

ls_Codigo	=	dw_1.Object.usua_codigo[il_fila]
ll_Fila		=	ids_AdmaUsuarOpcio.Retrieve(gstr_apl.CodigoSistema,ls_Codigo)

IF ll_Fila > 0 THEN
	ids_AdmaUsuarOpcio.RowsMove(1,ll_Fila, Primary!, ids_AdmaUsuarOpcio, 0, Delete!)
END IF

ll_Fila	=	ids_AdmaAplicacces.Retrieve(gstr_apl.CodigoSistema,ls_Codigo)

IF ll_Fila > 0 THEN
	IF MessageBox("Atención","Usuario registra accesos a Aplicaciones.~r~r" + &
		"¿Desea Continuar con Eliminación?", Question!, YesNo!) = 1 THEN
		
		ids_AdmaAplicacces.RowsMove(1,ll_Fila, Primary!, ids_AdmaAplicacces, 0, Delete!)
	ELSE
		Message.DoubleParm = -1
	END IF
END IF
end event

protected function boolean wf_actualiza_db (boolean borrando);Boolean	lb_AutoCommit, lb_Retorno

IF Not dw_2.uf_check_required(0) THEN RETURN False

IF Not dw_1.uf_validate(0) THEN RETURN False

lb_AutoCommit		=	sqlca.AutoCommit
sqlca.AutoCommit	=	False

IF Borrando THEN
	IF ids_AdmaAplicacces.Update(True, False) = -1 THEN
		F_ErrorBaseDatos(sqlca, This.Title)
	ELSEIF ids_AdmaUsuarOpcio.Update(True, False) = -1 THEN
		F_ErrorBaseDatos(sqlca, This.Title)
	ELSEIF dw_1.Update(True, False) = -1 THEN
		F_ErrorBaseDatos(sqlca, This.Title)
	ELSEIF dw_2.Update(True, False) = -1 THEN
		F_ErrorBaseDatos(sqlca, This.Title)
		
		RollBack;
	ELSE
		Commit;
		
		IF sqlca.SQLCode <> 0 THEN
			F_ErrorBaseDatos(sqlca, This.Title)
		ELSE
			lb_Retorno	=	True
			
			dw_2.ResetUpdate()
			dw_1.ResetUpdate()
			ids_AdmaUsuarOpcio.ResetUpdate()
			ids_AdmaAplicacces.ResetUpdate()
		END IF
	END IF
ELSE
	IF ids_AdmaUsuarOpcio.Update(True, False) = -1 THEN
		F_ErrorBaseDatos(sqlca, This.Title)
	ELSEIF ids_AdmaAplicacces.Update(True, False) = -1 THEN
		F_ErrorBaseDatos(sqlca, This.Title)
	ELSEIF dw_2.Update(True, False) = -1 THEN
		F_ErrorBaseDatos(sqlca, This.Title)
	ELSEIF dw_1.Update(True, False) = -1 THEN
		F_ErrorBaseDatos(sqlca, This.Title)
		
		RollBack;
	ELSE
		Commit;
		
		IF sqlca.SQLCode <> 0 THEN
			F_ErrorBaseDatos(sqlca, This.Title)
		ELSE
			lb_Retorno	=	True
			
			dw_2.ResetUpdate()
			dw_1.ResetUpdate()
			ids_AdmaUsuarOpcio.ResetUpdate()
			ids_AdmaAplicacces.ResetUpdate()
		END IF
	END IF
END IF

sqlca.AutoCommit	=	lb_AutoCommit

RETURN lb_Retorno
end function

public function boolean duplicado (string data);Integer li_grupo, li_Contador
string ls_nombre

li_grupo = Integer(data)		

SELECT	Count(*)
	INTO	:li_Contador
	FROM	dbo.grupousuario
	WHERE	grpo_codigo	=	:li_grupo;

IF sqlca.sqlcode = -1 THEN
	F_ErrorBaseDatos(sqlca,"No se pudo leer la tabla admagruposuario")
ELSEIF li_Contador = 0 THEN
	RETURN FALSE
ELSE
	RETURN TRUE
END IF
end function

public function boolean existegrupo (string as_grupo);Integer	li_Grupo
String	ls_Nombre

li_Grupo	=	Integer(as_Grupo)

SELECT	grpo_nombre
	INTO	:ls_Nombre
	FROM	dbo.gruposistema
	WHERE	sist_codigo =	:gstr_apl.CodigoSistema
	AND 	grpo_codigo	=	:li_Grupo ;

IF sqlca.SQLCode = -1 THEN
	F_ErrorBaseDatos(sqlca,"No se pudo leer la tabla Grupousuario")
	RETURN True
ELSEIF sqlca.SQLCode = 100 THEN
	RETURN False
ELSE
	istr_mant.argumento[1]	=	String(gstr_apl.CodigoSistema)
	istr_mant.Argumento[2]	=	as_Grupo
	istr_mant.Argumento[3]	=	ls_Nombre
	istr_mant.argumento[4]	=	gstr_apl.NombreSistema
	HabilitaEncab(false)
	
	TriggerEvent("ue_recuperadatos")	
	
	RETURN True
END IF
end function

public subroutine habilitaencab (boolean habilita);IF habilita THEN
	dw_2.Object.grpo_codigo.Protect					=	0
	dw_2.Object.grpo_nombre.Protect					=	0
ELSE
	dw_2.Object.grpo_codigo.Protect					=	1
	dw_2.Object.grpo_nombre.Protect					=	1
END IF
end subroutine

public subroutine habilitaingreso (string as_columna);Boolean	lb_Estado = True
long ll_fila

ll_fila = dw_2.getrow()

IF as_Columna <> "sist_codigo" AND &
	(dw_2.Object.sist_codigo[ll_fila] = 0 OR IsNull(dw_2.Object.sist_codigo[ll_fila])) THEN
	lb_Estado = False
END IF
	
IF as_Columna <> "grpo_codigo" AND &
	(dw_2.Object.grpo_codigo[ll_Fila] = 0 OR IsNull(dw_2.Object.grpo_codigo[ll_fila])) THEN
	lb_Estado = False
END IF

IF as_Columna <> "grpo_nombre" AND &
	(dw_2.Object.grpo_nombre[ll_Fila] = "" OR IsNull(dw_2.Object.grpo_nombre[ll_fila])) THEN
	lb_Estado = False
END IF

pb_ins_det.Enabled = lb_Estado
end subroutine

public function boolean noexistegrupo (string as_columna, string as_valor);Integer li_Contador, li_Grupo

li_Grupo	=	dw_2.Object.grpo_codigo[1]

CHOOSE CASE as_Columna
	CASE "grpo_codigo"
		li_Grupo	=	Integer(as_Valor)
		
END CHOOSE

SELECT	Count(*)
	INTO	:li_Contador
	FROM	dbo.grupousuario
	WHERE	grpo_codigo	=	:li_Grupo;

IF sqlca.sqlcode = -1 THEN
	F_ErrorBaseDatos(sqlca,"No se pudo leer la tabla Grupousuario")
	RETURN True
ELSEIF li_Contador = 0 THEN
	RETURN True
ELSE	
	istr_mant.argumento[1] = as_Valor
	TriggerEvent("ue_recuperadatos")	
	RETURN False
END IF
end function

public subroutine elimgrupousuario (string usuario, integer codaplica);String	ls_codigo,  ls_codusu4, ls_usuario
Integer	li_sistema, Respuesta

ls_usuario	=	usuario
li_sistema	=	CodAplica	


SELECT usua_codigo
 INTO :ls_codusu4
 FROM dbo.admaaplicacces
 WHERE usua_codigo   = 	:ls_usuario;

IF MessageBox("Eliminación de Registro", "Está seguro de Eliminar este Registro", Question!, YesNo!) = 1 THEN

	IF ls_codusu4 <> '' THEN
	
		IF	MessageBox("Eliminación de registro","El Usuario ha realizado movimientos en el Sistema.~r" + &
							"¿Está Seguro de Eliminar este Registro?", Question!, YesNo!, 2)	= 1 THEN 
			respuesta = 1
		ELSE
			respuesta = 0				
		END IF
	ELSE
		respuesta = 1 
	END IF

	IF Respuesta = 1 THEN
//		
//			DELETE
//			 FROM dbo.admagrupousuario 
//			 WHERE usua_codigo	= 	:ls_usuario;
			
//			DELETE
//			 FROM dbo.admausuaropcio 
//			 WHERE usua_codigo 	= 	:ls_usuario;
//			 
//			DELETE
//			 FROM dbo.admatipoadmiusua 
//			 WHERE usua_codigo   = 	:ls_usuario;
//			
//			DELETE
//			 FROM dbo.admaaplicacces
//			 WHERE usua_codigo   = 	:ls_usuario;
	END IF
END IF			
end subroutine

on w_maed_admagruposistemas.create
call super::create
end on

on w_maed_admagruposistemas.destroy
call super::destroy
end on

event ue_seleccion();call super::ue_seleccion;istr_busq.argum[3]	=	String(gstr_apl.CodigoSistema)


OpenWithParm(w_busc_admagruposistema, istr_busq)

istr_busq	=	Message.PowerObjectParm

IF istr_busq.argum[2] <> "" THEN
	istr_mant.argumento[1]	=	istr_busq.argum[3]
	istr_mant.argumento[2]	=	istr_busq.argum[1]
	istr_mant.argumento[3]	=	istr_busq.argum[2]

	This.TriggerEvent("ue_recuperadatos")
ELSE
	pb_buscar.SetFocus()
END IF
end event

event ue_recuperadatos;call super::ue_recuperadatos;Long ll_fila_e, ll_fila_d, respuesta

DO
	dw_2.SetRedraw(False)
	dw_2.Reset()
	
	ll_fila_e	= dw_2.Retrieve(Integer(istr_mant.argumento[1]), Integer(istr_mant.argumento[2]))
	
	IF ll_fila_e = -1 THEN
		respuesta = MessageBox(	"Error en Base de Datos", "No es posible conectar la Base de Datos.", &
										Information!, RetryCancel!)
	ELSE
		DO
			ll_fila_d	= dw_1.Retrieve(Integer(istr_mant.argumento[1]), &
												Integer(istr_mant.argumento[2]))

			IF ll_fila_d = -1 THEN
				respuesta = MessageBox(	"Error en Base de Datos", "No es posible conectar la Base de Datos.", &
												Information!, RetryCancel!)
			ELSE
				pb_eliminar.Enabled	=	True
				pb_grabar.Enabled		=	True
				pb_ins_det.Enabled	=	True
			END IF
			
		IF ll_fila_d > 0 THEN
			pb_eli_det.Enabled	=	True
			pb_imprimir.Enabled	=	True
			HabilitaEncab(false)
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

event ue_nuevo;call super::ue_nuevo;string ls_Null
SetNull(ls_Null)

ids_AdmaAplicacces.Reset()
ids_AdmaUsuarOpcio.Reset()

habilitaEncab(true)
istr_mant.argumento[1]							=	String(gstr_apl.CodigoSistema)
istr_mant.argumento[4]							=	gstr_apl.NombreSistema
dw_2.object.sist_codigo[dw_2.GetRow()]	=	gstr_apl.CodigoSistema
dw_2.object.sist_nombre[dw_2.GetRow()]	=	gstr_apl.NombreSistema

dw_2.SetColumn(1)

end event

event ue_nuevo_detalle;call super::ue_nuevo_detalle;istr_mant.Borra			=	False
istr_mant.Agrega		=	True

OpenWithParm(iw_mantencion, istr_mant)

IF dw_1.RowCount() > 0 THEN
	pb_grabar.Enabled		=	True
	pb_eli_det.Enabled	=	True
END IF

dw_1.SetRow(il_fila)
dw_1.SelectRow(il_fila,True)

end event

event open;call super::open;ids_AdmaAplicacces	=	Create DataStore
ids_AdmaUsuarOpcio	=	Create DataStore

ids_AdmaAplicacces.DataObject	=	'dw_mues_admaaplicacces_update'
ids_AdmaUsuarOpcio.DataObject	=	'dw_mues_admausuaropcio_update'

ids_AdmaAplicacces.SetTransObject(SQLca)
ids_AdmaUsuarOpcio.SetTransObject(SQLca)

buscar	= "Codigo:grpo_codigo,Nombre:grpo_Nombre"
ordenar	= "Codigo:grpo_codigo,Nombre:grpo_codigo"

dw_2.setfocus()
end event

event ue_modifica_detalle();call super::ue_modifica_detalle;IF dw_1.RowCount()>0 THEN
	istr_mant.Agrega 			=	False
	istr_mant.Borra 			=	False	
	istr_mant.argumento[2]	=	String(dw_1.Object.grpo_codigo[il_Fila])
	istr_mant.argumento[4]	=	String(dw_1.Object.sist_nombre[il_Fila])
	
 	OpenWithParm(iw_mantencion,istr_mant)
END IF
end event

event ue_borra_detalle;Long	ll_fila

IF dw_1.rowcount() < 1 THEN RETURN

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
		ll_fila = dw_1.GetRow()
		dw_1.SetRow(ll_fila)
		dw_1.SelectRow(ll_fila, True)		
	ELSE
		ib_borrar = False
		MessageBox(This.Title,"No se puede borrar actual registro.")
	END IF
 IF dw_1.RowCount() = 0 THEN pb_eli_det.Enabled = False
END IF

istr_mant.borra	 = False
end event

event ue_imprimir;Long		fila

istr_info.titulo	=	"INFORME DE GRUPOS Y USUARIOS"
istr_info.copias	=	1

OpenWithParm(vinf,istr_info)
vinf.dw_1.DataObject	=	"dw_info_usuariosistema"
vinf.dw_1.SetTransObject(sqlca)
fila	=	vinf.dw_1.Retrieve(gstr_apl.CodigoSistema)

IF fila	=	-1 THEN
	MessageBox( "Error en Base de Datos", "Se ha producido un error en Base " + &
					"de datos : ~n" + sqlca.SQLErrText, StopSign!, Ok!)
ELSEIF fila	=	0 THEN
	MessageBox( "No Existe información", "No existe información para este informe.", StopSign!, Ok!)
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

event ue_guardar();IF dw_1.AcceptText() = -1 THEN RETURN
IF ids_AdmaAplicacces.AcceptText() = -1 THEN RETURN
IF ids_AdmaUsuarOpcio.AcceptText() = -1 THEN RETURN

SetPointer(HourGlass!)

w_main.SetMicroHelp("Grabando información...")

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

type dw_1 from w_mant_encab_deta`dw_1 within w_maed_admagruposistemas
integer x = 183
integer y = 832
integer width = 2235
integer height = 848
string title = "Detalle de Usuarios"
string dataobject = "dw_mues_admagrupousuario"
end type

type dw_2 from w_mant_encab_deta`dw_2 within w_maed_admagruposistemas
integer x = 306
integer y = 48
integer width = 1952
integer height = 672
string dataobject = "dw_mant_admagruposistema"
end type

event dw_2::itemchanged;call super::itemchanged;String	ls_Columna, ls_Nula

SetNull(ls_Nula)

ls_Columna	=	dwo.Name

CHOOSE CASE ls_Columna	
	CASE "sist_codigo"	
		istr_mant.Argumento[1]	=	Data
	
	CASE "grpo_codigo"
		existegrupo(data)
		istr_mant.Argumento[2]	=	Data

	CASE "grpo_nombre"
		istr_mant.Argumento[3]	=	Data
END CHOOSE

HabilitaIngreso(ls_Columna)

		
		



end event

type pb_nuevo from w_mant_encab_deta`pb_nuevo within w_maed_admagruposistemas
integer x = 2583
integer y = 328
end type

type pb_eliminar from w_mant_encab_deta`pb_eliminar within w_maed_admagruposistemas
integer x = 2583
integer y = 508
end type

type pb_grabar from w_mant_encab_deta`pb_grabar within w_maed_admagruposistemas
integer x = 2583
integer y = 692
end type

type pb_imprimir from w_mant_encab_deta`pb_imprimir within w_maed_admagruposistemas
integer x = 2583
integer y = 868
end type

type pb_salir from w_mant_encab_deta`pb_salir within w_maed_admagruposistemas
integer x = 2583
integer y = 1048
end type

type pb_ins_det from w_mant_encab_deta`pb_ins_det within w_maed_admagruposistemas
integer x = 2587
integer y = 1340
end type

type pb_eli_det from w_mant_encab_deta`pb_eli_det within w_maed_admagruposistemas
integer x = 2587
integer y = 1512
end type

type pb_buscar from w_mant_encab_deta`pb_buscar within w_maed_admagruposistemas
integer x = 2583
integer y = 148
end type

