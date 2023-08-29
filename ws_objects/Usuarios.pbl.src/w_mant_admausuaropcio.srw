$PBExportHeader$w_mant_admausuaropcio.srw
$PBExportComments$Mantención de Accesos por Grupo y/o Usuario.
forward
global type w_mant_admausuaropcio from w_mant_directo
end type
type tv_1 from treeview within w_mant_admausuaropcio
end type
type st_1 from statictext within w_mant_admausuaropcio
end type
type st_2 from statictext within w_mant_admausuaropcio
end type
type rb_grupos from radiobutton within w_mant_admausuaropcio
end type
type rb_usuarios from radiobutton within w_mant_admausuaropcio
end type
type uo_selgrupo from uo_seleccion_gruposistemas within w_mant_admausuaropcio
end type
type uo_selusuario from uo_seleccion_usuarios within w_mant_admausuaropcio
end type
end forward

global type w_mant_admausuaropcio from w_mant_directo
integer width = 3598
integer height = 2104
string title = "MANTENCION DE ACCESO AL SISTEMA"
event ue_pueblatreeview ( )
tv_1 tv_1
st_1 st_1
st_2 st_2
rb_grupos rb_grupos
rb_usuarios rb_usuarios
uo_selgrupo uo_selgrupo
uo_selusuario uo_selusuario
end type
global w_mant_admausuaropcio w_mant_admausuaropcio

type variables
TreeViewItem		itvi_Item

String	is_Usuario, is_UsuarioNombre
end variables

forward prototypes
public subroutine buscausuario ()
public function integer of_add_items (long al_parent, integer ai_level, integer ai_rows)
public subroutine of_set_item (integer ai_level, integer ai_row, treeview atvi_new)
public function string wf_etiqueta (string as_texto)
public subroutine wf_validaacceso ()
end prototypes

event ue_pueblatreeview();Integer	li_Nivel1, li_Nivel2, li_Nivel3, li_Nivel4, li_Nivel5
Long		ll_Padre1, ll_Padre2, ll_Padre3, ll_Padre4, ll_Padre5

im_menu = m_principal

SetPointer(HourGlass!)
	
FOR li_Nivel1 = 2 TO UpperBound(im_menu.Item[])
	IF im_menu.Item[li_Nivel1].Visible THEN
		itvi_Item.Data						=	im_menu.Item[li_Nivel1].ClassName()
		itvi_Item.Label						=	wf_Etiqueta(im_menu.Item[li_Nivel1].Text)
		itvi_Item.PictureIndex				=	1
		itvi_Item.SelectedPictureIndex	=	2
			
		IF Pos("m_window%%m_help%%m_topicactions", itvi_Item.Data) = 0 THEN
			IF UpperBound(im_menu.Item[li_Nivel1].Item[]) > 0  THEN
				itvi_Item.Children		=	True
				ll_Padre1					=	tv_1.InsertItemLast(0, itvi_Item)
				
				FOR li_Nivel2 = 1 TO UpperBound(im_menu.Item[li_Nivel1].Item[])
					IF im_menu.Item[li_Nivel1].Item[li_Nivel2].Visible THEN
						itvi_Item.Data  						=	im_menu.Item[li_Nivel1].Item[li_Nivel2].ClassName()
						itvi_Item.Label						=	wf_Etiqueta(im_menu.Item[li_Nivel1].Item[li_Nivel2].Text)
						itvi_Item.PictureIndex				=	1
						itvi_Item.SelectedPictureIndex	=	2
						
						IF UpperBound(im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[]) > 0  THEN
							itvi_Item.Children		=	True
							ll_Padre2					=	tv_1.InsertItemLast(ll_Padre1, itvi_Item)
					
							FOR li_Nivel3 = 1 TO UpperBound(im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[])
								IF im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Visible THEN
									itvi_Item.Data  						=	im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].ClassName()
									itvi_Item.Label						=	wf_Etiqueta(im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Text)
									itvi_Item.PictureIndex				=	1
									itvi_Item.SelectedPictureIndex	=	2
									
									IF UpperBound(im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Item[]) > 0  THEN		
										itvi_Item.Children		=	True
										ll_Padre3					=	tv_1.InsertItemLast(ll_Padre2, itvi_Item)
						
										FOR li_Nivel4 = 1 TO UpperBound(im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Item[])
											IF im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Item[li_Nivel4].Visible THEN
												itvi_Item.Data  						=	im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Item[li_Nivel4].ClassName()
												itvi_Item.Label						=	wf_Etiqueta(im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Item[li_Nivel4].Text)
												itvi_Item.PictureIndex				=	1
												itvi_Item.SelectedPictureIndex	=	2
												
												IF UpperBound(im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Item[li_Nivel4].Item[]) > 0  THEN		
													itvi_Item.Children		=	True
													ll_Padre4					=	tv_1.InsertItemLast(ll_Padre3, itvi_Item)
							
													FOR li_Nivel5 = 1 TO UpperBound(im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Item[li_Nivel4].Item[li_Nivel5].Item[])
														itvi_Item.Data  						=	im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Item[li_Nivel4].Item[li_Nivel5].ClassName()
														itvi_Item.Label						=	wf_Etiqueta(im_menu.Item[li_Nivel1].Item[li_Nivel2].Item[li_Nivel3].Item[li_Nivel4].Item[li_Nivel5].Text)
														itvi_Item.PictureIndex				=	1
														itvi_Item.SelectedPictureIndex	=	2
														itvi_Item.Children					=	False
														ll_Padre5								=	tv_1.InsertItemLast(ll_Padre4, itvi_Item)
													NEXT
												ELSE
													itvi_Item.Children		=	False
													ll_Padre4					=	tv_1.InsertItemLast(ll_Padre3, itvi_Item)
												END IF
											END IF
										NEXT
									ELSE
										itvi_Item.Children		=	False
										ll_Padre3					=	tv_1.InsertItemLast(ll_Padre2, itvi_Item)
									END IF
								END IF
							NEXT
						ELSE
							itvi_Item.Children		=	False
							ll_Padre2					=	tv_1.InsertItemLast(ll_Padre1, itvi_Item)
						END IF
					END IF
				NEXT
			ELSE
				itvi_Item.Children		=	False
				ll_Padre1					=	tv_1.InsertItemLast(0, itvi_Item)
			END IF
		END IF
	END IF
