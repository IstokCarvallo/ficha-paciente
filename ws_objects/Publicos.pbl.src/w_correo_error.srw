$PBExportHeader$w_correo_error.srw
$PBExportComments$Ventana para envío de informes vía correo electrónico
forward
global type w_correo_error from window
end type
type cb_1 from commandbutton within w_correo_error
end type
type cb_ninguno from commandbutton within w_correo_error
end type
type mle_archivo from multilineedit within w_correo_error
end type
type mle_recipientes from multilineedit within w_correo_error
end type
type pb_salir from picturebutton within w_correo_error
end type
type st_estado from statictext within w_correo_error
end type
type st_2 from statictext within w_correo_error
end type
type mle_texto from multilineedit within w_correo_error
end type
type cb_para from commandbutton within w_correo_error
end type
type sle_asunto from singlelineedit within w_correo_error
end type
type st_1 from statictext within w_correo_error
end type
type st_encabezado from statictext within w_correo_error
end type
type pb_correo from picturebutton within w_correo_error
end type
type rte_adjunto from richtextedit within w_correo_error
end type
end forward

global type w_correo_error from window
integer width = 2418
integer height = 1700
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 16777215
cb_1 cb_1
cb_ninguno cb_ninguno
mle_archivo mle_archivo
mle_recipientes mle_recipientes
pb_salir pb_salir
st_estado st_estado
st_2 st_2
mle_texto mle_texto
cb_para cb_para
sle_asunto sle_asunto
st_1 st_1
st_encabezado st_encabezado
pb_correo pb_correo
rte_adjunto rte_adjunto
end type
global w_correo_error w_correo_error

type prototypes
SUBROUTINE keybd_event( int bVk, int bScan, int dwFlags, int dwExtraInfo) LIBRARY "user32.dll"
end prototypes

type variables
MailSession				imSes
MailReturnCode			imRet
MailMessage				imMsg

str_parms 				istr_parms
Str_ErrorBaseDatos	istr_ErrBD
String					is_documento, is_nombre
end variables

forward prototypes
public function string wf_chequeo_retorno_correo (MailReturnCode a_MailReturnCode, string as_mensaje, boolean ab_mensaje)
public subroutine wf_logoff_mail (ref mailsession ams_mses)
public subroutine wf_logon_mail ()
end prototypes

public function string wf_chequeo_retorno_correo (MailReturnCode a_MailReturnCode, string as_mensaje, boolean ab_mensaje);String	ls_mensaje

Choose Case a_MailReturnCode
	Case mailReturnAccessDenied!
		ls_mensaje = 'Acceso Denegado'
	Case mailReturnAttachmentNotFound!
		ls_mensaje = 'Archivo para atachar no encontrado'
	Case mailReturnAttachmentOpenFailure!
		ls_mensaje = 'Falla en apertura de archivo atachado'
	Case mailReturnAttachmentWriteFailure!
		ls_mensaje = 'Falla en escritura de archivo atachado'
	Case mailReturnDiskFull!
		ls_mensaje = 'Disco Lleno'
	Case mailReturnFailure!
		ls_mensaje = 'Falla General'
	Case mailReturnInsufficientMemory!
		ls_mensaje = 'Memoria Insuficiente'
	Case mailReturnInvalidMessage!
		ls_mensaje = 'Mensaje inválido'
	Case mailReturnLoginFailure!
		ls_mensaje = 'Falla de Conexión'
	Case mailReturnMessageInUse!
		ls_mensaje = 'Mensaje en Uso'
	Case mailReturnNoMessages!
		ls_mensaje = 'Sin Mensajes'
	Case mailReturnSuccess!
		ls_mensaje = 'Exitoso'
	Case mailReturnTextTooLarge!
		ls_mensaje = 'Texto demasiado grande'
	Case mailReturnTooManyFiles!
		ls_mensaje = 'Demasiados archivos'
	Case mailReturnTooManyRecipients!
		ls_mensaje = 'Demasiados recipientes'
	Case mailReturnTooManySessions!
		ls_mensaje = 'Demasiadas Sesiones de correo'
	Case mailReturnUnknownRecipient!
		ls_mensaje = 'Recipiente desconocido'
	Case mailReturnUserAbort!
		ls_mensaje = 'Abortado por Usuario'

	Case else
		ls_mensaje = 'Otros'
