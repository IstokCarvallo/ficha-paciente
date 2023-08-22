$PBExportHeader$w_mant_mues_admausuarios.srw
forward
global type w_mant_mues_admausuarios from w_mant_directo
end type
end forward

global type w_mant_mues_admausuarios from w_mant_directo
integer width = 4585
integer height = 2204
string title = "Mantención de Usuarios"
event ue_antesgurdar ( )
event ue_validaborrar ( )
end type
global w_mant_mues_admausuarios w_mant_mues_admausuarios

type variables
DataWindowChild idwc_unidadadmini

end variables

forward prototypes
public function boolean existesucursal (integer campo)
public function boolean existeunidad (integer sucursal, integer uniadmi)
public function boolean duplicado (string campo, integer tipo)
public function boolean creausuario (long al_fila)
end prototypes

public function boolean existesucursal (integer campo); long li_suc

 		SELECT count(*)
		INTO	:li_suc
    	FROM dbo.admaunidadadmini
	 	WHERE adsu_codigo = :campo;
		
IF sqlca.SQLCode = -1 THEN
	F_ErrorBaseDatos(sqlca, "Lectura tabla AdmaUnidadAdmini")
	RETURN False
ELSEIF li_suc = 0 THEN
	MessageBox("Atención", "Código" +string(campo)+" no ha sido~r" + &
	"ingresado en tabla respectiva.~r~rIngrese o seleccione otro Número.")
	RETURN False
END IF

RETURN True
end function

public function boolean existeunidad (integer sucursal, integer uniadmi); Integer li_UAdm
 String	ls_Nombre

 		SELECT	adun_codigo, adun_nombre
			INTO 	:li_uadm,
					:ls_nombre
			FROM	dbo.admaunidadadmini
			WHERE adsu_codigo = :Sucursal
			AND   adun_codigo = :UniAdmi;
		
IF sqlca.SQLCode = -1 THEN
	F_ErrorBaseDatos(sqlca, "Lectura tabla AdmaUnidadAdmini")
	RETURN False
ELSEIF sqlca.SQLCode = 100 THEN
	MessageBox("Atención", "Código" +string(uniadmi)+" no ha sido~r" + &
	"ingresado en tabla respectiva.~r~rIngrese o seleccione otro Número.")
	RETURN False
END IF

IF (String(li_UAdm) <> "") and (not IsNull(li_UAdm)) THEN
	dw_1.object.adun_nombre[dw_1.getrow()] = ls_Nombre
END IF

RETURN True
end function

public function boolean duplicado (string campo, integer tipo);Long      ll_fila, ll_filabd = 0
String    ls_Usuario

ls_Usuario = dw_1.GetItemString(il_fila,"usua_codigo")

CHOOSE CASE tipo
	CASE 1
		ls_Usuario = campo
END CHOOSE

ll_fila = dw_1.Find("usua_codigo = '" + ls_Usuario + "'", 1, dw_1.RowCount())

  SELECT Count(*) 
    INTO :ll_filabd
    FROM dbo.admausuarios  
   WHERE usua_codigo = :ls_usuario;

ll_fila = ll_fila + ll_filabd

IF ll_fila > 0 and ll_fila <> il_fila THEN
	MessageBox("Error","Codigo de Usuario ya fue Ingresado Anteriormente",Information!, OK!)
	RETURN true
ELSE
	RETURN False
END IF

end function

public function boolean creausuario (long al_fila);String	ls_Sentencia, ls_usuario, ls_passnew
Boolean	lb_Acepta = False, lb_AutoCommit

IF SQLCA.DBMS = 'ODBC' THEN
	ls_usuario = dw_1.Object.usua_codigo[al_fila]
	ls_Sentencia	=	"GRANT CONNECT TO " + ls_usuario + " " + &
							"IDENTIFIED BY RIO; GRANT DBA, RESOURCE TO " + ls_usuario 
							
	EXECUTE IMMEDIATE :ls_Sentencia USING sqlca ;
	
	IF sqlca.SQLCode = 0 THEN
		lb_Acepta		=	True
	END IF
END IF

RETURN lb_Acepta
end function

on w_mant_mues_admausuarios.create
call super::create
end on

on w_mant_mues_admausuarios.destroy
call super::destroy
end on

event ue_recuperadatos();call super::ue_recuperadatos;Long	ll_fila, respuesta

