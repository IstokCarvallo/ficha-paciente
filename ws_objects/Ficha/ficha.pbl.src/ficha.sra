$PBExportHeader$ficha.sra
$PBExportComments$Generated Application Object
forward
global type ficha from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
uo_ApiWindows		iuo_API

str_aplicacion			gstr_apl
str_usuario				gstr_us
str_parempresa		gstr_parempresa

String			nom_empresa, rut_empresa, dir_empresa, tel_empresa, gs_CodEmbalaje, gs_disco, &
				gs_base, gs_password, gs_opcion, gs_windows, gs_DirRes, gs_Ambiente = 'Windows', is_base
			
Long			Sistema_Operativo

w_informes				vinf

end variables

global type ficha from application
string appname = "ficha"
string themepath = "C:\Program Files (x86)\Appeon\PowerBuilder 22.0\IDE\theme"
string themename = "Flat Design Blue"
boolean nativepdfvalid = false
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 5
long richtexteditx64type = 5
long richtexteditversion = 3
string richtexteditkey = ""
string appicon = "\Repos\Resources\ICO\Ficha.ico"
string appruntimeversion = "22.1.0.2819"
boolean manualsession = false
boolean unsupportedapierror = false
boolean ultrafast = false
boolean bignoreservercertificate = false
uint ignoreservercertificate = 0
long webview2distribution = 0
boolean webview2checkx86 = false
boolean webview2checkx64 = false
string webview2url = "https://developer.microsoft.com/en-us/microsoft-edge/webview2/"
end type
global ficha ficha

type variables
Constant	Date			id_FechaLiberacion	=	Date('2019-08-01')
Constant	Time			it_HoraLiberacion		=	Now()
end variables

on ficha.create
appname="ficha"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on ficha.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;SetPointer ( HourGlass! )
String ls_parametros

ls_parametros				=	CommandParm()

ToolBarPopMenuText		=	"Izquierda,Arriba,Derecha,Abajo,Flotando,Muestra Texto"
MicroHelpDefault			=	"Listo"
gstr_apl.titulo				=	"FICHA PACIENTE"
gstr_apl.ini					=	"Ficha.ini"
gstr_apl.bmp				=	"\Repos\Resources\IMG\Ficha.png"
gstr_apl.Icono				=	"\Repos\Resources\ICO\Ficha.ico"
gstr_apl.liberacion			=	F_Fecha_Carta(id_FechaLiberacion, 3) + "  " + String(it_HoraLiberacion)
gstr_apl.version			=	"1.22.01092023"
gstr_apl.fechalibera		=  id_FechaLiberacion
gstr_apl.CodigoSistema	=	1
gstr_apl.NombreSistema	=	"FICHA"

OpenWithParm(w_acceso, ls_parametros)

If Message.DoubleParm <> 1 Then
	Halt
	Return
Else
	If AccesoSistemaValido() Then
	//	ParEmpresa()
		Open(w_main)
	Else
		Halt
		Return
	End If
End If
end event