End Choose

IF ab_mensaje THEN MessageBox ( 'Código Retorno Correo', as_Mensaje + ' ' + ls_mensaje, Exclamation!)

Return ls_mensaje
end function

public subroutine wf_logoff_mail (ref mailsession ams_mses);String			ls_ret	

imRet = ams_mSes.mailLogoff ( )
ls_ret = wf_chequeo_retorno_correo ( imRet, 'Desconexión:', FALSE )
st_estado.text = ' Desconexión: ' + ls_ret

If imRet <> mailReturnSuccess! Then
	MessageBox ("Desconexión de Correo", 'Código de Retorno <> mailReturnSuccess!' )
	return
End If

destroy ams_mses

end subroutine

public subroutine wf_logon_mail ();string ls_ret
imSes = create MailSession

imRet		= imSes.MailLogon ( mailNewSession! )

ls_ret	= wf_chequeo_retorno_correo ( imRet, 'Conexión:', FALSE )

If imRet <> mailReturnSuccess! Then
	wf_logoff_mail(imSes)
	Close(This)
End If
end subroutine

on w_correo_error.create
this.cb_1=create cb_1
this.cb_ninguno=create cb_ninguno
this.mle_archivo=create mle_archivo
this.mle_recipientes=create mle_recipientes
this.pb_salir=create pb_salir
this.st_estado=create st_estado
this.st_2=create st_2
this.mle_texto=create mle_texto
this.cb_para=create cb_para
this.sle_asunto=create sle_asunto
this.st_1=create st_1
this.st_encabezado=create st_encabezado
this.pb_correo=create pb_correo
this.rte_adjunto=create rte_adjunto
this.Control[]={this.cb_1,&
this.cb_ninguno,&
this.mle_archivo,&
this.mle_recipientes,&
this.pb_salir,&
this.st_estado,&
this.st_2,&
this.mle_texto,&
this.cb_para,&
this.sle_asunto,&
this.st_1,&
this.st_encabezado,&
this.pb_correo,&
this.rte_adjunto}
end on

on w_correo_error.destroy
destroy(this.cb_1)
destroy(this.cb_ninguno)
destroy(this.mle_archivo)
destroy(this.mle_recipientes)
destroy(this.pb_salir)
destroy(this.st_estado)
destroy(this.st_2)
destroy(this.mle_texto)
destroy(this.cb_para)
destroy(this.sle_asunto)
destroy(this.st_1)
destroy(this.st_encabezado)
destroy(this.pb_correo)
destroy(this.rte_adjunto)
end on

event open;x = 0
y = 0

String			ls_ret
String         ls_asunto,ls_texto,ls_destin
Integer        li_codigo
Long           ll_ArchivoTot,ll_tot

IF IsNull(ls_destin) OR ls_destin = ""	THEN ls_destin = ""
IF IsNull(ls_asunto) OR ls_Asunto =	""	THEN ls_asunto = "Envío Error"
IF IsNull(ls_texto) OR ls_texto =	""	THEN ls_texto  = "Envío Error"

istr_ErrBD							=	Message.PowerObjectParm
Close(w_errorbasedatos)

mle_recipientes.text 	=  "TicOficentral@rioblanco.cl"
sle_asunto.Text		=	"Reporte de Error - Ventana " + w_main.GetActiveSheet().title
mle_texto.Text			=	istr_ErrBD.mensajecorreo

rte_adjunto.PaperOrientation = PaperLandscape!
keybd_event(44, 0, 0, 0)
MessageBox("Envío de Error", "Por favor, presiones ~"Enviar~" y luego agregue los destinatarios de correo.", Information!)

cb_1.TriggerEvent("Clicked")
pb_correo.TriggerEvent("Clicked")
end event

type cb_1 from commandbutton within w_correo_error
boolean visible = false
integer x = 1970
integer y = 1092
integer width = 402
integer height = 112
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Adjunta"
end type

event clicked;long 		ll_start, ll_used, ll_i
String	ls_documento
DateTime	ldt_fechahora

rte_adjunto.setfocus()
send(handle(rte_adjunto),770,0, 0)

RegistryGet( "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders", "Personal", RegString!, ls_documento)

