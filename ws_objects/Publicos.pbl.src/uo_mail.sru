$PBExportHeader$uo_mail.sru
$PBExportComments$Objecto Usuario que valida la Parametros
forward
global type uo_mail from nonvisualobject
end type
end forward

shared variables

end variables

global type uo_mail from nonvisualobject
end type
global uo_mail uo_mail

type prototypes
FUNCTION Integer		seeAbort (Long Chan) LIBRARY "SEE32.DLL"
FUNCTION Long 		seeAttach (Long NbrChans, Long KeyCode) LIBRARY "SEE32.DLL"
FUNCTION Long 		seeClose (Long Chan) LIBRARY "SEE32.DLL"
FUNCTION Long 		seeCommand (Long Chan, String Text) LIBRARY "SEE32.DLL"
FUNCTION Long 		seeDebug (Long Chan, Long Index, String Buffer, Long BufLen) LIBRARY "SEE32.DLL"
FUNCTION Long 		seeDecodeBuffer (String CodedBuf, String ClearBuf, Long BufLen) LIBRARY "SEE32.DLL"
FUNCTION Long 		seeDecodeUTF8 (String UTF8Buffer, String UnicodeBuffer) LIBRARY "SEE32.DLL"
FUNCTION Long 		seeDecodeUU (String CodedBuf, String ClearBuf) LIBRARY "SEE32.DLL"
FUNCTION Long 		seeDeleteEmail (Long Chan, Long MsgNbr) LIBRARY "SEE32.DLL"
FUNCTION Long 		seeDriver (Long Chan) LIBRARY "SEE32.DLL"
FUNCTION Long 		seeEncodeBuffer (String ClearBuf, String CodedBuf, Long BufLen) LIBRARY "SEE32.DLL"
FUNCTION Long 		seeEncodeUTF8 (Long UnicodeValue, String UTF8Buffer) LIBRARY "SEE32.DLL"
FUNCTION Long 		seeErrorText (Long Chan, Long Code, ref String Buffer, Long BufLen) LIBRARY "SEE32.DLL" alias for "seeErrorText;Ansi"
FUNCTION Long 		seeExtractLine (String Src, Long LineNbr, String Buffer, Long BufLen) LIBRARY "SEE32.DLL"
FUNCTION Long 		seeExtractText (String Src, String Text, String Buffer, Long BufLen) LIBRARY "SEE32.DLL"
FUNCTION Long 		seeGetEmailCount (Long Chan) LIBRARY "SEE32.DLL"
FUNCTION Long 		seeGetEmailFile (Long Chan, Long MsgNbr, String FileName, String EmailDir, String AttachDir) LIBRARY "SEE32.DLL"
FUNCTION Long 		seeGetEmailLines (Long Chan, Long MsgNbr, Long Lines, String Buffer, Long BufLen) LIBRARY "SEE32.DLL"
FUNCTION Long 		seeGetEmailSize (Long Chan, Long MsgNbr) LIBRARY "SEE32.DLL"
FUNCTION Long 		seeGetEmailUID (Long Chan, Long MsgNbr, String Buffer, Long BufLen) LIBRARY "SEE32.DLL"
FUNCTION Long		seeIsConnected(Long Chan) LIBRARY "SEE32.DLL"
FUNCTION Long 		seeIntegerParam (Long Chan, Long Index, Long Value) LIBRARY "SEE32.DLL"
FUNCTION Long 		seePop3Connect (Long Chan, String Server, String User, String Password) LIBRARY "SEE32.DLL"
FUNCTION Long 		seeQuoteBuffer (String ClearBuf, String CodedBuf, Long BufLen) LIBRARY "SEE32.DLL"
FUNCTION Long 		seeRelease () LIBRARY "SEE32.DLL"
FUNCTION Long 		seeSendEmail (Long Chan, String Rcpt, String CC, String BCC, String Subj, String Msg, String Attach) LIBRARY "SEE32.DLL" alias for "seeSendEmail;Ansi"
FUNCTION Long 		seeSendHTML (Long Chan, String Rcpt, String CC, String BCC, String Subj, String Msg, String Images, String AltTxt, String Attach) LIBRARY "SEE32.DLL"
FUNCTION Long 		seeSmtpConnect (Long Chan, String Server, String Fromm, String Reply) LIBRARY "SEE32.DLL" alias for "seeSmtpConnect;Ansi"
FUNCTION Long 		seeStatistics (Long Chan, Long Index) LIBRARY "SEE32.DLL"
FUNCTION Long 		seeStringParam (Long Chan, Long Index, String Value) LIBRARY "SEE32.DLL"
FUNCTION Long 		seeVerifyFormat (String EmailAddr) LIBRARY "SEE32.DLL"
FUNCTION Long 		seeVerifyUser (Long Chan, String EmailAddr) LIBRARY "SEE32.DLL"
end prototypes

