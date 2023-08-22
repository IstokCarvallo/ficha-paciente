$PBExportHeader$w_imprimir.srw
$PBExportComments$Ventana antes de imprimir
forward
global type w_imprimir from window
end type
type rb_3 from radiobutton within w_imprimir
end type
type rb_2 from radiobutton within w_imprimir
end type
type rb_1 from radiobutton within w_imprimir
end type
type st_print from statictext within w_imprimir
end type
type vtb_1 from vtrackbar within w_imprimir
end type
type dw_1 from datawindow within w_imprimir
end type
type rb_actual from radiobutton within w_imprimir
end type
type sle_nombre from singlelineedit within w_imprimir
end type
type sle_coment from singlelineedit within w_imprimir
end type
type sle_puerto from singlelineedit within w_imprimir
end type
type st_3 from statictext within w_imprimir
end type
type st_2 from statictext within w_imprimir
end type
type p_1 from picture within w_imprimir
end type
type lv_1 from listview within w_imprimir
end type
type sle_impresora from dropdownpicturelistbox within w_imprimir
end type
type cbx_intercalar from checkbox within w_imprimir
end type
type ddlb_print from dropdownlistbox within w_imprimir
end type
type st_1 from statictext within w_imprimir
end type
type sle_paginas from singlelineedit within w_imprimir
end type
type rb_paginas from radiobutton within w_imprimir
end type
type rb_todo from radiobutton within w_imprimir
end type
type em_copias from editmask within w_imprimir
end type
type cb_impresora from commandbutton within w_imprimir
end type
type cb_cancelar from commandbutton within w_imprimir
end type
type cb_aceptar from commandbutton within w_imprimir
end type
type st_copies from statictext within w_imprimir
end type
type st_printer from statictext within w_imprimir
end type
type gb_1 from groupbox within w_imprimir
end type
type gb_3 from groupbox within w_imprimir
end type
type gb_5 from groupbox within w_imprimir
end type
type gb_6 from groupbox within w_imprimir
end type
type gb_2 from groupbox within w_imprimir
end type
type sle_estado from singlelineedit within w_imprimir
end type
type str_osversioninfo from structure within w_imprimir
end type
end forward

type str_osversioninfo from structure
	ulong		dwOSVersionInfoSize
	ulong		dwmajorversion
	ulong		dwminorversion
	ulong		dwbuildnumber
	ulong		dwplatformid
	character		SZCSDVERION[128]
end type

global type w_imprimir from window
integer x = 832
integer y = 356
integer width = 2693
integer height = 2332
boolean titlebar = true
string title = "Imprimir"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 16777215
string icon = "AppIcon!"
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
st_print st_print
vtb_1 vtb_1
dw_1 dw_1
rb_actual rb_actual
sle_nombre sle_nombre
sle_coment sle_coment
sle_puerto sle_puerto
st_3 st_3
st_2 st_2
p_1 p_1
lv_1 lv_1
sle_impresora sle_impresora
cbx_intercalar cbx_intercalar
ddlb_print ddlb_print
st_1 st_1
sle_paginas sle_paginas
rb_paginas rb_paginas
rb_todo rb_todo
em_copias em_copias
cb_impresora cb_impresora
cb_cancelar cb_cancelar
cb_aceptar cb_aceptar
st_copies st_copies
st_printer st_printer
gb_1 gb_1
gb_3 gb_3
gb_5 gb_5
gb_6 gb_6
gb_2 gb_2
sle_estado sle_estado
end type
global w_imprimir w_imprimir

type prototypes
Function long GetPrinter (ulong hPrinter, long Level, long buffer, long pbSize, ref long pbSizeNeeded ) Library "winspool.drv" Alias For"GetPrinterW"
//Function long GetPrinter (ulong hPrinter, long Level,ref blob buffer, long pbSize, ref long pbSizeNeeded ) Library "winspool.drv" Alias For"GetPrinterW"

Function long GetPrinter (ulong hPrinter, long Level, ref ulong buffer[], long pbSize, ref long pbSizeNeeded ) Library "winspool.drv" Alias For"GetPrinterW"

Function long OpenPrinter ( string pPrinterName, ref ulong phPrinter, long pDefault ) Library "winspool.drv" Alias For "OpenPrinterW"
Function long ClosePrinter ( ulong hPrinter) Library "winspool.drv" 
Subroutine CopyMemory ( ref blob Destination, long Source,Long Length) Library "kernel32.dll" Alias For "RtlMoveMemory"
FUNCTION ulong GetVersionExA( REF str_osversioninfo lpVersionInfo ) LIBRARY "kernel32.dll" Alias For 'GetVersionExA;Ansi'
end prototypes

