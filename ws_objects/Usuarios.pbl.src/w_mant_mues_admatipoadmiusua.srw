$PBExportHeader$w_mant_mues_admatipoadmiusua.srw
$PBExportComments$Mantenedor de Tipos de Administrador de Sistema
forward
global type w_mant_mues_admatipoadmiusua from w_mant_directo
end type
type st_1 from statictext within w_mant_mues_admatipoadmiusua
end type
type st_sisnombre from statictext within w_mant_mues_admatipoadmiusua
end type
type st_sisnumero from statictext within w_mant_mues_admatipoadmiusua
end type
type cb_global from commandbutton within w_mant_mues_admatipoadmiusua
end type
type cb_sucursal from commandbutton within w_mant_mues_admatipoadmiusua
end type
type cb_uniadm from commandbutton within w_mant_mues_admatipoadmiusua
end type
type dw_2 from uo_dw within w_mant_mues_admatipoadmiusua
end type
type dw_3 from uo_dw within w_mant_mues_admatipoadmiusua
end type
type dw_4 from uo_dw within w_mant_mues_admatipoadmiusua
end type
end forward

global type w_mant_mues_admatipoadmiusua from w_mant_directo
integer width = 3739
string title = "TIPOS DE ADMINISTRADOR DEL SISTEMA"
st_1 st_1
st_sisnombre st_sisnombre
st_sisnumero st_sisnumero
cb_global cb_global
cb_sucursal cb_sucursal
cb_uniadm cb_uniadm
dw_2 dw_2
dw_3 dw_3
dw_4 dw_4
end type
global w_mant_mues_admatipoadmiusua w_mant_mues_admatipoadmiusua

type variables

end variables

forward prototypes
public subroutine traspasausuarios (datawindow adw_1, datawindow adw_2, integer ai_tipousuario)
protected function boolean wf_actualiza_db ()
end prototypes

public subroutine traspasausuarios (datawindow adw_1, datawindow adw_2, integer ai_tipousuario);Long		ll_FilaOrigen, ll_FilaNueva

//	Primer Paso : Desde DataWindow 1 a DataWindow 2

ll_FilaOrigen	=	adw_1.GetSelectedRow(0)
ll_FilaNueva	=	adw_2.RowCount() + 1

DO WHILE ll_FilaOrigen > 0
	adw_1.RowsMove(ll_FilaOrigen, ll_FilaOrigen, Primary!, &
						adw_2, ll_FilaNueva, Primary!)
	
	adw_2.Object.adta_tipoad[ll_FilaNueva]	=	ai_TipoUsuario
	
	adw_2.SetItemStatus(ll_FilaNueva, 0, Primary!, DataModified!)
	adw_2.SetItemStatus(ll_FilaNueva, "sist_codigo", Primary!, DataModified!)
	adw_2.SetItemStatus(ll_FilaNueva, "usua_codigo", Primary!, DataModified!)
	adw_2.SetItemStatus(ll_FilaNueva, "adta_tipoad", Primary!, DataModified!)
	
	ll_FilaOrigen	=	adw_1.GetSelectedRow(0)
	ll_FilaNueva	=	adw_2.RowCount() + 1
LOOP

//	Primer Paso : Desde DataWindow 1 a DataWindow 2

ll_FilaOrigen	=	adw_2.GetSelectedRow(0)
ll_FilaNueva	=	adw_1.RowCount() + 1

DO WHILE ll_FilaOrigen > 0
	adw_2.RowsMove(ll_FilaOrigen, ll_FilaOrigen, Primary!, &
						adw_1, adw_1.RowCount() + 1, Primary!)
	
	adw_1.Object.adta_tipoad[ll_FilaNueva]	=	4
	
	adw_1.SetItemStatus(ll_FilaNueva, 0, Primary!, DataModified!)
	adw_1.SetItemStatus(ll_FilaNueva, "sist_codigo", Primary!, DataModified!)
	adw_1.SetItemStatus(ll_FilaNueva, "usua_codigo", Primary!, DataModified!)
	adw_1.SetItemStatus(ll_FilaNueva, "adta_tipoad", Primary!, DataModified!)
	
	ll_FilaOrigen	=	adw_2.GetSelectedRow(0)
	ll_FilaNueva	=	adw_1.RowCount() + 1