type variables
Constant Private String	_SMTP = "smtp.office365.com"
Constant	Private Integer _PORT = 587
Constant Private String	_USER = "sendmail@rioblanco.net"
Constant Private String	_PASS = "rio.blanco.2019"
end variables

forward prototypes
private function string of_error (integer ai_codigo)
public subroutine of_send (string email_to[], string email_cc[], string email_bcc[], string email_subject, string email_msg, string email_attach[], integer email_priority)
public subroutine of_send (string email_to[], string email_cc[], string email_bcc[], string email_subject, string email_msg, integer email_priority)
public subroutine of_send (string email_to[], string email_cc[], string email_subject, string email_msg, integer email_priority)
public subroutine of_send (string email_to[], string email_subject, string email_msg, integer email_priority)
public subroutine of_send (string email_to[], string email_subject, string email_msg, string email_attach[], integer email_priority)
public subroutine of_send (string email_to[], string email_cc[], string email_subject, string email_msg, string email_attach[], integer email_priority)
end prototypes

private function string of_error (integer ai_codigo);String	ls_Retorno = ''

Choose Case ai_Codigo
	Case 1  
		ls_Retorno = 'Éxito.'
		
	Case -1 
		ls_Retorno = 'Ocurrió un error general.'
		
	Case -2 
		ls_Retorno = 'No se puede conectar al servicio a través del proxy.'

	Case -3 
		ls_Retorno = 'No se pudo resolver el host proxy dado.'

	Case -4 
		ls_Retorno = 'No se pudo resolver el host remoto proporcionado.'

	Case -5 
		ls_Retorno = 'No se pudo conectar con el host.'

	Case -6 
		ls_Retorno = 'El host tiene un formato incorrecto/ilegal o falta.'

	Case -7 
		ls_Retorno = 'El protocolo no es compatible.'

	Case -8 
		ls_Retorno = 'Error en la conexión SSL.'

	Case -9 
		ls_Retorno = 'El certificado del servidor está revocado.'

	Case -10 
		ls_Retorno = 'Falló la autenticación del certificado de servicio.'

	Case -11 
		ls_Retorno = 'Tiempo de espera de la operación.'

	Case -12 
		ls_Retorno = 'El servidor remoto denegó curl para iniciar sesión.'

	Case -13 
		ls_Retorno = 'Error al enviar datos de red.'

	Case -14 
		ls_Retorno = 'Fallo en la recepción de datos de red.'

	Case -15 
		ls_Retorno = 'Nombre de usuario o contraseña incorrectos.'

	Case -16 
		ls_Retorno = 'Error al leer el archivo local.'

	Case -17 
		ls_Retorno = 'No se ha especificado ningún remitente.'

	Case -18 
		ls_Retorno = 'No se han especificado destinatarios.'
		
End CHoose

Return ls_Retorno
end function

public subroutine of_send (string email_to[], string email_cc[], string email_bcc[], string email_subject, string email_msg, string email_attach[], integer email_priority);Integer li_rc, i

SMTPClient  lnv_SmtpClient

lnv_SmtpClient = Create SMTPClient

