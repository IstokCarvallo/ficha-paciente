$PBExportHeader$w_mant_parempresa.srw
forward
global type w_mant_parempresa from w_mant_tabla
end type
type tab_1 from tab within w_mant_parempresa
end type
type tabpage_1 from userobject within tab_1
end type
type dw_empresa from uo_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_empresa dw_empresa
end type
type tabpage_2 from userobject within tab_1
end type
type dw_dte from uo_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_dte dw_dte
end type
type tab_1 from tab within w_mant_parempresa
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_mant_parempresa from w_mant_tabla
integer width = 3118
integer height = 1844
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
tab_1 tab_1
end type
global w_mant_parempresa w_mant_parempresa

type variables
String	is_rut, is_rutleg
end variables

forward prototypes
public subroutine cargaparametros ()
end prototypes

public subroutine cargaparametros ();gstr_apl.razon_social		=	dw_1.Object.empr_razsoc[1]
gstr_apl.nom_empresa	=	dw_1.Object.empr_nombre[1]
gstr_apl.rut_empresa		=	dw_1.Object.empr_rutemp[1]
gstr_apl.dir_empresa		=	dw_1.Object.empr_direcc[1]
gstr_apl.com_empresa	=	dw_1.Object.empr_comuna[1]
gstr_apl.ciu_empresa		=	dw_1.Object.empr_ciudad[1]
gstr_apl.gir_empresa		=	dw_1.Object.empr_giroem[1]
gstr_apl.tel_empresa		=	dw_1.Object.empr_nrotel[1]
gstr_apl.fax_empresa		=	dw_1.Object.empr_nrofax[1]
gstr_apl.rep_legal			=	dw_1.Object.empr_repleg[1]
gstr_apl.rut_replegal		=	dw_1.Object.empr_rutrle[1]
gstr_apl.Oficina				=	dw_1.Object.empr_oficin[1]
gstr_apl.DirRespaldo		=	dw_1.Object.empr_dirres[1]

end subroutine

event open;Long ll_Fila

x				= 0
y				= 0
im_menu		= m_principal

This.Icon									=	Gstr_apl.Icono
dw_1.SetTransObject(sqlca)
Tab_1.TabPage_1.dw_empresa.SetTransObject(sqlca)
Tab_1.TabPage_2.dw_dte.SetTransObject(sqlca)

dw_1.Modify("datawindow.message.title='Error '+ is_titulo")
istr_mant.dw	= dw_1

dw_1.ShareData(Tab_1.TabPage_1.dw_empresa)
dw_1.ShareData(Tab_1.TabPage_2.dw_DTE)

TriggerEvent("ue_validapassword")

If dw_1.Retrieve() = 0 Then dw_1.InsertRow(0)

IF ll_fila = 0 THEN
	dw_1.InsertRow(0)
ELSE
	is_rutleg	=	dw_1.Object.empr_rutrle[1]
END IF

GrabaAccesoAplicacion(True, id_FechaAcceso, it_HoraAcceso, This.Title, "Acceso a Aplicación", 1)

end event

on w_mant_parempresa.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_mant_parempresa.destroy
call super::destroy
destroy(this.tab_1)
end on

type dw_1 from w_mant_tabla`dw_1 within w_mant_parempresa
boolean visible = false
integer x = 46
integer y = 60
integer width = 2487
integer height = 1660
integer taborder = 20
boolean enabled = false
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
integer x = 183
integer y = 176
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
integer x = 2720
integer y = 640
integer taborder = 30
boolean enabled = true
string picturename = "\Repos\Resources\BTN\Guardar.png"
string disabledname = "\Repos\Resources\BTN\Guardar-bn.png"
end type

event pb_grabar::clicked;If dw_1.Update() = 1 Then
	Commit;
	If SQLCA.SQLCode <> 0 Then
		RollBack;
		MessageBox("Grabación de Parámetros", "El Proceso no se pudo ejecutar.~r~n"+&
						"Codigo de Error : "+String(SQLCA.SQLdbCode)+"~r~n"+&
						"Mensaje         : "+SQLCA.SQLErrText)
	Else
		CargaParametros()	
		ParEmpresa()
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
integer x = 2715
integer y = 1148
integer taborder = 40
string picturename = "\Repos\Resources\BTN\Apagar.png"
string disabledname = "\Repos\Resources\BTN\Apagar-bn.png"
end type

type tab_1 from tab within w_mant_parempresa
integer x = 55
integer y = 64
integer width = 2592
integer height = 1564
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 2555
integer height = 1436
long backcolor = 16777215
string text = "Empresa"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_empresa dw_empresa
end type

on tabpage_1.create
this.dw_empresa=create dw_empresa
this.Control[]={this.dw_empresa}
end on

on tabpage_1.destroy
destroy(this.dw_empresa)
end on

type dw_empresa from uo_dw within tabpage_1
integer x = 32
integer y = 32
integer width = 2487
integer height = 1400
integer taborder = 11
string dataobject = "dw_mant_parempresa_emp"
boolean vscrollbar = false
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 2555
integer height = 1436
long backcolor = 16777215
string text = "Guia Electronica"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_dte dw_dte
end type

on tabpage_2.create
this.dw_dte=create dw_dte
this.Control[]={this.dw_dte}
end on

on tabpage_2.destroy
destroy(this.dw_dte)
end on

type dw_dte from uo_dw within tabpage_2
integer x = 32
integer y = 32
integer width = 2487
integer height = 1100
integer taborder = 11
string dataobject = "dw_mant_parempresa_dte"
boolean vscrollbar = false
end type

