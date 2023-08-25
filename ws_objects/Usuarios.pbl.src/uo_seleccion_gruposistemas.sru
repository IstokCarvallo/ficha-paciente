$PBExportHeader$uo_seleccion_gruposistemas.sru
$PBExportComments$Objeto público para selección de version de sistemas
forward
global type uo_seleccion_gruposistemas from userobject
end type
type cbx_consolida from checkbox within uo_seleccion_gruposistemas
end type
type cbx_todos from checkbox within uo_seleccion_gruposistemas
end type
type dw_seleccion from datawindow within uo_seleccion_gruposistemas
end type
end forward

global type uo_seleccion_gruposistemas from userobject
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
global uo_seleccion_gruposistemas uo_seleccion_gruposistemas

type variables
DataWindowChild	idwc_Seleccion

Integer	Codigo, Sistema
String  	Nombre

uo_gruposistema	iuo_Codigo


End variables

forward prototypes
public subroutine of_filtra (integer ai_codigo)
public subroutine of_bloquear (boolean ab_opcion)
public function boolean of_inicia (integer ai_codigo)
public subroutine of_limpiardatos ()
public subroutine of_seleccion (boolean ab_todos, boolean ab_consolida)
public subroutine of_todos (boolean ab_todos)
end prototypes

public subroutine of_filtra (integer ai_codigo);Sistema	=	ai_Codigo
 
dw_Seleccion.GetChild("codigo", idwc_Seleccion)

idwc_Seleccion.SetTransObject(sqlca)

If idwc_Seleccion.Retrieve(Sistema) = 0 Then
	MessageBox("Atención", "No existen Variedades para Especie seleccionada.")
	
	SetNull(Codigo)
	SetNull(Nombre)
End If
End subroutine

public subroutine of_bloquear (boolean ab_opcion);If ab_opcion Then
	dw_Seleccion.Enabled	= False
	dw_Seleccion.Object.Codigo.Color					=	RGB(255, 255, 255)
	dw_Seleccion.Object.Codigo.BackGround.Color	=	553648127
Else
	dw_Seleccion.Enabled	= True
	dw_Seleccion.Object.Codigo.Color					=	0
	dw_Seleccion.Object.Codigo.BackGround.Color	=	RGB(255, 255, 255)
End If
End subroutine

public function boolean of_inicia (integer ai_codigo);Integer	li_Nula
Boolean	lb_Retorno = False

SetNull(li_Nula)

If iuo_Codigo.of_Existe(Sistema, ai_Codigo, False, sqlca) Then
	Sistema	=	iuo_Codigo.Sistema
	Codigo	=	iuo_Codigo.Grupo
	Nombre	=	iuo_Codigo.Nombre
		
	dw_Seleccion.SetItem(1, "codigo", ai_Codigo)
	lb_Retorno = True
Else
	dw_Seleccion.SetItem(1, "codigo", li_Nula)
End If

Return lb_Retorno 
end function

public subroutine of_limpiardatos ();String	ls_Nula

SetNull(ls_Nula)

dw_Seleccion.SetItem(1, "codigo", Long(ls_Nula))
Codigo = Long(ls_Nula)
End subroutine

public subroutine of_seleccion (boolean ab_todos, boolean ab_consolida);cbx_Todos.Visible		=	ab_Todos
cbx_Consolida.Visible	=	ab_Consolida
 
If Not ab_Todos AND Not ab_Consolida Then
	dw_Seleccion.y				=	0
	dw_Seleccion.Enabled	=	True
	
	dw_Seleccion.Object.Codigo.Color					=	0
	dw_Seleccion.Object.codigo.BackGround.Color	=	RGB(255, 255, 255)
Else
	dw_Seleccion.y				=	84
	dw_Seleccion.Enabled	=	False
	
	dw_Seleccion.Object.Codigo.Color					=	RGB(255, 255, 255)
	dw_Seleccion.Object.codigo.BackGround.Color	=	553648127
End If
End subroutine

public subroutine of_todos (boolean ab_todos);If ab_Todos Then
	Codigo						=	-1
	Nombre						=	'Todos'
	cbx_Todos.Checked		=	True
	cbx_Consolida.Enabled	=	True
	dw_Seleccion.Enabled	=	False
	
	dw_Seleccion.Object.Codigo.Color					=	RGB(255, 255, 255)
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
	dw_Seleccion.Object.Codigo.Color					=	0
	dw_Seleccion.Object.codigo.BackGround.Color	=	RGB(255, 255, 255)
End If
End subroutine

on uo_seleccion_gruposistemas.create
this.cbx_consolida=create cbx_consolida
this.cbx_todos=create cbx_todos
this.dw_seleccion=create dw_seleccion
this.Control[]={this.cbx_consolida,&
this.cbx_todos,&
this.dw_seleccion}
end on

on uo_seleccion_gruposistemas.destroy
destroy(this.cbx_consolida)
destroy(this.cbx_todos)
destroy(this.dw_seleccion)
end on

event constructor;dw_Seleccion.Object.Codigo.Dddw.Name			=	'dw_mues_admagruposistema'
dw_Seleccion.Object.codigo.Dddw.DisplayColumn	=	'grpo_nombre'
dw_Seleccion.Object.codigo.Dddw.DataColumn		=	'grpo_codigo'

dw_Seleccion.GetChild("codigo", idwc_Seleccion)
idwc_Seleccion.SetTransObject(sqlca)

cbx_Todos.FaceName		=	"Tahoma"
cbx_consolida.FaceName	=	"Tahoma"
cbx_Todos.TextColor		=	RGB(255,255,255)
cbx_consolida.TextColor	=	RGB(255,255,255)

If	idwc_Seleccion.Retrieve(-1) = 0 Then
	MessageBox("Atención", "No existen Sistemas en tabla respectiva")
	
	SetNull(Codigo)
	SetNull(Nombre)
Else
	idwc_Seleccion.SetSort("grpo_nombre A")
	idwc_Seleccion.Sort()
	
	dw_Seleccion.Object.codigo.Font.Height	=	'-8'
	dw_Seleccion.Object.codigo.Height		=	64
	
	dw_Seleccion.InsertRow(0)
	
	Codigo		=	-1
	Nombre		=	'Todas'
	iuo_Codigo 	=	Create uo_gruposistema
	
	This.of_Seleccion(True, True)
End If
end event

type cbx_consolida from checkbox within uo_seleccion_gruposistemas
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
	Codigo	=	-9
	Nombre	=	'Consolidada'
Else
	Codigo	=	-1
	Nombre	=	'Todas'
End If
Parent.TriggerEvent("ue_cambio")
End event

type cbx_todos from checkbox within uo_seleccion_gruposistemas
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
Parent.TriggerEvent("ue_cambio")
End event

type dw_seleccion from datawindow within uo_seleccion_gruposistemas
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

If iuo_Codigo.of_Existe(Sistema, Integer(Data), True, sqlca) Then
	Sistema	=	iuo_Codigo.Sistema
	Codigo	=	iuo_Codigo.Grupo
	Nombre	=	iuo_Codigo.Nombre
Else
	This.SetItem(1, "codigo", li_Nula)

	Return 1
End If

Parent.TriggerEvent("ue_cambio")
end event

event itemerror;Return 1
End event