NEXT
end event

public subroutine buscausuario ();
end subroutine

public function integer of_add_items (long al_parent, integer ai_level, integer ai_rows);// Function to add the items to the TreeView using the data in the DataStore

Integer				li_Cnt
TreeViewItem		ltvi_New
TreeView          ltvi_Nuevo

// Add each item to the TreeView
For li_Cnt = 1 To ai_Rows
	// Call a function to set the values of the TreeView item from 
	// the DataStore data
	of_set_item(ai_Level, li_Cnt, ltvi_Nuevo)
	
	// Add the item after the last child
	If tv_1.InsertItemLast(al_Parent, ltvi_New) < 1 Then
		// Error
		MessageBox("Error", "Error inserting item", Exclamation!)
		Return -1
	End If
Next

Return ai_Rows

end function

public subroutine of_set_item (integer ai_level, integer ai_row, treeview atvi_new);//// Set the Lable and Data attributes for the new item from the data in the DataStore
//
//Integer	li_Picture
//
//Choose Case ai_Level
//	Case 1
//		atvi_New.Label = ids_Data[1].Object.grpo_codigo[ai_Row] + ", " + &
//							  ids_Data[1].Object.grpo_nombre[ai_Row]
//	Case 2
//		atvi_New.Label = ids_Data[2].Object.sist_codigo[ai_Row]
//		atvi_New.Data  = ids_Data[2].Object.usop_grpusu[ai_Row]
//		atvi_New.Data  = ids_Data[2].Object.usop_habili[ai_Row]
//		atvi_New.Data  = ids_Data[2].Object.usop_visibl[ai_Row]		
//		atvi_New.Data  = ids_Data[2].Object.grpo_codigo[ai_Row]		
//		atvi_New.Data  = ids_Data[2].Object.sist_codigo[ai_Row]		
//		atvi_New.Data  = ids_Data[2].Object.grpo_nombre[ai_Row]		
//End Choose
//
//
//If ai_Level < 2 Then
//	atvi_New.Children = True
//	atvi_New.PictureIndex = ai_Level
//	atvi_New.SelectedPictureIndex = 2
//Else
//	atvi_New.Children = False
//	
//	// Set the picture to be the product picture
//	//li_Picture = tv_1.AddPicture(ids_Data[4].Object.product_picture_name[ai_Row])
//	//atvi_New.PictureIndex = li_Picture
//	//atvi_New.SelectedPictureIndex = 4
//End If
//
end subroutine

public function string wf_etiqueta (string as_texto);IF as_Texto = "-" THEN
	as_Texto	=	"__________________________"
ELSE
	as_Texto	=	F_Global_Replace(as_Texto, "&", "")
END IF

RETURN as_Texto
end function

