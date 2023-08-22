$PBExportHeader$w_busqueda.srw
forward
global type w_busqueda from window
end type
type pb_insertar from picturebutton within w_busqueda
end type
type dw_1 from datawindow within w_busqueda
end type
type pb_salir from picturebutton within w_busqueda
end type
type tab_1 from tab within w_busqueda
end type
type tabpage_1 from userobject within tab_1
end type
type pb_filtrar from picturebutton within tabpage_1
end type
type tabpage_1 from userobject within tab_1
pb_filtrar pb_filtrar
end type
type tabpage_2 from userobject within tab_1
end type
type pb_acepta from picturebutton within tabpage_2
end type
type dw_3 from datawindow within tabpage_2
end type
type dw_2 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
pb_acepta pb_acepta
dw_3 dw_3
dw_2 dw_2
end type
type tabpage_3 from userobject within tab_1
end type
type sle_argumento2 from singlelineedit within tabpage_3
end type
type st_argum2 from statictext within tabpage_3
end type
type sle_argumento1 from singlelineedit within tabpage_3
end type
type st_argum1 from statictext within tabpage_3
end type
type pb_buscar from picturebutton within tabpage_3
end type
type tabpage_3 from userobject within tab_1
sle_argumento2 sle_argumento2
st_argum2 st_argum2
sle_argumento1 sle_argumento1
st_argum1 st_argum1
pb_buscar pb_buscar
end type
type tab_1 from tab within w_busqueda
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
end forward

global type w_busqueda from window
integer x = 1074
integer y = 476
integer width = 3049
integer height = 1792
boolean titlebar = true
string title = "Busqueda"
boolean resizable = true
windowtype windowtype = response!
long backcolor = 16777215
string icon = "Question!"
event ue_asignacion ( )
event ue_ordenamiento ( )
event ue_grabacion ( )
pb_insertar pb_insertar
dw_1 dw_1
pb_salir pb_salir
tab_1 tab_1
end type
global w_busqueda w_busqueda

type variables
str_busqueda	istr_busq
str_mant		istr_mant 

String	is_argume, is_busca, is_ordena
Boolean	es_numero
end variables

event ue_asignacion;// Script no heredable. Se debe sobreescribir en objeto heredado para asignar parametros de retorno.

CloseWithReturn(This, istr_busq)
end event

event ue_ordenamiento();Integer li_posi, li_idx
String  ls_temp, ls_buscar_info, tmp

setpointer(hourglass!)
w_main.SetMicroHelp("Cargando Ordenamiento...")

li_idx = 1
ls_buscar_info = is_ordena

IF is_ordena <> "" THEN 
	DO 
		li_posi = pos(ls_buscar_info,",")
		IF li_posi = 0 THEN
			ls_temp = ls_buscar_info 
			ls_buscar_info = ""
		ELSE
			ls_temp = left(ls_buscar_info, li_posi - 1)
			ls_buscar_info = mid(ls_buscar_info, li_posi+1)
		END IF
		li_posi = pos(ls_temp, ":")
		tab_1.TabPage_2.dw_2.insertrow(li_idx)
		tab_1.TabPage_2.dw_2.setitem(li_idx,"campo",mid(ls_temp, li_posi + 1))
		tab_1.TabPage_2.dw_2.setitem(li_idx,"nombre",left(ls_temp, li_posi - 1))
		li_idx = li_idx + 1
	LOOP UNTIL ls_buscar_info = "" or li_idx = 10  
	tab_1.TabPage_2.dw_2.setsort("nombre A")
	tab_1.TabPage_2.dw_2.sort()
END IF
w_main.SetMicroHelp("Listo")

end event

event ue_grabacion();Boolean     lb_Autocommit

lb_AutoCommit		=	sqlca.AutoCommit
sqlca.AutoCommit	=	False

IF dw_1.Update() = 1 THEN
	COMMIT;
	IF Sqlca.SqlCode <> 0 THEN
		F_ErrorBaseDatos(Sqlca, This.Title)
	END IF
ELSE
	ROLLBACK;
	IF Sqlca.SqlCode <> 0 THEN F_ErrorBaseDatos(Sqlca, This.Title)
END IF

Sqlca.AutoCommit = lb_AutoCommit

dw_1.SetRow(dw_1.GetRow())
dw_1.SelectRow(dw_1.GetRow(),True)
dw_1.SetFocus()
end event