type variables
DataWindow 	idw_imprimir
String		is_impresora_predef

Constant long PRINTER_STATUS_READY = 0 // &H0
Constant long PRINTER_STATUS_PAUSED = 1 // &H1
Constant long PRINTER_STATUS_ERROR = 2 //  &H2
Constant long PRINTER_STATUS_PENDING_DELETION = 4 // &H4
Constant long PRINTER_STATUS_PAPER_JAM = 8 // &H8
Constant long PRINTER_STATUS_PAPER_OUT = 16 // &H10
Constant long PRINTER_STATUS_MANUAL_FEED = 32 // &H20
Constant long PRINTER_STATUS_PAPER_PROBLEM = 64 // &H40
Constant long PRINTER_STATUS_OFFLINE = 132 // &H80
Constant long PRINTER_STATUS_IO_ACTIVE = 256 // &H100
Constant long PRINTER_STATUS_BUSY = 512 // &H200
Constant long PRINTER_STATUS_PRINTING = 1024 // &H400
Constant long PRINTER_STATUS_OUTPUT_BIN_FULL = 2048 //&H800
Constant long PRINTER_STATUS_NOT_AVAILABLE = 4096 // &H1000
Constant long PRINTER_STATUS_WAITING = 8192 // &H2000
Constant long PRINTER_STATUS_PROCESSING = 16384 // &H4000
Constant long PRINTER_STATUS_INITIALIZING = 32768 // &H8000
Constant long PRINTER_STATUS_WARMING_UP = 65536 // &H10000
Constant long PRINTER_STATUS_TONER_LOW = 131072 // &H20000
Constant long PRINTER_STATUS_NO_TONER = 262144 // &H40000
Constant long PRINTER_STATUS_PAGE_PUNT = 524288 // &H80000
Constant long PRINTER_STATUS_USER_INTERVENTION = 1048576 // &H100000
Constant long PRINTER_STATUS_OUT_OF_MEMORY = 2097152 //&H200000
Constant long PRINTER_STATUS_DOOR_OPEN = 4194304 // &H400000
Constant long PRINTER_STATUS_SERVER_UNKNOWN = 8388608 // &H800000
Constant long PRINTER_STATUS_POWER_SAVE = 16777216 // &H1000000
end variables

forward prototypes
public subroutine cargaimpresoras ()
public function string of_getstringfrompointer (unsignedlong al_pointer)
public subroutine datosimpresora (string as_impresora)
public subroutine cambiaimagen (integer ai_index)
public subroutine modificaimpresion ()
public subroutine cargalistaimpresoras (ref string ls_printers[])
end prototypes

public subroutine cargaimpresoras ();string				ls_printers[]
Integer				li_rtn, li_fila, li_nbPrinters, li_pos, li_imagen
listviewitem		lvi_item

//li_rtn					= 	RegistryKeys ("HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Print\Printers", ls_printers)

CargaListaImpresoras(ls_printers[])
li_nbPrinters			=	UpperBound(ls_printers)
li_pos					=	Pos(PrintGetPrinter(), '~t') -1
is_impresora_predef	=	Left(PrintGetPrinter(), li_pos)

FOR li_fila = 1 TO li_nbPrinters
	li_imagen = 1
	
	IF ls_printers[li_fila] = is_impresora_predef THEN 
		li_imagen = 2
		DatosImpresora(ls_printers[li_fila])
	END IF
	lv_1.addItem(ls_printers[li_fila], li_imagen)
	
NEXT

end subroutine

public function string of_getstringfrompointer (unsignedlong al_pointer);integer	li_len
integer	li_max = 1024
string	ls_temp
blob	lblb_temp

IF al_pointer = 0 THEN Return ''

lblb_temp 	= 	Blob (Space(li_max))
CopyMemory(lblb_temp, al_pointer, li_max)
li_len 		= 	Len(lblb_temp)
ls_temp 		= 	String(lblb_temp)

Return ls_temp
end function

public subroutine datosimpresora (string as_impresora);string 			ls_printer, ls_estado
Long 				ll_pos, ll_size, ll_count, ll_max = 1020, rc
printer_info	pi
integer			li_index
ulong				ll_buffer[], hPrinter
blob 				buffer

