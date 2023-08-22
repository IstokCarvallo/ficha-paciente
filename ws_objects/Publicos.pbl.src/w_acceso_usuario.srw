$PBExportHeader$w_acceso_usuario.srw
$PBExportComments$Ventana de entrada a sistemas
forward
global type w_acceso_usuario from window
end type
type p_aceptar from picturebutton within w_acceso_usuario
end type
type p_cerrar from picturebutton within w_acceso_usuario
end type
type sle_nombre from singlelineedit within w_acceso_usuario
end type
type ddlb_bases from dropdownlistbox within w_acceso_usuario
end type
type st_titulo from statictext within w_acceso_usuario
end type
type st_empresa from statictext within w_acceso_usuario
end type
type st_conect from statictext within w_acceso_usuario
end type
type sle_clave from singlelineedit within w_acceso_usuario
end type
type st_2 from statictext within w_acceso_usuario
end type
type st_1 from statictext within w_acceso_usuario
end type
type p_mono from picture within w_acceso_usuario
end type
end forward

global type w_acceso_usuario from window
integer x = 882
integer y = 724
integer width = 2418
integer height = 1284
boolean titlebar = true
windowtype windowtype = response!
long backcolor = 16777215
string icon = "AppIcon!"
windowanimationstyle openanimation = toproll!
windowanimationstyle closeanimation = bottomroll!
event ue_conectar ( )
event ue_usuario ( )
event ue_datosempresa ( )
p_aceptar p_aceptar
p_cerrar p_cerrar
sle_nombre sle_nombre
ddlb_bases ddlb_bases
st_titulo st_titulo
st_empresa st_empresa
st_conect st_conect
sle_clave sle_clave
st_2 st_2
st_1 st_1
p_mono p_mono
end type
global w_acceso_usuario w_acceso_usuario

type variables
Integer		ii_pos, ii_attempts, ii_seq
Boolean		ib_connected
String			is_ClaveUsuario, is_Computador
end variables

event ue_conectar();SetPointer(HourGlass!)

st_conect.text = "Abriendo Base de Datos..."

String	ls_server1 = "12345678", ls_nombre, ls_Dbms, ls_DbParm, ls_aplicacion, ls_Provider
Integer	li_posic, li_resp

sqlca.SQLCode	=	1
ii_pos				=	1
ls_server1		=	ProfileString(gstr_apl.ini, is_base, "servername", "12345678")
ls_Dbms			=	ProFileString(gstr_apl.ini, is_base, "dbms", "ODBC")
ls_aplicacion	=	"AppName='"+gstr_apl.NombreSistema+"',Host='"+gstr_us.computador+"'"
ls_DBParm		=	ProfileString(gstr_apl.ini, is_base, "DbParm", "")
ls_Provider		=	ProfileString(gstr_apl.ini, is_base, "Provider", "SQLNCLI10")

If ls_server1 <> "12345678" Then
	ls_nombre			=	ProfileString(gstr_apl.ini, is_base, "NombreOdbc", "")
	sqlca.Dbms			=	ProFileString(gstr_apl.ini, is_base, "dbms", "ODBC")
	sqlca.ServerName	=	ProfileString(gstr_apl.ini, is_base, "servername", "")
	sqlca.DataBase		=	ProFileString(gstr_apl.ini, is_base, "database", "")
	
	If IsNull(ls_Nombre) Or ls_nombre = '' Then 
		ls_nombre			=	ProfileString(gstr_apl.ini, is_base, "DataBase", "")
	End If
	
	If Mid(ls_Dbms,1,3) = 'SNC' or Mid(ls_Dbms,1,9) = 'TRACE SNC' Then
		sqlca.LogId   	= sle_nombre.text
		sqlca.LogPass  = sle_clave.text
		sqlca.Autocommit = True
			
		If Len(Trim(ls_DBParm)) > 0 Then ls_DbParm = ","+ls_DbParm
		ls_Dbparm = "Provider='"+ ls_Provider +"',Database='"+ProfileString(gstr_apl.ini, is_base, "database", "")+"'"+ls_DbParm+",TrimSpaces=1,"+ls_Aplicacion
			
		SQLCA.DBParm = ls_Dbparm
	ElseIf Mid(ls_Dbms,1, 10) = 'MSOLEDBSQL'  Then
		SQLCA.LogPass 		= sle_clave.text
		SQLCA.LogId 			= sle_nombre.text
		SQLCA.AutoCommit	= False
		SQLCA.DBParm = "Database='"+ProfileString(gstr_apl.ini, is_base, "database", "")+"'"+ls_DbParm+",TrimSpaces=1,"+ls_Aplicacion
	End If
Else
	MessageBox(This.Title,"No se puede ejecutar la aplicación por la falta de archivo " &
					+ gstr_apl.ini + ". VerIfique que el archivo exista y que esté en el directorio " + &
					"donde la aplicación esté corriEndo o en el PATH del Computador del cliente.",StopSign!)
	Halt Close
	Return
End If

If Len(Trim(sle_nombre.text)) <> 0 Then sle_clave.SetFocus()

