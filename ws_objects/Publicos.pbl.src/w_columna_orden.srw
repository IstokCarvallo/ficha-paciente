$PBExportHeader$w_columna_orden.srw
forward
global type w_columna_orden from window
end type
type pb_salir from picturebutton within w_columna_orden
end type
type pb_acepta from picturebutton within w_columna_orden
end type
type dw_2 from datawindow within w_columna_orden
end type
type st_2 from statictext within w_columna_orden
end type
type st_1 from statictext within w_columna_orden
end type
type dw_1 from datawindow within w_columna_orden
end type
type st_3 from statictext within w_columna_orden
end type
end forward

global type w_columna_orden from window
integer x = 695
integer y = 404
integer width = 2341
integer height = 1072
boolean titlebar = true
string title = "Orden"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 16777215
string icon = "Exclamation!"
pb_salir pb_salir
pb_acepta pb_acepta
dw_2 dw_2
st_2 st_2
st_1 st_1
dw_1 dw_1
st_3 st_3
end type
global w_columna_orden w_columna_orden

type variables
DataWindow	idw_orden

end variables

forward prototypes
public subroutine wf_chequea_seleccion (datawindow adw_orden, ref string as_seleccion)
end prototypes

public subroutine wf_chequea_seleccion (datawindow adw_orden, ref string as_seleccion);String ls_objetos,ls_nombre_columna, ls_tipo, ls_columnas, ls_buscar_info, ls_temp
Integer li_i,ret,li_idx = 1
 					 
ls_objetos = adw_orden.Object.DataWindow.Objects
ls_buscar_info	=	as_seleccion

li_i = Pos(ls_objetos,'~t')

DO WHILE ls_objetos <> ""
	ls_nombre_columna = Left(ls_objetos,li_i - 1)
	ls_tipo    = adw_orden.Describe( ls_nombre_columna + ".type")
	IF ls_tipo ='column' THEN
		ls_columnas=ls_columnas+" "+ls_nombre_columna+','
	END IF
	ls_objetos = Mid(ls_objetos,li_i + 1)
	li_i = Pos(ls_objetos,'~t')
	If li_i = 0 THEN li_i = Len(ls_objetos) + 1
LOOP

DO
	li_i = pos(ls_buscar_info,",")
	if li_i = 0 then 
		ls_temp = ls_buscar_info 
		ls_buscar_info = ""
	else	
		ls_temp = left(ls_buscar_info, li_i - 1)
		ls_buscar_info = mid(ls_buscar_info, li_i+1)
	end if
	
	li_i = pos(ls_temp, ":")
	
	IF Pos(ls_columnas,mid(ls_temp, li_i + 1)) > 0 THEN
		li_idx=dw_1.insertrow(0)
		dw_1.setitem(li_idx,"campo",mid(ls_temp, li_i + 1))
		dw_1.setitem(li_idx,"nombre",left(ls_temp, li_i - 1))
		li_idx = li_idx + 1
	END IF
		
loop until ls_buscar_info = ""

IF dw_1.RowCount()=0 THEN
	DO
		li_i = pos(ls_columnas,", ")
		if li_i = 0 then 
			ls_temp = Mid(ls_columnas,2,Len(ls_columnas)-2)
			ls_columnas = ""
		else	
			ls_temp = left(ls_columnas, li_i - 1)
			ls_temp = Trim(ls_temp)
			ls_columnas = mid(ls_columnas, li_i+1)
		end if
		
		li_idx=dw_1.insertrow(0)
		dw_1.setitem(li_idx,"campo",ls_temp)
		dw_1.setitem(li_idx,"nombre",ls_temp)
		li_idx = li_idx + 1
		
	LOOP UNTIL ls_columnas = ""
END IF
end subroutine

event open;Integer li_posi, li_idx
String  ls_temp, ls_buscar_info, tmp, ls_seleccion
str_parms parm

setpointer(hourglass!)
w_main.SetMicroHelp("Cargando Ordenamiento...")
parm = message.powerobjectparm
idw_orden = parm.dw_arg
li_idx = 1
ls_seleccion = parm.string_arg[1]

wf_chequea_seleccion(idw_orden, ls_seleccion)

dw_1.setsort("nombre A")
dw_1.sort()
setfocus(dw_1)
w_main.SetMicroHelp("Listo")
end event

on w_columna_orden.create
this.pb_salir=create pb_salir
this.pb_acepta=create pb_acepta
this.dw_2=create dw_2
this.st_2=create st_2
this.st_1=create st_1
this.dw_1=create dw_1
this.st_3=create st_3
this.Control[]={this.pb_salir,&
this.pb_acepta,&
this.dw_2,&
this.st_2,&
this.st_1,&
this.dw_1,&
this.st_3}
end on

on w_columna_orden.destroy
destroy(this.pb_salir)
destroy(this.pb_acepta)
destroy(this.dw_2)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.st_3)
end on

type pb_salir from picturebutton within w_columna_orden
event clicked pbm_bnclicked
event mousemove pbm_mousemove
string tag = "Salir"
integer x = 1966
integer y = 664
integer width = 302
integer height = 244
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean cancel = true
string picturename = "\Desarrollo 17\Imagenes\Botones\Apagar.png"
string disabledname = "\Desarrollo 17\Imagenes\Botones\Apagar-bn.png"
alignment htextalign = left!
string powertiptext = "Salir"
end type

