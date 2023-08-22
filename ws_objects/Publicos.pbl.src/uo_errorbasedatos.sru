$PBExportHeader$uo_errorbasedatos.sru
forward
global type uo_errorbasedatos from nonvisualobject
end type
end forward

global type uo_errorbasedatos from nonvisualobject
end type
global uo_errorbasedatos uo_errorbasedatos

type variables
Private	String	SMTP, Correo, Password
Private	uo_Mail	iuo_Mail
end variables

forward prototypes
public function integer of_errobasedatos (transaction transaccion, string mensaje)
private function string of_addtexthtml ()
private function string of_addtext (transaction trans)
public function integer of_send (transaction trans)
end prototypes

public function integer of_errobasedatos (transaction transaccion, string mensaje);Str_ErrorBaseDatos	lstr_ErrBD
Integer					li_repsuesta, li_Retorno = 0

If Transaccion.sqlcode = 0 Then 
	li_Retorno = 0
Else
	If Pos(Transaccion.SqlErrText, "Database server not found", 1) > 0 Then
		MessageBox("Atención", "El servidor al que intenta acceder no se encuentra disponible.~r~n" + &
									  "Por favor, comuniqueselo al administrador del sistema e intente mas tarde.", Exclamation!)
		li_Retorno =  1	
	ElseIf Pos(Transaccion.SqlErrText, "Specified database not found", 1) > 0 Then
		MessageBox("Atención", "La base de datos a la que intenta acceder no se encuentra disponible.~r~n" + &
									  "Por favor, comuniqueselo al administrador del sistema e intente mas tarde.", Exclamation!)
		li_Retorno =  1
	Else
		lstr_ErrBD.Titulo	=	"Se ha Producido un Error en :~r~n" + Mensaje
		lstr_ErrBD.Numero	=	Transaccion.SqldbCode
		lstr_ErrBD.Texto	=	Transaccion.SqlErrText
		
		Mensaje	=	"Se ha Producido un Error en :~r~n" + Mensaje + "~r~n~r~n"
		Mensaje	+=	"Transaction Error Code~t: " + String (Transaccion.SqlCode) + "~r~n"
		Mensaje	+=	"Database Error Code~t: " + String (Transaccion.SqldbCode) + "~r~n"
		Mensaje	+=	"Database Error Text~t~t: " + Transaccion.SqlErrText + "~r~n~r~n"
		Mensaje	+=	"DBMS~t~t~t: " + Transaccion.DBMS + "~r~n"
		Mensaje	+=	"Database~t~t~t: " + Transaccion.DataBase + "~r~n"
		Mensaje	+=	"User ID~t~t~t: " + Transaccion.UserId + "~r~n"
		Mensaje	+=	"DBParm~t~t~t: " + Transaccion.dbParm + "~r~n"
		Mensaje	+=	"Login ID~t~t~t: " + Transaccion.LogId + "~r~n"
		Mensaje	+=	"ServerName~t~t: " + Transaccion.ServerName + "~r~n"
		
		If Transaccion.AutoCommit Then
			Mensaje	+=	"AutoCommit~t~t: True~r~n"
		Else
			Mensaje	+=	"AutoCommit~t~t: False~r~n"
		End If
		
		lstr_ErrBD.MensajePantalla	=	Mensaje
		OpenWithParm(w_ErrorBaseDatos, lstr_ErrBD)
		li_repsuesta	=	Integer(Message.StringParm)
		
		If li_repsuesta = 1 Then
			Mensaje	=	""
			Mensaje	=	"Se ha Producido un Error en :~r~n" + Mensaje + "~r~n~r~n"
			Mensaje	+=	"Transaction Error Code~t: " + String (Transaccion.SqlCode) + "~r~n"
			Mensaje	+=	"Database Error Code~t: " + String (Transaccion.SqldbCode) + "~r~n"
			Mensaje	+=	"Database Error Text~t: " + Transaccion.SqlErrText + "~r~n~r~n"
			Mensaje	+=	"DBMS~t~t~t~t: " + Transaccion.DBMS + "~r~n"
			Mensaje	+=	"Database~t~t~t: " + Transaccion.DataBase + "~r~n"
			Mensaje	+=	"User ID~t~t~t: " + Transaccion.UserId + "~r~n"
			Mensaje	+=	"DBParm~t~t~t: " + Transaccion.dbParm + "~r~n"
			Mensaje	+=	"Login ID~t~t~t: " + Transaccion.LogId + "~r~n"
			Mensaje	+=	"ServerName~t~t~t: " + Transaccion.ServerName + "~r~n"
		
			If Transaccion.AutoCommit Then
				Mensaje	+=	"AutoCommit~t~t~t: True~r~n"
			Else
				Mensaje	+=	"AutoCommit~t~t~t: False~r~n"
			End If
			
			lstr_ErrBD.MensajeCorreo	=	Mensaje
			OpenWithParm(w_correo_error, lstr_ErrBD)
		End If
		li_Retorno =  1
	End If
