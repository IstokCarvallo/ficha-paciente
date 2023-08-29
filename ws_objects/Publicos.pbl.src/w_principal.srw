$PBExportHeader$w_principal.srw
forward
global type w_principal from window
end type
type mdi_1 from mdiclient within w_principal
end type
end forward

global type w_principal from window
integer width = 5038
integer height = 2880
boolean titlebar = true
string title = "MENU PRINCIPAL"
string menuname = "m_principal"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdihelp!
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
event ue_habilitamenu ( )
event ue_listo ( )
mdi_1 mdi_1
end type
global w_principal w_principal

type prototypes
SUBROUTINE keybd_event( int bVk, int bScan, int dwFlags, int dwExtraInfo) LIBRARY "user32.dll"
end prototypes

type variables
Menu			im_menu
Transaction it_trans
DataStore 	ds_acceso, dw_2

Integer		ii_fondo_ancho
Integer		ii_fondo_alto
end variables

forward prototypes
public subroutine wf_habilitaopcion (string as_menucodigo, ref boolean ab_habilitado, ref boolean ab_visible)
public subroutine wf_captura_pantalla ()
end prototypes

event ue_habilitamenu();Integer 	li_Nivel1, li_Nivel2, li_Nivel3, li_Nivel4, li_Nivel5, li_Cantidad
Boolean  lb_Habilita ,  lb_Visible
String		ls_MenuNombre, ls_MenuCodigo
Long  		ll_Fila

m_principal.m_file.m_controldeaccesos.visible = True

im_menu = m_principal

If gstr_us.Administrador = 0 Then
	 im_menu.Item[1].Item[1].Item[1].Visible = False
	 im_menu.Item[1].Item[1].Item[2].Visible = False
	 im_menu.Item[1].Item[1].Item[3].Visible = False
	 im_menu.Item[1].Item[1].Item[4].Visible = False
	 im_menu.Item[1].Item[1].Item[5].Visible = False
	 im_menu.Item[1].Item[1].Item[6].Visible = False
	 im_menu.Item[1].Item[1].Item[7].Visible = False
End If

SetPointer(HourGlass!)

ll_Fila = ds_acceso.Retrieve(gstr_apl.CodigoSistema, gstr_us.CodigoGrupo, gstr_us.sucursal, -1)

If ll_Fila = -1 Then
	F_ErrorBaseDatos(sqlca, "Lectura de tabla USUAROPCIO")
	Return
ElseIf ll_Fila = 0 Then
	Return
End If

For li_Nivel1 = 2 TO UpperBound(im_menu.Item[])
	ls_MenuCodigo = im_menu.Item[li_Nivel1].ClassName()
	ls_MenuNombre =  im_menu.Item[li_Nivel1].Text
	
	wf_HabilitaOpcion(ls_MenuCodigo, im_menu.Item[li_Nivel1].Enabled, &
	im_menu.Item[li_Nivel1].Visible)

	If im_menu.Item[li_Nivel1].Enabled AND 	im_menu.Item[li_Nivel1].Visible AND &
			Pos("m_window%%m_help%%m_topicactions", ls_MenuCodigo) = 0 AND &
			UpperBound(im_menu.Item[li_Nivel1].Item[]) > 0  Then
	
		For li_Nivel2 = 1 TO UpperBound(im_menu.Item[li_Nivel1].Item[])
			ls_MenuCodigo = im_menu.Item[li_Nivel1].Item[li_Nivel2].ClassName()
			ls_MenuNombre =  im_menu.Item[li_Nivel1].Item[li_Nivel2].Text
			
			wf_HabilitaOpcion(ls_MenuCodigo, &
			im_menu.Item[li_Nivel1].Item[li_Nivel2].Enabled, &
			im_menu.Item[li_Nivel1].Item[li_Nivel2].Visible)
			
			If im_menu.Item[li_Nivel1].Item[li_Nivel2].Enabled AND im_menu.Item[li_Nivel1].Item[li_Nivel2].Visible AND &
				UpperBound(im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[]) > 0  Then
			
				For li_Nivel3 = 1 TO UpperBound(im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[])
							ls_MenuCodigo = im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].ClassName()
							ls_MenuNombre =  im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Text
							
							wf_HabilitaOpcion(ls_MenuCodigo, &
							im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Enabled, &
							im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Visible)
							
							If im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Enabled AND &
							im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Visible AND &
							UpperBound(im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Item[]) > 0  Then
							
							For li_Nivel4 = 1 TO UpperBound(im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Item[])
								ls_MenuCodigo = im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Item[li_Nivel4].ClassName()
								ls_MenuNombre =  im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Item[li_Nivel4].Text
								
								wf_HabilitaOpcion(ls_MenuCodigo, &
								im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Item[li_Nivel4].Enabled, &
								im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Item[li_Nivel4].Visible)
								
								If im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Item[li_Nivel4].Enabled AND &
								im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Item[li_Nivel4].Visible AND &
								UpperBound(im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Item[li_Nivel4].Item[]) > 0  Then
							
								For li_Nivel5 = 1 TO UpperBound(im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Item[li_Nivel4].Item[li_Nivel5].Item[])
								ls_MenuCodigo = im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Item[li_Nivel4].Item[li_Nivel5].ClassName()
								ls_MenuNombre =  im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Item[li_Nivel4].Item[li_Nivel5].Text
								
									wf_HabilitaOpcion(ls_MenuCodigo, &
									im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Item[li_Nivel4].Item[li_Nivel5].Enabled, &
									im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Item[li_Nivel4].Item[li_Nivel5].Visible)
								Next
							End If
						Next
					End If
				Next
			End If
		Next
	End If