ldt_fechahora		=	f_fechahora()
is_nombre			=	"RptEr" + String(ldt_fechahora, "yyyymmddHHmm") + ".pdf"
is_documento		=	ls_documento+"\RptEr" + String(ldt_fechahora, "yyyymmddHHmm") + ".pdf"
mle_archivo.Text	=	is_nombre

rte_adjunto.savedocument(is_documento, FileTypePDF!)

end event

type cb_ninguno from commandbutton within w_correo_error
integer x = 69
integer y = 580
integer width = 251
integer height = 80
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ninguno"
end type

event clicked;if messagebox('Atención','Desea eliminar todos los correos destinatarios',Question!,YesNo!,2)=1 then
	mle_recipientes.text=''
	st_estado.text='Correos destinatarios eliminados'
end if
end event

type mle_archivo from multilineedit within w_correo_error
integer x = 379
integer y = 188
integer width = 1545
integer height = 260
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
boolean autohscroll = true
alignment alignment = center!
borderstyle borderstyle = stylelowered!
end type

type mle_recipientes from multilineedit within w_correo_error
integer x = 379
integer y = 472
integer width = 1545
integer height = 188
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
boolean autohscroll = true
boolean autovscroll = true
alignment alignment = center!
borderstyle borderstyle = stylelowered!
end type

type pb_salir from picturebutton within w_correo_error
integer x = 2043
integer y = 1272
integer width = 302
integer height = 244
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean cancel = true
string picturename = "\Repos\Resources\BTN\Apagar.png"
string disabledname = "\Repos\Resources\BTN\Apagar-bn.png"
alignment htextalign = left!
long backcolor = 553648127
end type

event clicked;IF IsValid(imSes) THEN
	wf_logoff_mail(imSes)
END IF

Close(Parent)
end event

type st_estado from statictext within w_correo_error
integer x = 69
integer y = 1436
integer width = 1851
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_2 from statictext within w_correo_error
integer x = 69
integer y = 184
integer width = 251
integer height = 56
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "Archivo"
boolean focusrectangle = false
end type

type mle_texto from multilineedit within w_correo_error
integer x = 73
integer y = 776
integer width = 1851
integer height = 632
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_para from commandbutton within w_correo_error
integer x = 69
integer y = 476
integer width = 251
integer height = 80
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Para ..."
end type

event clicked;String	ls_ret, ls_recipientes,ls_recipientesAct
Boolean	lb_noerrors
Integer	li_nrecipients, li_index,li_pos
String   ls_DirectorioAct

/*Se guarda el directorio actual para que no ocurran errores de direccionamiento en la aplicación*/
ls_DirectorioAct=GetCurrentDirectory()
wf_logon_mail()
//Si ya existen direcciones de correo, las asigna a una variable 
ls_recipientesAct=Trim(mle_recipientes.Text)

//Directo al Correo Electrónico instalado
imRet = imSes.mailAddress ( imMsg )
If imRet = mailReturnUserAbort! Then 
	st_estado.text = "Envío cancelado por el Usuario"
	wf_logoff_mail(imSes)
	ChangeDirectory ( ls_DirectorioAct )	
	Return
End If

ls_ret = wf_chequeo_retorno_correo ( imRet, 'Dirección de Correo:', FALSE )
st_estado.text = ' Dirección de Correo: ' + ls_ret

Do 
	lb_noerrors = True
	li_nrecipients = UpperBound( imMsg.Recipient )
	FOR li_index = 1 To li_nrecipients
		imRet = imSes.mailResolveRecipient(imMsg.Recipient[li_index].Name)
		IF imRet <> mailReturnSuccess! THEN
			lb_noerrors = False
		ELSE
			li_pos    = pos(imMsg.Recipient[li_index].Name,"(")
			if li_pos>=1 then 
				ls_recipientes	+= TRIM(mid(imMsg.Recipient[li_index].Name,1,li_pos - 1 )+'('+imMsg.Recipient[li_index].address+')')+'; '
			else
				ls_recipientes	+= TRIM(imMsg.Recipient[li_index].Name	+'('+imMsg.Recipient[li_index].address+')')+'; '
			end if			
		END IF
		ls_ret = wf_chequeo_retorno_correo ( imRet, 'Recipiente:', FALSE )
		st_estado.text = ' Recipiente (' + imMsg.Recipient[li_index].Name + '): ' + ls_ret
	NEXT
	If Not lb_noerrors Then
		Messagebox("Correo Microsoft","Error Resolviendo Nombre(s)~n~r"+&
		"Los nombre(s) no subrayados no son validos.~n~n~rFavor corrija o cancele"&
		,Exclamation!)
		imRet = imSes.mailAddress(imMsg)
		If imRet = mailReturnUserAbort! Then 
			st_estado.text = "Envío de Correo cancelado por usuario"
			wf_logoff_mail(imSes)
			ChangeDirectory ( ls_DirectorioAct )	
			Return
		End If
	End If