//Sets the email-sEnder information       
lnv_SmtpClient.Host = _SMTP
lnv_SmtpClient.Port = _PORT
lnv_SmtpClient.Username = _USER
lnv_SmtpClient.password = _PASS
lnv_SmtpClient.EnableTLS = True

//Sets the email message
lnv_SmtpClient.Message.SetSEnder(_USER,"SENDMAIL")
lnv_SmtpClient.Message.Subject = email_Subject
lnv_SmtpClient.Message.TextBody = email_MSG
lnv_SmtpClient.Message.Subject = email_Subject
lnv_SmtpClient.message.Priority = email_Priority
lnv_SmtpClient.message.Encoding = "UTF-8"
lnv_SmtpClient.LogFile("mail.log")

If Not IsNull(email_To) Then
	For i = 1 To UpperBound(email_To)
	  li_rc = lnv_SmtpClient.Message.AddRecipient(email_To[i])
	  If li_rc = -1 Then  MessageBox("Error","Fallo al agregar destinatario(s).")
	Next
End If

If Not IsNull(email_CC) Then
	For i = 1 To UpperBound(email_CC)
	  li_rc = lnv_SmtpClient.Message.AddCc(email_CC[i])
	  If li_rc = -1 Then  MessageBox("Error","Fallo al agregar destinatario(s).")
	Next
End If

If Not IsNull(email_BCC) Then
	For i = 1 To UpperBound(email_BCC)
	  li_rc = lnv_SmtpClient.Message.AddBcc(email_BCC[i])
	  If li_rc = -1 Then  MessageBox("Error","Fallo al agregar destinatario(s).")
	Next
End If

If Not IsNull(email_Attach) Then
	For i = 1 To UpperBound(email_Attach)
	  li_rc = lnv_SmtpClient.Message.AddAttachment(email_Attach[i])
	  If li_rc = -1 Then  MessageBox("Error","Fallo al agregar documento(s) adjunto(s).")
	  Next
End If

//Sends the email
li_rc = lnv_SmtpClient.Send()

If li_rc <> 1 Then 	Messagebox('Envio Correo...', 'Email envio fallido.~r~nRetorna : ' + of_error(li_rc) + ' ('+ String(li_rc) + ').', StopSign!)

Destroy lnv_SmtpClient
end subroutine

public subroutine of_send (string email_to[], string email_cc[], string email_bcc[], string email_subject, string email_msg, integer email_priority);Integer li_rc, i

SMTPClient  lnv_SmtpClient

lnv_SmtpClient = Create SMTPClient

//Sets the email-sEnder information       
lnv_SmtpClient.Host = _SMTP
lnv_SmtpClient.Port = _PORT
lnv_SmtpClient.Username = _USER
lnv_SmtpClient.password = _PASS
lnv_SmtpClient.EnableTLS = True

//Sets the email message
lnv_SmtpClient.Message.SetSEnder(_USER,"SENDMAIL")
lnv_SmtpClient.Message.Subject = email_Subject
lnv_SmtpClient.Message.TextBody = email_MSG
lnv_SmtpClient.Message.Subject = email_Subject
lnv_SmtpClient.message.Priority = email_Priority
lnv_SmtpClient.message.Encoding = "UTF-8"
lnv_SmtpClient.LogFile("mail.log")

If Not IsNull(email_To) Then
	For i = 1 To UpperBound(email_To)
	  li_rc = lnv_SmtpClient.Message.AddRecipient(email_To[i])
	  If li_rc = -1 Then  MessageBox("Error","Fallo al agregar destinatario(s).")
	Next
End If

If Not IsNull(email_CC) Then
	For i = 1 To UpperBound(email_CC)
	  li_rc = lnv_SmtpClient.Message.AddCc(email_CC[i])
	  If li_rc = -1 Then  MessageBox("Error","Fallo al agregar destinatario(s).")
	Next
End If

If Not IsNull(email_BCC) Then
	For i = 1 To UpperBound(email_BCC)
	  li_rc = lnv_SmtpClient.Message.AddBcc(email_BCC[i])
	  If li_rc = -1 Then  MessageBox("Error","Fallo al agregar destinatario(s).")
	Next