on w_busqueda.create
this.pb_insertar=create pb_insertar
this.dw_1=create dw_1
this.pb_salir=create pb_salir
this.tab_1=create tab_1
this.Control[]={this.pb_insertar,&
this.dw_1,&
this.pb_salir,&
this.tab_1}
end on

on w_busqueda.destroy
destroy(this.pb_insertar)
destroy(this.dw_1)
destroy(this.pb_salir)
destroy(this.tab_1)
end on

event resize;Integer		li_posic_x, li_posic_y, li_Ancho = 300, li_Alto = 245, li_Siguiente = 255
Long			maximo

IF tab_1.Width > dw_1.Width THEN
	maximo = tab_1.Width
ELSE
	maximo = dw_1.Width
END IF

This.Width		= maximo + 560

li_posic_x			=	This.WorkSpaceWidth() - 400
li_posic_y			=	108

pb_salir.width		=	li_Ancho
pb_salir.height		=	li_Alto
pb_salir.x			=	li_posic_x
pb_salir.y			=	li_posic_y

pb_insertar.x		=	pb_salir.x
pb_insertar.y		=	pb_salir.y + li_Siguiente
pb_insertar.width	=	li_Ancho
pb_insertar.height	=	li_Alto


tab_1.x			= 78
tab_1.y			= 69

dw_1.x			= 78
dw_1.y			= tab_1.Height + 136

end event

event open;dw_1.SetTransObject(sqlca)

dw_1.SetRowFocusIndicator(Hand!)

PostEvent("ue_ordenamiento")
/* En ventana heredada se debe setear variables como no selecionado */

is_ordena = 'Nombre Campo:nombre_campo,Otro Campo:otro_campo'
/* Esta Variable se utiliza para asignar los Conceptos por los cuales se puede
	realizar el ordenamiento de la dw_1.*/

This.Icon											=	Gstr_apl.Icono

If gs_Ambiente <> "Windows" Then dw_1.Object.DataWindow.Retrieve.AsNeeded	=	"Yes"
	
end event

event mousemove;w_main.SetMicroHelp("Ventana : " + ClassName())
end event

type pb_insertar from picturebutton within w_busqueda
event mousemove pbm_mousemove
string tag = "Inserta un Nuevo Registro"
integer x = 2578
integer y = 1024
integer width = 302
integer height = 244
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean cancel = true
string picturename = "\Repos\Resources\BTN\Aceptar.png"
string disabledname = "\Repos\Resources\BTN\Aceptar-bn.png"
alignment htextalign = left!
string powertiptext = "Inserta un Nuevo Registro"
long backcolor = 553648127
end type

event mousemove;RETURN w_main.SetMicroHelp(This.Tag)
end event

event clicked;istr_mant.dw		= dw_1
istr_mant.borra	= False
istr_mant.agrega	= True

//istr_mant.argumento[1]	= parametro de entrada (Filtro)
//
//OpenWithParm(iw_mantencion, istr_mant)
//
//Parent.TriggerEvent("ue_grabacion")
//
// La Ventana iw_mantencion debe ser la ventana del mantenedor de la tabla (se reemplaza).
end event

type dw_1 from datawindow within w_busqueda
event clicked pbm_dwnlbuttonclk
event doubleclicked pbm_dwnlbuttondblclk
event ue_teclas pbm_dwnkey
event ue_seteafila pbm_custom21
integer x = 78
integer y = 736
integer width = 2409
integer height = 864
integer taborder = 50
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;IF Row > 0 THEN
	This.SelectRow(0,False)
	This.SelectRow(Row,True)
	This.SetRow(Row)
END IF

/*
Para que funcione este ordenamiento los títulos deben tener el nombre
de la columna y terminacion "_t", de lo contrario no funcionará
*/
String	ls_old_sort, ls_column, ls_color_old
Char		lc_sort

IF IsNull(dwo) THEN RETURN