public subroutine wf_validaacceso ();Integer li_HabGrupo = 1, li_VisGrupo = 1
String  ls_CodMenu

ls_CodMenu	=	itvi_Item.Data

IF rb_Usuarios.checked THEN
	SELECT	usop_habili, usop_visibl 
		INTO	:li_HabGrupo, :li_VisGrupo
		FROM	dbo.usuaropcion
		WHERE	sist_codigo	=	:gstr_apl.CodigoSistema
		AND	grpo_codigo	=	:uo_SelGrupo.Codigo
		AND	usua_codigo	=	'TODOS'
		AND	usop_codmen	=	:ls_CodMenu ;
	
	IF sqlca.sqlcode	=	-1	THEN
		F_ErrorBaseDatos(sqlca,"No se pudo leer la tabla AdmaUsuarOpcio")
	ELSE
		IF li_VisGrupo = 0 THEN
			MessageBox("Error de Acceso", "El Grupo al que pertenece el Usuario " + &
			is_UsuarioNombre + "~rno tiene acceso al módulo, por lo tanto " + &
			"este usuario tampoco tiene acceso.")
			
			RETURN
		ELSEIF li_VisGrupo = 1 AND li_HabGrupo = 0 THEN
			TriggerEvent("ue_recuperadatos")
			
			dw_1.Object.usop_visibl.protect	=	1
			dw_1.Object.usop_habili.protect	=	1
		ELSEIF li_VisGrupo = 1 AND li_HabGrupo = 1 THEN
			TriggerEvent("ue_recuperadatos")
		END IF
	END IF
ELSE
	TriggerEvent("ue_recuperadatos")
END IF
end subroutine

on w_mant_admausuaropcio.create
int iCurrent
call super::create
this.tv_1=create tv_1
this.st_1=create st_1
this.st_2=create st_2
this.rb_grupos=create rb_grupos
this.rb_usuarios=create rb_usuarios
this.uo_selgrupo=create uo_selgrupo
this.uo_selusuario=create uo_selusuario
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.rb_grupos
this.Control[iCurrent+5]=this.rb_usuarios
this.Control[iCurrent+6]=this.uo_selgrupo
this.Control[iCurrent+7]=this.uo_selusuario
end on

on w_mant_admausuaropcio.destroy
call super::destroy
destroy(this.tv_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.rb_grupos)
destroy(this.rb_usuarios)
destroy(this.uo_selgrupo)
destroy(this.uo_selusuario)
end on

event open;x				=	0
y				=	0
im_menu		=	m_principal

This.ParentWindow().ToolBarVisible	=	True
im_menu.Item[1].Item[6].Enabled		=	True
im_menu.Item[7].Visible					=	False
This.Icon										=	Gstr_apl.Icono

dw_1.SetTransObject(sqlca)

uo_SelGrupo.of_Seleccion(False, False)
uo_SelUsuario.of_Seleccion(False, False)
uo_SelGrupo.of_Filtra(gstr_apl.codigosistema)

istr_mant.argumento[2]	=	"TODOS"

dw_1.InsertRow(0)

rb_grupos.TriggerEvent(Clicked!)

PostEvent("ue_pueblatreeview")

f_GrabaAccesoAplicacion(True, id_FechaAcceso, it_HoraAcceso, This.Title, "Acceso a Aplicación", 1)

end event

event ue_recuperadatos;
Integer li_HabGrupo, li_ViGrupo, li_Codigo
String ls_CodMenu


dw_1.SetRedraw(False)

dw_1.Retrieve(gstr_apl.CodigoSistema, uo_SelGrupo.Codigo, istr_mant.argumento[2], itvi_item.Data)
					
IF dw_1.RowCount()=0 THEN
	dw_1.InsertRow(0)
	
	dw_1.SetItem(1, "sist_nombre", gstr_apl.NombreSistema)
	dw_1.SetItem(1, "usop_nommen", itvi_item.Label)			
	dw_1.SetITem(1, "grpo_nombre", uo_SelGrupo.Nombre)
	dw_1.SetItem(1, "usua_codigo", istr_mant.argumento[2])
	dw_1.SetItem(1, "sist_codigo", gstr_apl.CodigoSistema)					
	dw_1.SetItem(1, "grpo_codigo", uo_SelGrupo.Codigo)
	dw_1.SetItem(1, "usop_codmen", itvi_item.data)
	
	pb_imprimir.Enabled	=	False
	pb_grabar.Enabled		=	True
ELSE
	pb_imprimir.Enabled	=	True
	pb_grabar.Enabled		=	True
END IF

dw_1.SetRedraw(True)
end event