//IF Left(as_impresora, 1) = "\" OR Left(as_impresora, 1) = "/" THEN
//	sle_estado.Text	=	"Lista - En Red"
//	sle_puerto.Text	=	""
//	sle_coment.Text	=	""
//	sle_nombre.Text	=	as_impresora
//	Return
//END IF
//ls_printer 	= 	as_impresora
//str_osversioninfo lstr_osver
//
//lstr_osver.dwosversioninfosize = 148
//GetVersionExA( lstr_osver )
//IF NOT (lstr_osver.dwmajorversion = 5 AND lstr_osver.dwminorversion = 1)  THEN
//	rc 			= 	OpenPrinter(ls_printer, hPrinter, 0 )
//	rc 			= 	GetPrinter(hPrinter, 2, 0, 0, ll_size )
//	ll_count 	= 	Min(ll_size / 4, ll_max)
//	
//	ll_count 	= 	Min ( ll_size / 4, ll_max)
//
//	FOR li_index = 1 TO ll_count
//		ll_buffer[li_index] = 0
//	NEXT
//	
//	Try
//		rc = GetPrinter(hPrinter, 2, ll_buffer, ll_size, ll_size)
//		rc = ClosePrinter(hPrinter)
//	CATCH (dwruntimeerror dwr)
//		MessageBox('Atencion','Error de DataWindows ' + dwr.GetMessage(), Exclamation!, Ok!)
//	CATCH (dividebyzeroerror dz)
//		MessageBox('Atencion','Division por Cero' + dz.GetMessage(), Exclamation!, Ok!)
//	CATCH (nullobjecterror no)
//		MessageBox('Atencion','nullobjecterror ' + no.GetMessage(), Exclamation!, Ok!)
//	CATCH (pbxruntimeerror pbx)
//		MessageBox('Atencion','Pbx Run Time Error ' + pbx.GetMessage(), Exclamation!, Ok!)
//	CATCH (runtimeerror rt)
//		MessageBox('Atencion','No se puede obtener informacion de la Impresora. Favor seleccione Otra.~rRunTime Error ' + rt.GetMessage(), Exclamation!, Ok!)
//	CATCH (exception ex)
//		MessageBox('Atencion','Execpcion ' + ex.GetMessage(), Exclamation!, Ok!)
//	End Try
	
//	rc = GetPrinter(hPrinter, 2, ll_buffer, ll_size, ll_size)
//	rc = ClosePrinter(hPrinter)

//	pi.pservername 			= 	of_getstringfrompointer(ll_buffer[1])
//	pi.pprintername 			= 	of_getstringfrompointer(ll_buffer[2])
//	pi.pShareName 				= 	of_getStringFrompointer(ll_buffer[3])
//	pi.pPortName 				= 	of_getStringFrompointer(ll_buffer[4])
//	pi.pDriverName 			= 	of_getStringFrompointer(ll_buffer[5])
//	pi.pComment 				=	of_getStringFrompointer(ll_buffer[6])
//	pi.pLocation 					= 	of_getStringFrompointer(ll_buffer[7])
//	pi.pDevMode 				= 	ll_buffer[8]
//	pi.pSepFile 					= 	of_getStringFrompointer(ll_buffer[9])
//	pi.pPrintProcessor			= 	of_getStringFrompointer(ll_buffer[10])
//	pi.pDatatype 				= 	of_getStringFrompointer(ll_buffer[11])
//	pi.pParameters 				= 	of_getStringFrompointer(ll_buffer[12])
//	pi.pSecurityDescriptor 		= 	ll_buffer[13]
//	pi.Attributes 					= 	ll_buffer[14]
//	pi.Priority 					= 	ll_buffer[15]
//	pi.DefaultPriority 			= 	ll_buffer[16]
//	pi.StartTime 				= 	ll_buffer[17]
//	pi.UntilTime 					= 	ll_buffer[18]
//	pi.Status 						= 	ll_buffer[19]
//	pi.JobsCount		 			= 	ll_buffer[20]
//	pi.AveragePPM 				= 	ll_buffer[21]

	
//	rc 		= 	OpenPrinter(ls_printer, hPrinter, 0 )
//	rc 		= 	GetPrinter (hPrinter, 2, 0, 0,ll_size )
//	
//	buffer 	= 	blob(space(ll_size))
//	rc 		= 	GetPrinter (hPrinter, 2, buffer, ll_size, ll_size)
//	ClosePrinter(hPrinter)
//	
//	IF rc = 1 THEN
//		MessageBox ("Error", "La funcion devolvio el error " + String(rc))
//		Return
//	END IF
//
//	pi.pservername 			=	of_getstringfrompointer (long(blobmid(buffer, 1, 4)))
//	pi.pprintername 			= 	of_getstringfrompointer (long(blobmid(buffer,5, 4)))
//	pi.pShareName 				= 	of_getStringFrompointer(long(blobmid(buffer, 9, 4)))
//	pi.pPortName 				= 	of_getStringFrompointer(long(blobmid(buffer, 13, 4)))
//	pi.pDriverName 			= 	of_getStringFrompointer(long(blobmid(buffer, 17, 4)))
//	pi.pComment 				= 	of_getStringFrompointer(long(blobmid(buffer, 21, 4)))
//	pi.pLocation 				= 	of_getStringFrompointer(long(blobmid(buffer, 25, 4)))
//	pi.pDevMode 				= 	long(blobmid(buffer, 1, 4))
//	pi.pSepFile 				= 	of_getStringFrompointer(long(blobmid(buffer, 29, 4)))
//	pi.pPrintProcessor 		= 	of_getStringFrompointer(long(blobmid(buffer, 33, 4)))
//	pi.pDatatype 				= 	of_getStringFrompointer(long(blobmid(buffer, 37, 4)))
//	pi.pParameters 			= 	of_getStringFrompointer(long(blobmid(buffer, 41, 4)))
//	pi.pSecurityDescriptor 	= 	long(blobmid(buffer, 45, 4))
//	pi.Attributes 				=	long(blobmid(buffer, 49, 4))
//	pi.Priority 				= 	long(blobmid(buffer, 53, 4))
//	pi.DefaultPriority 		= 	long(blobmid(buffer, 57, 4))
//	pi.StartTime 				= 	long(blobmid(buffer, 61, 4))
//	pi.UntilTime 				= 	long(blobmid(buffer, 65, 4))
//	pi.Status 					= 	long(blobmid(buffer, 69, 4))
//	pi.JobsCount 				= 	long(blobmid(buffer, 73, 4))
//	pi.AveragePPM 				= 	long(blobmid(buffer, 77, 4))

