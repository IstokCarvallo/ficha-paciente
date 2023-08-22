$PBExportHeader$uo_dw.sru
forward
global type uo_dw from datawindow
end type
type col_struct from structure within uo_dw
end type
type validation_struct from structure within uo_dw
end type
end forward

type col_struct from structure
    integer tab
    string col
end type

type Validation_struct from structure
    string expression
    string error_message
end type

global type uo_dw from datawindow
integer width = 709
integer height = 364
integer taborder = 1
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
event on_delete pbm_custom17
event on_insert pbm_custom16
event on_update pbm_custom15
event ue_deshace pbm_custom44
event ue_columnacambia pbm_custom59
event dwnkey pbm_dwnkey
event ue_seteafila pbm_custom21
event ue_nomover pbm_syscommand
end type
global uo_dw uo_dw

type variables
Boolean				ib_allow_updates	=	True, ib_allow_inserts	=	True
Long					il_selected_row
DataStore			ids_CtlRep
DateTime				GrupoFecha

Private:
validation_struct istr_validations[]
end variables

forward prototypes
public subroutine uf_add_validation (string expression, string error_message)
public function boolean uf_validate (long row)
public function boolean uf_is_modified ()
public function boolean uf_check_required (integer num_dw)
end prototypes

event ue_nomover;uint wParam, lParam

wParam = Message.WordParm

Choose Case wParam
	Case 61456, 61458
	     Message.Processed = True
	     Message.ReturnValue = 0

End Choose
end event

public subroutine uf_add_validation (string expression, string error_message);int cnt

cnt = upperbound(istr_validations) + 1

istr_validations[cnt].expression = expression

istr_validations[cnt].error_message = error_message
end subroutine

public function boolean uf_validate (long row);window current_win
int expr,num_expr
string error_msg,result
boolean one_time
num_expr = upperbound(istr_validations)
if num_expr = 0 then return true // if no rules then get out right away
if this.accepttext() = -1 then return false
error_msg = ""
if row <> 0 then
	one_time = true
else
	one_time = false
	row = this.getnextmodified(0,primary!)
end if
do while row > 0 
	for expr = 1 to num_expr
		result =  this.describe("evaluate('"+istr_validations[expr].expression+"',"+string(row)+")")
		if result <> 'true' then
			error_msg = istr_validations[expr].error_message
			Exit
		END IF
	next
	if len(error_msg) > 0 then // there is an error
		this.setrow(row)
		this.scrolltorow(row)
		current_win = parent // get the current window title for the error message
		messagebox(current_win.title+" en la fila "+string(row),error_msg)
		this.setfocus()
		return false
	end if
	// get the next modified row
	if one_time then
		exit
	else 
		row = this.getnextmodified(row,primary!)
	end if
loop
// if we get to here then there are no errors
return true
end function

public function boolean uf_is_modified ();// return true if there are any modified or deleted rows
// or if the dataindow does not pass validations
if this.accepttext() = -1 then return true
return this.modifiedcount() > 0 or this.deletedcount() > 0 
end function

public function boolean uf_check_required (integer num_dw);window parent_win
integer	col
string	colname
message.doubleparm = 0
if num_dw = 0 then
	parent.triggerevent("ue_requerido")
else
	parent.triggerevent("ue_detalle_requerido")
end if
col = message.doubleparm
if col <> 0 then
	parent_win = parent
	colname = this.Describe("#"+string(col)+".Name")
   MessageBox(parent_win.title,"Se requiere "+ upper(colname) +" en el registro No." + string (getrow())+'. Por favor, ingrese un valor.',stopsign! )
	this.SetColumn(col)
	this.setfocus()
	return false
end if

return true
end function

event clicked;String	Tab, ls_old_sort, ls_column, ls_color_old
Char	lc_sort

If IsNull(dwo) Then Return

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
	
	This.Modify(dwo.Name + ".Color = " + String(RGB(255,255,0)))
	
	This.Sort()
End If

IF Row <= 0 THEN RETURN

IF Row <> This.GetRow() THEN
	Tab	=	Describe('#' + String(dwo) + '.tabsequence')
	
	IF Tab = '0' THEN This.SetRow(Row)
END IF
end event

event dberror;String	ls_Tipo, ls_Mensaje

Str_ErrorBaseDatos	lstr_ErrBD
uo_ErrorBaseDatos	iuo_Error

iuo_Error	=	Create uo_ErrorBaseDatos

CHOOSE CASE buffer
	CASE delete!
		ls_Tipo = "Borrando"
		
	CASE primary!
		DwItemStatus Stat
		
		Stat	=	This.getitemstatus(Row, 0, Buffer)
		
		IF Stat = New! OR Stat = NewModified! THEN
			ls_Tipo	=	"Agregando"
		ELSE
			ls_Tipo	=	"Actualizando"
		END IF
		
END CHOOSE

lstr_ErrBD.Titulo	=	"Error " + ls_Tipo + " registro " + String(row)
lstr_ErrBD.Numero	=	SqlDbCode
lstr_ErrBD.Texto	=	SqlErrText

ls_Mensaje	=	"Error " + ls_Tipo + " registro " + String(row)
ls_Mensaje	+=	"~r~nNúmero de Error Base Datos: " + String(SqlDbCode)
ls_Mensaje	+=	"~r~nMensaje de Error Base Datos:~r~n~r~n" + SqlErrText

lstr_ErrBD.MensajePantalla	=	ls_Mensaje

SQLCA.SqlErrText = SqlErrText
iuo_Error.of_Send(SQLCA)
SQLCA.SqlErrText = ''

OpenWithParm(w_ErrorBaseDatos, lstr_ErrBD)

This.SetFocus()
This.SetRow(row)
This.ScrollToRow(row)
Destroy iuo_Error

RETURN 1
end event

event itemerror;String	s

s	=	This.Describe(This.GetColumnName()+".coltype")

CHOOSE CASE s
	CASE "number"
		IF Trim(This.GetText())= "" OR Not IsNumber(Trim(This.GetText())) THEN
			Int	null_num
			
			SetNull(null_num)
			
			This.SetItem(This.GetRow(),This.GetColumn(),null_num)
			
			RETURN 3
		END IF
		
	CASE "date"
		IF Trim(This.GetText()) = "" THEN
			Date	null_date
			
			SetNull(null_date)
			
			This.SetItem(This.GetRow(),This.GetColumn(),null_date)
			
			RETURN 3
		END IF
		
	CASE "time"
		IF Trim(This.GetText()) = "" THEN
			Time	null_time
			
			SetNull(null_time)
			
			This.SetItem(This.GetRow(),This.GetColumn(),null_time)
			
			RETURN 3
		END IF
		
	CASE "datetime"
		IF Trim(This.GetText()) = "" THEN
			Date	null_datetime
			
			SetNull(null_datetime)
			
			This.SetItem(This.GetRow(),This.GetColumn(),null_datetime)
			
			RETURN 3
		END IF
		
	CASE ELSE
		RETURN 3
		
END CHOOSE
end event

on uo_dw.create
end on

on uo_dw.destroy
end on

