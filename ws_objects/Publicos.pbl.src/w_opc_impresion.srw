$PBExportHeader$w_opc_impresion.srw
forward
global type w_opc_impresion from window
end type
type cb_file from commandbutton within w_opc_impresion
end type
type st_print_file from statictext within w_opc_impresion
end type
type st_pf from statictext within w_opc_impresion
end type
type ddlb_range from dropdownlistbox within w_opc_impresion
end type
type st_4 from statictext within w_opc_impresion
end type
type cb_printer from commandbutton within w_opc_impresion
end type
type cb_cancel from commandbutton within w_opc_impresion
end type
type cbx_print_to_file from checkbox within w_opc_impresion
end type
type st_3 from statictext within w_opc_impresion
end type
type sle_page_range from singlelineedit within w_opc_impresion
end type
type rb_pages from radiobutton within w_opc_impresion
end type
type rb_current_page from radiobutton within w_opc_impresion
end type
type rb_all from radiobutton within w_opc_impresion
end type
type em_copies from editmask within w_opc_impresion
end type
type st_2 from statictext within w_opc_impresion
end type
type st_1 from statictext within w_opc_impresion
end type
type cb_ok from commandbutton within w_opc_impresion
end type
type gb_1 from groupbox within w_opc_impresion
end type
type sle_printer from singlelineedit within w_opc_impresion
end type
end forward

global type w_opc_impresion from window
integer x = 672
integer y = 268
integer width = 2327
integer height = 1244
boolean titlebar = true
string title = "Opciones de Impresión"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 16777215
string icon = "Question!"
cb_file cb_file
st_print_file st_print_file
st_pf st_pf
ddlb_range ddlb_range
st_4 st_4
cb_printer cb_printer
cb_cancel cb_cancel
cbx_print_to_file cbx_print_to_file
st_3 st_3
sle_page_range sle_page_range
rb_pages rb_pages
rb_current_page rb_current_page
rb_all rb_all
em_copies em_copies
st_2 st_2
st_1 st_1
cb_ok cb_ok
gb_1 gb_1
sle_printer sle_printer
end type
global w_opc_impresion w_opc_impresion

type variables
string	is_page_range
str_info	istr_info
end variables

forward prototypes
public subroutine wf_enable_printfile ()
public subroutine wf_disable_printfile ()
private subroutine wf_page_range (radiobutton who)
end prototypes

public subroutine wf_enable_printfile ();//show all items related to choosing a file
st_pf.visible = true
st_print_file.visible = true
cb_file.visible = true
end subroutine

public subroutine wf_disable_printfile ();//hide all items related to choosing a file
st_pf.visible = false
st_print_file.visible = false
cb_file.visible = false
st_print_file.text = ''
end subroutine

private subroutine wf_page_range (radiobutton who);CHOOSE CASE Who
	CASE rb_all
		sle_page_range.Text		=	''
//		sle_page_range.Enabled	=	False
		is_page_range				=	'a'
	CASE rb_current_page
		sle_page_range.text		=	''
//		sle_page_range.enabled	=	False
		is_page_range				=	'c'
	CASE rb_pages	
//		sle_page_range.enabled	=	True
		is_page_range				=	'p'
END CHOOSE
end subroutine

event open;String	ls_rc

This.Icon			=	Gstr_apl.Icono
istr_info			=	Message.PowerObjectParm
This.Title			=	istr_info.Titulo
sle_printer.Text	=	istr_info.dw.Describe('datawindow.printer')

//Ajusta la inclusión de páginas a imprimir (all,even,odd)

ls_rc = istr_info.dw.Describe('datawindow.print.paper.size')
CHOOSE CASE trim(ls_rc) 
	CASE '0' 
		ddlb_range.SelectItem(1) 
		is_page_range = 'd'
	CASE '1' // even
		ddlb_range.SelectItem(2) 
		is_page_range = 'c'
	CASE '5' //odd
		ddlb_range.SelectItem(3) 
		is_page_range = 'o'
	CASE '13' //odd
		ddlb_range.SelectItem(4) 
		is_page_range = 'b'
	CASE '9' //odd
		ddlb_range.SelectItem(3) 
		is_page_range = 'a'
END CHOOSE

This.Title	= istr_info.titulo

//Rango de Páginas

ls_rc = istr_info.dw.Describe('datawindow.print.page.range')

IF ls_rc = "" THEN
	is_page_range = "a"
	rb_all.checked = True