event clicked;Close(Parent)
end event

event mousemove;RETURN w_main.SetMicroHelp(This.Tag)
end event

type pb_acepta from picturebutton within w_columna_orden
event clicked pbm_bnclicked
event mousemove pbm_mousemove
string tag = "Realiza el Ordenamiento"
integer x = 1970
integer y = 400
integer width = 302
integer height = 244
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean default = true
string picturename = "\Repos\Resources\BTN\Aceptar.png"
string disabledname = "\Repos\Resources\BTN\Aceptar-bn.png"
alignment htextalign = left!
string powertiptext = "Realiza el Ordenamiento"
end type

event clicked;Integer li_rowcount, i
String ls_campo, ls_orden, ls_sintaxis=""

li_rowcount = dw_2.rowcount()

IF li_rowcount = 0 THEN
	Close(Parent)
	RETURN
END IF

FOR i = 1 TO li_rowcount
	ls_campo = Trim(dw_2.GetItemString (i,"campo"))
	ls_orden = Trim(dw_2.GetItemString (i,"ordena"))
	
	IF len(trim(ls_sintaxis)) > 0 THEN ls_sintaxis = ls_sintaxis + ","
	
	ls_sintaxis = ls_sintaxis + ls_campo + " " + ls_orden
NEXT

idw_orden.SetSort(ls_sintaxis)
idw_orden.Sort()

Close(Parent)
end event

event mousemove;RETURN w_main.SetMicroHelp(This.Tag)
end event

type dw_2 from datawindow within w_columna_orden
event ue_mousemove pbm_mousemove
integer x = 850
integer y = 344
integer width = 992
integer height = 564
integer taborder = 50
string dragicon = "\Desarrollo\Bmp\Row.ico"
boolean titlebar = true
string title = "Columnas"
string dataobject = "d_columna_ordena"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_mousemove;IF This.IsSelected(This.GetRow()) AND message.WordParm = 1 THEN
	This.Drag(begin!)
END IF
end event

event dragdrop;DataWindow	ldw_Source
Long			ll_fila, new_row
String		dwstr, dropped_rep_id, dropped_campo

IF Source.typeof() = DataWindow! THEN
	ldw_Source = Source
ELSE
	RETURN
END IF

FOR ll_fila = 1 TO ldw_Source.Rowcount()
	IF ldw_Source.IsSelected(ll_fila) THEN
		ldw_Source.SelectRow(ll_fila,False)
		dropped_rep_id	= ldw_Source.GetItemString(ll_fila,"nombre")
		dropped_campo	= ldw_Source.GetItemString(ll_fila,"campo")
		
		IF This.Find("nombre='" + dropped_rep_id + "'",1,This.Rowcount()) > 0 THEN
			messagebox("Error","Columna ya existe en el Orden.")
		ELSE
			new_row = This.InsertRow(0)
			This.SetItem(new_row, "nombre",dropped_rep_id)
			This.SetItem(new_row, "campo",dropped_campo)
			This.SetItem(new_row, "ordena","a")
		END IF
	END IF
NEXT
end event

event clicked;IF This.IsSelected(row) THEN
	RETURN
ELSE
	This.SelectRow(0,False)
	This.SelectRow(row,True)
	This.SetRow(row)
END IF
end event

type st_2 from statictext within w_columna_orden
integer x = 142
integer y = 192
integer width = 1175
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean italic = true
long textcolor = 16777215
long backcolor = 553648127
boolean enabled = false
string text = "2) Arrastrar (sin soltar) al area de columnas"
boolean focusrectangle = false
end type

type st_1 from statictext within w_columna_orden
integer x = 142
integer y = 116
integer width = 1175
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean italic = true
long textcolor = 16777215
long backcolor = 553648127
boolean enabled = false
string text = "1) Seleccione una columna en origen"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_columna_orden
event ue_mousemove pbm_mousemove
integer x = 78
integer y = 344
integer width = 727
integer height = 564
integer taborder = 30
string dragicon = "\Desarrollo\Bmp\Row.ico"
boolean titlebar = true
string title = "Origen"
string dataobject = "d_campos_orden"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_mousemove;IF This.IsSelected(GetRow()) AND message.WordParm = 1 THEN
	This.Drag(begin!)
END IF
end event

event clicked;IF This.IsSelected(row) THEN
	RETURN
ELSE
	This.SelectRow(0,False)
	This.SelectRow(row,True)
	This.SetRow(row)
END IF


end event

event dragdrop;DataWindow	ldw_Source
Long			ll_fila

IF source.TypeOf() = DataWindow! THEN 
	ldw_Source = source
	IF Source = This THEN
		RETURN
	END IF
ELSE
	RETURN
END IF

ll_fila = ldw_Source.GetSelectedRow(0) 

DO WHILE ll_fila > 0
	ldw_Source.DeleteRow(ll_fila)
	ll_fila = ldw_Source.GetSelectedRow(0) 
LOOP
end event

type st_3 from statictext within w_columna_orden
integer x = 78
integer y = 68
integer width = 1765
integer height = 240
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16711680
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

