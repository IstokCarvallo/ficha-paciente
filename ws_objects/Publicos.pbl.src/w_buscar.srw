$PBExportHeader$w_buscar.srw
forward
global type w_buscar from window
end type
type pb_acepta from picturebutton within w_buscar
end type
type pb_cancela from picturebutton within w_buscar
end type
type ddlb_1 from dropdownlistbox within w_buscar
end type
type em_dato from editmask within w_buscar
end type
type st_2 from statictext within w_buscar
end type
type st_1 from statictext within w_buscar
end type
type st_3 from statictext within w_buscar
end type
type st_4 from statictext within w_buscar
end type
end forward

global type w_buscar from window
integer x = 581
integer y = 732
integer width = 1792
integer height = 732
boolean titlebar = true
string title = "Búscar por:"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 16777215
string icon = "Question!"
pb_acepta pb_acepta
pb_cancela pb_cancela
ddlb_1 ddlb_1
em_dato em_dato
st_2 st_2
st_1 st_1
st_3 st_3
st_4 st_4
end type
global w_buscar w_buscar

type variables
string is_buscar
datawindow idw_buscar
end variables

event open;Integer		li_posi, li_idx
String		ls_temp, ls_buscar_info, tmp
str_parms	parm

setpointer(hourglass!)

This.Icon		=	Gstr_apl.Icono
parm				=	Message.PowerObjectParm
is_buscar		=	parm.string_arg[1]
idw_buscar		=	parm.dw_arg
ls_buscar_info	=	is_buscar

DO 
	li_posi	=	Pos(ls_buscar_info, ",")
	
	IF li_posi = 0 THEN
		ls_temp			=	ls_buscar_info 
		ls_buscar_info	=	""
	ELSE
		ls_temp			=	Left(ls_buscar_info, li_posi - 1)
		ls_buscar_info	=	Mid(ls_buscar_info, li_posi + 1)
	END IF
	
	li_posi	=	Pos(ls_temp, ":")
	ls_temp	=	Left(ls_temp, li_posi - 1)
	li_idx	++
	
	ddlb_1.InsertItem(ls_temp, li_idx)
LOOP UNTIL ls_buscar_info = "" OR li_idx = 10  

ddlb_1.SelectItem(1)
ddlb_1.SetFocus()

SetFocus(em_dato)
end event

on w_buscar.create
this.pb_acepta=create pb_acepta
this.pb_cancela=create pb_cancela
this.ddlb_1=create ddlb_1
this.em_dato=create em_dato
this.st_2=create st_2
this.st_1=create st_1
this.st_3=create st_3
this.st_4=create st_4
this.Control[]={this.pb_acepta,&
this.pb_cancela,&
this.ddlb_1,&
this.em_dato,&
this.st_2,&
this.st_1,&
this.st_3,&
this.st_4}
end on

on w_buscar.destroy
destroy(this.pb_acepta)
destroy(this.pb_cancela)
destroy(this.ddlb_1)
destroy(this.em_dato)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.st_4)
end on

type pb_acepta from picturebutton within w_buscar
event mousemove pbm_mousemove
string tag = "Realiza Búsqueda"
integer x = 1417
integer y = 32
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
string powertiptext = "Realiza Búsqueda"
long backcolor = 553648127
end type

event mousemove;RETURN w_main.SetMicroHelp(This.Tag)
end event

event clicked;Long		ll_fila,li
Integer	li_posi, li_idx
String	ls_buscar, ls_buscar_info, ls_temp, ls_dato

IF em_dato.Text = "" THEN
	MessageBox(Parent.Title, "Ingrese valor a buscar.")
	ddlb_1.SetFocus()
	
	RETURN
END IF

SetPointer(HourGlass!)

ls_buscar_info	=	is_buscar

DO
	li_posi	=	Pos(ls_buscar_info, ",")
	
	IF li_posi = 0 THEN
		ls_temp			=	ls_buscar_info 
		ls_buscar_info	=	""
	ELSE
		ls_temp			=	Left(ls_buscar_info, li_posi - 1)
		ls_buscar_info	=	Mid(ls_buscar_info, li_posi+1)
	END IF

	li_posi	=	Pos(ls_temp, ":")
	
	IF Left(ls_temp, li_posi - 1) = ddlb_1.Text THEN
		CHOOSE CASE Mid(ls_temp, li_posi + 1, 1)
			CASE "N"
				ls_dato		=	String(Long(em_dato.Text))
				ls_buscar	=	Mid(ls_temp, li_posi + 2) + " = " + ls_dato
				
			CASE "S"
				ls_dato		=	"'" + Upper(Trim(em_dato.Text)) + "'"
				ls_buscar	=	"Left(Upper(" + mid(ls_temp, li_posi + 2) + &
									")," + String(Len(ls_dato) - 2) + ") = " + ls_dato
			CASE "D"
				ls_dato		=	"Date('" + Trim(em_dato.Text) + "')"
				ls_buscar	=	Mid(ls_temp, li_posi + 2) + " = " + ls_dato
		END CHOOSE
		
		EXIT
	END IF
	
	li_idx ++
LOOP UNTIL IsNull(ls_buscar) OR li_idx = 10

ll_fila	=	idw_buscar.Find(ls_buscar, 1, idw_buscar.RowCount())

IF ll_fila > 0 THEN
	idw_buscar.ScrollToRow(ll_fila)	
	
	Close(Parent)
ELSE
	MessageBox(Parent.Title, "No encontrado " + ls_buscar)
	
	em_dato.SetFocus()
END IF
end event

type pb_cancela from picturebutton within w_buscar
event mousemove pbm_mousemove
string tag = "Cancela Búsqueda"
integer x = 1417
integer y = 272
integer width = 302
integer height = 244
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\Repos\Resources\BTN\Cancelar.png"
string disabledname = "\Repos\Resources\BTN\Cancelar-bn.png"
alignment htextalign = left!
string powertiptext = "Cancela Búsqueda"
long backcolor = 553648127
end type

event mousemove;RETURN w_main.SetMicroHelp(This.Tag)
end event

event clicked;Close(Parent)
end event

type ddlb_1 from dropdownlistbox within w_buscar
integer x = 526
integer y = 332
integer width = 754
integer height = 696
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type em_dato from editmask within w_buscar
integer x = 530
integer y = 128
integer width = 745
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
end type

type st_2 from statictext within w_buscar
integer x = 151
integer y = 348
integer width = 274
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 553648127
boolean enabled = false
string text = "Columna"
boolean focusrectangle = false
end type

type st_1 from statictext within w_buscar
integer x = 146
integer y = 140
integer width = 389
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 553648127
boolean enabled = false
string text = "Argumento"
boolean focusrectangle = false
end type

type st_3 from statictext within w_buscar
integer x = 78
integer y = 68
integer width = 1257
integer height = 208
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 16711680
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_4 from statictext within w_buscar
integer x = 78
integer y = 276
integer width = 1257
integer height = 208
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 16711680
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