//	CHOOSE CASE pi.Status 
//		CASE PRINTER_STATUS_READY 
//			ls_estado	=	'Lista'
//			
//		CASE PRINTER_STATUS_PAUSED 
//			ls_estado	=	'En Pausa'
//			
//		CASE PRINTER_STATUS_ERROR  
//			ls_estado	=	'Con Error'
//			
//		CASE PRINTER_STATUS_PENDING_DELETION  
//			ls_estado	=	'Pendiente de Eliminación'
//			
//		CASE PRINTER_STATUS_PAPER_JAM  
//			ls_estado	=	'Atasco de Papel'
//			
//		CASE PRINTER_STATUS_PAPER_OUT  
//			ls_estado	=	'Sin Papel'
//			
//		CASE PRINTER_STATUS_MANUAL_FEED  
//			ls_estado	=	'Alimentación Manual'
//			
//		CASE PRINTER_STATUS_PAPER_PROBLEM  
//			ls_estado	=	'Problemas con Papel'
//			
//		CASE PRINTER_STATUS_OFFLINE  
//			ls_estado	=	'Fuera de Linea'
//			
//		CASE PRINTER_STATUS_IO_ACTIVE  
//			ls_estado	=	'Recibiendo Datos'
//			
//		CASE PRINTER_STATUS_BUSY  
//			ls_estado	=	'Ocupada'
//			
//		CASE PRINTER_STATUS_PRINTING  
//			ls_estado	=	'Imprimiendo'
//			
//		CASE PRINTER_STATUS_OUTPUT_BIN_FULL
//			ls_estado	=	'Bandeja de Salida Llena'
//			  
//		CASE PRINTER_STATUS_NOT_AVAILABLE  
//			ls_estado	=	'No Disponible'
//			
//		CASE PRINTER_STATUS_WAITING  
//			ls_estado	=	'Esperando'
//			
//		CASE PRINTER_STATUS_PROCESSING  
//			ls_estado	=	'Procesando'
//			
//		CASE PRINTER_STATUS_INITIALIZING  
//			ls_estado	=	'Inicializando'
//			
//		CASE PRINTER_STATUS_WARMING_UP  
//			ls_estado	=	'Calentando'
//			
//		CASE PRINTER_STATUS_TONER_LOW  
//			ls_estado	=	'Toner Bajo'
//			
//		CASE PRINTER_STATUS_NO_TONER  
//			ls_estado	=	'Sin Toner'
//			
//		CASE PRINTER_STATUS_PAGE_PUNT  
//			ls_estado	=	'Pagina Demasiado Compleja'
//			
//		CASE PRINTER_STATUS_USER_INTERVENTION  
//			ls_estado	=	'Solicita Intervencion Usuario'
//			
//		CASE PRINTER_STATUS_OUT_OF_MEMORY  
//			ls_estado	=	'Sin Memoria'
//			
//		CASE PRINTER_STATUS_DOOR_OPEN  
//			ls_estado	=	'Puerta Abierta'
//			
//		CASE PRINTER_STATUS_SERVER_UNKNOWN  
//			ls_estado	=	'Servidor Desconocido'
//			
//		CASE PRINTER_STATUS_POWER_SAVE
//			ls_estado	=	'Ahorro de Energia'
//			
//		CASE 128
//			ls_estado	=	'Fuera de Linea'
//			
//		CASE ELSE
//			ls_estado	=	'Estado Desconocido' + String(pi.Status)
//	END CHOOSE
//	
//	sle_estado.Text	=	ls_estado
//	sle_puerto.Text	=	pi.pPortName 
//	sle_coment.Text	=	pi.pComment
//	sle_nombre.Text	=	pi.pprintername
//END IF
end subroutine

