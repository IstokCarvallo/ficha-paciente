$PBExportHeader$w_mant_mues_admalogtransacs.srw
$PBExportComments$Ejecuta Actualizaciones de Conexiones seleccionadas.
forward
global type w_mant_mues_admalogtransacs from w_mant_directo
end type
type dw_2 from uo_dw within w_mant_mues_admalogtransacs
end type
type dw_dispon from uo_dw within w_mant_mues_admalogtransacs
end type
type dw_repli from uo_dw within w_mant_mues_admalogtransacs
end type
type cb_ponetodos from commandbutton within w_mant_mues_admalogtransacs
end type
type cb_poneuno from commandbutton within w_mant_mues_admalogtransacs
end type
type cb_sacauno from commandbutton within w_mant_mues_admalogtransacs
end type
type cb_sacatodos from commandbutton within w_mant_mues_admalogtransacs
end type
end forward

global type w_mant_mues_admalogtransacs from w_mant_directo
integer width = 3607
integer height = 2092
dw_2 dw_2
dw_dispon dw_dispon
dw_repli dw_repli
cb_ponetodos cb_ponetodos
cb_poneuno cb_poneuno
cb_sacauno cb_sacauno
cb_sacatodos cb_sacatodos
end type
global w_mant_mues_admalogtransacs w_mant_mues_admalogtransacs

type variables
Transaction	SqlRep
end variables

forward prototypes
public function boolean conexiones (integer ll_fila)
end prototypes

public function boolean conexiones (integer ll_fila);Boolean	lb_Retorno = True

	DISCONNECT USING SqlRep;
	
	SqlRep.dbms			=	dw_Repli.Object.reco_nodbms[ll_Fila]
	SqlRep.ServerName	=	dw_Repli.Object.reco_noserv[ll_Fila]
	SqlRep.DataBase	=	dw_Repli.Object.reco_nobase[ll_Fila]
	
	IF SqlRep.Dbms = "ODBC" THEN
		SqlRep.DbParm	=	"ConnectString='DSN=" + dw_Repli.Object.reco_noodbc[ll_Fila] + &
											";UID=" + dw_Repli.Object.reco_usuari[ll_Fila] + &
											";PWD=" + dw_Repli.Object.reco_passwo[ll_Fila] + &
											"',DisableBind=1,ConnectOption='SQL_DRIVER_CONNECT," + &
											"SQL_DRIVER_NOPROMPT'// ;PBUseProcOwner = " + '"Yes"'
	ELSE
		SqlRep.LogId		=	dw_Repli.Object.reco_usuari[ll_Fila]
		SqlRep.LogPass		=	dw_Repli.Object.reco_passwo[ll_Fila]
		SqlRep.Autocommit	=	True
	END IF
	
	DO
		CONNECT Using SqlRep; 
	
		IF SqlRep.SQLCode <> 0 THEN
			IF SqlRep.SQLDBCode = -102 THEN
				MessageBox("Error de Conexión", "Demasiados Usuarios conectados a la Base.~r" + &
								"Consulte con Administrador", StopSign!, Ok!)
				lb_Retorno	=	False
			ELSEIF SqlRep.SQLDBCode <> 0 THEN
//				F_ErrorBaseDatos(sqlca, This.Title)
				lb_Retorno	=	False
			END IF
		END IF
	LOOP UNTIL SqlRep.SQLCode <> 0

RETURN lb_Retorno
end function

on w_mant_mues_admalogtransacs.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_dispon=create dw_dispon
this.dw_repli=create dw_repli
this.cb_ponetodos=create cb_ponetodos
this.cb_poneuno=create cb_poneuno
this.cb_sacauno=create cb_sacauno
this.cb_sacatodos=create cb_sacatodos
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_dispon
this.Control[iCurrent+3]=this.dw_repli
this.Control[iCurrent+4]=this.cb_ponetodos
this.Control[iCurrent+5]=this.cb_poneuno
this.Control[iCurrent+6]=this.cb_sacauno
this.Control[iCurrent+7]=this.cb_sacatodos
end on

on w_mant_mues_admalogtransacs.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.dw_dispon)
destroy(this.dw_repli)
destroy(this.cb_ponetodos)
destroy(this.cb_poneuno)
destroy(this.cb_sacauno)
destroy(this.cb_sacatodos)
end on

event open;call super::open;dw_2.SetTransObject(sqlca)

dw_dispon.SetTransObject(sqlca)
dw_dispon.Retrieve()

dw_repli.SetTransObject(sqlca)

dw_repli.Object.DataWindow.ReadOnly="Yes"

dw_dispon.Object.DataWindow.ReadOnly="Yes"

SqlRep	=	CREATE TRANSACTION
end event

event ue_recuperadatos;call super::ue_recuperadatos;Long		ll_Filas, ll_Fila

