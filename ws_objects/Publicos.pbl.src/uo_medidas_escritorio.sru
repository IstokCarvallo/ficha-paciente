$PBExportHeader$uo_medidas_escritorio.sru
forward
global type uo_medidas_escritorio from nonvisualobject
end type
type str_rect from structure within uo_medidas_escritorio
end type
end forward

type str_rect from structure
	long		left
	long		top
	long		right
	long		bottom
end type

global type uo_medidas_escritorio from nonvisualobject
end type
global uo_medidas_escritorio uo_medidas_escritorio

type prototypes
Function boolean SystemParametersInfo(ulong wActon, &
												  ulong wParam, &
												  REF str_rect  pvParam, &
												  ulong fUpdateProfile) Library "USER32.DLL" ALIAS FOR  "SystemParametersInfoW"
end prototypes

type variables
Long			il_top, il_left, il_right, il_bottom
end variables

forward prototypes
public subroutine of_cargamedidas ()
end prototypes

public subroutine of_cargamedidas ();CONSTANT long SPI_GETWORKAREA = 48
boolean 	lb_Ret
str_rect	lstr_Rect

lb_Ret 		= 	SystemParametersInfo(SPI_GETWORKAREA, 0, lstr_Rect,  0 )

il_top		=	lstr_Rect.Top
il_left		=	lstr_Rect.Left
il_right	=	lstr_Rect.Right
il_bottom	=	lstr_Rect.Bottom

end subroutine

on uo_medidas_escritorio.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_medidas_escritorio.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