public subroutine cambiaimagen (integer ai_index);Integer			li_fila
ListViewItem	llvi_1
FOR li_fila = 1 TO lv_1.TotalItems()
	lv_1.GetItem(li_fila, llvi_1)
	IF li_fila = ai_index THEN
		llvi_1.PictureIndex	=	2
	ELSe
		llvi_1.PictureIndex	=	1
	END IF
	
	lv_1.SetItem(li_fila, llvi_1)
NEXT
end subroutine

public subroutine modificaimpresion ();integer li_retorno
string  ls_argumentos_a_modificar, ls_error, ls_paso

SetPointer ( HourGlass! )

ls_argumentos_a_modificar = "DataWindow.Print.Copies = " &
	+ string ( em_copias.text ) + " "

if rb_todo.checked then
   ls_argumentos_a_modificar = ls_argumentos_a_modificar + "DataWindow.Print.Page.Range = '' "
	
elseIF rb_actual.checked THEN
		li_retorno						= 	idw_imprimir.getrow()
		ls_paso							=	idw_imprimir.describe("evaluate('page()',"+string(li_retorno)+")")
		ls_argumentos_a_modificar 	= 	ls_argumentos_a_modificar + "DataWindow.Print.Page.Range = '" + ls_paso + "' "
	ELSE
		
   ls_argumentos_a_modificar = ls_argumentos_a_modificar + "DataWindow.Print.Page.Range = '" &
		+ sle_paginas.text + "' "
end if

if rb_3.checked then
   ls_argumentos_a_modificar = ls_argumentos_a_modificar + "DataWindow.Print.Page.RangeInclude = 2"
	
elseif rb_2.checked  then
   ls_argumentos_a_modificar = ls_argumentos_a_modificar + "DataWindow.Print.Page.RangeInclude = 1"
	
else
   ls_argumentos_a_modificar = ls_argumentos_a_modificar + "DataWindow.Print.Page.RangeInclude = 0"
	
end if

if cbx_intercalar.checked then
   ls_argumentos_a_modificar = ls_argumentos_a_modificar + "DataWindow.Print.Collate= yes "
	
else
   ls_argumentos_a_modificar = ls_argumentos_a_modificar + "DataWindow.Print.Collate= no "
	
end if

ls_error = idw_imprimir.modify ( ls_argumentos_a_modificar )

if ls_error <> "" then
	MessageBox ( "Error", ls_error )
	CloseWithReturn (This, -1 )
end if

gb_5.Text	=	"Preview - Páginas " + dw_1.describe("evaluate('pagecount()'," + string ( dw_1.rowcount() ) + ")")
end subroutine

public subroutine cargalistaimpresoras (ref string ls_printers[]);String 	ls_impresoras, ls_variable, ls_caracter, ls_ImpresoraActual, ls_ImpresoraComp
Integer	li_fila, li_posi, li_columna, li_row

ls_impresoras 		= 	PrintGetPrinters ( )

DO WHILE Len(ls_impresoras) > 0
	li_columna		=	1
	li_posi			=	Pos(ls_impresoras, '~n')
	
	IF li_posi = 0 THEN
		ls_impresoras	=	ls_impresoras + '~n'
		li_posi	 		=	Pos(ls_impresoras, '~n')
	END IF
	
	FOR li_fila = 1 TO li_posi
		ls_caracter	=	Mid(ls_impresoras, li_fila, 1)
		
		IF ls_caracter <> '~t' AND ls_caracter <> '~n' THEN
			ls_variable = 	ls_variable + ls_caracter
		ELSE
			CHOOSE CASE li_columna
				CASE 1
					li_row ++
					ls_printers[li_row] 	= 	ls_variable
					
				CASE 2
//					ids_impresoras.Object.drivers[li_row] 		= 	ls_variable
					
				CASE 3
//					ids_impresoras.Object.puerto[li_row] 		= 	ls_variable
					
			END CHOOSE
			li_columna 		++
			ls_variable 	= 	''
			
		END IF
		
	NEXT
	ls_impresoras	=	Right(ls_impresoras, (Len(ls_impresoras) - li_posi))
	