SetPointer(HourGlass!)

DO
	CONNECT Using SQLCA ; 

	If sqlca.SQLCode <> 0 Then
		If sqlca.SQLDBCode = -103 Then
			If MessageBox("Error de Conexión", "Usuario o Password ingresado está incorrecto.", &
								Information!, RetryCancel!) = 1 Then
				sle_clave.SetFocus()
			End If
			
			Return
		ElseIf sqlca.SQLDBCode = -102 Then
			MessageBox("Error de Conexión", "Demasiados Usuarios conectados a la Base.~r" + &
							"Consulte con Administrador", StopSign!, Ok!)
			Return
		ElseIf sqlca.SQLDBCode <> 0 Then
			st_conect.text = "Error de Conexión..."
			F_ErrorBaseDatos(sqlca, This.Title)
			Return
		End If
	End If
	
	sle_nombre.text	= 	sqlca.UserId
LOOP UNTIL sqlca.SQLCode <> 0

gstr_apl.Odbc	=	ls_nombre

If Upper(sle_clave.Text) = "123" Then
	SetPointer(HourGlass!)
	OpenWithParm(w_cambio_password,"1")
End If

st_conect.text	= "Usuario Conectado..."
ib_connected	= True

This.TriggerEvent("ue_datosempresa")

SetPointer(Arrow!)
end event

event ue_usuario();RegistryGet("HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\ComputerName\ComputerName", "ComputerName", RegString!, is_Computador)
				
gstr_us.Nombre		=	sle_nombre.text
gstr_us.Computador	=	is_Computador

sqlca.LogId		=	sle_nombre.text
sqlca.UserId		=	sle_nombre.text
sqlca.LogPass	=	sle_clave.text
sqlca.DbPass	=	sle_clave.text

This.TriggerEvent("ue_conectar")
end event

event ue_datosempresa();/*
Obtiene Datos de Empresa
*/
SELECT	empr_razsoc, empr_nombre, empr_rutemp, empr_direcc, empr_comuna,
			empr_ciudad, empr_giroem, empr_nrotel, empr_nrofax, empr_repleg,
			empr_rutrle, empr_oficin, empr_dirres
	INTO	:gstr_apl.razon_social, :gstr_apl.nom_empresa, :gstr_apl.rut_empresa, :gstr_apl.dir_empresa, :gstr_apl.com_empresa,
			:gstr_apl.ciu_empresa, :gstr_apl.gir_empresa, :gstr_apl.tel_empresa, :gstr_apl.fax_empresa, :gstr_apl.rep_legal	,
			:gstr_apl.rut_replegal	, :gstr_apl.Oficina	, :gstr_apl.DirRespaldo
	FROM	dbo.parempresa
	Using Sqlca;
end event

on w_acceso_usuario.create
this.p_aceptar=create p_aceptar
this.p_cerrar=create p_cerrar
this.sle_nombre=create sle_nombre
this.ddlb_bases=create ddlb_bases
this.st_titulo=create st_titulo
this.st_empresa=create st_empresa
this.st_conect=create st_conect
this.sle_clave=create sle_clave
this.st_2=create st_2
this.st_1=create st_1
this.p_mono=create p_mono
this.Control[]={this.p_aceptar,&
this.p_cerrar,&
this.sle_nombre,&
this.ddlb_bases,&
this.st_titulo,&
this.st_empresa,&
this.st_conect,&
this.sle_clave,&
this.st_2,&
this.st_1,&
this.p_mono}
end on

on w_acceso_usuario.destroy
destroy(this.p_aceptar)
destroy(this.p_cerrar)
destroy(this.sle_nombre)
destroy(this.ddlb_bases)
destroy(this.st_titulo)
destroy(this.st_empresa)
destroy(this.st_conect)
destroy(this.sle_clave)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.p_mono)
end on

event open;String	ls_linea, ls_cadena
Integer	li_archivo, li_inicio, li_termino

iuo_API	=	Create uo_ApiWindows

// Determina Sistema Operativo
iuo_Api.of_iswin98_2k() //lstr_VersionInfo.sistema_operativo(1=W95/NT4,2=W98,3=WME,4=WNT3,5=W2000,6=WXP)

// Recurepa el dominio de la red
gstr_us.dominio 	=	iuo_Api.recupera_dominio()

// Recupera el nombre del usuario de windows
gstr_us.nombre		=	iuo_Api.obtiene_usuario_windows()

This.Icon					=	gstr_apl.Icono
li_archivo				=	FileOpen(gstr_apl.Ini)
st_titulo.text				=	gstr_apl.Titulo
p_mono.OriginalSize	=	False
p_mono.PictureName	=	gstr_apl.Bmp
sle_nombre.Text		=	gstr_us.nombre

ls_cadena				=	Message.StringParm

st_conect.Text	=	'Esperando Conexión...'

gstr_apl.Launcher					=	False
	
PostEvent("ue_validainstalacion")

If li_archivo < 0 Then
	MessageBox("Error","Archivo " + gstr_apl.ini + " no se encuentra en directorio.", StopSign!)
	Halt Close