LOOP

RETURN
end subroutine

protected function boolean wf_actualiza_db ();Boolean	lb_AutoCommit, lb_Retorno

IF Not dw_2.uf_check_required(0) THEN RETURN False

IF Not dw_1.uf_validate(0) THEN RETURN False

lb_AutoCommit		=	sqlca.AutoCommit
sqlca.AutoCommit	=	False

IF dw_1.Update(True, False) = 1 THEN
	IF dw_2.Update(True, False) = 1 THEN
		IF dw_3.Update(True, False) = 1 THEN
			IF dw_4.Update(True, False) = 1 THEN
				Commit;
				
				IF sqlca.SQLCode <> 0 THEN
					F_ErrorBaseDatos(sqlca, This.Title)
					
					RollBack;
				ELSE
					lb_Retorno	=	True
					
					dw_1.ResetUpdate()
					dw_2.ResetUpdate()
					dw_3.ResetUpdate()
					dw_4.ResetUpdate()
				END IF
			ELSE
				F_ErrorBaseDatos(sqlca, This.Title)
				
				RollBack;
			END IF
		ELSE
			F_ErrorBaseDatos(sqlca, This.Title)
			
			RollBack;
		END IF
	ELSE
		F_ErrorBaseDatos(sqlca, This.Title)
		
		RollBack;
	END IF
ELSE
	F_ErrorBaseDatos(sqlca, This.Title)
END IF

sqlca.AutoCommit	=	lb_AutoCommit

RETURN lb_Retorno
end function

on w_mant_mues_admatipoadmiusua.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_sisnombre=create st_sisnombre
this.st_sisnumero=create st_sisnumero
this.cb_global=create cb_global
this.cb_sucursal=create cb_sucursal
this.cb_uniadm=create cb_uniadm
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_sisnombre
this.Control[iCurrent+3]=this.st_sisnumero
this.Control[iCurrent+4]=this.cb_global
this.Control[iCurrent+5]=this.cb_sucursal
this.Control[iCurrent+6]=this.cb_uniadm
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.dw_3
this.Control[iCurrent+9]=this.dw_4
end on

on w_mant_mues_admatipoadmiusua.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_sisnombre)
destroy(this.st_sisnumero)
destroy(this.cb_global)
destroy(this.cb_sucursal)
destroy(this.cb_uniadm)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_4)
end on

event open;x				=	0
y				=	0
This.Height	=	1993
im_menu		=	m_principal

st_SisNumero.Text	=	String(gstr_apl.CodigoSistema)
st_SisNombre.Text	=	gstr_apl.NombreSistema

This.ParentWindow().ToolBarVisible	=	True
im_menu.Item[1].Item[6].Enabled		=	True
im_menu.Item[7].Visible					=	False
This.Icon									=	Gstr_apl.Icono

dw_1.SetTransObject(sqlca)
dw_1.Modify("datawindow.message.title='Error '+ is_titulo")
dw_1.Modify("usua_codigo_t.Text	=	'Nivel Usuario'")

dw_2.SetTransObject(sqlca)
dw_2.Modify("datawindow.message.title='Error '+ is_titulo")
dw_2.Modify("usua_codigo_t.Text	=	'Nivel Global'")

dw_3.SetTransObject(sqlca)
dw_3.Modify("datawindow.message.title='Error '+ is_titulo")
dw_3.Modify("usua_codigo_t.Text	=	'Nivel Sucursal'")

dw_4.SetTransObject(sqlca)
dw_4.Modify("datawindow.message.title='Error '+ is_titulo")
dw_4.Modify("usua_codigo_t.Text	=	'Nivel Unidad Administrativa'")

GrabaAccesoAplicacion(True, id_FechaAcceso, it_HoraAcceso, &
							This.Title, "Acceso a Aplicación", 1)								

buscar			= "Código:Nusua_codigo,Nombre:Nusua_nombre"
ordenar			= "Código:grpo_codigo,Nombre:grpo_nombre"
end event