Next
end event

public subroutine wf_habilitaopcion (string as_menucodigo, ref boolean ab_habilitado, ref boolean ab_visible);Long		ll_Fila
Integer	li_Habilitado = 1, li_Visible = 1

ll_Fila	=	ds_acceso.Find("sist_codigo = " + String(gstr_apl.CodigoSistema) + &
								"and grpo_codigo = " + String(gstr_us.CodigoGrupo) + &
								"and usua_codigo = 'TODOS'" + &
								"and usop_codmen = '" + as_MenuCodigo + "'" &
								, 1, ds_acceso.RowCount())
								
IF ll_Fila > 0 THEN
	li_Habilitado	=	ds_acceso.Object.usop_habili[ll_Fila]
	li_Visible		=	ds_acceso.Object.usop_visibl[ll_Fila]
	
	IF li_Habilitado = 0 THEN
		ab_Habilitado	=	False
	ELSE
		ab_Habilitado	=	True
	END IF
	
	IF li_Visible = 0 THEN
		ab_Visible	=	False
	ELSE
		ab_Visible	=	True
	END IF
END IF

ll_Fila	=	ds_acceso.Find("sist_codigo = " + String(gstr_apl.CodigoSistema) + &
								"and grpo_codigo = " + String(gstr_us.CodigoGrupo) + &
								"and Upper(usua_codigo) = '" + Upper(gstr_us.Nombre) + "'" + &
								"and usop_codmen = '" + as_MenuCodigo + "'" &
								, 1, ds_acceso.RowCount())
								
IF ll_Fila > 0 THEN
	li_Habilitado	=	ds_acceso.Object.usop_habili[ll_Fila]
	li_Visible		=	ds_acceso.Object.usop_visibl[ll_Fila]
	
	IF li_Habilitado = 0 THEN
		ab_Habilitado	=	False
	ELSE
		ab_Habilitado	=	True
	END IF
	
	IF li_Visible = 0 THEN
		ab_Visible	=	False
	ELSE
		ab_Visible	=	True
	END IF
END IF

RETURN
end subroutine

public subroutine wf_captura_pantalla ();
end subroutine

event open;String	ls_odbc, ls_paso

IF gstr_apl.referencia <> "" THEN
	This.Title	=	gstr_apl.titulo + ' - [' + Trim(gstr_apl.referencia) + ']'
ELSE
	This.Title	=	gstr_apl.titulo
END IF

PostEvent("ue_listo")

This.ToolBarVisible	=	False
This.Icon					=	gstr_apl.Icono
ds_acceso				=	CREATE DataStore

ds_acceso.DataObject	=	"dw_mues_admausuaropcio"
ds_acceso.SetTransObject(sqlca)
This.TriggerEvent("ue_habilitamenu")

// Fondo de Pantalla
OpenSheet(w_fondo, w_main)

w_fondo.Width	=	This.Width - 10
w_fondo.Height	=	This.Width - 10

ii_fondo_ancho	=	w_fondo.Width
ii_fondo_alto	=	w_fondo.Height

TriggerEvent("ue_mdi_move")
	
end event

on w_principal.create
if this.MenuName = "m_principal" then this.MenuID = create m_principal
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_principal.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

event mousemove;This.SetMicroHelp("Window : " + ClassName())
end event

event resize;IF IsValid(w_fondo) THEN
	w_fondo.Width	=	This.Width - 10
END IF
end event

type mdi_1 from mdiclient within w_principal
long BackColor=16777215
end type