End If

//Sends the email
li_rc = lnv_SmtpClient.Send()

If li_rc <> 1 Then 	Messagebox('Envio Correo...', 'Email envio fallido.~r~nRetorna : ' + of_error(li_rc) + ' ('+ String(li_rc) + ').', StopSign!)

Destroy lnv_SmtpClient
end subroutine

public subroutine of_send (string email_to[], string email_cc[], string email_subject, string email_msg, integer email_priority);Integer li_rc, i

SMTPClient  lnv_SmtpClient

lnv_SmtpClient = Create SMTPClient

//Sets the email-sEnder information       
lnv_SmtpClient.Host = _SMTP
lnv_SmtpClient.Port = _PORT
lnv_SmtpClient.Username = _USER
lnv_SmtpClient.password = _PASS
lnv_SmtpClient.EnableTLS = True

//Sets the email message
lnv_SmtpClient.Message.SetSEnder(_USER,"SENDMAIL")
lnv_SmtpClient.Message.Subject = email_Subject
lnv_SmtpClient.Message.TextBody = email_MSG
lnv_SmtpClient.Message.Subject = email_Subject
lnv_SmtpClient.message.Priority = email_Priority
lnv_SmtpClient.message.Encoding = "UTF-8"
lnv_SmtpClient.LogFile("mail.log")

If Not IsNull(email_To) Then
	For i = 1 To UpperBound(email_To)
	  li_rc = lnv_SmtpClient.Message.AddRecipient(email_To[i])
	  If li_rc = -1 Then  MessageBox("Error","Fallo al agregar destinatario(s).")
	Next
End If

If Not IsNull(email_CC) Then
	For i = 1 To UpperBound(email_CC)
	  li_rc = lnv_SmtpClient.Message.AddCc(email_CC[i])
	  If li_rc = -1 Then  MessageBox("Error","Fallo al agregar destinatario(s).")
	Next
End If

//Sends the email
li_rc = lnv_SmtpClient.Send()

If li_rc <> 1 Then 	Messagebox('Envio Correo...', 'Email envio fallido.~r~nRetorna : ' + of_error(li_rc) + ' ('+ String(li_rc) + ').', StopSign!)

Destroy lnv_SmtpClient
end subroutine

public subroutine of_send (string email_to[], string email_subject, string email_msg, integer email_priority);Integer li_rc, i

SMTPClient  lnv_SmtpClient

lnv_SmtpClient = Create SMTPClient

//Sets the email-sEnder information       
lnv_SmtpClient.Host = _SMTP
lnv_SmtpClient.Port = _PORT
lnv_SmtpClient.Username = _USER
lnv_SmtpClient.password = _PASS
lnv_SmtpClient.EnableTLS = True

//Sets the email message
lnv_SmtpClient.Message.SetSEnder(_USER,"SENDMAIL")
lnv_SmtpClient.Message.Subject = email_Subject
lnv_SmtpClient.Message.TextBody = email_MSG
lnv_SmtpClient.Message.Subject = email_Subject
lnv_SmtpClient.message.Priority = email_Priority
lnv_SmtpClient.message.Encoding = "UTF-8"
lnv_SmtpClient.LogFile("mail.log")

If Not IsNull(email_To) Then
	For i = 1 To UpperBound(email_To)
	  li_rc = lnv_SmtpClient.Message.AddRecipient(email_To[i])
	  If li_rc = -1 Then  MessageBox("Error","Fallo al agregar destinatario(s).")
	Next
End If

//Sends the email
//li_rc = lnv_SmtpClient.Send()

If li_rc <> 1 Then 	Messagebox('Envio Correo...', 'Email envio fallido.~r~nRetorna : ' + of_error(li_rc) + ' ('+ String(li_rc) + ').', StopSign!)

Destroy lnv_SmtpClient
end subroutine

public subroutine of_send (string email_to[], string email_subject, string email_msg, string email_attach[], integer email_priority);Integer li_rc, i

SMTPClient  lnv_SmtpClient