dw_1.SetRedraw(False)

ll_Filas	=	dw_1.Retrieve()

IF ll_Filas = -1 THEN
	F_ErrorBaseDatos(sqlca, "Lectura de Tabla Buscada")

	dw_1.SetRedraw(True)

	RETURN
ELSEIF ll_Filas > 0 THEN
//	IF AlgúnControl THEN
//		istr_Mant.Solo_Consulta	=	True
//	ELSE
	istr_Mant.Solo_Consulta	=	False
//	END IF
ELSE
	pb_Eliminar.Enabled  =	Not istr_mant.Solo_Consulta
	pb_Grabar.Enabled		=	Not istr_mant.Solo_Consulta
	pb_insertar.Enabled	=	Not istr_mant.Solo_Consulta
	pb_eliminar.Enabled	=	Not istr_mant.Solo_Consulta
		
	IF ll_Filas > 0 THEN
		pb_imprimir.Enabled	=	True
		
		dw_1.SetRow(1)
		dw_1.SelectRow(1, True)
		dw_1.SetFocus()
	END IF

	pb_insertar.SetFocus()
END IF

dw_1.SetRedraw(True)
end event

event ue_antesguardar;call super::ue_antesguardar;Long		ll_Fila, ll_Fil2, ll_Fil3, ll_Fil4
String	ls_SenFinal

FOR ll_Fila = 1 TO dw_Repli.RowCount()	
	IF Conexiones(ll_Fila) THEN
		FOR ll_Fil2 = 1 TO dw_1.RowCount()	
			IF Not IsNull(dw_1.Object.lotr_sente1[ll_Fil2]) OR &
				Not dw_1.Object.lotr_sente1[ll_Fil2] = "" THEN	ls_SenFinal += dw_1.Object.lotr_sente1[ll_Fil2]
			IF Not IsNull(dw_1.Object.lotr_sente2[ll_Fil2]) OR &
				Not dw_1.Object.lotr_sente2[ll_Fil2] = "" THEN	ls_SenFinal += dw_1.Object.lotr_sente1[ll_Fil2]
			IF Not IsNull(dw_1.Object.lotr_sente3[ll_Fil2]) OR &
				Not dw_1.Object.lotr_sente3[ll_Fil2] = "" THEN	ls_SenFinal += dw_1.Object.lotr_sente1[ll_Fil2]
			IF Not IsNull(dw_1.Object.lotr_sente4[ll_Fil2]) OR &
				Not dw_1.Object.lotr_sente4[ll_Fil2] = "" THEN	ls_SenFinal += dw_1.Object.lotr_sente1[ll_Fil2]
			IF Not IsNull(dw_1.Object.lotr_sente5[ll_Fil2]) OR &
				Not dw_1.Object.lotr_sente5[ll_Fil2] = "" THEN	ls_SenFinal += dw_1.Object.lotr_sente1[ll_Fil2]
				
			ll_Fil4 = dw_2.Find("reco_codigo = " + String(dw_Repli.Object.reco_codigo[ll_Fila]) + &
									  "AND lotr_numero = " + String(dw_1.Object.lotr_numero[ll_Fil2]), 1, dw_1.RowCount())
			
			IF ll_Fil4 = 0 THEN										
				IF Not IsNull(ls_SenFinal) OR Not ls_SenFinal = "" THEN	
					EXECUTE IMMEDIATE :ls_SenFinal USING SqlRep;
					
					IF SqlRep.SQLCode = -1 THEN
						F_ErrorBaseDatos(SqlRep, "Ejecución de Sentencia : ~r" + ls_SenFinal)
					ELSE
						ll_Fil3 = dw_2.InsertRow(0)
						dw_2.Object.reco_codigo[ll_Fil3] =	dw_Repli.Object.reco_codigo[ll_Fila]
						dw_2.Object.lotr_numero[ll_Fil3] =	dw_1.Object.lotr_numero[ll_Fil2] 
						dw_2.Object.lotr_estado[ll_Fil3] =	1
					END IF
				END IF				
			END IF
		NEXT
	ELSE
	END IF
NEXT
end event

type st_encabe from w_mant_directo`st_encabe within w_mant_mues_admalogtransacs
boolean visible = false
integer y = 44
integer width = 3392
integer height = 604
end type

type pb_nuevo from w_mant_directo`pb_nuevo within w_mant_mues_admalogtransacs
integer x = 3269
integer y = 428
end type

type pb_lectura from w_mant_directo`pb_lectura within w_mant_mues_admalogtransacs
integer x = 3269
integer y = 132
end type

type pb_eliminar from w_mant_directo`pb_eliminar within w_mant_mues_admalogtransacs
boolean visible = false
integer x = 3570
integer y = 788
end type