ELSE
	is_page_range = "p"
	rb_pages.checked		= True
	sle_page_range.Text	= ls_rc
END IF

// Número de copias

If istr_info.copias = 0 THEN istr_info.copias = 1

em_copies.text = String(istr_info.copias)

//Impresión a archivo

ls_rc = istr_info.dw.Describe('datawindow.print.filename')

IF ls_rc <> "" AND ls_rc <>"!" THEN
	cbx_print_to_file.checked = True
	wf_enable_printfile()
	//strip the ~'s out of the file name to display properly
	ls_rc = f_global_replace(ls_rc,"~~","")
	st_print_file.text = ls_rc
ELSE
	cbx_print_to_file.checked = False
	wf_disable_printfile()
END IF
end event

on w_opc_impresion.create
this.cb_file=create cb_file
this.st_print_file=create st_print_file
this.st_pf=create st_pf
this.ddlb_range=create ddlb_range
this.st_4=create st_4
this.cb_printer=create cb_printer
this.cb_cancel=create cb_cancel
this.cbx_print_to_file=create cbx_print_to_file
this.st_3=create st_3
this.sle_page_range=create sle_page_range
this.rb_pages=create rb_pages
this.rb_current_page=create rb_current_page
this.rb_all=create rb_all
this.em_copies=create em_copies
this.st_2=create st_2
this.st_1=create st_1
this.cb_ok=create cb_ok
this.gb_1=create gb_1
this.sle_printer=create sle_printer
this.Control[]={this.cb_file,&
this.st_print_file,&
this.st_pf,&
this.ddlb_range,&
this.st_4,&
this.cb_printer,&
this.cb_cancel,&
this.cbx_print_to_file,&
this.st_3,&
this.sle_page_range,&
this.rb_pages,&
this.rb_current_page,&
this.rb_all,&
this.em_copies,&
this.st_2,&
this.st_1,&
this.cb_ok,&
this.gb_1,&
this.sle_printer}
end on

on w_opc_impresion.destroy
destroy(this.cb_file)
destroy(this.st_print_file)
destroy(this.st_pf)
destroy(this.ddlb_range)
destroy(this.st_4)
destroy(this.cb_printer)
destroy(this.cb_cancel)
destroy(this.cbx_print_to_file)
destroy(this.st_3)
destroy(this.sle_page_range)
destroy(this.rb_pages)
destroy(this.rb_current_page)
destroy(this.rb_all)
destroy(this.em_copies)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_ok)
destroy(this.gb_1)
destroy(this.sle_printer)
end on

type cb_file from commandbutton within w_opc_impresion
integer x = 1691
integer y = 976
integer width = 517
integer height = 124
integer taborder = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Archivo..."
end type

on clicked;string ls_temp 
string ls_file
int li_rc
li_rc = GetFileSaveName("Imprimir en Archivo", ls_file, ls_temp, "PRN", "Impreso (*.PRN),*.PRN")

If li_rc = 1 Then	st_print_file.text = ls_file
end on

type st_print_file from statictext within w_opc_impresion
integer x = 443
integer y = 1004
integer width = 1143
integer height = 96
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 553648127
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_pf from statictext within w_opc_impresion
integer x = 96
integer y = 1020
integer width = 320
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 553648127
boolean enabled = false
string text = "Archivo"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_range from dropdownlistbox within w_opc_impresion
integer x = 443
integer y = 872
integer width = 1143
integer height = 288
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "Definido en Windows"
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Definido en Windows","Carta 8,5 x 11 cm.","Oficio 8,5 x 14 cm.","B5 182 x 257 mm.","A4 210 x 297 mm."}
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_opc_impresion
integer x = 96
integer y = 884
integer width = 320
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 553648127
boolean enabled = false
string text = "P&apel"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_printer from commandbutton within w_opc_impresion
integer x = 1691
integer y = 360
integer width = 517
integer height = 124
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Impre&sora..."
end type

event clicked;PrintSetup()
sle_printer.text = istr_info.dw.Describe('datawindow.printer')
end event

type cb_cancel from commandbutton within w_opc_impresion
integer x = 1691
integer y = 204
integer width = 517
integer height = 124
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancelar"
boolean cancel = true
end type

on clicked;CloseWithReturn(Parent,-1)
end on

type cbx_print_to_file from checkbox within w_opc_impresion
integer x = 1655
integer y = 672
integer width = 594
integer height = 68
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 553648127
string text = "Imprimir &Archivo"
end type