event ue_borrar;call super::ue_borrar;PostEvent("ue_nuevo")
end event

event ue_imprimir;Long		fila
str_info	lstr_info

lstr_info.titulo	= "MAESTRPO OPCIONES DE USUARIO"
lstr_info.copias	= 1

OpenWithParm(vinf,lstr_info)
vinf.dw_1.DataObject = "dw_info_admausuaropcio"
vinf.dw_1.SetTransObject(sqlca)
fila = vinf.dw_1.Retrieve(gstr_apl.codigosistema, gstr_apl.nombresistema, uo_SelGrupo.Codigo, istr_mant.argumento[2])

IF fila = -1 THEN
	MessageBox( "Error en Base de Datos", "Se ha producido un error en Base " + &
					"de datos : ~n" + sqlca.SQLErrText, StopSign!, Ok!)
ELSEIF fila = 0 THEN
	MessageBox( "No Existe información", "No existe información para este informe.", StopSign!, Ok!)
ELSE
	F_Membrete(vinf.dw_1)
END IF
end event

event ue_nuevo;call super::ue_nuevo;pb_grabar.Enabled	=	False
pb_eliminar.Enabled	=	False

istr_mant.argumento[2]	=	""
	

end event

event resize;Integer		li_posic_x, li_posic_y, &
				li_Ancho = 300, li_Alto = 245, li_Siguiente = 255

li_posic_x				=	This.WorkSpaceWidth() - 370
li_posic_y				=	30

pb_lectura.x				=	li_posic_x
pb_lectura.y				=	li_posic_y
pb_lectura.width		=	li_Ancho
pb_lectura.height		=	li_Alto

li_posic_y 				+= li_Siguiente * 1.25

IF pb_nuevo.Visible THEN
	pb_nuevo.x			=	li_posic_x
	pb_nuevo.y			=	li_posic_y
	pb_nuevo.width	=	li_Ancho
	pb_nuevo.height	=	li_Alto
	li_posic_y 			+= li_Siguiente
END IF

IF pb_insertar.Visible THEN
	pb_insertar.x		=	li_posic_x
	pb_insertar.y		=	li_posic_y
	pb_insertar.width	=	li_Ancho
	pb_insertar.height	=	li_Alto
	li_posic_y += li_Siguiente
END IF

IF pb_eliminar.Visible THEN
	pb_eliminar.x			=	li_posic_x
	pb_eliminar.y			=	li_posic_y
	pb_eliminar.width		=	li_Ancho
	pb_eliminar.height	=	li_Alto
	li_posic_y += li_Siguiente
END IF

IF pb_grabar.Visible THEN
	pb_grabar.x				=	li_posic_x
	pb_grabar.y				=	li_posic_y
	pb_grabar.width		=	li_Ancho
	pb_grabar.height		=	li_Alto
	li_posic_y += li_Siguiente
END IF

IF pb_imprimir.Visible THEN
	pb_imprimir.x			=	li_posic_x
	pb_imprimir.y			=	li_posic_y
	pb_imprimir.width		=	li_Ancho
	pb_imprimir.height	=	li_Alto
	li_posic_y += li_Siguiente
END IF

pb_salir.x				=	li_posic_x
pb_salir.y				=	This.WorkSpaceHeight() - li_Siguiente
pb_salir.width			=	li_Ancho
pb_salir.height			=	li_Alto
end event

type st_encabe from w_mant_directo`st_encabe within w_mant_admausuaropcio
integer x = 1339
integer y = 56
integer width = 1783
integer height = 560
end type

type pb_nuevo from w_mant_directo`pb_nuevo within w_mant_admausuaropcio
integer x = 3250
integer y = 456
integer taborder = 50
end type

event pb_nuevo::clicked;call super::clicked;CHOOSE CASE wf_modifica()
	CASE 0
		CHOOSE CASE MessageBox("Grabar registro(s)","Desea Grabar la información ?", Question!, YesNoCancel!)
			CASE 1
				Message.DoubleParm = 0
				Parent.TriggerEvent("ue_guardar")
				IF message.DoubleParm = -1 THEN RETURN
				
			CASE 3
				RETURN
		END CHOOSE
		
END CHOOSE

Parent.PostEvent("ue_nuevo")
end event

type pb_lectura from w_mant_directo`pb_lectura within w_mant_admausuaropcio
boolean visible = false
integer x = 3301
integer y = 176
end type

type pb_eliminar from w_mant_directo`pb_eliminar within w_mant_admausuaropcio
boolean visible = false
integer x = 3250
integer y = 600
integer taborder = 90
end type