Else
	SetPointer(HourGlass!)
	
	ddlb_bases.SetRedraw(false)
	ddlb_bases.Reset()

	DO WHILE FileRead(li_archivo,ls_linea) >= 0
		If Pos(ls_linea,"Instalación",1) > 0 Then
			st_empresa.text		=	Mid(ls_linea,13,Len(ls_linea)-12)
			gstr_apl.instalacion	=	st_empresa.text
		End If
		
		li_inicio	= Pos(ls_linea,"[",1)
		li_termino	= Pos(ls_linea,"]",1)
		
		If li_inicio > 0 AND li_termino>0 Then
			ddlb_bases.AddItem(Mid(ls_linea, li_inicio + 1, li_termino - li_inicio - 1))
		End If
	LOOP
	FileClose(li_archivo)
	ddlb_bases.SetRedraw(True)
	ddlb_bases.SelectItem(1)
	
	is_base				= ddlb_bases.Text
	is_ClaveUsuario 	=	ProfileString(gstr_apl.Ini, is_base, "DatabasePassword", "")
End If

SetPointer(Arrow!)
end event

event doubleclicked;If Pos(Upper(gstr_apl.Instalacion), "DESARROLLO") > 0 Then
	If KeyDown(KeyI!) Then
		sle_nombre.Text	=	"Istok.Carvallo"	
		sle_clave.Text		=	"prag"
	
		p_Aceptar.TriggerEvent(Clicked!)
	End If
End If
end event

type p_aceptar from picturebutton within w_acceso_usuario
integer x = 1586
integer y = 544
integer width = 384
integer height = 336
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean default = true
alignment htextalign = left!
end type

event clicked;Integer	start_pos, End_pos, dbparm_len, i
string	dbparm, scan_item
Char		cur_char

SetPointer(HourGlass!)

If Trim(sle_nombre.text) = "" Then
	MessageBox(Parent.Title, "Nombre del usuario no ingresado.  ~n~nPor favor ingrese su nombre de acceso.")
	sle_nombre.SetFocus()
	Return
ElseIf Trim(sle_clave.text) = "" Then
	MessageBox(Parent.Title, "Clave de acceso no ingresada.  ~n~nPor favor ingrese su clave de acceso.")
	sle_clave.SetFocus()
	Return
End If

st_conect.text = "Ahora Conectando..."

Parent.TriggerEvent("ue_usuario")

If ib_connected = False Then
	If ii_attempts < 3 Then
		SetPointer(Arrow!)
		ii_attempts ++
		sle_nombre.SetFocus()
		st_conect.text = "Conexión invalida."
		Return
	End If
End If

SetPointer(Arrow!)
st_conect.text = ""

CloseWithReturn(Parent,1)	
end event

type p_cerrar from picturebutton within w_acceso_usuario
integer x = 1989
integer y = 544
integer width = 384
integer height = 336
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean cancel = true
alignment htextalign = left!
end type

event clicked;Halt
end event

type sle_nombre from singlelineedit within w_acceso_usuario
integer x = 530
integer y = 576
integer width = 997
integer height = 92
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

event modified;This.SelectText(1,Len(This.Text))
end event

type ddlb_bases from dropdownlistbox within w_acceso_usuario
integer x = 530
integer y = 432
integer width = 1856
integer height = 372
integer taborder = 10
integer transparency = 100
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 8388608
long backcolor = 16777215
boolean border = false
boolean sorted = false
boolean vscrollbar = true
end type

event selectionchanged;is_base				=	This.Text
is_ClaveUsuario 	=	ProfileString(gstr_apl.Ini, is_base, "DatabasePassword", "")
end event

type st_titulo from statictext within w_acceso_usuario
integer x = 530
integer y = 220
integer width = 1856
integer height = 192
integer textsize = -16
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_empresa from statictext within w_acceso_usuario
integer x = 91
integer y = 64
integer width = 2281
integer height = 104
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 8388608
long backcolor = 553648127
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_conect from statictext within w_acceso_usuario
integer x = 146
integer y = 1096
integer width = 1061
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 8388608
long backcolor = 553648127
boolean enabled = false
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type sle_clave from singlelineedit within w_acceso_usuario
integer x = 530
integer y = 712
integer width = 997
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
boolean autohscroll = false
boolean password = true
integer limit = 25
borderstyle borderstyle = stylelowered!
end type

event getfocus;This.SelectText(1,Len(This.Text))
end event

type st_2 from statictext within w_acceso_usuario
integer x = 169
integer y = 716
integer width = 352
integer height = 84
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 553648127
boolean enabled = false
string text = "Clave"
boolean focusrectangle = false
end type

type st_1 from statictext within w_acceso_usuario
integer x = 169
integer y = 580
integer width = 352
integer height = 84
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 553648127
boolean enabled = false
string text = "Nombre"
boolean focusrectangle = false
end type

type p_mono from picture within w_acceso_usuario
integer x = 78
integer y = 204
integer width = 402
integer height = 352
string dragicon = "AppIcon!"
boolean enabled = false
boolean focusrectangle = false
boolean map3dcolors = true
end type