DO
	ll_fila	= dw_1.Retrieve(0, 0)
	
	IF ll_fila	= -1 THEN
		respuesta	= MessageBox("Error en Base de Datos", "No es posible conectar la Base de Datos.", &
											Information!, RetryCancel!)
	ELSEIF ll_fila > 0 THEN
		dw_1.SetRow(1)
		dw_1.SetFocus()
		pb_imprimir.Enabled	= True
		pb_eliminar.Enabled	= True
		pb_insertar.Enabled  = True
//		pb_grabar.Enabled		= True
	ELSE
		pb_insertar.SetFocus()
	END IF
LOOP WHILE respuesta	 = 1

IF respuesta	= 2 THEN 
	Close(This)
ELSE	
	pb_insertar.Enabled = True
END IF
pb_grabar.Enabled	=	False
end event

event open;call super::open;buscar			= "Código:Nusua_codigo,Nombre:Susua_nombre"
ordenar			= "Código:usua_codigo,Nombre:usua_nombre"

pb_grabar.Enabled	=	FALSE


end event

event ue_imprimir;Long		fila
str_info	lstr_info

lstr_info.titulo	= "Mantenedor de Usuarios"
lstr_info.copias	= 1

OpenWithParm(vinf,lstr_info)
vinf.dw_1.DataObject = "dw_info_mant_admausuarios"
vinf.dw_1.SetTransObject(sqlca)
fila = vinf.dw_1.Retrieve(gstr_apl.Nombresistema)

IF fila = -1 THEN
	MessageBox( "Error en Base de Datos", "Se ha producido un error en Base " + &
					"de datos : ~n" + sqlca.SQLErrText, StopSign!, Ok!)
ELSEIF fila = 0 THEN
	MessageBox( "No Existe información", "No existe información para este informe.", StopSign!, Ok!)
ELSE
	F_Membrete(vinf.dw_1)
END IF
end event

event ue_antesguardar;Integer	li_cont
String	ls_mensaje, ls_colu[]
Long		ll_Fila	=	1
		
DO WHILE ll_Fila <= dw_1.RowCount()
	
IF Isnull(dw_1.Object.usua_codigo[ll_fila]) OR dw_1.Object.usua_codigo[ll_fila] = "" THEN
	li_cont ++
	ls_mensaje			= ls_mensaje + "~nCódigo Usuario"
	ls_colu[li_cont]	= "usua_codigo"
END IF

IF Isnull(dw_1.Object.usua_nombre[ll_fila]) OR dw_1.Object.usua_nombre[ll_fila]	= "" THEN
	li_cont ++
	ls_mensaje			= ls_mensaje + "~nNombre Usuario"
	ls_colu[li_cont]	= "usua_nombre"
END IF

IF Isnull(dw_1.Object.usua_admini[ll_fila])  THEN
	li_cont ++
	ls_mensaje			= ls_mensaje + "~nAdministrador"
	ls_colu[li_cont]	= "usua_admini"
END IF

IF li_Cont > 0 THEN
	MessageBox("Error de Consistencia", "Falta el ingreso de :" + ls_mensaje + ".", StopSign!, Ok!)
	dw_1.SetRow(ll_fila)
	dw_1.SetColumn(ls_colu[1])
	dw_1.SetFocus()
	Message.DoubleParm = -1
	Return
END IF

IF dw_1.GetItemStatus(ll_fila, 0, Primary!) = New! OR &
	dw_1.GetItemStatus(ll_fila, 0, Primary!) = NewModified! THEN
	CreaUsuario(ll_fila)
END IF
		
ll_fila++
LOOP

end event

event ue_guardar();IF dw_1.AcceptText() = -1 THEN RETURN

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

event ue_borrar;String ls_codigo , ls_codusu1, ls_codusu2, ls_codusu3, ls_codusu4, ls_usuario
Integer li_fila, li_apli1, li_apli2,li_apli3, li_apli4, li_aplica, li_sistema
		 	
li_aplica	=	Integer(gstr_apl.CodigoSistema)
					  
IF dw_1.rowcount() < 1 THEN RETURN

SetPointer(HourGlass!)
li_fila = dw_1.GetRow()
ib_borrar = True
w_main.SetMicroHelp("Validando la eliminación...")

Message.DoubleParm = 0