LOOP
end subroutine

event open;str_mant		lstr_mant
integer    	li_copias, li_intervalo
string     	ls_rango

lstr_mant = message.PowerObjectParm
SetPointer ( HourGlass! )
idw_imprimir = lstr_mant.dw

dw_1.DataObject	=	lstr_mant.dw.DataObject
lstr_mant.dw.ShareData(dw_1)
dw_1.Modify('DataWindow.Print.Preview = Yes')
dw_1.Modify('DataWindow.Print.Preview.Zoom = 28')

sle_impresora.additem(idw_imprimir.describe("DataWindow.Printer"), 1)
sle_impresora.selectitem(1)

li_copias = integer ( idw_imprimir.describe ( "DataWindow.Print.Copies" ) )
IF li_copias < 1 THEN
	em_copias.text = "1"
ELSE
	em_copias.text = string ( li_copias )
END IF

ls_rango = idw_imprimir.describe ( "DataWindow.Print.Page.Range" )
IF ls_rango = "" THEN
   rb_todo.checked   	= 	TRUE
   rb_paginas.checked 	= 	FALSE
   sle_paginas.text   	= 	""
	
ELSE
   rb_todo.checked   	= 	FALSE
   rb_paginas.checked 	= 	TRUE
   sle_paginas.text   	= 	ls_rango
	
END IF

cargaimpresoras()

li_intervalo = integer ( idw_imprimir.describe("DataWindow.Print.Page.RangeInclude"))
	
IF li_intervalo = 2 THEN
   ddlb_print.text = "Páginas Impares"
	rb_3.Checked		=	True
	rb_2.Checked		=	False
	rb_1.Checked		=	False
	
ELSEIF li_intervalo = 1 THEN
   ddlb_print.text = "Páginas Pares"
	rb_2.Checked		=	True
	rb_1.Checked		=	False
	rb_3.Checked		=	False
	
ELSE
   ddlb_print.text 	= 	"El intervalo"
	rb_1.Checked		=	True
	rb_2.Checked		=	False
	rb_3.Checked		=	False
	
END IF

IF idw_imprimir.describe ( "DataWindow.Print.Collate" ) = "yes" THEN
   cbx_intercalar.checked = TRUE
ELSE
   cbx_intercalar.checked = FALSE
END IF

cbx_intercalar.TriggerEvent("Clicked")

end event

on w_imprimir.create
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_print=create st_print
this.vtb_1=create vtb_1
this.dw_1=create dw_1
this.rb_actual=create rb_actual
this.sle_nombre=create sle_nombre
this.sle_coment=create sle_coment
this.sle_puerto=create sle_puerto
this.st_3=create st_3
this.st_2=create st_2
this.p_1=create p_1
this.lv_1=create lv_1
this.sle_impresora=create sle_impresora
this.cbx_intercalar=create cbx_intercalar
this.ddlb_print=create ddlb_print
this.st_1=create st_1
this.sle_paginas=create sle_paginas
this.rb_paginas=create rb_paginas
this.rb_todo=create rb_todo
this.em_copias=create em_copias
this.cb_impresora=create cb_impresora
this.cb_cancelar=create cb_cancelar
this.cb_aceptar=create cb_aceptar
this.st_copies=create st_copies
this.st_printer=create st_printer
this.gb_1=create gb_1
this.gb_3=create gb_3
this.gb_5=create gb_5
this.gb_6=create gb_6
this.gb_2=create gb_2
this.sle_estado=create sle_estado
this.Control[]={this.rb_3,&
this.rb_2,&
this.rb_1,&
this.st_print,&
this.vtb_1,&
this.dw_1,&
this.rb_actual,&
this.sle_nombre,&
this.sle_coment,&
this.sle_puerto,&
this.st_3,&
this.st_2,&
this.p_1,&
this.lv_1,&
this.sle_impresora,&
this.cbx_intercalar,&
this.ddlb_print,&
this.st_1,&
this.sle_paginas,&
this.rb_paginas,&
this.rb_todo,&
this.em_copias,&
this.cb_impresora,&
this.cb_cancelar,&
this.cb_aceptar,&
this.st_copies,&
this.st_printer,&
this.gb_1,&
this.gb_3,&
this.gb_5,&
this.gb_6,&
this.gb_2,&
this.sle_estado}
end on