on clicked;If this.checked Then
	wf_enable_printfile()
Else
	wf_disable_printfile()
End If
end on

type st_3 from statictext within w_opc_impresion
integer x = 160
integer y = 648
integer width = 1115
integer height = 128
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 553648127
boolean enabled = false
string text = "Ingresar número de página y/o  rangos de página. Por ejemplo, 2,5,8-10"
boolean focusrectangle = false
end type

type sle_page_range from singlelineedit within w_opc_impresion
integer x = 480
integer y = 548
integer width = 1047
integer height = 84
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event getfocus;rb_pages.Checked	=	True
is_page_range		=	'p'
end event

type rb_pages from radiobutton within w_opc_impresion
integer x = 128
integer y = 552
integer width = 357
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 553648127
string text = "Pá&ginas"
end type

on clicked;wf_page_range(this)
end on

type rb_current_page from radiobutton within w_opc_impresion
integer x = 128
integer y = 472
integer width = 489
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 553648127
string text = "&Página Actual"
end type

on clicked;wf_page_range(this)
end on

type rb_all from radiobutton within w_opc_impresion
integer x = 128
integer y = 388
integer width = 247
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 553648127
string text = "&Todo"
end type

on clicked;wf_page_range(this)
end on

type em_copies from editmask within w_opc_impresion
integer x = 384
integer y = 172
integer width = 242
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "1"
borderstyle borderstyle = stylelowered!
string mask = "###"
boolean spin = true
string displaydata = ""
double increment = 1
string minmax = "1~~999"
end type

type st_2 from statictext within w_opc_impresion
integer x = 128
integer y = 192
integer width = 229
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 553648127
boolean enabled = false
string text = "Copias"
boolean focusrectangle = false
end type

type st_1 from statictext within w_opc_impresion
integer x = 64
integer y = 56
integer width = 315
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 553648127
boolean enabled = false
string text = "Impresora:"
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_opc_impresion
integer x = 1691
integer y = 48
integer width = 517
integer height = 124
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Aceptar"
boolean default = true
end type

event clicked;String	tmp, command
Long		row 
String	docname, named
Integer	value

CHOOSE CASE Lower(Left(ddlb_range.text,1))
	CASE 'd' // Todas
		tmp = '0'
	CASE 'c' // Impares
		tmp = '1'
	CASE 'o' //Pares
		tmp = '5'
	CASE 'b' //Pares
		tmp = '13'
	CASE 'a' //Pares
		tmp = '9'
END CHOOSE
command = "datawindow.print.DocumentName = '" + istr_info.Titulo + "'"
command = command + 'datawindow.print.paper.size = ' + tmp

CHOOSE CASE is_page_range // Selección de un Rango de Páginas
	CASE 'a'  // Todas
		tmp = ''
	CASE 'c' // Página Actual
		row = istr_info.dw.getrow()
		tmp = istr_info.dw.describe("evaluate('page()',"+string(row)+")")
	CASE 'p' // Un Rango
		tmp = sle_page_range.text
END CHOOSE

IF len(tmp) > 0 THEN command = command +  " datawindow.print.page.range = '"+tmp+"'"

// Número de copias
IF len(em_copies.text) > 0 THEN command = command +  " datawindow.print.copies = "+em_copies.text

IF cbx_print_to_file.checked  THEN
	IF len(trim(st_print_file.text)) = 0 THEN 
		value = GetFileSaveName("Imprimir en Archivo", docname, named, "PRN", "Impreso (*.PRN),*.PRN")
	ELSE
		value		= 1
		docname	= st_print_file.text
	END IF
	
	IF value = 1 THEN
		command = command + " datawindow.print.filename = '"+docname+"'"
	ELSE
		RETURN
	END IF
END IF

tmp = istr_info.dw.modify(command)

IF len(tmp) > 0 THEN
	MessageBox('Error en Opciones de Impresión','mensaje de error = ' + tmp + '~r~nComando = ' + command)
	RETURN
END IF

CloseWithReturn(Parent,1)
end event

type gb_1 from groupbox within w_opc_impresion
integer x = 64
integer y = 304
integer width = 1522
integer height = 524
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 553648127
string text = "Rango de Página"
end type

type sle_printer from singlelineedit within w_opc_impresion
integer x = 384
integer y = 48
integer width = 1216
integer height = 92
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

