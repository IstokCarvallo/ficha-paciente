$PBExportHeader$w_password.srw
forward
global type w_password from window
end type
type pb_rechaza from picturebutton within w_password
end type
type sle_password from singlelineedit within w_password
end type
type pb_acepta from picturebutton within w_password
end type
end forward

global type w_password from window
integer x = 581
integer y = 732
integer width = 1312
integer height = 644
boolean titlebar = true
string title = "Password Acceso"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 16777215
string icon = "AppIcon!"
pb_rechaza pb_rechaza
sle_password sle_password
pb_acepta pb_acepta
end type
global w_password w_password

type variables
Str_mant		istr_mant

Integer		ii_Errores
end variables

event open;//	istr_mant.Argumento[1]	=	"Sistema"
//	istr_mant.Argumento[2]	=	"Password"

istr_mant	=	Message.PowerObjectParm
This.Title	=	"Password Acceso " + istr_mant.Argumento[1]
 
sle_password.SetFocus()
end event

on w_password.create
this.pb_rechaza=create pb_rechaza
this.sle_password=create sle_password
this.pb_acepta=create pb_acepta
this.Control[]={this.pb_rechaza,&
this.sle_password,&
this.pb_acepta}
end on

on w_password.destroy
destroy(this.pb_rechaza)
destroy(this.sle_password)
destroy(this.pb_acepta)
end on

event close;CloseWithReturn(This, istr_mant)
end event

type pb_rechaza from picturebutton within w_password
event mousemove pbm_mousemove
string tag = "Rechazar"
integer x = 965
integer y = 304
integer width = 302
integer height = 244
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\Repos\Resources\BTN\Cancelar.png"
string disabledname = "\Repos\Resources\BTN\Cancelar-bn.png"
alignment htextalign = right!
string powertiptext = "Rechazar"
long backcolor = 553648127
end type

event clicked;istr_mant.Respuesta	=	0

Parent.TriggerEvent(close!)
end event

type sle_password from singlelineedit within w_password
integer x = 23
integer y = 184
integer width = 901
integer height = 152
integer taborder = 10
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 553648127
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type pb_acepta from picturebutton within w_password
event mousemove pbm_mousemove
string tag = "Aceptar"
integer x = 969
integer y = 52
integer width = 302
integer height = 244
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Narrow"
boolean default = true
string picturename = "\Repos\Resources\BTN\Aceptar.png"
string disabledname = "\Repos\Resources\BTN\Aceptar-bn.png"
alignment htextalign = right!
string powertiptext = "Aceptar"
long backcolor = 553648127
end type

event clicked;If sle_password.Text = istr_mant.Argumento[2] Then
	If UpperBound(istr_mant.Argumento) = 3 Then
		If (Upper(gstr_us.Nombre) = Upper(istr_mant.Argumento[3])) Then
			istr_mant.Respuesta	=	1
		Else
			MessageBox("Error", "El usuario no tiene Acceso a esta Aplicacion.~r~rSi desea Accesar, contáctese con Encargado.", Exclamation!)
			istr_mant.Respuesta	=	0
		End If
	Else
		istr_mant.Respuesta	=	1
	End If
Else
	If ii_Errores = 3 Then
		MessageBox("Error", "Usted no tiene Acceso a esta Aplicación.~r~r" + &
						"Si desea Accesar, contáctese con Encargado.", Exclamation!)
						
		istr_mant.Respuesta	=	0
	Else
		If MessageBox("Error", "Clave de Acceso a esta Aplicación es incorrecta.~r~r" + &
						"Desea intentar nuevamente.", Exclamation!, YesNo!, 1) = 1 Then
			ii_Errores ++
			
			sle_password.SetFocus()
			
			Return
		Else
			istr_mant.Respuesta	=	0
		End If
	End If
End If
	
Parent.TriggerEvent(close!)
end event