End If

If li_Retorno <> 0 Then of_Send(Transaccion)

Return li_Retorno
end function

private function string of_addtexthtml ();String	ls_Retorno = ''

ls_Retorno = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">' + Char(13)
ls_Retorno += '<html xmlns="http://www.w3.org/1999/xhtml">'+ Char(13)
ls_Retorno += ' <head>'+ Char(13)
ls_Retorno += '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />'+ Char(13)
ls_Retorno += '<title>Demystifying Email Design</title>'+ Char(13)
ls_Retorno += '<meta name="viewport" content="width=device-width, initial-scale=1.0"/>'+ Char(13)

ls_Retorno += '<body style="margin: 0; padding: 0;">'+ Char(13)
ls_Retorno += '<table align="center" border="1" cellpadding="0" cellspacing="0" width="600" style="border-collapse: collapse;"> '+ Char(13)
ls_Retorno += '<tr><td bgcolor="#70bbd9">'+ Char(13)
ls_Retorno += 'Row 1!'+ Char(13)
ls_Retorno += '</td></tr>'+ Char(13)

ls_Retorno += '<tr><td bgcolor="#ffffff">'+ Char(13)
ls_Retorno += 'Row 2!'+ Char(13)
ls_Retorno += '</td></tr>'+ Char(13)

ls_Retorno += '<tr><td bgcolor="#ee4c50">'+ Char(13)
ls_Retorno += 'Row 3!'+ Char(13)
ls_Retorno += '</td></tr>'+ Char(13)

ls_Retorno += '</table>'+ Char(13)
ls_Retorno += '</body>'+ Char(13)

ls_Retorno += '</head>'+ Char(13)
ls_Retorno += '</html>'+ Char(13)

Return ls_Retorno
end function

private function string of_addtext (transaction trans);String	ls_Retorno = ''

If IsNull(Trans.SqlErrText) Then Trans.SqlErrText = ''
If IsNull(Trans.DataBase) Then Trans.DataBase = ''
If IsNull(Trans.LogId) Then Trans.LogId = ''
If IsNull(Trans.ServerName) Then Trans.ServerName = ''

ls_Retorno = 'Estimados:~r~n~r~n'
ls_Retorno += "Error Text~t~t: " + Trans.SqlErrText + "~r~n~r~n"
ls_Retorno += "Base de Datos~t~t~t: " + Trans.DataBase + "~r~n"
ls_Retorno += "Usuario APP~t~t~t: " + gstr_Us.Nombre+ "~r~n"
ls_Retorno += "Computador ~t~t~t: " + gstr_Us.Computador+ "~r~n"
ls_Retorno += "Login BD~t~t~t: " + Trans.LogId + "~r~n"
ls_Retorno += "Servidor~t~t~t: " + Trans.ServerName + "~r~n"
ls_Retorno += "Fecha~t~t~t~t: " + String(Today(), 'dd/mm/yyyy hh:mm:ss') + "~r~n"
ls_Retorno += "Sistema~t~t~t~t: " + gstr_Apl.Titulo + "~r~n"

Return ls_Retorno
end function

public function integer of_send (transaction trans);Integer 	li_Retorno = 0
String		ls_Correo[], ls_Asunto, ls_Texto

ls_Asunto	= 'Error de Base Datos en: ' + gstr_Apl.Titulo
ls_Texto		= of_AddText(Trans)

iuo_mail.of_Send({"istok.carvallo@rioblanco.net"},ls_asunto,ls_texto,0)
								
Return li_Retorno
end function

on uo_errorbasedatos.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_errorbasedatos.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;iuo_Mail	=	Create uo_Mail
end event