on w_imprimir.destroy
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_print)
destroy(this.vtb_1)
destroy(this.dw_1)
destroy(this.rb_actual)
destroy(this.sle_nombre)
destroy(this.sle_coment)
destroy(this.sle_puerto)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.p_1)
destroy(this.lv_1)
destroy(this.sle_impresora)
destroy(this.cbx_intercalar)
destroy(this.ddlb_print)
destroy(this.st_1)
destroy(this.sle_paginas)
destroy(this.rb_paginas)
destroy(this.rb_todo)
destroy(this.em_copias)
destroy(this.cb_impresora)
destroy(this.cb_cancelar)
destroy(this.cb_aceptar)
destroy(this.st_copies)
destroy(this.st_printer)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.gb_5)
destroy(this.gb_6)
destroy(this.gb_2)
destroy(this.sle_estado)
end on

type rb_3 from radiobutton within w_imprimir
integer x = 946
integer y = 1388
integer width = 320
integer height = 92
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Impares"
end type

event clicked;ModificaImpresion()
end event

type rb_2 from radiobutton within w_imprimir
integer x = 663
integer y = 1388
integer width = 238
integer height = 92
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Pares"
end type

event clicked;ModificaImpresion()
end event

type rb_1 from radiobutton within w_imprimir
integer x = 329
integer y = 1388
integer width = 329
integer height = 92
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Intervalo"
boolean checked = true
end type

event clicked;ModificaImpresion()
end event

type st_print from statictext within w_imprimir
integer x = 101
integer y = 1412
integer width = 215
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
boolean enabled = false
string text = "Imprimir:"
boolean focusrectangle = false
end type

type vtb_1 from vtrackbar within w_imprimir
integer x = 1390
integer y = 916
integer width = 101
integer height = 1188
integer minposition = 1
integer maxposition = 100
integer position = 28
integer tickfrequency = 2
integer linesize = 1
vtickmarks tickmarks = vticksonneither!
end type

event moved;dw_1.Modify('DataWindow.Print.Preview.Zoom = ' + String(ScrollPos))
end event

type dw_1 from datawindow within w_imprimir
integer x = 1531
integer y = 916
integer width = 1083
integer height = 1188
integer taborder = 60
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_actual from radiobutton within w_imprimir
integer x = 96
integer y = 1036
integer width = 279
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "&Actual"
end type

event clicked;ModificaImpresion()
end event

type sle_nombre from singlelineedit within w_imprimir
integer x = 370
integer y = 636
integer width = 923
integer height = 76
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
borderstyle borderstyle = stylelowered!
end type

type sle_coment from singlelineedit within w_imprimir
integer x = 370
integer y = 724
integer width = 923
integer height = 76
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
borderstyle borderstyle = stylelowered!
end type

type sle_puerto from singlelineedit within w_imprimir
integer x = 1486
integer y = 724
integer width = 645
integer height = 76
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_imprimir
integer x = 87
integer y = 732
integer width = 274
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
boolean enabled = false
string text = "Comentarios"
boolean focusrectangle = false
end type

type st_2 from statictext within w_imprimir
integer x = 1330
integer y = 732
integer width = 165
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
boolean enabled = false
string text = "Puerto"
boolean focusrectangle = false
end type

type p_1 from picture within w_imprimir
integer x = 603
integer y = 1820
integer width = 494
integer height = 224
string picturename = "\Desarrollo 17\Imagenes\MenuImpresion\nor.jpg"
boolean focusrectangle = false
end type

type lv_1 from listview within w_imprimir
integer x = 69
integer y = 92
integer width = 2551
integer height = 512
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean autoarrange = true
boolean fixedlocations = true
boolean labelwrap = false
boolean twoclickactivate = true
listviewview view = listviewlist!
string largepicturename[] = {"\Desarrollo 12\Imagenes\Botones\ImprimirEnab.png","\Desarrollo 12\Imagenes\Botones\Imprime2.png"}
integer largepicturewidth = 32
integer largepictureheight = 32
long largepicturemaskcolor = 536870912
string smallpicturename[] = {"\Desarrollo 12\Imagenes\Botones\ImprimirEnab.png","\Desarrollo 12\Imagenes\Botones\Imprime2.png"}
integer smallpicturewidth = 32
integer smallpictureheight = 32
long smallpicturemaskcolor = 536870912
string statepicturename[] = {"Custom038!"}
integer statepicturewidth = 32
integer statepictureheight = 32
long statepicturemaskcolor = 536870912
end type

event clicked;listviewitem		lvi_item

lv_1.GetItem(Index, lvi_item)

IF Len(lvi_item.label) > 1 THEN
	PrintSetPrinter(lvi_item.label)
	DatosImpresora(lvi_item.label)
	CambiaImagen(Index)
END IF
end event