type pb_insertar from w_mant_directo`pb_insertar within w_mant_mues_admalogtransacs
boolean visible = false
integer x = 3570
integer y = 608
end type

type pb_salir from w_mant_directo`pb_salir within w_mant_mues_admalogtransacs
integer x = 3269
integer y = 1532
end type

type pb_imprimir from w_mant_directo`pb_imprimir within w_mant_mues_admalogtransacs
boolean visible = false
integer x = 3570
integer y = 1148
end type

type pb_grabar from w_mant_directo`pb_grabar within w_mant_mues_admalogtransacs
integer x = 3269
integer y = 968
end type

type dw_1 from w_mant_directo`dw_1 within w_mant_mues_admalogtransacs
integer y = 864
integer width = 3077
integer height = 976
string dataobject = "dw_mues_admalogtransacs"
end type

type dw_2 from uo_dw within w_mant_mues_admalogtransacs
integer x = 69
integer y = 1464
integer width = 2327
integer height = 372
integer taborder = 11
boolean bringtotop = true
string dataobject = "dw_mues_admarepliestado"
end type

type dw_dispon from uo_dw within w_mant_mues_admalogtransacs
integer x = 78
integer y = 32
integer width = 1426
integer height = 756
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Conexiones Disponibles"
string dataobject = "dw_mues_admaconexiones"
boolean hscrollbar = true
end type

event clicked;call super::clicked;IF row > 0 THEN
	IF IsSelected(row) THEN
		SelectRow(row,False)
	ELSE
		SelectRow(row,True)
	END IF
END IF
end event

type dw_repli from uo_dw within w_mant_mues_admalogtransacs
integer x = 1733
integer y = 32
integer width = 1426
integer height = 756
integer taborder = 21
boolean bringtotop = true
boolean titlebar = true
string title = "Conexiones a Replicar"
string dataobject = "dw_mues_admaconexiones"
boolean hscrollbar = true
end type

event clicked;call super::clicked;IF row > 0 THEN
	IF IsSelected(row) THEN
		SelectRow(row,False)
	ELSE
		SelectRow(row,True)
	END IF
END IF
end event

type cb_ponetodos from commandbutton within w_mant_mues_admalogtransacs
integer x = 1550
integer y = 192
integer width = 133
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
end type

event clicked;Long	ll_fila2, ll_fila1

ll_fila2 = dw_dispon.GetSelectedRow(0)

IF ll_fila2 = 0 THEN
	MessageBox("Error de Consistencia","Debe seleccionar Conexiones Disponibles")
	RETURN
END IF

SetPointer(HourGlass!)

DO WHILE ll_fila2 > 0
	
	ll_fila1  = dw_repli.InsertRow(0)
	 
	dw_repli.Object.reco_codigo[ll_fila1]	=	dw_dispon.Object.reco_codigo[ll_fila2]
	dw_repli.Object.reco_nombre[ll_fila1]	=	dw_dispon.Object.reco_nombre[ll_fila2]
	dw_repli.Object.reco_nodbms[ll_fila1]	=	dw_dispon.Object.reco_nodbms[ll_fila2]
	dw_repli.Object.reco_noodbc[ll_fila1]	=	dw_dispon.Object.reco_noodbc[ll_fila2]
	dw_repli.Object.reco_noserv[ll_fila1]	=	dw_dispon.Object.reco_noserv[ll_fila2]
	dw_repli.Object.reco_nobase[ll_fila1]	=	dw_dispon.Object.reco_nobase[ll_fila2]
	dw_repli.Object.reco_usuari[ll_fila1]	=	dw_dispon.Object.reco_usuari[ll_fila2]
	dw_repli.Object.reco_passwo[ll_fila1]	=	dw_dispon.Object.reco_passwo[ll_fila2]

	dw_dispon.DeleteRow(ll_fila2)
	ll_fila2 = dw_dispon.GetRow()
LOOP

pb_grabar.Enabled		      = True

dw_repli.SetFocus()
end event

type cb_poneuno from commandbutton within w_mant_mues_admalogtransacs
integer x = 1550
integer y = 328
integer width = 133
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">"
end type

event clicked;Long		ll_fila1, ll_fila2

ll_fila2 = dw_dispon.GetSelectedRow(0)
IF ll_fila2 = 0 THEN
	MessageBox("Error de Consistencia","Debe seleccionar del Conexiones Disponibles ")
	RETURN
END IF

SetPointer(HourGlass!)

DO WHILE ll_fila2 > 0
	ll_fila1 =	dw_repli.InsertRow(0)
	dw_repli.Object.reco_codigo[ll_fila1]	=	dw_dispon.Object.reco_codigo[ll_fila2]
	dw_repli.Object.reco_nombre[ll_fila1]	=	dw_dispon.Object.reco_nombre[ll_fila2]
	dw_repli.Object.reco_nodbms[ll_fila1]	=	dw_dispon.Object.reco_nodbms[ll_fila2]
	dw_repli.Object.reco_noodbc[ll_fila1]	=	dw_dispon.Object.reco_noodbc[ll_fila2]
	dw_repli.Object.reco_noserv[ll_fila1]	=	dw_dispon.Object.reco_noserv[ll_fila2]
	dw_repli.Object.reco_nobase[ll_fila1]	=	dw_dispon.Object.reco_nobase[ll_fila2]
	dw_repli.Object.reco_usuari[ll_fila1]	=	dw_dispon.Object.reco_usuari[ll_fila2]
	dw_repli.Object.reco_passwo[ll_fila1]	=	dw_dispon.Object.reco_passwo[ll_fila2]	

	dw_dispon.DeleteRow(ll_fila2)
	ll_fila2 = dw_dispon.GetSelectedRow(0)
LOOP

pb_grabar.Enabled		= True
 
dw_repli.SetFocus()
end event

type cb_sacauno from commandbutton within w_mant_mues_admalogtransacs
integer x = 1550
integer y = 464
integer width = 133
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<"
end type

event clicked;Long		ll_fila1, ll_fila2

ll_fila2 = dw_repli.GetSelectedRow(0)
IF ll_fila2 = 0 THEN
	MessageBox("Error de Consistencia","Debe seleccionar del Conexiones Disponibles ")
	RETURN
END IF

SetPointer(HourGlass!)

DO WHILE ll_fila2 > 0
	ll_fila1 =	dw_dispon.InsertRow(0)
	dw_dispon.Object.reco_codigo[ll_fila1]	=	dw_repli.Object.reco_codigo[ll_fila2]
	dw_dispon.Object.reco_nombre[ll_fila1]	=	dw_repli.Object.reco_nombre[ll_fila2]
	dw_dispon.Object.reco_nodbms[ll_fila1]	=	dw_repli.Object.reco_nodbms[ll_fila2]
	dw_dispon.Object.reco_noodbc[ll_fila1]	=	dw_repli.Object.reco_noodbc[ll_fila2]
	dw_dispon.Object.reco_noserv[ll_fila1]	=	dw_repli.Object.reco_noserv[ll_fila2]
	dw_dispon.Object.reco_nobase[ll_fila1]	=	dw_repli.Object.reco_nobase[ll_fila2]
	dw_dispon.Object.reco_usuari[ll_fila1]	=	dw_repli.Object.reco_usuari[ll_fila2]
	dw_dispon.Object.reco_passwo[ll_fila1]	=	dw_repli.Object.reco_passwo[ll_fila2]	

	dw_repli.DeleteRow(ll_fila2)
	ll_fila2 = dw_repli.GetSelectedRow(0)
LOOP

pb_grabar.Enabled		= True
 
dw_dispon.SetFocus()
end event

type cb_sacatodos from commandbutton within w_mant_mues_admalogtransacs
integer x = 1550
integer y = 600
integer width = 133
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<<"
end type

event clicked;Long	ll_fila2, ll_fila1

ll_fila1 = dw_repli.GetSelectedRow(0)

IF ll_fila1 = 0 THEN
	MessageBox("Error de Consistencia","Debe seleccionar Conexiones a Replicar")
	RETURN
END IF

SetPointer(HourGlass!)

DO WHILE ll_fila1 > 0
	
	ll_fila2  = dw_dispon.InsertRow(0)
	 
	dw_dispon.Object.reco_codigo[ll_fila2]	=	dw_repli.Object.reco_codigo[ll_fila1]
	dw_dispon.Object.reco_nombre[ll_fila2]	=	dw_repli.Object.reco_nombre[ll_fila1]
	dw_dispon.Object.reco_nodbms[ll_fila2]	=	dw_repli.Object.reco_nodbms[ll_fila1]
	dw_dispon.Object.reco_noodbc[ll_fila2]	=	dw_repli.Object.reco_noodbc[ll_fila1]
	dw_dispon.Object.reco_noserv[ll_fila2]	=	dw_repli.Object.reco_noserv[ll_fila1]
	dw_dispon.Object.reco_nobase[ll_fila2]	=	dw_repli.Object.reco_nobase[ll_fila1]
	dw_dispon.Object.reco_usuari[ll_fila2]	=	dw_repli.Object.reco_usuari[ll_fila1]
	dw_dispon.Object.reco_passwo[ll_fila2]	=	dw_repli.Object.reco_passwo[ll_fila1]

	dw_repli.DeleteRow(ll_fila1)
	ll_fila1 = dw_dispon.GetRow()
LOOP

pb_grabar.Enabled		      = True

dw_dispon.SetFocus()
end event

