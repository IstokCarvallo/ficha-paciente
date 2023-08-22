$PBExportHeader$w_cambio_password.srw
$PBExportComments$Ventana para Cambio de Password de Usuario Activo o con Usuario Administrador.
forward
global type w_cambio_password from window
end type
type cb_automatica from commandbutton within w_cambio_password
end type
type sle_confirma from singlelineedit within w_cambio_password
end type
type sle_usuario from singlelineedit within w_cambio_password
end type
type st_6 from statictext within w_cambio_password
end type
type st_5 from statictext within w_cambio_password
end type
type st_4 from statictext within w_cambio_password
end type
type st_1 from statictext within w_cambio_password
end type
type pb_acepta from picturebutton within w_cambio_password
end type
type pb_salir from picturebutton within w_cambio_password
end type
type sle_password from singlelineedit within w_cambio_password
end type
type st_3 from statictext within w_cambio_password
end type
type st_2 from statictext within w_cambio_password
end type
end forward

global type w_cambio_password from window
integer x = 599
integer y = 828
integer width = 2071
integer height = 1056
boolean titlebar = true
windowtype windowtype = response!
windowstate windowstate = maximized!
long backcolor = 16777215
cb_automatica cb_automatica
sle_confirma sle_confirma
sle_usuario sle_usuario
st_6 st_6
st_5 st_5
st_4 st_4
st_1 st_1
pb_acepta pb_acepta
pb_salir pb_salir
sle_password sle_password
st_3 st_3
st_2 st_2
end type
global w_cambio_password w_cambio_password

type variables
Str_info		istr_info
Boolean		ib_Acepta = False
end variables

on w_cambio_password.create
this.cb_automatica=create cb_automatica
this.sle_confirma=create sle_confirma
this.sle_usuario=create sle_usuario
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_1=create st_1
this.pb_acepta=create pb_acepta
this.pb_salir=create pb_salir
this.sle_password=create sle_password
this.st_3=create st_3
this.st_2=create st_2
this.Control[]={this.cb_automatica,&
this.sle_confirma,&
this.sle_usuario,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_1,&
this.pb_acepta,&
this.pb_salir,&
this.sle_password,&
this.st_3,&
this.st_2}
end on

on w_cambio_password.destroy
destroy(this.cb_automatica)
destroy(this.sle_confirma)
destroy(this.sle_usuario)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_1)
destroy(this.pb_acepta)
destroy(this.pb_salir)
destroy(this.sle_password)
destroy(this.st_3)
destroy(this.st_2)
end on

event open;x = 100
y = 100

This.Icon				=	Gstr_apl.Icono
sle_usuario.Text	=	gstr_us.Nombre

gs_Password		=	Message.StringParm

IF gstr_us.Administrador = 0 THEN
	sle_usuario.Enabled	=	False
END IF

end event

type cb_automatica from commandbutton within w_cambio_password
integer x = 87
integer y = 784
integer width = 1513
integer height = 136
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Genera Password Automáticamente"
end type

event clicked;Integer	li_Letra, li_Respuesta
String	ls_NuevaPassword
Boolean	lb_Continua = True

sle_password.Text	=	""

DO WHILE lb_Continua
	FOR li_Letra = 1 TO 8
		ls_NuevaPassword	+=	String(Char(Rand(26) + 64))
	NEXT
	
	li_Respuesta	=	MessageBox("Cambio Password", &
											"¿Acepta la Clave propuesta?~r~r" + &
											ls_NuevaPassword, Question!, YesNoCancel!, 1)

	CHOOSE CASE li_Respuesta
		CASE 1
			lb_Continua			=	False
			sle_password.Text	=	ls_NuevaPassword
			sle_confirma.Text	=	ls_NuevaPassword
			
		CASE 2
			ls_NuevaPassword	=	''
			
		CASE 3
			RETURN

	END CHOOSE
LOOP

end event

type sle_confirma from singlelineedit within w_cambio_password
integer x = 704
integer y = 584
integer width = 841
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean italic = true
long textcolor = 33554432
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type sle_usuario from singlelineedit within w_cambio_password
integer x = 704
integer y = 268
integer width = 841
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean italic = true
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;String		ls_Usuario
Integer		li_Grupo, li_Administrador

IF This.Text = "" THEN
	This.SetFocus()
ELSEIF This.Text <> gstr_us.Nombre THEN
	ls_Usuario	=	This.Text
	
	SELECT	usua_admini
		INTO	:li_Administrador
		FROM	dbo.admausuarios
		WHERE	usua_codigo	=	:ls_Usuario ;
		
	IF sqlca.SQLCode = -1 THEN
		F_ErrorBasedatos(sqlca, "Lectura de tabla de Usuarios")
	ELSEIF sqlca.SQLCode = 100 THEN
		MessageBox("Atención", "Usuario no ha sido creado en esta Base de Datos")
		
		This.Text = ""
		This.SetFocus()
	ELSE
		IF li_Administrador = 1 THEN
			MessageBox("Atención", "No puede cambiar Password a otro Administrador" + &
							".~r~rIngrese otro Usuario.")
			
			This.Text = ""
			This.SetFocus()
		ELSE
//			IF li_Grupo <> gstr_us.CodigoGrupo THEN
//				MessageBox("Atención", "Usuario no corresponde a Grupo " + &
//								gstr_us.NombreGrupo + ".~r~rIngrese otro Usuario.")
//				
//				This.Text = ""
//				This.SetFocus()
//			END IF
		END IF
	END IF