If Right(dwo.Name,2) = '_t' Then
	ls_column	= Left (dwo.Name, Len(String(dwo.Name)) - 2)
	ls_old_sort	= This.Describe("Datawindow.Table.sort")
	ls_color_old	=This.Describe(ls_Column + "_t.Color")

	If ls_column = Left(ls_old_sort, Len(ls_old_sort) - 2) Then
		lc_sort = Right(ls_old_sort, 1)
		If lc_sort = 'A' Then
			lc_sort = 'D'
		Else
			lc_sort = 'A'
		End If
		This.SetSort(ls_column+" "+lc_sort)
	Else
		This.SetSort(ls_column+" A")
		This.Modify(Left(ls_old_sort, Len(ls_old_sort) - 2) + "_t.Color = " + ls_color_old)
	End If
	
	This.Modify(dwo.Name + ".Color = " + String(Rgb(0, 0, 255)))
	
	This.Sort()
End If

end event

event doubleclicked;// Script no heredable. Se debe sobreescribir en objeto heredado 

IF row > 0 THEN
	Parent.PostEvent("ue_asignacion")
END IF
end event

event ue_teclas;IF KeyDown(KeyRightArrow!) OR KeyDown(KeyLeftArrow!) THEN RETURN -1

IF KeyDown(KeyDownArrow!) OR &
	KeyDown(KeyUpArrow!) OR &
	KeyDown(KeyPageUp!) OR &
	KeyDown(KeyPageDown!) OR &
	KeyDown(KeyEnd!) OR &
	KeyDown(KeyHome!) THEN
	PostEvent("ue_seteafila")
ELSEIF KeyDown(KeyEnter!) THEN
	Parent.PostEvent("ue_asignacion")
END IF
end event

event ue_seteafila;This.SelectRow(0, False)
This.SelectRow(This.GetRow(), True)
end event

type pb_salir from picturebutton within w_busqueda
event mousemove pbm_mousemove
string tag = "Salir [Cerrar Ventana Activa]"
integer x = 2574
integer y = 1328
integer width = 302
integer height = 244
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean cancel = true
string picturename = "\Repos\Resources\BTN\Apagar.png"
alignment htextalign = left!
string powertiptext = "Salir [Cerrar Ventana Activa]"
long backcolor = 553648127
end type

event mousemove;RETURN w_main.SetMicroHelp(This.Tag)
end event

event clicked;CloseWithReturn(Parent, istr_busq)
end event

type tab_1 from tab within w_busqueda
integer x = 78
integer y = 88
integer width = 2304
integer height = 636
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 553648127
boolean raggedright = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 2267
integer height = 508
long backcolor = 16777215
string text = "Filtros                        "
long tabtextcolor = 8388608
long tabbackcolor = 16777215
long picturemaskcolor = 553648127
pb_filtrar pb_filtrar
end type

on tabpage_1.create
this.pb_filtrar=create pb_filtrar
this.Control[]={this.pb_filtrar}
end on

on tabpage_1.destroy
destroy(this.pb_filtrar)
end on

type pb_filtrar from picturebutton within tabpage_1
event mousemove pbm_mousemove
string tag = "Lectura Según Filtros"
integer x = 1838
integer y = 328
integer width = 197
integer height = 172
integer taborder = 51
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean default = true
string picturename = "\Repos\Resources\BTN\Filtrar.png"
string disabledname = "\Repos\Resources\BTN\Filtrar-bn.png"
alignment htextalign = left!
string powertiptext = "Lectura Según Filtros"
long backcolor = 553648127
end type

event mousemove;RETURN w_main.SetMicroHelp(This.Tag)
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 2267
integer height = 508
long backcolor = 16777215
string text = "Ordenamiento            "
long tabtextcolor = 8388608
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
pb_acepta pb_acepta
dw_3 dw_3
dw_2 dw_2
end type

on tabpage_2.create
this.pb_acepta=create pb_acepta
this.dw_3=create dw_3
this.dw_2=create dw_2
this.Control[]={this.pb_acepta,&
this.dw_3,&
this.dw_2}
end on

on tabpage_2.destroy
destroy(this.pb_acepta)
destroy(this.dw_3)
destroy(this.dw_2)
end on

type pb_acepta from picturebutton within tabpage_2
event mousemove pbm_mousemove
string tag = "Realiza Ordenamiento"
integer x = 1824
integer y = 268
integer width = 233
integer height = 196
integer taborder = 11
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean default = true
string picturename = "\Desarrollo 17\Imagenes\Botones\Aceptar.png"
string disabledname = "\Desarrollo 17\Imagenes\Botones\Aceptar-bn.png"
alignment htextalign = left!
string powertiptext = "Realiza Ordenamiento"
long backcolor = 553648127
end type

