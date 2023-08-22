$PBExportHeader$uo_apiwindows.sru
$PBExportComments$Objeto de Usuario con llamada a Funciones API de Windows.
forward
global type uo_apiwindows from nonvisualobject
end type
end forward

global type uo_apiwindows from nonvisualobject
end type
global uo_apiwindows uo_apiwindows

type prototypes

FUNCTION ulong		GetCurrentDirectoryA(ulong BufferLen, ref string currentdir) LIBRARY "Kernel32.dll" alias for "GetCurrentDirectoryA;Ansi"
FUNCTION boolean	CopyFileA(ref string cfrom, ref string cto, boolean flag) LIBRARY "Kernel32.dll" alias for "CopyFileA;Ansi"
FUNCTION integer	SQLAllocEnv(ref long henv) LIBRARY "odbc32.dll" 
FUNCTION integer	SQLFreeEnv(long henv) LIBRARY "odbc32.dll" 
FUNCTION integer	SQLDataSources (long henv, integer idirection, ref string szdsn, int idsnmax, ref integer idsn, ref string szdesc, integer idescmax, ref integer idesc) library "odbc32.dll" alias for "SQLDataSources;Ansi" 
FUNCTION boolean	GetUserNameA(ref string uname, ref ulong slength) LIBRARY "ADVAPI32.DLL" alias for "GetUserNameA;Ansi" // Recupera usuario de windows
FUNCTION Boolean	LogonUserA(ref string lpszUsername, ref String lpszDomain, ref string lpszPassword, Long dwLogonType, Long dwLogonProvider, REF  Long  phToken)  LIBRARY "ADVAPI32.DLL" Alias For "LogonUserA;Ansi"
FUNCTION boolean	CloseHandle(long handle)  LIBRARY "kernel32.dll"
FUNCTION ulong		GetLastError() LIBRARY "kernel32.dll"
Function Long		CreateProcessWithLogonW(Ref String lpUsername, Ref String lpDomain, Ref String lpPassword, &
						Ref Long dwLogonFlags, REf String lpApplicationName, Ref String lpCommandLine,&
						Ref Long dwCreationFlags, Ref Long lpEnvironment, Ref String lpCurrentDirectory, &
						Ref str_startupinfo lpStartupInfo, Ref str_process_information lpProcessInformation) Library "advapi32.dll" alias for "CreateProcessWithLogonW;Ansi" 
FUNCTION	Long		SetErrorMode(Ref Long uMode) LIBRARY "kernel32.dll"
FUNCTION	uLong		GetVersionExA(ref str_osversioninfo lpVersionInfo) LIBRARY "Kernel32.dll" alias for "GetVersionExA;Ansi"
end prototypes

forward prototypes
public function string directorioactual ()
public function string obtiene_usuario_windows ()
public function string recupera_dominio ()
public function boolean valida_user_pass_windows ()
public function long w2krunasuser (string username, string domainname, string password)
public function boolean copiaarchivo (string as_archivo_de, string as_archivo_donde)
public function boolean of_iswin98_2k ()
end prototypes

public function string directorioactual ();//Declarar como función Global Externa
//FUNCTION ulong GetCurrentDirectoryA(ulong BufferLen, ref string currentdir) LIBRARY "Kernel32.dll"

String	ls_directorio
ulong 	l_buf

l_buf = 100

ls_directorio = space(l_buf)

GetCurrentDirectoryA(l_buf, ls_directorio)

RETURN ls_directorio
end function

public function string obtiene_usuario_windows ();// Declarar como Funcion Global Externa
// FUNCTION boolean GetUserNameA(ref string uname, ref ulong slength) LIBRARY "ADVAPI32.DLL"

STRING ls_username, ls_var
ulong		lu_val
boolean	rtn
lu_val			=	255
ls_username		=	space(255)
rtn				=	GetUserNameA(ls_username, lu_val)
//Messagebox("GetUserNameA", "Username = " + string(ls_username))
RETURN	ls_username
end function

public function string recupera_dominio ();OleObject wsh
Integer li_rc
String	dominio
wsh	=	CREATE OleObject
li_rc	=	wsh.ConnectToNewObject("WScript.Network")
IF	li_rc	=	0	THEN
	//MessageBox("Domain",String(wsh.UserDomain))
	dominio	=	String(wsh.UserDomain)	
ELSE
	dominio=''
END IF
Return dominio
end function

public function boolean valida_user_pass_windows ();//Valida usuario, dominio y password de Windows NT.
//FUNCTION Boolean	LogonUserA  (string lpszUsername, String lpszDomain, string lpszPassword, Long dwLogonType, Long dwLogonProvider, REF  uLong  phToken)  LIBRARY "advapi32.dll"
//FUNCTION ulong		GetLastError() LIBRARY "kernel32.dll"
Long			h_token, f_Match
boolean		lb_yes, cheqwin, lb_yes1
String		ls_result, ls_error
Long			LOGON32_PROVIDER_DEFAULT =0, LOGON32_LOGON_NETWORK=2,LOGON32_LOGON_BATCH=3
Long 		version


