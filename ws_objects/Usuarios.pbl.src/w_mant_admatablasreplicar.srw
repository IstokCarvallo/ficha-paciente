$PBExportHeader$w_mant_admatablasreplicar.srw
$PBExportComments$Mantención de Tablas a Replicar
forward
global type w_mant_admatablasreplicar from w_mant_tabla
end type
type st_1 from statictext within w_mant_admatablasreplicar
end type
type uo_selsistema from uo_seleccion_sistemas within w_mant_admatablasreplicar
end type
end forward

global type w_mant_admatablasreplicar from w_mant_tabla
integer width = 3776
integer height = 2096
string title = "TABLAS DE REPLICACION DE DATOS"
st_1 st_1
uo_selsistema uo_selsistema
end type
global w_mant_admatablasreplicar w_mant_admatablasreplicar

type variables
//w_mant_deta_replicacion_datos iw_mantencion

DataWindowChild  dw_cliente
end variables

forward prototypes
public function boolean duplicado (string as_columna, string as_valor)
end prototypes

public function boolean duplicado (string as_columna, string as_valor);Long		ll_Fila
String	ls_Tabla

ls_Tabla	=	String(dw_1.Object.tare_tabrep[il_Fila])

CHOOSE CASE as_Columna
	CASE "tare_tabrep"
		ls_Tabla	=	as_Valor
		
END CHOOSE

ll_Fila	=	dw_1.Find("tare_tabrep = '" + ls_Tabla + "'", + &
							1, dw_1.RowCount())

IF ll_Fila > 0 AND ll_Fila <> il_Fila THEN
	MessageBox("Error", "Registro ya fue ingresado anteriormente en otro Sistema.", &
					Information!, Ok!)
	RETURN True
ELSE
	RETURN False
END IF
end function

event ue_nuevo;istr_mant.borra	= False
istr_mant.agrega	= True

//OpenWithParm(iw_mantencion, istr_mant)

IF dw_1.RowCount() > 0 and pb_eliminar.Enabled = FALSE THEN
	pb_eliminar.Enabled	= TRUE
	pb_grabar.Enabled		= TRUE
END IF

dw_1.SetRow(il_fila)
dw_1.SelectRow(il_fila,True)
end event

event ue_imprimir;SetPointer(HourGlass!)

Long		fila
str_info	lstr_info

lstr_info.titulo	= "MAESTRO DE CONECTIVIDAD"
lstr_info.copias	= 1

OpenWithParm(vinf,lstr_info)

vinf.dw_1.DataObject = "dw_info_admatablasreplicar"

vinf.dw_1.SetTransObject(sqlca)

fila = vinf.dw_1.Retrieve(uo_SelSistema.Codigo)

IF fila = -1 THEN
	MessageBox( "Error en Base de Datos", "Se ha producido un error en Base " + &
					"de datos : ~n" + sqlca.SQLErrText, StopSign!, Ok!)
ELSEIF fila = 0 THEN
	MessageBox( "No Existe información", "No existe información para este informe.", &
					StopSign!, Ok!)
ELSE
	F_Membrete(vinf.dw_1)
	vinf.dw_1.Modify('DataWindow.Print.Preview = Yes')
	vinf.dw_1.Modify('DataWindow.Print.Preview.Zoom = 75')
	vinf.Visible	= True
	vinf.Enabled	= True
END IF

SetPointer(Arrow!)
end event

event ue_recuperadatos;call super::ue_recuperadatos;Long		ll_Filas

dw_1.SetRedraw(False)

ll_Filas	=	dw_1.Retrieve(uo_SelSistema.Codigo)

IF ll_Filas = -1 THEN
	F_ErrorBaseDatos(sqlca, "Lectura de Tabla Buscada")

	dw_1.SetRedraw(True)

	RETURN
ELSEIF ll_Filas > 0 THEN
//	IF AlgúnControl THEN
//		istr_Mant.Solo_Consulta	=	True
//	ELSE
		istr_Mant.Solo_Consulta	=	False
//	END IF
ELSE
	pb_Eliminar.Enabled  =	Not istr_mant.Solo_Consulta
	pb_Grabar.Enabled		=	Not istr_mant.Solo_Consulta
	pb_insertar.Enabled	=	Not istr_mant.Solo_Consulta
	pb_eliminar.Enabled	=	Not istr_mant.Solo_Consulta
		
	IF ll_Filas > 0 THEN
		pb_imprimir.Enabled	=	True
		
		dw_1.SetRow(1)
		dw_1.SelectRow(1, True)
		dw_1.SetFocus()
	END IF

	pb_insertar.SetFocus()