lnv_SmtpClient = Create SMTPClient

//Sets the email-sEnder information       
lnv_SmtpClient.Host = _SMTP
lnv_SmtpClient.Port = _PORT
lnv_SmtpClient.Username = _USER
lnv_SmtpClient.password = _PASS
lnv_SmtpClient.EnableTLS = True

//Sets the email message
lnv_SmtpClient.Message.SetSEnder(_USER,"SENDMAIL")
lnv_SmtpClient.Message.Subject = email_Subject
lnv_SmtpClient.Message.TextBody = email_MSG
lnv_SmtpClient.Message.Subject = email_Subject
lnv_SmtpClient.message.Priority = email_Priority
lnv_SmtpClient.message.Encoding = "UTF-8"
lnv_SmtpClient.LogFile("mail.log")

If Not IsNull(email_To) Then
	For i = 1 To UpperBound(email_To)
	  li_rc = lnv_SmtpClient.Message.AddRecipient(email_To[i])
	  If li_rc = -1 Then  MessageBox("Error","Fallo al agregar destinatario(s).")
	Next
End If

If Not IsNull(email_Attach) Then
	For i = 1 To UpperBound(email_Attach)
	  li_rc = lnv_SmtpClient.Message.AddAttachment(email_Attach[i])
	  If li_rc = -1 Then  MessageBox("Error","Fallo al agregar documento(s) adjunto(s).")
	  Next
End If

//Sends the email
li_rc = lnv_SmtpClient.Send()

If li_rc <> 1 Then 	Messagebox('Envio Correo...', 'Email envio fallido.~r~nRetorna : ' + of_error(li_rc) + ' ('+ String(li_rc) + ').', StopSign!)

Destroy lnv_SmtpClient
end subroutine

public subroutine of_send (string email_to[], string email_cc[], string email_subject, string email_msg, string email_attach[], integer email_priority);Integer li_rc, i

SMTPClient  lnv_SmtpClient

lnv_SmtpClient = Create SMTPClient

//Sets the email-sEnder information       
lnv_SmtpClient.Host = _SMTP
lnv_SmtpClient.Port = _PORT
lnv_SmtpClient.Username = _USER
lnv_SmtpClient.password = _PASS
lnv_SmtpClient.EnableTLS = True

//Sets the email message
lnv_SmtpClient.Message.SetSEnder(_USER,"SENDMAIL")
lnv_SmtpClient.Message.Subject = email_Subject
lnv_SmtpClient.Message.TextBody = email_MSG
lnv_SmtpClient.Message.Subject = email_Subject
lnv_SmtpClient.message.Priority = email_Priority
lnv_SmtpClient.message.Encoding = "UTF-8"
lnv_SmtpClient.LogFile("mail.log")

If Not IsNull(email_To) Then
	For i = 1 To UpperBound(email_To)
	  li_rc = lnv_SmtpClient.Message.AddRecipient(email_To[i])
	  If li_rc = -1 Then  MessageBox("Error","Fallo al agregar destinatario(s).")
	Next
End If

If Not IsNull(email_CC) Then
	For i = 1 To UpperBound(email_CC)
	  li_rc = lnv_SmtpClient.Message.AddCc(email_CC[i])
	  If li_rc = -1 Then  MessageBox("Error","Fallo al agregar destinatario(s).")
	Next
End If

If Not IsNull(email_Attach) Then
	For i = 1 To UpperBound(email_Attach)
	  li_rc = lnv_SmtpClient.Message.AddAttachment(email_Attach[i])
	  If li_rc = -1 Then  MessageBox("Error","Fallo al agregar documento(s) adjunto(s).")
	  Next
End If

//Sends the email
li_rc = lnv_SmtpClient.Send()

If li_rc <> 1 Then 	Messagebox('Envio Correo...', 'Email envio fallido.~r~nRetorna : ' + of_error(li_rc) + ' ('+ String(li_rc) + ').', StopSign!)

Destroy lnv_SmtpClient
end subroutine

on uo_mail.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_mail.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