type sle_impresora from dropdownpicturelistbox within w_imprimir
boolean visible = false
integer x = 2715
integer y = 1668
integer width = 965
integer height = 96
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 33543637
boolean enabled = false
boolean allowedit = true
boolean showlist = true
borderstyle borderstyle = stylelowered!
string picturename[] = {"Custom074!"}
long picturemaskcolor = 553648127
end type

type cbx_intercalar from checkbox within w_imprimir
integer x = 242
integer y = 1884
integer width = 325
integer height = 68
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "Int&ercalar"
boolean checked = true
end type

event clicked;IF THIS.Checked THEN
	p_1.PictureName	=	"\Desarrollo 17\Imagenes\MenuImpresion\int.jpg"
ELSE
	p_1.PictureName	=	"\Desarrollo 17\Imagenes\MenuImpresion\nor.jpg"
END IF
end event

type ddlb_print from dropdownlistbox within w_imprimir
boolean visible = false
integer x = 2738
integer y = 1572
integer width = 681
integer height = 320
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean vscrollbar = true
string item[] = {"El intervalo","Páginas pares","Páginas impares"}
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_imprimir
integer x = 96
integer y = 1204
integer width = 1175
integer height = 116
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
boolean enabled = false
string text = "Escriba números de páginas e intervalos separados por comas. Ejemplo: 1,3,5-12,14"
boolean focusrectangle = false
end type

type sle_paginas from singlelineedit within w_imprimir
event pbm_enchange pbm_enchange
integer x = 407
integer y = 1116
integer width = 663
integer height = 80
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event pbm_enchange;if this.text = "" then
   parent.rb_todo.checked   = true
   parent.rb_paginas.checked = false
else
   parent.rb_todo.checked   = false
   parent.rb_paginas.checked = true
end if

ModificaImpresion()
end event

type rb_paginas from radiobutton within w_imprimir
integer x = 96
integer y = 1116
integer width = 306
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "Pá&ginas:"
end type

type rb_todo from radiobutton within w_imprimir
integer x = 96
integer y = 948
integer width = 279
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "&Todo"
boolean checked = true
end type

event clicked;ModificaImpresion()
end event

type em_copias from editmask within w_imprimir
integer x = 603
integer y = 1684
integer width = 494
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
integer accelerator = 99
borderstyle borderstyle = stylelowered!
string mask = "####"
boolean spin = true
double increment = 1
string minmax = "1~~"
end type

type cb_impresora from commandbutton within w_imprimir
integer x = 2181
integer y = 652
integer width = 434
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Propiedades..."
end type

event clicked;//PrintSetup ()
////Mensaje a WM_WININICHANGE
//
//Send(65535, 26, 0, 0)
//
//SetPointer ( HourGlass! )
//
//parent.sle_impresora.deleteitem ( 1 )
//
//parent.sle_impresora.additem ( parent.idw_imprimir.describe ( "DataWindow.Printer" ),1 )
//parent.sle_impresora.selectitem ( 1 )

PrintSetupPrinter()

end event

type cb_cancelar from commandbutton within w_imprimir
integer x = 2098
integer y = 2140
integer width = 375
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

on clicked;CloseWithReturn ( parent, 0 )


end on

type cb_aceptar from commandbutton within w_imprimir
integer x = 1678
integer y = 2140
integer width = 375
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
boolean default = true
end type

event clicked;integer li_retorno
string  ls_argumentos_a_modificar, ls_error, ls_paso

ModificaImpresion()

li_retorno = parent.idw_imprimir.print(true)

CloseWithReturn (parent, li_retorno)

end event

type st_copies from statictext within w_imprimir
integer x = 137
integer y = 1700
integer width = 434
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
boolean enabled = false
string text = "Número de &copias:"
boolean focusrectangle = false
end type

type st_printer from statictext within w_imprimir
integer x = 87
integer y = 644
integer width = 197
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
boolean enabled = false
string text = "Nombre:"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_imprimir
integer x = 32
integer y = 28
integer width = 2619
integer height = 812
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "Impresora"
end type

type gb_3 from groupbox within w_imprimir
integer x = 37
integer y = 1588
integer width = 1257
integer height = 540
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "Copias"
end type

type gb_5 from groupbox within w_imprimir
integer x = 1330
integer y = 852
integer width = 1321
integer height = 1276
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "Preview"
end type

type gb_6 from groupbox within w_imprimir
integer x = 78
integer y = 1332
integer width = 1184
integer height = 176
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
end type

type gb_2 from groupbox within w_imprimir
integer x = 37
integer y = 852
integer width = 1257
integer height = 740
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "Intervalo de páginas"
end type

type sle_estado from singlelineedit within w_imprimir
integer x = 1330
integer y = 636
integer width = 805
integer height = 76
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
borderstyle borderstyle = stylelowered!
end type