event mousemove;RETURN w_main.SetMicroHelp(This.Tag)
end event

event clicked;Integer	li_rowcount, i
String	ls_campo, ls_orden, ls_sintaxis=""

li_rowcount = dw_3.RowCount()

IF li_rowcount = 0 THEN
	RETURN
END IF

FOR i = 1 TO li_rowcount
	ls_campo = Trim(dw_3.GetItemString (i,"campo"))
	ls_orden = Trim(dw_3.GetItemString (i,"ordena"))
	
	IF len(trim(ls_sintaxis)) > 0 THEN ls_sintaxis = ls_sintaxis + ","
	
	ls_sintaxis = ls_sintaxis + ls_campo + " " + ls_orden
NEXT

dw_1.SetSort(ls_sintaxis)
dw_1.Sort()
end event

type dw_3 from datawindow within tabpage_2
event ue_mousemove pbm_mousemove
integer x = 823
integer y = 44
integer width = 983
integer height = 400
integer taborder = 11
string dragicon = "\Desarrollo 12\Imagenes\Varios PNG\Row.ico"
boolean titlebar = true
string title = "Orden"
string dataobject = "d_columna_ordena"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_mousemove;IF This.IsSelected(This.GetRow()) AND message.WordParm = 1 THEN
	This.Drag(begin!)
END IF
end event

event clicked;IF row > 0 THEN
	This.SelectRow(0, False)
	This.SelectRow(row, True)
	This.SetRow(row)
END IF
end event

event dragdrop;DataWindow	ldw_Source
Long			ll_nueva
String		ls_nombre, ls_codigo

IF Source.typeof() = DataWindow! THEN
	ldw_Source = Source
	IF Source = Tab_1.tabpage_2.dw_3 THEN
		This.RowsMove(ldw_Source.GetRow(), ldw_Source.GetRow(), Primary!, This, row, Primary!)
		RETURN
	END IF
ELSE
	RETURN
END IF

ldw_Source.SelectRow(ldw_Source.GetRow(), False)

ls_nombre	= ldw_Source.GetItemString(ldw_Source.GetRow(), "nombre")
ls_codigo	= ldw_Source.GetItemString(ldw_Source.GetRow(), "campo")
		
IF This.Find("nombre='" + ls_nombre + "'",1,This.Rowcount()) = 0 THEN
	ll_nueva = This.InsertRow(row)

	This.SetItem(ll_nueva, "nombre", ls_nombre)
	This.SetItem(ll_nueva, "campo", ls_codigo)
	This.SetItem(ll_nueva, "ordena","a")
END IF
end event

type dw_2 from datawindow within tabpage_2
event ue_mousemove pbm_mousemove
integer x = 27
integer y = 44
integer width = 741
integer height = 400
integer taborder = 1
string dragicon = "\Desarrollo 12\Imagenes\Varios PNG\Row.ico"
boolean titlebar = true
string title = "Columnas"
string dataobject = "d_campos_orden"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_mousemove;IF This.IsSelected(GetRow()) AND message.WordParm = 1 THEN
	This.Drag(begin!)
END IF
end event

event clicked;IF row > 0 THEN
	This.SelectRow(0, False)
	This.SelectRow(row, True)
END IF
end event

event dragdrop;DataWindow	ldw_Source

IF source.TypeOf() = DataWindow! THEN 
	ldw_Source 	= 	source
	IF Source 	=	Tab_1.tabpage_2.dw_2 THEN
		RETURN
	END IF
ELSE
	RETURN
END IF

ldw_Source.DeleteRow(ldw_Source.GetRow())
end event

type tabpage_3 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 2267
integer height = 508
long backcolor = 16777215
string text = "Búsqueda                    "
long tabtextcolor = 8388608
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
sle_argumento2 sle_argumento2
st_argum2 st_argum2
sle_argumento1 sle_argumento1
st_argum1 st_argum1
pb_buscar pb_buscar
end type

on tabpage_3.create
this.sle_argumento2=create sle_argumento2
this.st_argum2=create st_argum2
this.sle_argumento1=create sle_argumento1
this.st_argum1=create st_argum1
this.pb_buscar=create pb_buscar
this.Control[]={this.sle_argumento2,&
this.st_argum2,&
this.sle_argumento1,&
this.st_argum1,&
this.pb_buscar}
end on