END IF
end event

type st_6 from statictext within w_cambio_password
integer x = 165
integer y = 596
integer width = 494
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean italic = true
long textcolor = 16777215
long backcolor = 553648127
string text = "Confirmación"
boolean focusrectangle = false
end type

type st_5 from statictext within w_cambio_password
integer x = 165
integer y = 468
integer width = 494
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean italic = true
long textcolor = 16777215
long backcolor = 553648127
string text = "Nueva Password"
boolean focusrectangle = false
end type

type st_4 from statictext within w_cambio_password
integer x = 165
integer y = 280
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean italic = true
long textcolor = 16777215
long backcolor = 553648127
string text = "Usuario"
boolean focusrectangle = false
end type

type st_1 from statictext within w_cambio_password
integer x = 87
integer y = 68
integer width = 1513
integer height = 92
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 16711680
string text = "Cambio de Password Usuarios"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type pb_acepta from picturebutton within w_cambio_password
event mousemove pbm_mousemove
integer x = 1696
integer y = 220
integer width = 302
integer height = 244
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean default = true
string picturename = "\Desarrollo 17\Imagenes\Botones\Aceptar.png"
string disabledname = "\Desarrollo 17\Imagenes\Botones\Aceptar-bn.png"
alignment htextalign = right!
end type

event clicked;String	ls_Sentencia, ls_passant, ls_passnew, ls_usuario
Integer	li_retorno
Boolean	lb_AutoCommit

ls_passant	=	sqlca.LogPass
ls_passnew	=	sle_password.Text
ls_usuario	=	sle_usuario.Text

If Upper(sle_password.Text) = 'RIO' Then
	MessageBox("ERROR", "No se debe utilizar la palabra RIO", StopSign!)
	sle_password.Text	=	''
	sle_confirma.Text	=	''
ElseIf Not ib_Acepta AND sle_password.Text = '' Then
	MessageBox("ERROR", "Debe Ingresar Nueva Password", StopSign!)
Else
	If sle_password.Text <> sle_confirma.Text Then
		MessageBox("Atención", "Confirmación no es igual a Password.~r~r" + &
						"Confirme nuevamente o revise password.")
	Else
		If SQLCA.DBMS = 'ODBC' Then
			ls_Sentencia	=	"GRANT CONNECT TO " + ls_usuario + " " + &
									"IDENTIfIED BY " + ls_passnew
									
			EXECUTE IMMEDIATE :ls_Sentencia USING sqlca ;
			
			If sqlca.SQLCode = 0 Then
				ib_Acepta		=	True
				MessageBox("Cambio de Password", "El cambio de Password se ha ejecutado" + &
								" Exitosamente.", Information!)
			End If
		Else
			lb_AutoCommit		=	SQLCA.AutoCommit
			SQLCA.AutoCommit	=	True
			
			DECLARE Cambio_Password PROCEDURE FOR dbo.sp_password
				@old = :ls_passant,
				@new = :ls_passnew,
				@loginame = :ls_usuario
				Using SQLCA;
				
			EXECUTE Cambio_Password;
			
			If SQLCA.SQLCode = 100 Then
				FETCH Cambio_Password INTO :li_retorno;
				
				sqlca.LogPass	=	ls_passnew
				ib_Acepta		=	True
				MessageBox("Atención","El cambio de password se ha ejecutado Exitosamente.", Information!)
			Else
				MessageBox("Atención","El cambio de password en este ambiente es de uso exclusivo del Administrador de Bases de Datos.")
			End If
			SQLCA.AutoCommit	=	lb_AutoCommit
		End If
	End If
	Close(Parent)
End If
end event

type pb_salir from picturebutton within w_cambio_password
event mousemove pbm_mousemove
integer x = 1701
integer y = 500
integer width = 302
integer height = 244
integer taborder = 50
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean cancel = true
string picturename = "\Desarrollo 17\Imagenes\Botones\Apagar.png"
string disabledname = "\Desarrollo 17\Imagenes\Botones\Apagar-bn.png"
alignment htextalign = right!
end type

event mousemove;//w_main.SetMicroHelp("Salir [Cerrar Ventana Activa]")
end event

event clicked;IF Upper(sle_password.Text) = 'RIO' THEN
	MessageBox("ERROR", "No se debe utilizar la palabra RIO", StopSign!)
	sle_password.Text	=	''
	sle_confirma.Text	=	''
ELSEIF ib_Acepta = False AND sle_password.Text <> '' THEN
	MessageBox("Atención", "Debe Aceptar para Cambiar Su Password", StopSign!)
ELSEIF ib_Acepta = False AND sle_password.Text = '' AND gs_Password = "1" THEN
	MessageBox("ERROR", "Debe Ingresar Nueva Password", StopSign!)
ELSE
	Close(Parent)
END IF
end event

type sle_password from singlelineedit within w_cambio_password
integer x = 704
integer y = 456
integer width = 841
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean italic = true
long textcolor = 33554432
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_cambio_password
integer x = 87
integer y = 408
integer width = 1513
integer height = 316
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 16711680
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_2 from statictext within w_cambio_password
integer x = 87
integer y = 220
integer width = 1513
integer height = 188
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16711680
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_cambio_password
boolean visible = false
integer x = 1682
integer y = 448
integer width = 274
integer height = 272
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
end type

