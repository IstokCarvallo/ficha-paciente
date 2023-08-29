$PBExportHeader$uo_seleccion_isapre.sru
$PBExportComments$Objeto público para selección de Isapres, Todos o Consolidado
forward
global type uo_seleccion_isapre from userobject
end type
type cbx_consolida from checkbox within uo_seleccion_isapre
end type
type cbx_todos from checkbox within uo_seleccion_isapre
end type
type dw_seleccion from datawindow within uo_seleccion_isapre
end type
end forward

global type uo_seleccion_isapre from userobject
integer width = 896
integer height = 180
long backcolor = 553648127
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_cambio ( )
cbx_consolida cbx_consolida
cbx_todos cbx_todos
dw_seleccion dw_seleccion
end type
global uo_seleccion_isapre uo_seleccion_isapre

type variables
DataWindowChild	idwc_Seleccion

uo_Isapre	iuo_Codigo

Integer	Codigo
String		Nombre, RUT, Abreviacion
end variables

forward prototypes
public function boolean of_inicia (integer ai_codigo)
public subroutine of_bloquear (boolean ab_opcion)
public subroutine of_limpiardatos (integer a)
public subroutine of_todos (boolean ab_todos)
public subroutine of_seleccion (boolean ab_todos, boolean ab_consolida)
end prototypes

public function boolean of_inicia (integer ai_codigo);Integer	li_Nula
Boolean	lb_Retorno = False

SetNull(li_Nula)

If iuo_Codigo.of_Existe(ai_codigo, False, sqlca) Then
	Codigo		=	iuo_Codigo.Codigo
	Nombre		=	iuo_Codigo.Nombre
	RUT			=	iuo_Codigo.RUT
	Abreviacion	=	iuo_Codigo.Abreviacion
	
	dw_Seleccion.SetItem(1, "codigo", ai_codigo)
	lb_Retorno = True
Else
	dw_Seleccion.SetItem(1, "codigo", li_Nula)
End If

Return lb_Retorno 
end function

public subroutine of_bloquear (boolean ab_opcion);If ab_opcion Then
	dw_Seleccion.Enabled								= False
	dw_Seleccion.Object.Codigo.Color					=	RGB(255, 255, 255)
	dw_Seleccion.Object.Codigo.BackGround.Color	=	553648127
Else
	dw_Seleccion.Enabled								= True
	dw_Seleccion.Object.Codigo.Color					=	0
	dw_Seleccion.Object.Codigo.BackGround.Color	=	RGB(255, 255, 255)
End If
end subroutine

public subroutine of_limpiardatos (integer a);String	ls_Nula

SetNull(ls_Nula)

dw_Seleccion.SetItem(1, "codigo", Long(ls_Nula))
Codigo = Long(ls_Nula)
end subroutine

public subroutine of_todos (boolean ab_todos);If ab_Todos Then
	Codigo						=	-1
	Nombre						=	'Todos'
	cbx_Todos.Checked		=	True
	cbx_Consolida.Enabled	=	True
	dw_Seleccion.Enabled	=	False
	
	dw_Seleccion.Object.codigo.Color					=	RGB(255, 255, 255)
	dw_Seleccion.Object.codigo.BackGround.Color	=	553648127
	
	dw_Seleccion.Reset()
	dw_Seleccion.InsertRow(0)
Else
	SetNull(Codigo)
	SetNull(Nombre)
	
	cbx_Todos.Checked			=	False
	cbx_Consolida.Checked	=	False
	cbx_Consolida.Enabled	=	False
	dw_Seleccion.Enabled		=	True
	
	dw_Seleccion.Object.codigo[1]						=	Codigo
	dw_Seleccion.Object.codigo.Color					=	0
	dw_Seleccion.Object.codigo.BackGround.Color	=	RGB(255, 255, 255)
End If
end subroutine

public subroutine of_seleccion (boolean ab_todos, boolean ab_consolida);cbx_Todos.Visible		=	ab_Todos
cbx_Consolida.Visible	=	ab_Consolida