event ue_recuperadatos;call super::ue_recuperadatos;Long	ll_fila, ls_Respuesta

DECLARE GeneraUsuarios PROCEDURE FOR dba.AdmUsua_GeneraUsuarios
	@Sistema	=	:gstr_apl.CodigoSistema ;
	
	EXECUTE GeneraUsuarios;
	
DO
	IF dw_1.Retrieve(gstr_apl.CodigoSistema, 4) = -1 THEN
		ls_Respuesta	=	MessageBox(	"Error en Base de Datos", &
										"No es posible conectar la Base de Datos.", &
										Information!, RetryCancel!)
	END IF
	
	IF dw_2.Retrieve(gstr_apl.CodigoSistema, 1) = -1 THEN
		ls_Respuesta	=	MessageBox(	"Error en Base de Datos", &
										"No es posible conectar la Base de Datos.", &
										Information!, RetryCancel!)
	END IF
	
	IF dw_3.Retrieve(gstr_apl.CodigoSistema, 2) = -1 THEN
		ls_Respuesta	=	MessageBox(	"Error en Base de Datos", &
										"No es posible conectar la Base de Datos.", &
										Information!, RetryCancel!)
	END IF
	
	IF dw_4.Retrieve(gstr_apl.CodigoSistema, 3) = -1 THEN
		ls_Respuesta	=	MessageBox(	"Error en Base de Datos", &
										"No es posible conectar la Base de Datos.", &
										Information!, RetryCancel!)
	END IF
	
	il_fila = 1

	IF dw_1.RowCount() > 0 THEN
		dw_1.SetFocus()
	ELSEIF dw_2.RowCount() > 0 THEN
		dw_2.SetFocus()
	ELSEIF dw_3.RowCount() > 0 THEN
		dw_3.SetFocus()
	ELSEIF dw_4.RowCount() > 0 THEN
		dw_4.SetFocus()
	ELSE
		MessageBox("Atención", 	"No Existen Usuarios creados para este Sistema.")
		ls_Respuesta	=	2
	END IF
	
LOOP WHILE ls_Respuesta = 1

IF ls_Respuesta = 2 THEN Close(This)
end event

event ue_imprimir;Long		ll_Fila
str_info	lstr_info

lstr_info.copias	= 1

OpenWithParm(vinf,lstr_info)
vinf.dw_1.DataObject = "dw_info_admatipoadmiusua"
vinf.dw_1.SetTransObject(sqlca)
ll_Fila	=	vinf.dw_1.Retrieve(gstr_apl.CodigoSistema)

IF ll_Fila = -1 THEN
	MessageBox( "Error en Base de Datos", "Se ha producido un error en Base " + &
					"de datos : ~n" + sqlca.SQLErrText, StopSign!, Ok!)
ELSEIF ll_Fila = 0 THEN
	MessageBox( "No Existe información", "No existe información para este informe.", &
					StopSign!, Ok!)
ELSE
	F_Membrete(vinf.dw_1)
	If gs_Ambiente = 'Windows' Then
		vinf.dw_1.Modify('DataWindow.Print.Preview = Yes')
		vinf.dw_1.Modify('DataWindow.Print.Preview.Zoom = 75')
	
		vinf.Visible	= True
		vinf.Enabled	= True
	End If
END IF
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

event ue_guardar;IF dw_1.AcceptText() = -1 THEN RETURN

SetPointer(HourGlass!)

w_main.SetMicroHelp("Grabando información...")

TriggerEvent("ue_antesguardar")

IF wf_actualiza_db() THEN
	w_main.SetMicroHelp("Información Grabada.")
	pb_imprimir.Enabled	= True
ELSE
	w_main.SetMicroHelp("No se puede Grabar información.")
	Message.DoubleParm = -1
	RETURN
END IF
end event

type st_encabe from w_mant_directo`st_encabe within w_mant_mues_admatipoadmiusua
integer y = 36
integer width = 3067
integer height = 272
end type

type pb_nuevo from w_mant_directo`pb_nuevo within w_mant_mues_admatipoadmiusua
boolean visible = false
integer x = 3287
integer y = 424
end type