lb_yes		=	LogonUserA(gstr_us.nombre, gstr_us.dominio, gstr_us.password,2,0,h_token)
//lb_yes1		=	LogonUser(gstr_us.nombre, gstr_us.dominio, gstr_us.password,LOGON32_LOGON_NETWORK,LOGON32_PROVIDER_DEFAULT,h_token)
	

if (lb_yes) then
	//ls_result = "Conección Satisfactoria"
	CloseHandle(h_token)
else
	ls_error			=	string(GetLastError())
	//ls_result		=	"Conección a Fallado"
end if

return lb_yes


end function

public function long w2krunasuser (string username, string domainname, string password);
//Option Explicit

Long CREATE_DEFAULT_ERROR_MODE = 67108864
Long  LOGON_WITH_PROFILE = 1
Long	w2krunasuser
//Private Const LOGON_NETCREDENTIALS_ONLY = &H2
//
//Private Const LOGON32_LOGON_INTERACTIVE = 2
//Private Const LOGON32_PROVIDER_DEFAULT = 0


//'  LogonUser() requires that the caller has the following permission
//'  Permission                        Display Name
//'  --------------------------------------------------------------------
//'  SE_TCB_NAME                      Act as part of the operating system
//
//'  CreateProcessAsUser() requires that the caller has the following permissions
//'  Permission                        Display Name
//'  ---------------------------------------------------------------
//'  SE_ASSIGNPRIMARYTOKEN_NAME       Replace a process level token
//'  SE_INCREASE_QUOTA_NAME           Increase quotas
//  
                             

//Private Const VER_PLATFORM_WIN32_NT = &H2

//'********************************************************************
//
//'                   RunAsUser for Windows 2000 and Later
//'********************************************************************

//Public Function W2KRunAsUser(ByVal UserName As String, _
//        ByVal Password As String, _
//        ByVal DomainName As String, _
//        ByVal CommandLine As String, _
//        ByVal CurrentDirectory As String) As Long

    str_startupinfo 				istr_si
	 str_process_information	istr_pi   
    String 	lpApplicationName, lpCommandLine, lpCurrentDirectory
    Long		Result
		
	 lpApplicationName	="C:\winnt\notepad.exe"
	 lpCommandLine			="notepad.exe"
	 lpCurrentDirectory	="C:\winnt"
//    
    

	 istr_si.cb	=	148	// si.cb = len(si) revisar cual es la equivalencia
	// istr_si.dwfllags = 0&
           
    Result = CreateProcessWithLogonW(username, domainname, password,LOGON_WITH_PROFILE, lpApplicationName,&
	 lpCommandLine, CREATE_DEFAULT_ERROR_MODE, istr_si.dwfllags, lpCurrentDirectory, istr_si, istr_pi)
												 
  // CreateProcessWithLogonW() does not
    If Result <> 0 Then
        CloseHandle(istr_pi.hThread)
        CloseHandle(istr_pi.hProcess)
        w2krunasuser = 0
    Else
        w2krunasuser = GetLastError() //w2krunasuser = Err.LastDllError
    End If

//End Function
//

return 1

end function

public function boolean copiaarchivo (string as_archivo_de, string as_archivo_donde);BOOLEAN lb_flag, lb_rtn

lb_flag = false

lb_rtn = CopyFileA(as_archivo_de, as_archivo_donde, lb_flag)


RETURN lb_rtn
end function

public function boolean of_iswin98_2k ();//Obtiene Version del sistema operativo
/* lstr_VersionInfo.dwMajorVersion:
Windows 95: 4
Windows 98: 4
Windows ME: 4
Windows NT 3.51: 3
Windows NT 4: 4
Windows 2000: 5
Windows XP: 5

lstr_VersionInfo.dwMinorVersion:
Windows 95: 0
Windows 98: 10
Windows ME: 90
Windows NT 3.51: 51
Windows NT 4: 0
Windows 2000: 0
Windows XP: 1
*/

str_osversioninfo lstr_VersionInfo // Estructura asignada en variable global

lstr_VersionInfo.dwosversioninfosize = 148

GetVersionExA(lstr_VersionInfo)

IF	(lstr_VersionInfo.dwmajorversion = 4 And lstr_VersionInfo.dwminorversion = 0) THEN
	Sistema_Operativo =1 // Windows 95 / NT 4
END IF
IF	(lstr_VersionInfo.dwmajorversion = 4 And lstr_VersionInfo.dwminorversion = 10) THEN
	Sistema_Operativo =2 // Windows 98
END IF
IF	(lstr_VersionInfo.dwmajorversion = 4 And lstr_VersionInfo.dwminorversion = 90) THEN
	Sistema_Operativo =3 // Windows ME
END IF	
IF	(lstr_VersionInfo.dwmajorversion = 3 And lstr_VersionInfo.dwminorversion = 51) THEN
	Sistema_Operativo =4 // Windows NT 3
END IF
IF	(lstr_VersionInfo.dwmajorversion = 5 And lstr_VersionInfo.dwminorversion = 0) THEN
	Sistema_Operativo =5 // Windows 2000
END IF
IF	(lstr_VersionInfo.dwmajorversion = 5 And lstr_VersionInfo.dwminorversion = 1) THEN
	Sistema_Operativo =6 // Windows XP
END IF

Return TRUE

end function

on uo_apiwindows.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_apiwindows.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

