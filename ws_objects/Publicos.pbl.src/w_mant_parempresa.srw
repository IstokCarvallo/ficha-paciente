$PBExportHeader$w_mant_parempresa.srw
forward
global type w_mant_parempresa from w_mant_tabla
end type
end forward

global type w_mant_parempresa from w_mant_tabla
integer width = 3118
integer height = 1560
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
end type
global w_mant_parempresa w_mant_parempresa

type variables
String	is_rut, is_rutleg
end variables

forward prototypes
public subroutine wf_cargaparametros ()
end prototypes

public subroutine wf_cargaparametros ();gstr_apl.razon_social		=	dw_1.Object.empr_razsoc[1]
gstr_apl.nom_empresa	=	dw_1.Object.empr_nombre[1]
gstr_apl.rut_empresa		=	dw_1.Object.empr_rutemp[1]
gstr_apl.dir_empresa		=	dw_1.Object.empr_direcc[1]
gstr_apl.com_empresa	=	dw_1.Object.empr_comuna[1]
gstr_apl.ciu_empresa		=	dw_1.Object.empr_ciudad[1]
gstr_apl.gir_empresa		=	dw_1.Object.empr_giroem[1]
gstr_apl.tel_empresa		=	dw_1.Object.empr_nrotel[1]
gstr_apl.rep_legal			=	dw_1.Object.empr_repleg[1]
gstr_apl.rut_replegal		=	dw_1.Object.empr_rutrle[1]
gstr_apl.Oficina				=	dw_1.Object.empr_oficin[1]
end subroutine

event open;Long ll_Fila

x				= 0
y				= 0
im_menu		= m_principal

This.Icon									=	Gstr_apl.Icono
dw_1.SetTransObject(sqlca)

dw_1.Modify("datawindow.message.title='Error '+ is_titulo")
istr_mant.dw	= dw_1

TriggerEvent("ue_validapassword")

If dw_1.Retrieve() = 0 Then dw_1.InsertRow(0)

is_rutleg	=	dw_1.Object.empr_rutrle[1]

f_GrabaAccesoAplicacion(True, id_FechaAcceso, it_HoraAcceso, This.Title, "Acceso a Aplicación", 1)

end event

on w_mant_parempresa.create
call super::create
end on

on w_mant_parempresa.destroy
call super::destroy
end on

type dw_1 from w_mant_tabla`dw_1 within w_mant_parempresa
integer x = 64
integer y = 80
integer width = 2487
integer height = 1300
integer taborder = 20
string dataobject = "dw_mant_parempresa"
boolean vscrollbar = false
boolean livescroll = false
end type

event dw_1::clicked;//
end event

event dw_1::rowfocuschanged;//
end event

event dw_1::getfocus;//
end event

event dw_1::doubleclicked;//
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;IF is_rut <> "" THEN
	IF dwo.Name = "empr_rutemp" THEN

		IF is_rut <> "" THEN
			This.SetItem(1, "empr_rutemp", String(Double(Mid(is_rut, 1, 9)), "#########") + Mid(is_rut, 10))
		END IF
	ELSE
		This.SetItem(1, "empr_rutemp", is_rut)
	END IF
END IF

IF is_rutleg <> "" THEN
	IF dwo.Name = "empr_rutrle" THEN

		IF is_rutleg <> "" THEN
			This.SetItem(1, "empr_rutrle", String(Double(Mid(is_rutleg, 1, 9)), "#########") + Mid(is_rutleg, 10))
		END IF
	ELSE
		This.SetItem(1, "empr_rutrle", is_rutleg)
	END IF
END IF
end event

event dw_1::itemchanged;call super::itemchanged;String	ls_Null

SetNull(ls_Null)

CHOOSE CASE dwo.Name
			
	CASE "empr_rutemp"
		is_rut = F_verrut(data, True)
		
		IF is_rut = ""  THEN
			This.SetItem(1, "empr_rutemp", ls_Null)
			RETURN 1
		END IF

	CASE "empr_rutrle"
		is_rutleg = F_verrut(data, True)
		
		IF is_rutleg = ""  THEN
			This.SetItem(1, "empr_rutrle", ls_Null)
			RETURN 1
		END IF
		
END CHOOSE

end event

type st_encabe from w_mant_tabla`st_encabe within w_mant_parempresa
boolean visible = false
integer x = 142
integer y = 160
integer width = 2359
end type

type pb_lectura from w_mant_tabla`pb_lectura within w_mant_parempresa
boolean visible = false
integer x = 3643
integer y = 128
integer taborder = 0
end type

type pb_nuevo from w_mant_tabla`pb_nuevo within w_mant_parempresa
boolean visible = false
integer x = 3639
integer taborder = 0
end type

type pb_insertar from w_mant_tabla`pb_insertar within w_mant_parempresa
boolean visible = false
integer x = 3639
integer y = 604
integer taborder = 0
end type

type pb_eliminar from w_mant_tabla`pb_eliminar within w_mant_parempresa
boolean visible = false
integer x = 3639
integer y = 784
integer taborder = 0
end type

type pb_grabar from w_mant_tabla`pb_grabar within w_mant_parempresa
integer x = 2624
integer y = 376
integer taborder = 30
boolean enabled = true
end type

event pb_grabar::clicked;If dw_1.Update() = 1 Then
	Commit;
	If SQLCA.SQLCode <> 0 Then
		RollBack;
		MessageBox("Grabación de Parámetros", "El Proceso no se pudo ejecutar.~r~n"+&
						"Codigo de Error : "+String(SQLCA.SQLdbCode)+"~r~n"+&
						"Mensaje         : "+SQLCA.SQLErrText)
	Else
		wf_CargaParametros()	
		f_ParEmpresa()
		MessageBox("Atención","Parámetros de la Empresa Grabados.", Exclamation!,Ok!)
	End If
Else
	MessageBox("Grabación de Parámetros", "El Proceso no se pudo ejecutar.~r~n"+&
						"Codigo de Error : "+String(SQLCA.SQLdbCode)+"~r~n"+&
						"Mensaje         : "+SQLCA.SQLErrText)
	dw_1.Retrieve()
End If	
end event

type pb_imprimir from w_mant_tabla`pb_imprimir within w_mant_parempresa
boolean visible = false
integer x = 3639
integer y = 1144
integer taborder = 0
end type

type pb_salir from w_mant_tabla`pb_salir within w_mant_parempresa
integer x = 2610
integer y = 712
integer taborder = 40
end type