type pb_insertar from w_mant_directo`pb_insertar within w_mant_admausuaropcio
boolean visible = false
integer x = 3305
integer y = 600
integer taborder = 80
end type

type pb_salir from w_mant_directo`pb_salir within w_mant_admausuaropcio
integer x = 3250
integer y = 1196
integer taborder = 120
end type

type pb_imprimir from w_mant_directo`pb_imprimir within w_mant_admausuaropcio
integer x = 3250
integer y = 912
integer taborder = 110
boolean enabled = true
end type

type pb_grabar from w_mant_directo`pb_grabar within w_mant_admausuaropcio
integer x = 3250
integer y = 752
integer taborder = 100
end type

event pb_grabar::clicked;Parent.TriggerEvent("ue_guardar")
end event

type dw_1 from w_mant_directo`dw_1 within w_mant_admausuaropcio
integer x = 1339
integer y = 860
integer width = 1705
integer height = 932
integer taborder = 70
string dataobject = "dw_mant_admausuariopcio"
boolean hscrollbar = true
boolean vscrollbar = false
end type

event dw_1::itemchanged;call super::itemchanged;String	ls_columna

ls_columna = dwo.Name

CHOOSE CASE ls_columna
	CASE "usop_visibl", "usop_habili"
		This.SetItem(il_fila, "usop_soloco", 0)

END CHOOSE
end event

type tv_1 from treeview within w_mant_admausuaropcio
event type long ue_selectionchanged ( any oldhandle,  long newhandle )
integer x = 64
integer y = 44
integer width = 1198
integer height = 1804
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
string picturename[] = {"Custom027!","Custom026!",""}
long picturemaskcolor = 553648127
long statepicturemaskcolor = 536870912
end type

event selectionchanged;This.GetItem(NewHandle, itvi_Item)

wf_ValidaAcceso()
end event

event selectionchanging;Integer	li_Grupo

li_Grupo	=	uo_SelGrupo.Codigo

IF	This.GetItem(NewHandle, itvi_Item) > 0 AND IsNull(li_Grupo) THEN
	MessageBox("Atención", "Primero debe seleccionar por lo menos el grupo")
	tv_1.SetReDraw(True)
ELSE
	wf_ValidaAcceso()	
END IF
end event

type st_1 from statictext within w_mant_admausuaropcio
integer x = 1577
integer y = 348
integer width = 192
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 553648127
boolean enabled = false
string text = "Grupo"
boolean focusrectangle = false
end type

type st_2 from statictext within w_mant_admausuaropcio
integer x = 1577
integer y = 452
integer width = 219
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 553648127
string text = "Usuario"
boolean focusrectangle = false
end type

type rb_grupos from radiobutton within w_mant_admausuaropcio
integer x = 1682
integer y = 160
integer width = 293
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 553648127
string text = "Grupos"
boolean checked = true
end type

event clicked;
uo_SelGrupo.of_Bloquear(False)
uo_SelGrupo.of_Filtra(gstr_apl.CodigoSistema)

uo_SelUsuario.of_Bloquear(True)

istr_mant.Argumento[2]									=	"TODOS"
uo_SelUsuario.of_LimpiarDatos()

pb_grabar.Enabled	=	False
end event

type rb_usuarios from radiobutton within w_mant_admausuaropcio
integer x = 2441
integer y = 160
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 553648127
string text = "Usuarios"
end type

event clicked;	uo_SelUsuario.of_Bloquear(False)
end event

type uo_selgrupo from uo_seleccion_gruposistemas within w_mant_admausuaropcio
integer x = 1851
integer y = 332
integer height = 92
integer taborder = 100
boolean bringtotop = true
end type

on uo_selgrupo.destroy
call uo_seleccion_gruposistemas::destroy
end on

event ue_cambio;call super::ue_cambio;	
If Not rb_usuarios.Checked Then	
//	dw_usuario.Getchild("usua_codigo", idwc_usuarios)
//	idwc_usuarios.Retrieve(This.Codigo,gstr_apl.codigosistema)
//Else
	dw_1.SetItem(il_Fila,"usop_soloco",'TODOS')
End If
end event

type uo_selusuario from uo_seleccion_usuarios within w_mant_admausuaropcio
integer x = 1851
integer y = 440
integer height = 92
integer taborder = 100
boolean bringtotop = true
end type

on uo_selusuario.destroy
call uo_seleccion_usuarios::destroy
end on

event ue_cambio;call super::ue_cambio;istr_mant.Argumento[2]	=	This.Codigo
is_Usuario					=	This.Codigo

end event

