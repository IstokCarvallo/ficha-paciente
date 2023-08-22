$PBExportHeader$w_mant_deta_admaunidadadmini.srw
$PBExportComments$Mantención de Detalle Unidades Administrativas.
forward
global type w_mant_deta_admaunidadadmini from w_mant_detalle
end type
end forward

global type w_mant_deta_admaunidadadmini from w_mant_detalle
integer width = 2715
integer height = 1072
end type
global w_mant_deta_admaunidadadmini w_mant_deta_admaunidadadmini

forward prototypes
public function boolean duplicado (integer ai_codigo)
end prototypes

public function boolean duplicado (integer ai_codigo);Integer 	li_Contador, li_Sucursal
Boolean	lb_Retorno = True

li_Sucursal	=	Integer(istr_mant.Argumento[1])

SELECT	Count(*)
	INTO	:li_Contador
	FROM	dbo.admaunidadadmini
	WHERE	adsu_codigo	=	:li_Sucursal
	AND	adun_codigo	=	:ai_Codigo;

IF sqlca.SQLCode = -1 THEN
	F_ErrorBaseDatos(sqlca, "Lectura de Tabla admaunidadadmini")
ELSEIF li_Contador > 0 THEN
	MessageBox("Atención","Unidad Administrativa ya fue~r" + &
					"Registrada para Sucursal " + Trim(istr_mant.Argumento[2]) + "~r~rIngrese otro Código.")
ELSE
	lb_Retorno	=	False
END IF

RETURN lb_Retorno
end function

on w_mant_deta_admaunidadadmini.create
call super::create
end on

on w_mant_deta_admaunidadadmini.destroy
call super::destroy
end on

event ue_recuperadatos();call super::ue_recuperadatos;ias_Campo[1]	=	String(dw_1.Object.adun_codigo[il_Fila])
ias_Campo[2]	=	dw_1.Object.adun_nombre[il_Fila]
ias_Campo[3]	=	dw_1.Object.adun_abrevi[il_Fila]

IF istr_mant.Agrega THEN
	dw_1.Object.adsu_codigo[il_Fila]	=	Integer(istr_mant.Argumento[1])
	dw_1.Object.adsu_nombre[il_Fila]	=	istr_mant.Argumento[2]
END IF
end event

event ue_nuevo();call super::ue_nuevo;dw_1.Object.adsu_codigo[il_Fila]	=	Integer(istr_mant.Argumento[1])
dw_1.Object.adsu_nombre[il_Fila]	=	istr_mant.Argumento[2]
end event

event ue_antesguardar();call super::ue_antesguardar;Integer	li_Contador
String	ls_Mensaje, ls_Columna[]

IF IsNull(dw_1.Object.adun_codigo[il_Fila]) OR &
	dw_1.Object.adun_codigo[il_Fila] = 0 THEN
	li_Contador ++
	ls_Mensaje 					+=	"~nCódigo de Unidad"
	ls_Columna[li_Contador]	=	"adun_codigo"
END IF

IF IsNull(dw_1.Object.adun_nombre[il_Fila]) OR &
	dw_1.Object.adun_nombre[il_Fila] = "" THEN
	li_Contador ++
	ls_Mensaje 					+=	"~nNombre de Unidad"
	ls_Columna[li_Contador]	=	"adun_nombre"
END IF

IF IsNull(dw_1.Object.adun_abrevi[il_Fila]) OR &
	dw_1.Object.adun_abrevi[il_Fila] = "" THEN
	li_Contador ++
	ls_Mensaje 					+=	"~nAbreviación de Unidad"
	ls_Columna[li_Contador]	=	"adun_abrevi"
END IF

IF li_Contador > 0 THEN
	MessageBox("Error de Consistencia", "Falta el ingreso de :" + ls_Mensaje + ".", StopSign!, Ok!)
	dw_1.SetColumn(ls_Columna[1])
	dw_1.SetFocus()
	Message.DoubleParm = -1
END IF
end event

type pb_ultimo from w_mant_detalle`pb_ultimo within w_mant_deta_admaunidadadmini
integer x = 325
end type

type pb_siguiente from w_mant_detalle`pb_siguiente within w_mant_deta_admaunidadadmini
integer x = 242
end type

type pb_anterior from w_mant_detalle`pb_anterior within w_mant_deta_admaunidadadmini
integer x = 160
end type

type pb_primero from w_mant_detalle`pb_primero within w_mant_deta_admaunidadadmini
end type

type pb_cancela from w_mant_detalle`pb_cancela within w_mant_deta_admaunidadadmini
integer x = 2290
integer y = 468
end type

type pb_acepta from w_mant_detalle`pb_acepta within w_mant_deta_admaunidadadmini
integer x = 2290
integer y = 288
end type

type pb_salir from w_mant_detalle`pb_salir within w_mant_deta_admaunidadadmini
integer x = 2290
integer y = 648
end type

type dw_1 from w_mant_detalle`dw_1 within w_mant_deta_admaunidadadmini
integer x = 101
integer y = 104
integer width = 2066
integer height = 808
string dataobject = "dw_mant_admaunidadadmini"
end type

event dw_1::itemchanged;call super::itemchanged;String	ls_Columna, ls_nula

SetNull(ls_Nula)

ls_Columna	=	dwo.name

CHOOSE CASE ls_Columna
	CASE "adun_codigo"
		IF Duplicado(Integer(Data)) Then
			This.SetItem(il_fila, ls_Columna, Integer(ls_Nula))
			RETURN 1
		END IF
		
END CHOOSE
end event

