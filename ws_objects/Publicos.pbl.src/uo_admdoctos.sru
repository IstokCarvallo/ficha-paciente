$PBExportHeader$uo_admdoctos.sru
$PBExportComments$Manejo de Documentos
forward
global type uo_admdoctos from nonvisualobject
end type
end forward

global type uo_admdoctos from nonvisualobject
end type
global uo_admdoctos uo_admdoctos

type prototypes
Function ulong GetTempPath (long nBufferLength, ref string lpBuffer ) LIBRARY "KERNEL32.DLL" Alias For "GetTempPathA;Ansi"
end prototypes

type variables
CONSTANT Integer LARGO_ARCHIVO = 32765
end variables

forward prototypes
public function boolean obtienearchivo (ref string as_ruta, ref string as_fichero, string as_filtro)
public function integer abrirdocumento (string as_fichero)
public function string temporalwindow ()
public function string generadocumento (datawindow adw, long fila, transaction at_transaccion)
public function boolean archivoblob (string as_archivo, blob ablob_content)
public function boolean recuperaimagen (datawindow adw, long fila, transaction at_transaccion)
public function boolean grabaimagen (datawindow adw, long fila, transaction at_transaccion, string as_archivo)
public function blob seleccionadocto (datawindow adw, long fila, ref string as_file_tmp, transaction at_transaccion)
end prototypes

public function boolean obtienearchivo (ref string as_ruta, ref string as_fichero, string as_filtro);Boolean	lb_Retorno = True
String	ls_Filtro

ls_Filtro	=	as_Filtro

IF IsNull(as_Filtro) THEN
	ls_Filtro	=	"JPEG Files (*.jpg),*.jpg," + "GIFF Files (*.gif),*.gif," + &
						"BMP Files (*.bmp),*.bmp,"
END IF

IF GetFileOpenName("Archivo de Imagen: ", as_Ruta, as_Fichero , "jpg", ls_Filtro) = 0 THEN
	lb_Retorno	=	False
END IF

RETURN lb_Retorno
end function

public function integer abrirdocumento (string as_fichero);String		ls_Fichero
Integer		li_Retorno
OleObject	loo_Objeto

ls_Fichero	=	as_Fichero

IF Pos(ls_Fichero,'"') = 0 THEN ls_Fichero = '"' + ls_Fichero + '"'

IF Not FileExists(as_Fichero) THEN RETURN -1

loo_Objeto	=	CREATE OleObject
li_Retorno	=	loo_Objeto.ConnectToNewObject('WScript.Shell')

IF li_Retorno >= 0 THEN
	loo_Objeto.Run(ls_Fichero, 1, False)
	
	loo_Objeto.DisconnectObject()
	
	li_Retorno	=	1
ELSE
   li_Retorno	=	-1
END IF

DESTROY loo_Objeto

RETURN li_retorno
end function

public function string temporalwindow ();Constant Long	lcl_MaxRuta	=	260 

String	ls_DirTemporal, ls_Retorno
ULong		lul_ValorRet
 
ls_DirTemporal	=	Fill('0', lcl_MaxRuta) 
lul_ValorRet	=	GetTempPath(lcl_MaxRuta, ls_DirTemporal) 
 
IF lul_ValorRet > 0 THEN 
	ls_Retorno	=	ls_DirTemporal
Else
	ls_Retorno	=	''
END IF 
 
RETURN ls_Retorno

end function

public function string generadocumento (datawindow adw, long fila, transaction at_transaccion);String 	ls_ArchivoTmp
Blob   	lblob_Archivo

lblob_Archivo	=	SeleccionaDocto(adw, Fila, ls_ArchivoTmp, at_Transaccion)

IF Mid(ls_ArchivoTmp, 2, 2) <> ':\' THEN
	ls_ArchivoTmp	=	'C:\' + ls_ArchivoTmp
ELSE
	ls_ArchivoTmp	=	ls_ArchivoTmp
END IF

IF IsNull(lblob_Archivo) THEN
	MessageBox( "Atención", "Archivo que está leyendo viene nulo.", StopSign!, OK!) 
	RETURN ''
END IF

IF ArchivoBlob(ls_ArchivoTmp, lblob_Archivo) THEN
	RETURN ls_ArchivoTmp
ELSE
	RETURN ''
END IF
end function

public function boolean archivoblob (string as_archivo, blob ablob_content);Integer	li_Canal
Boolean	lb_Retorno	=	True

SetPointer(HourGlass!)

FileDelete(as_Archivo)

li_Canal	=	FileOpen(as_Archivo, Streammode!, Write!, Shared!, Replace!)

