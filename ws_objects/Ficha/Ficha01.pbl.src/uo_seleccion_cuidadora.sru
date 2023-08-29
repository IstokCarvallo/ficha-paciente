$PBExportHeader$uo_seleccion_cuidadora.sru
$PBExportComments$Objeto público para selección de Cuidadora Particular, Todos o Consolidado
forward
global type uo_seleccion_cuidadora from userobject
end type
type cbx_consolida from checkbox within uo_seleccion_cuidadora
end type
type cbx_todos from checkbox within uo_seleccion_cuidadora
end type
type dw_seleccion from datawindow within uo_seleccion_cuidadora
end type
end forward

global type uo_seleccion_cuidadora from userobject
integer width = 896
integer height = 176
long backcolor = 553648127
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_cambio ( )
cbx_consolida cbx_consolida
cbx_todos cbx_todos
dw_seleccion dw_seleccion
end type
global uo_seleccion_cuidadora uo_seleccion_cuidadora

type variables
DataWindowChild	idwc_Seleccion

uo_cuidadora	iuo_Codigo

String		Codigo,Nombre, Telefono
End variables

forward prototypes
public subroutine of_seleccion (boolean ab_todos, boolean ab_consolida)
public subroutine of_limpiardatos ()
public subroutine of_todos (boolean ab_todos)
public subroutine of_bloquear (boolean ab_opcion)
public function boolean of_inicia (string as_codigo)
end prototypes

public subroutine of_seleccion (boolean ab_todos, boolean ab_consolida);cbx_Todos.Visible			=	ab_Todos
cbx_Consolida.Visible	=	ab_Consolida
 
If Not ab_Todos AND Not ab_Consolida Then
	dw_Seleccion.y			=	0
	dw_Seleccion.Enabled	=	True
	
	dw_Seleccion.Object.codigo.BackGround.Color	=	RGB(255, 255, 255)
Else
	dw_Seleccion.y			=	100
	dw_Seleccion.Enabled	=	False
	
	dw_Seleccion.Object.codigo.BackGround.Color	=	553648127
End If

Return
End subroutine

public subroutine of_limpiardatos ();String	ls_Nula

SetNull(ls_Nula)

dw_Seleccion.SetItem(1, "codigo", String(ls_Nula))
Codigo = (ls_Nula)
End subroutine

public subroutine of_todos (boolean ab_todos);If ab_Todos Then
	Codigo						=	'*'
	Nombre						=	'Todos'
	cbx_Todos.Checked		=	True
	cbx_Consolida.Enabled	=	True
	dw_Seleccion.Enabled	=	False
	
	dw_Seleccion.Object.codigo.BackGround.Color	=	553648127
	
	dw_Seleccion.Reset()
	
	dw_Seleccion.InsertRow(0)
Else
	SetNull(Codigo)
	SetNull(Nombre)
	
	cbx_Todos.Checked		=	False
	cbx_Consolida.Checked	=	False
	cbx_Consolida.Enabled	=	False
	dw_Seleccion.Enabled	=	True
	
	dw_Seleccion.Object.codigo[1]						=	Codigo
	dw_Seleccion.Object.codigo.BackGround.Color	=	RGB(255, 255, 255)
End If

Return
End subroutine

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

public function boolean of_inicia (string as_codigo);Integer	li_Nula
Boolean	lb_Retorno = False

SetNull(li_Nula)

If iuo_Codigo.of_Existe(as_codigo, False, sqlca) Then
	Codigo		=	iuo_Codigo.RUT
	Nombre		=	iuo_Codigo.Nombre
	Telefono 	=	iuo_Codigo.Telefono
	
	dw_Seleccion.SetItem(1, "codigo", as_codigo)
	lb_Retorno = True
Else
	dw_Seleccion.SetItem(1, "codigo", li_Nula)
End If

Return lb_Retorno 
end function

on uo_seleccion_cuidadora.create
this.cbx_consolida=create cbx_consolida
this.cbx_todos=create cbx_todos
this.dw_seleccion=create dw_seleccion
this.Control[]={this.cbx_consolida,&
this.cbx_todos,&
this.dw_seleccion}
end on

on uo_seleccion_cuidadora.destroy
destroy(this.cbx_consolida)
destroy(this.cbx_todos)
destroy(this.dw_seleccion)
end on

event constructor;dw_Seleccion.Object.Codigo.Dddw.Name			=	'dw_mues_cuidadora'
dw_Seleccion.Object.codigo.Dddw.DisplayColumn	=	'cupa_nrorut'
dw_Seleccion.Object.codigo.Dddw.DataColumn		=	'cupa_nombre'

dw_Seleccion.GetChild("codigo", idwc_Seleccion)

idwc_Seleccion.SetTransObject(sqlca)


If	idwc_Seleccion.Retrieve('*') = 0 Then
	MessageBox("Atención", "No existen Cuidadoras Particulares en tabla respectiva")
	
	SetNull(Codigo)
	SetNull(Nombre)
Else
	idwc_Seleccion.SetSort("cupa_nombre A")
	idwc_Seleccion.Sort()
	
	dw_Seleccion.Object.codigo.Font.Height	=	'-8'
	dw_Seleccion.Object.codigo.Height		=	64
	
	dw_Seleccion.InsertRow(0)
	
	Codigo			=	'*'
	Nombre			=	'Todas'
	iuo_Codigo   =	Create uo_cuidadora
	
	This.Of_Seleccion(True, True)
End If
End event

type cbx_consolida from checkbox within uo_seleccion_cuidadora
integer x = 480
integer width = 407
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
string text = "Consolidado"
end type

event clicked;If This.Checked Then
	Codigo	=	'**'
	Nombre	=	'Consolidada'
Else
	Codigo	=	'*'
	Nombre	=	'Todas'
End If

Parent.TriggerEvent("ue_cambio")
End event

type cbx_todos from checkbox within uo_seleccion_cuidadora
integer width = 402
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

event clicked;Of_Todos(This.Checked)

Parent.TriggerEvent("ue_cambio")
End event

type dw_seleccion from datawindow within uo_seleccion_cuidadora
integer y = 84
integer width = 882
integer height = 88
integer taborder = 30
string title = "none"
string dataobject = "dddw_codcaracteres"
boolean border = false
boolean livescroll = true
end type

event itemchanged;Integer	li_Nula

SetNull(li_Nula)

If iuo_Codigo.of_Existe(data, True, sqlca) Then
	Codigo	=	iuo_Codigo.RUT
	Nombre	=	iuo_Codigo.Nombre	
	Telefono 	=	iuo_Codigo.Telefono
Else
	This.SetItem(1, "codigo", li_Nula)
	Return 1
End If

Parent.TriggerEvent("ue_cambio")
end event

event itemerror;Return 1
End event