on tabpage_3.destroy
destroy(this.sle_argumento2)
destroy(this.st_argum2)
destroy(this.sle_argumento1)
destroy(this.st_argum1)
destroy(this.pb_buscar)
end on

type sle_argumento2 from singlelineedit within tabpage_3
integer x = 462
integer y = 204
integer width = 1051
integer height = 92
integer taborder = 15
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;is_argume	= This.Text
end event

event getfocus;// Este Script debe ser traspasado a ventana heredada para cambiar columna y/o agregar argumentos
This.SelectText(1, Len(This.Text))

This.Text						= ""
This.BackColor					= RGB(255,255,255)
This.TabOrder					= 10
sle_argumento1.Text			= ""
sle_argumento1.BackColor	= RGB(166,180,210)
sle_argumento1.TabOrder		= 0
es_numero						= False
is_busca							= "columna2"
end event

type st_argum2 from statictext within tabpage_3
integer x = 50
integer y = 208
integer width = 384
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 553648127
boolean enabled = false
string text = "Argumento 2"
boolean focusrectangle = false
end type

type sle_argumento1 from singlelineedit within tabpage_3
integer x = 462
integer y = 80
integer width = 1051
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;is_argume	= This.Text
end event

event getfocus;// Este Script debe ser traspasado a ventana heredada para cambiar columna y/o agregar argumentos
This.SelectText(1, Len(This.Text))


This.BackColor					= RGB(255,255,255)
This.TabOrder					= 10
sle_argumento2.Text			= ""
sle_argumento2.BackColor	= RGB(166,180,210)
sle_argumento2.TabOrder		= 0
es_numero						= True
is_busca							= "columna1"
end event

type st_argum1 from statictext within tabpage_3
integer x = 50
integer y = 92
integer width = 384
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 553648127
boolean enabled = false
string text = "Argumento 1"
boolean focusrectangle = false
end type

type pb_buscar from picturebutton within tabpage_3
event mousemove pbm_mousemove
string tag = "Realiza Búsqueda"
integer x = 1797
integer y = 288
integer width = 233
integer height = 196
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean default = true
string picturename = "\Desarrollo 17\Imagenes\Botones\Busqueda.png"
string disabledname = "\Desarrollo 17\Imagenes\Botones\Busqueda-bn.png"
alignment htextalign = left!
string powertiptext = "Realiza Búsqueda"
long backcolor = 553648127
end type

event mousemove;RETURN w_main.SetMicroHelp(This.Tag)
end event

event clicked;Long		ll_fila
Boolean	lb_inicio, lb_termino

dw_1.SetRedraw(False)

IF dw_1.RowCount() > 0 THEN
	dw_1.SetSort(is_busca + " A")
	dw_1.Sort()
	dw_1.SetFilter("")
	dw_1.Filter()

	tab_1.tabpage_2.dw_3.Reset()
	
	IF es_numero THEN
		ll_fila	=	dw_1.Find(is_busca + " >= " + is_argume, 1, dw_1.RowCount())
	ELSE
		IF Mid(is_argume, 1, 1) = "%" THEN
			lb_inicio	=	True
			is_argume	=	Mid(is_argume, 2)
		END IF
		
		IF Mid(is_argume, Len(is_argume)) = "%" THEN
			lb_termino	=	True
			is_argume	=	Mid(is_argume, 1, Len(is_argume) - 1)
		END IF
		
		IF Not lb_inicio THEN
			is_busca	=	"Mid(String(" + is_busca + "), 1, " + String(Len(is_argume)) + ")"
			ll_fila	=	dw_1.Find(is_busca + " >= '" + is_argume + "'", 1, dw_1.RowCount())
		ELSEIF lb_inicio THEN
			Is_busca	=	"Pos(Lower(String(" + is_busca + ")), '" + Lower(is_argume) + "') > 0"
			dw_1.SetFilter(Is_busca)
			dw_1.Filter()
		END IF
	END IF

	IF ll_fila = 0 THEN ll_fila = 1
	
	dw_1.SetRow(ll_fila)
	dw_1.ScrollToRow(ll_fila)
	dw_1.SelectRow(0,False)
	dw_1.SelectRow(ll_fila,True)
	dw_1.SetFocus()
	dw_1.SetRedraw(True)
END IF
end event