END IF

dw_1.SetRedraw(True)
end event

on w_mant_admatablasreplicar.create
int iCurrent
call super::create
this.st_1=create st_1
this.uo_selsistema=create uo_selsistema
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.uo_selsistema
end on

on w_mant_admatablasreplicar.destroy
call super::destroy
destroy(this.st_1)
destroy(this.uo_selsistema)
end on

event ue_borrar;IF dw_1.rowcount() < 1 THEN RETURN

SetPointer(HourGlass!)

ib_borrar = True
w_main.SetMicroHelp("Validando la eliminación...")

Message.DoubleParm = 0

This.TriggerEvent ("ue_validaborrar")

IF Message.DoubleParm = -1 THEN RETURN

istr_mant.borra	= True
istr_mant.agrega	= False

//OpenWithParm(iw_mantencion, istr_mant) 

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
	
	IF dw_1.RowCount() = 0 THEN
		pb_eliminar.Enabled = False
	ELSE
		il_fila = dw_1.GetRow()
		dw_1.SelectRow(il_fila,True)
	END IF
END IF

istr_mant.borra	 = False
end event

event ue_modifica;call super::ue_modifica;IF dw_1.RowCount() > 0 THEN
	istr_mant.agrega	= False
	istr_mant.borra	= False

	//OpenWithParm(iw_mantencion, istr_mant)
END IF
end event

type dw_1 from w_mant_tabla`dw_1 within w_mant_admatablasreplicar
integer x = 69
integer y = 340
integer width = 3301
integer height = 1392
integer taborder = 40
string dataobject = "dw_mues_admatablasreplicar"
boolean hscrollbar = true
end type

event dw_1::itemchanged;call super::itemchanged;Long		ll_fila
String	ls_Columna

ls_Columna	=	dwo.Name

CHOOSE CASE ls_Columna
	CASE "tare_tabrep"
		IF Duplicado(ls_Columna, Data) THEN
			F_RestauraValor(Row, ls_Columna, dw_1)
			
			RETURN 1
		END IF
		
END CHOOSE
end event

type st_encabe from w_mant_tabla`st_encabe within w_mant_admatablasreplicar
boolean visible = false
integer width = 3301
integer height = 212
end type

type pb_lectura from w_mant_tabla`pb_lectura within w_mant_admatablasreplicar
integer x = 3451
integer y = 156
integer taborder = 20
end type

type pb_nuevo from w_mant_tabla`pb_nuevo within w_mant_admatablasreplicar
integer x = 3447
integer y = 484
integer taborder = 30
end type

event pb_nuevo::clicked;call super::clicked;pb_insertar.Enabled	= False
pb_imprimir.Enabled	= False
pb_eliminar.Enabled	= False
pb_grabar.Enabled		= False

end event

type pb_insertar from w_mant_tabla`pb_insertar within w_mant_admatablasreplicar
integer x = 3447
integer y = 660
integer taborder = 50
end type

type pb_eliminar from w_mant_tabla`pb_eliminar within w_mant_admatablasreplicar
integer x = 3447
integer y = 828
integer taborder = 60
end type

type pb_grabar from w_mant_tabla`pb_grabar within w_mant_admatablasreplicar
integer x = 3447
integer y = 996
integer taborder = 70
end type

type pb_imprimir from w_mant_tabla`pb_imprimir within w_mant_admatablasreplicar
integer x = 3447
integer y = 1164
integer taborder = 80
end type

type pb_salir from w_mant_tabla`pb_salir within w_mant_admatablasreplicar
integer x = 3447
integer y = 1536
integer taborder = 90
end type

type st_1 from statictext within w_mant_admatablasreplicar
integer x = 242
integer y = 136
integer width = 293
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Sistema"
boolean focusrectangle = false
end type

type uo_selsistema from uo_seleccion_sistemas within w_mant_admatablasreplicar
integer x = 590
integer y = 132
integer height = 84
integer taborder = 10
boolean bringtotop = true
end type

on uo_selsistema.destroy
call uo_seleccion_sistemas::destroy
end on