IF Not ab_Todos AND Not ab_Consolida THEN
	dw_Seleccion.y				=	0
	dw_Seleccion.Enabled	=	True
	
	dw_Seleccion.Object.codigo.Color					=	0
	dw_Seleccion.Object.codigo.BackGround.Color	=	RGB(255, 255, 255)
ELSE
	dw_Seleccion.y				=	100
	dw_Seleccion.Enabled	=	False
	
	dw_Seleccion.Object.codigo.Color					=	RGB(255, 255, 255)
	dw_Seleccion.Object.codigo.BackGround.Color	=	553648127
End If
end subroutine

on uo_seleccion_isapre.create
this.cbx_consolida=create cbx_consolida
this.cbx_todos=create cbx_todos
this.dw_seleccion=create dw_seleccion
this.Control[]={this.cbx_consolida,&
this.cbx_todos,&
this.dw_seleccion}
end on

on uo_seleccion_isapre.destroy
destroy(this.cbx_consolida)
destroy(this.cbx_todos)
destroy(this.dw_seleccion)
end on

event constructor;dw_Seleccion.Object.Codigo.Dddw.Name			=	'dw_mues_isapre'
dw_Seleccion.Object.codigo.Dddw.DisplayColumn	=	'isap_nombre'
dw_Seleccion.Object.codigo.Dddw.DataColumn		=	'isap_codigo'

dw_Seleccion.GetChild("codigo", idwc_Seleccion)
idwc_Seleccion.SetTransObject(sqlca)

cbx_Todos.FaceName		=	"Tahoma"
cbx_consolida.FaceName	=	"Tahoma"
cbx_Todos.TextColor		=	RGB(255,255,255)
cbx_consolida.TextColor	=	RGB(255,255,255)

IF	idwc_Seleccion.Retrieve() = 0 THEN
	MessageBox("Atención", "No existen en tabla respectiva")
	
	SetNull(Codigo)
	SetNull(Nombre)
ELSE
	idwc_Seleccion.SetSort("isap_nombre A")
	idwc_Seleccion.Sort()
	
	dw_Seleccion.Object.codigo.Font.Height	=	'-8'
	dw_Seleccion.Object.codigo.Height		=	64
	
	dw_Seleccion.SetTransObject(sqlca)
	dw_Seleccion.InsertRow(0)
	
	Codigo		=	-1
	Nombre		=	'Todas'
	iuo_Codigo	=	Create uo_Isapre
	
	This.of_Seleccion(True, True)
END IF

end event

type cbx_consolida from checkbox within uo_seleccion_isapre
integer x = 466
integer width = 425
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = " Consolidado"
end type

event clicked;IF This.Checked THEN
	Codigo	=	-9
	Nombre	=	'Consolidada'
	cbx_todos.Checked = False
	dw_Seleccion.Reset()
	dw_Seleccion.InsertRow(0)
ELSE
	Codigo	=	-1
	Nombre	=	'Todas'
	dw_seleccion.SetFocus()
END IF

Parent.TriggerEvent("ue_cambio")
end event

type cbx_todos from checkbox within uo_seleccion_isapre
integer width = 315
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Todos"
boolean checked = true
end type

event clicked;of_Todos(This.Checked)
cbx_consolida.Checked = False

Parent.TriggerEvent("ue_cambio")
end event

type dw_seleccion from datawindow within uo_seleccion_isapre
integer y = 84
integer width = 882
integer height = 96
integer taborder = 30
string title = "none"
string dataobject = "dddw_codnumero"
boolean border = false
boolean livescroll = true
end type

event itemchanged;Integer	li_Nula

SetNull(li_Nula)

dw_seleccion.PostEvent(Clicked!)

IF iuo_Codigo.of_Existe(Integer(data), True, sqlca) THEN
	Codigo		=	iuo_Codigo.Codigo
	Nombre		=	iuo_Codigo.Nombre
	Rut			=	iuo_Codigo.RUT
	Abreviacion	=	iuo_Codigo.Abreviacion
ELSE
	This.SetItem(1, "codigo", li_Nula)

	RETURN 1
END IF

Parent.TriggerEvent("ue_cambio")
end event

event itemerror;RETURN 1
end event

event clicked;cbx_todos.Checked = False
cbx_consolida.Checked = False
end event