IF li_Canal = -1 THEN
	Messagebox("Error al Escribir Archivo", as_Archivo, StopSign!, OK!)
	lb_Retorno	=	False
END IF
		
IF FileWriteEx(li_Canal, ablob_Content) = -1 THEN
	Messagebox("Error al Escribir Archivo", as_Archivo, StopSign!, OK!)
	lb_Retorno	=	False
END IF

FileClose(li_Canal)

Setpointer(Arrow!)

RETURN lb_Retorno
end function

public function boolean recuperaimagen (datawindow adw, long fila, transaction at_transaccion);String 	ls_TemporalWindows, ls_Archivo, ls_ArchivoTemp
Blob   	lblob_Archivo

lblob_Archivo			=	SeleccionaDocto(adw, Fila, ls_Archivo, at_transaccion)
ls_TemporalWindows	=	TemporalWindow()

// Archivo temporal para leer
IF ls_TemporalWindows = "" THEN
	ls_ArchivoTemp  = "c:\" + ls_Archivo
ELSE
	ls_ArchivoTemp = ls_TemporalWindows + ls_Archivo
END IF

IF IsNull(lblob_Archivo) THEN
	MessageBox( "Atención", "Archivo que está leyendo viene nulo" ) 
	RETURN False
END IF

IF ArchivoBlob(ls_ArchivoTemp, lblob_Archivo) THEN
	AbrirDocumento(ls_ArchivoTemp)
END IF
end function

public function boolean grabaimagen (datawindow adw, long fila, transaction at_transaccion, string as_archivo);Boolean	lb_Retorno = False
Long		ll_Archivo, ll_Numero
Blob 		lbl_Datos, lbl_Temporal

/*
	Script de Ejemplo
	No se hereda

Integer	li_Cliente, li_Especie, li_Codigo

ll_Numero	=	adw.Object.reen_numero[Fila]
li_Cliente	=	adw.Object.clie_codigo[Fila]
li_Especie	=	adw.Object.espe_codigo[Fila]
li_Codigo	=	adw.Object.reid_codigo[Fila]
ll_Archivo	=	FileOpen(as_archivo, StreamMode!)

DO WHILE FileRead(ll_Archivo, lbl_Temporal) > 0
	lbl_Datos	+=	lbl_Temporal
LOOP

FileClose(ll_Archivo)

IF ll_Archivo = 1 THEN
	FileRead(ll_Archivo, lbl_Datos)
	FileClose(ll_Archivo)
	
	at_Transaccion.AutoCommit	=	True
	
	UPDATEBLOB dba.ctlcalreclamosimagenesdeta 
			SET	reid_imagen  =	:lbl_Datos 
			WHERE	reen_numero	=	:ll_Numero
			AND	espe_codigo	=	:li_Especie
			AND	clie_codigo	=	:li_Cliente
			AND	reid_codigo	=	:li_Codigo
			USING at_Transaccion;
			
	at_Transaccion.AutoCommit	=	False
	lb_Retorno						=	True
END IF

IF at_Transaccion.SQLNRows > 0 THEN
	Commit;
	lb_Retorno	=	True
END IF

FileClose(ll_Archivo)
*/

RETURN lb_Retorno
end function

public function blob seleccionadocto (datawindow adw, long fila, ref string as_file_tmp, transaction at_transaccion);Blob 		lblob_Archivo

SetNull(lblob_Archivo)

/*
	Este script no se hereda
	Sólo es un ejemplo

Long		ll_Numero
Integer	li_Cliente, li_Especie, li_Codigo

as_File_tmp	=	adw.Object.reid_archiv[Fila]
ll_Numero	=	adw.Object.reen_numero[Fila]
li_Cliente	=	adw.Object.clie_codigo[Fila]
li_Especie	=	adw.Object.espe_codigo[Fila]
li_Codigo	=	adw.Object.reid_codigo[Fila]

SELECTBLOB 	reid_imagen
	INTO	:lblob_Archivo
	FROM	dba.ctlcalreclamosimagenesdeta
	WHERE	reen_numero	=	:ll_Numero
	AND	espe_codigo	=	:li_Especie
	AND	clie_codigo	=	:li_Cliente
	AND	reid_codigo	=	:li_Codigo
	USING at_transaccion;

IF at_transaccion.Sqlcode = -1 OR at_transaccion.Sqlcode = 100 THEN
	MessageBox( "Atención", "Ha ocurrido el error: ~n~r" + at_transaccion.SqlErrText ) 
	RETURN lblob_Archivo
END IF
*/

RETURN lblob_Archivo
end function

on uo_admdoctos.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_admdoctos.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