Loop Until lb_noerrors

if len(ls_recipientesAct)>0 then ls_recipientesAct=trim(ls_recipientesAct)+'; '

mle_recipientes.Text = ls_recipientesAct+Mid(ls_recipientes, 1, Len(ls_recipientes) -2)



wf_logoff_mail(imSes)
ChangeDirectory ( ls_DirectorioAct )	





end event

type sle_asunto from singlelineedit within w_correo_error
integer x = 379
integer y = 680
integer width = 1545
integer height = 80
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_correo_error
integer x = 69
integer y = 692
integer width = 251
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "Asunto"
boolean focusrectangle = false
end type

type st_encabezado from statictext within w_correo_error
integer x = 73
integer y = 60
integer width = 1851
integer height = 92
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 16711680
string text = "Envío de Informe de Error por Correo Electrónico"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type pb_correo from picturebutton within w_correo_error
integer x = 2048
integer y = 776
integer width = 302
integer height = 244
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\Repos\Resources\BTN\Email.png"
string disabledname = "\Repos\Resources\BTN\Email-bn.png"
alignment htextalign = left!
long backcolor = 553648127
end type

event clicked;MailFileDescription	mAttach

String					ls_ret,	ls_recipientes,	ls_directorioAct, ls_Smtp
Integer              li_totdest,	li_pos,	li_pos2, li_Pos3, li_Pos4
Long                 ll_ArchivoTot

SetPointer(HourGlass!)
/*Se guarda el directorio actual para que no ocurran errores de direccionamiento en la aplicación*/
ls_DirectorioAct=GetCurrentDirectory()
wf_logon_mail()
imMsg.Subject				= 	sle_asunto.Text
imMsg.notetext				= 	mle_texto.Text+"~n~r "

mAttach.FileType 			= 	mailAttach!
mAttach.PathName			=	Trim(is_documento)
mAttach.FileName 			=  Trim(is_nombre)
mAttach.Position 			= 	len(imMsg.notetext) - 1		
imMsg.AttachmentFile[1] = 	mAttach

ls_recipientes	=	mle_recipientes.text

li_pos = 1
li_totdest = 1

/*Toma las direcciones de correo y nombre del destinatario y las guarda para enviar mail */

DO WHILE li_pos>0
	li_pos    = pos(ls_recipientes,"(")
	li_pos2   = pos(ls_recipientes,")")
	IF li_pos>0 THEN
		string var,var1
		var=Trim(mid(ls_recipientes,1,li_pos - 1))
		var1=Trim(mid(ls_recipientes,li_pos+1,li_pos2 - li_pos - 1 ))
		imMsg.Recipient[li_totdest].Name=Trim(mid(ls_recipientes,1,li_pos - 1))
		imMsg.Recipient[li_totdest].address=Trim(mid(ls_recipientes,li_pos+1,li_pos2 - li_pos - 1 ))
		li_totdest = li_totdest + 1	
		ls_recipientes=mid(ls_recipientes,li_pos2+3,len(ls_recipientes))
	END IF
LOOP



SetPointer(HourGlass!)

If UpperBound ( imMsg.Recipient ) < 1 and len(mle_recipientes.text) <= 0 Then 
	messagebox ("Envío Correo","Correo debe incluir al menos 1 recipiente",Exclamation!)
	ChangeDirectory ( ls_DirectorioAct )	
	return
End If

imRet = imSes.mailsend ( imMsg )

ls_ret = wf_chequeo_retorno_correo ( imRet, 'Envío Correo:', True )
st_estado.text = ' Envío Correo: ' + ls_ret

wf_logoff_mail(imSes)
ChangeDirectory ( ls_DirectorioAct )	
Close(parent)
end event

type rte_adjunto from richtextedit within w_correo_error
integer x = 2098
integer y = 688
integer width = 101
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean border = false
borderstyle borderstyle = stylelowered!
end type