type pb_lectura from w_mant_directo`pb_lectura within w_mant_mues_admatipoadmiusua
integer x = 3287
integer y = 128
end type

type pb_eliminar from w_mant_directo`pb_eliminar within w_mant_mues_admatipoadmiusua
boolean visible = false
integer x = 3287
integer y = 752
end type

type pb_insertar from w_mant_directo`pb_insertar within w_mant_mues_admatipoadmiusua
boolean visible = false
integer x = 3287
integer y = 588
end type

type pb_salir from w_mant_directo`pb_salir within w_mant_mues_admatipoadmiusua
integer x = 3296
integer y = 1364
end type

type pb_imprimir from w_mant_directo`pb_imprimir within w_mant_mues_admatipoadmiusua
integer x = 3287
integer y = 1080
end type

type pb_grabar from w_mant_directo`pb_grabar within w_mant_mues_admatipoadmiusua
integer x = 3287
integer y = 916
boolean enabled = true
end type

type dw_1 from w_mant_directo`dw_1 within w_mant_mues_admatipoadmiusua
integer y = 352
integer width = 1298
integer height = 1480
string dataobject = "dw_mues_admatipoadmiusua"
end type

event dw_1::clicked;call super::clicked;IF Row > 0 THEN
	IF This.IsSelected(Row) THEN
		This.SelectRow(Row, False)
	ELSE
		This.SelectRow(Row, True)
	END IF
END IF
end event

type st_1 from statictext within w_mant_mues_admatipoadmiusua
integer x = 169
integer y = 140
integer width = 256
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 553648127
string text = "Sistema"
boolean focusrectangle = false
end type

type st_sisnombre from statictext within w_mant_mues_admatipoadmiusua
integer x = 768
integer y = 128
integer width = 2304
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 65535
long backcolor = 553648127
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_sisnumero from statictext within w_mant_mues_admatipoadmiusua
integer x = 503
integer y = 128
integer width = 192
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 65535
long backcolor = 553648127
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_global from commandbutton within w_mant_mues_admatipoadmiusua
integer x = 1408
integer y = 536
integer width = 402
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<<  >>"
end type

event clicked;TraspasaUsuarios(dw_1, dw_2, 1)
end event

type cb_sucursal from commandbutton within w_mant_mues_admatipoadmiusua
integer x = 1408
integer y = 1040
integer width = 402
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<<  >>"
end type

event clicked;TraspasaUsuarios(dw_1, dw_3, 2)
end event

type cb_uniadm from commandbutton within w_mant_mues_admatipoadmiusua
integer x = 1408
integer y = 1544
integer width = 402
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<<  >>"
end type

event clicked;TraspasaUsuarios(dw_1, dw_4, 3)
end event

type dw_2 from uo_dw within w_mant_mues_admatipoadmiusua
integer x = 1842
integer y = 352
integer width = 1303
integer height = 468
integer taborder = 11
boolean bringtotop = true
string dataobject = "dw_mues_admatipoadmiusua"
end type

event clicked;call super::clicked;IF Row > 0 THEN
	IF This.IsSelected(Row) THEN
		This.SelectRow(Row, False)
	ELSE
		This.SelectRow(Row, True)
	END IF
END IF
end event

type dw_3 from uo_dw within w_mant_mues_admatipoadmiusua
integer x = 1842
integer y = 860
integer width = 1303
integer height = 468
integer taborder = 21
boolean bringtotop = true
string dataobject = "dw_mues_admatipoadmiusua"
end type

event clicked;call super::clicked;IF Row > 0 THEN
	IF This.IsSelected(Row) THEN
		This.SelectRow(Row, False)
	ELSE
		This.SelectRow(Row, True)
	END IF
END IF
end event

type dw_4 from uo_dw within w_mant_mues_admatipoadmiusua
integer x = 1842
integer y = 1364
integer width = 1303
integer height = 468
integer taborder = 31
boolean bringtotop = true
string dataobject = "dw_mues_admatipoadmiusua"
end type

event clicked;call super::clicked;IF Row > 0 THEN
	IF This.IsSelected(Row) THEN
		This.SelectRow(Row, False)
	ELSE
		This.SelectRow(Row, True)
	END IF
END IF
end event