This.TriggerEvent ("ue_validaborrar")

IF Message.DoubleParm = -1 THEN RETURN

ls_codigo  = dw_1.Object.usua_codigo[li_fila]

IF dw_1.RowCount() = 0 THEN
	pb_eliminar.Enabled = False
ELSE
	il_fila = dw_1.GetRow()
END IF

dw_1.SetFocus()
istr_mant.borra	 = False
end event

type st_encabe from w_mant_directo`st_encabe within w_mant_mues_admausuarios
boolean visible = false
end type

type pb_nuevo from w_mant_directo`pb_nuevo within w_mant_mues_admausuarios
integer x = 4192
integer y = 408
end type

type pb_lectura from w_mant_directo`pb_lectura within w_mant_mues_admausuarios
integer x = 4192
integer y = 112
end type

type pb_eliminar from w_mant_directo`pb_eliminar within w_mant_mues_admausuarios
integer x = 4192
integer y = 768
end type

event pb_eliminar::clicked;call super::clicked;istr_mant.borra	=	TRUE

end event

type pb_insertar from w_mant_directo`pb_insertar within w_mant_mues_admausuarios
integer x = 4192
integer y = 588
end type

event pb_insertar::clicked;call super::clicked;pb_grabar.Enabled	=	True
end event

type pb_salir from w_mant_directo`pb_salir within w_mant_mues_admausuarios
integer x = 4192
integer y = 1512
end type

type pb_imprimir from w_mant_directo`pb_imprimir within w_mant_mues_admausuarios
integer x = 4192
integer y = 1128
end type

type pb_grabar from w_mant_directo`pb_grabar within w_mant_mues_admausuarios
integer x = 4192
integer y = 948
integer weight = 400
fontcharset fontcharset = ansi!
end type

type dw_1 from w_mant_directo`dw_1 within w_mant_mues_admausuarios
integer x = 87
integer y = 76
integer width = 3986
integer height = 1936
string dataobject = "dw_mues_admausuarios"
boolean maxbox = true
boolean hscrollbar = true
end type

event dw_1::buttonclicked;String li_Null,ls_Null,li_sucursal

IsNull(li_Null)
IsNull(ls_Null)

li_Sucursal = String(dw_1.GetItemNumber(dw_1.GetRow(), "adsu_codigo"))

IF li_Sucursal = "" OR IsNull(li_Sucursal) THEN
	Messagebox("Sucursal","Debe Ingresar Sucursal")
	dw_1.SetItem(dw_1.GetRow(), "adun_codigo", li_Null)
	dw_1.SetItem(dw_1.GetRow(), "adun_nombre", ls_Null)	
ELSE	
	istr_busq.argum[1]	=	li_Sucursal 
	OpenWithParm(w_busqueda_admaunidadmini,istr_busq)
	istr_busq	= Message.PowerObjectParm

	IF istr_busq.argum[1] <> "" THEN
		dw_1.SetItem(dw_1.GetRow(), "adun_codigo", Integer(istr_busq.argum[1]))
		dw_1.SetItem(dw_1.GetRow(), "adun_nombre", istr_busq.argum[2])	
	ELSE
		dw_1.SetItem(dw_1.GetRow(), "adun_codigo", li_null)
		dw_1.SetItem(dw_1.GetRow(), "adun_nombre", ls_null)
   		Return 1
	END IF
END IF	


end event

event dw_1::itemchanged;Long		ll_Null,ll_Sucursal
String	ls_Campo, ls_Null

ls_Campo =	dwo.name

SetNull(ll_Null) 
SetNull(ls_Null)

CHOOSE CASE ls_Campo
	CASE "usua_codigo"
		IF Duplicado(Data, 1) THEN
			dw_1.SetItem(il_fila, ls_Campo, ls_Null)
			dw_1.SetColumn(ls_campo)
			RETURN 1
		END IF
	
	CASE "adsu_codigo"
		IF (string(data) <> "") AND (NOT IsNull(data)) THEN
			dw_1.SetItem(il_fila, "adun_nombre", ls_Null)
			IF NOT existesucursal(integer(data)) THEN
				dw_1.SetItem(il_fila, ls_Campo, ll_Null)
				dw_1.SetColumn(ls_campo)
				RETURN 1
			END IF
		END IF
		
END CHOOSE

end event

