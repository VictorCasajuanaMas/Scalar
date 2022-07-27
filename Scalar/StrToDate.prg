#include 'hbclass.ch'

CREATE CLASS StrToDate

    EXPORTED:
		METHOD Convert(cDate, cFormat, xReturn) 
		METHOD SetDate( dDate )

	PROTECTED:

		DATA dDate AS DATE INIT Date()

        METHOD cLetToDate(cLet)  	// Letra a Fecha
		METHOD cSimToDate(cDate) 	// Fecha con un s�mbolo a Fecha
		METHOD cDMASepToDate(cDate)	// Fecha con Separadores a Fecha
		METHOD cMDASepToDate(cDate)	// Fecha con Separadores a Fecha
		METHOD cAMDSepToDate(cDate)	// Fecha con Separadores a Fecha
		METHOD cSemToDate(cDate) 	// Dia de la semana a Fecha
		METHOD cDMAToDate(cDate) 	// Numerica en formato DMA a Fecha
		METHOD cMDAToDate(cDate) 	// Numerica en formato MDA a Fecha
		METHOD cAMDToDate(cDate) 	// Numerica en formato AMD a Fecha

END CLASS

/* METHOD: Convert( cDate, cFormat, xReturn )
    Devuelve una fecha a partir de una Cadena interpretable como fecha.

	Par�metros:
	cDate - Formato seg�n:
            h -- Fecha de actual
            m -- Fecha de ma�ana
            a -- Fecha de ayer
			
			+d -- Dentro de d d�as
			-d -- Hace d d�as
			>  -- �ltimo d�a del a�o
			<  -- Primer d�as del a�o
			
			d, dd - D�a d del mes y a�o actual
			dmm, ddmm - D�a d y mes mm del a�o actual
			dmmaa, ddmmaa - D�a d y mes mm del a�o aa
			dmmaaaa, ddmmaaaa - D�a d y mes mm del a�o aaaa
			d/m, d/mm, dd/m, dd/mm - D�a d y mes m del a�o actual
			d/m/a - D�a d y mes mm del a�o aa
			sem, semana - Fecha del pr�ximo dia de la semana.

    xReturn - Cadena a devolver si no se logra la conversi�n, ::dDate por defecto
	cFormat - Formato de entrada AMD MDA AMD


Devuelve:
    Cadena formateada como una fecha
*/

METHOD Convert(cDate, cFormat, xReturn) CLASS StrToDate
	Local dRet
	
	xReturn := iif(empty(xReturn), ::dDate, xReturn)
	hb_default(@cFormat, "DMA" )
	
	cDate := Lower( AllTrim (cDate) )
	
	Do Case
		Case Len(cDate) == 1 .and.  cDate $ "htaymw"
			dRet := ::cLetToDate( cDate )
			
		Case Left( cDate,1) $ "+-><"
			dRet := ::cSimToDate( cDate )
			
		Case At("-", cDate) > 0 .or. At(" ", cDate) > 0 .or. At(".", cDate) > 0 .or. At("/", cDate) > 0
			switch cFormat
				case "DMA"
					dRet := ::cDMASepToDate( cDate )
					exit
										
				case "MDA"
					dRet := ::cMDASepToDate( cDate )
					exit
					
				case "AMD"
					dRet := ::cAMDSepToDate( cDate )
					exit
			endswitch
		
		Case Val( cDate ) == 0
			dRet := ::cSemToDate( cDate )
			
		Case Val( cDate ) > 0
			switch cFormat
				case "DMA"
					dRet := ::cDMAToDate( cDate )
					exit
										
				case "MDA"
					dRet := ::cMDAToDate( cDate )
					exit
					
				case "AMD"
					dRet := ::cAMDToDate( cDate )
					exit
			endswitch
			
		Otherwise
		    dRet := xReturn
		
	End Case
	
	If empty(dRet)
		dRet := xReturn
	EndIf
	
Return dRet

/* METHOD: SetDAte( dDAte )
	Asigna dDAte al data de la clase dDAte
	
	Par�metros:
		dDAte - fecha a asignar

Devuelve:
	Self
*/
METHOD SetDAte( dDAte ) CLASS StrToDate

	If dDate != Nil .And.;
	   HB_ISDATE( dDate )

		::dDate := dDate

	Endif

Return ( Self )

//------------------------------------------------------------------------------
// Si se le pasa h, t, a, y, m, w devuelve una fecha correspondiente a hoy,
// ayer o ma�ana. Cualquier otra cosa devuelve una fecha vacia
// La fecha devuelta tendra el formato activo

METHOD cLetToDate( cLet ) CLASS StrToDate
	Local dRet

    if ValType( cLet ) == 'C'
        		
		switch cLet
			// Hoy
			case 'h'
			case 't'
			    dRet := ::dDate
				exit
					
			// Ayer
			case 'a'
            case 'y'
				dRet := ::dDate - 1
				exit
					
            // Ma�ana
			case 'm'
            case 'w'
				dRet := ::dDate + 1
				exit
				
			otherwise
				dRet := CToD( "" )
			
		endswitch

    endif
	
return dRet


//------------------------------------------------------------------------------
// Si se pasa + � -  seguido de un n�mero, suma o resta a la fecha actual
// Si se pasa > � < devuelve el �ltimo d�a del a�o actual o el primero
// La fecha devuelta tendra el formato activo

METHOD cSimToDate (cDate) CLASS StrToDate
	Local cRet := "" , cSymbol, cParam
	
	if ValType( cDate ) == 'C'

		cSymbol := Left(cDate,1)
		cParam  := SubStr(cDate,2)

		switch cSymbol

			case '+'
				cRet := DToC(::dDate + (iif(Val(cParam) > 0, Val(cParam), 1)) )
				exit
						
			case '-'
				cRet := DToC(::dDate - (iif(Val(cParam) > 0, Val(cParam), 1)) )
				exit
						
			case '>'
				cRet := '31-12-' + IIF (Val(cParam)> 0 .and. Val(cParam) < 10000, SubStr(cDate,2), Str(Year(::dDate)))
				exit
						
			case '<'
				cRet := '01-01-' + iif(Val(SubStr(cDate,2)) > 0 .and. Val(SubStr(cDate,2)) < 10000, SubStr(cDate,2), Str(Year(::dDate)))
				exit
			
		endswitch
	endif
return CToD( cRet )


//------------------------------------------------------------------------------
// Devuelve la fecha pasado con separadores
// La fecha devuelta tendra el formato activo

METHOD  cDMASepToDate (cDate) CLASS StrToDate
	Local aParts, cRet, cFormOld
	
	cFormOld := Set( _SET_DATEFORMAT, "dd-mm-yyyy" )
	
	cDate := cStrTran(cDate," ./","---")
	aParts := HB_ATokens( DToC( ::dDate ), "-" )
	
	AEval( HB_ATokens( cDate, "-" ), {| token, n | aParts[n] := IIF(Val(token)>0, token, aParts[n])  } )	
	
	cRet := aParts[ 1 ] + "-" + aParts[ 2 ] + "-" + aParts[ 3 ]
	Set( _SET_DATEFORMAT, cFormOld )
	
return (CToD(cRet))

METHOD  cMDASepToDate (cDate) CLASS StrToDate
	Local aParts, cRet, cFormOld
	
	cFormOld := Set( _SET_DATEFORMAT, "mm-dd-yyyy" )
	
	cDate := cStrTran(cDate," ./","---")
	aParts := HB_ATokens( DToC( ::dDate ), "-" )
	
	AEval( HB_ATokens( cDate, "-" ), {| token, n | aParts[n] := IIF(Val(token)>0, token, aParts[n])  } )	
	
	cRet := aParts[ 2 ] + "-" + aParts[ 1 ] + "-" + aParts[ 3 ]
	Set( _SET_DATEFORMAT, cFormOld )
	
return (CToD(cRet))

METHOD  cAMDSepToDate (cDate) CLASS StrToDate
	Local aParts, cRet, cFormOld
	
	cFormOld := Set( _SET_DATEFORMAT, "yyyy-mm-dd" )
	
	cDate := cStrTran(cDate," ./","---")
	aParts := HB_ATokens( DToC( ::dDate ), "-" )
	
	AEval( HB_ATokens( cDate, "-" ), {| token, n | aParts[n] := IIF(Val(token)>0, token, aParts[n])  } )	
	
	cRet := aParts[ 3 ] + "-" + aParts[ 2 ] + "-" + aParts[ 1 ]
	Set( _SET_DATEFORMAT, cFormOld )
	
return (CToD(cRet))


//------------------------------------------------------------------------------
// Formato d�a de la semana, internacional

METHOD cSemToDate( cDiaSemana ) CLASS StrToDate

    local dRet, aDay, nDayFound, n
	local nCountDays := 0

    if ValType( cDiaSemana ) == 'C'
        aDay := Array( 7 )
        cDiaSemana := lower( cDiaSemana )

		// Cargamos los d�as de la semana en el idioma actual en min�sculas
		for n := 1 to 7
            aDay[ n ] := lower( HB_TRANSLATE(hb_CDay( n ),"ES850","ESWIN") )
		next
		
		// Buscamos en el Array de semanas el d�a y cuantos coinciden
		for n:= 1 to 7
			if Left(aDay[ n ],Len(cDiaSemana)) == cDiaSemana    // B�squeda blanda
				nCountDays++
				nDayFound := n
			endif
		next
		
		// Si hay coincidencia en mas de un d�a no es valida la entrada
		if nCountDays == 1
			if  nDayFound - DoW( ::dDate )  > 0 // En esta semana o la siguiente
				return ::dDate + nDayFound - Dow( ::dDate )
			else
				return ::dDate + 7 + nDayFound - Dow( ::dDate )
			endif
		endif
    endif

return CToD( "" )


//------------------------------------------------------------------------------
// Formato DMA (D�aMesA�o)

METHOD cDMAToDate( cDate ) CLASS StrToDate

    local cFormOld, aParts, dRet

    if ValType( cDate ) == 'C' .and. Val( cDate ) > 0

		cFormOld := Set( _SET_DATEFORMAT, "dd-mm-yyyy" )

        aParts := HB_ATokens( DToC( ::dDate ), "-" )

        if Mod( Len( cDate ), 2 ) != 0
            cDate := "0" + cDate
        endif

        switch Len( cDate )
			case 2
				aParts[ 1 ] := cDate
				exit
			case 4
				aParts[ 1 ] := SubStr( cDate, 1, 2 )
				aParts[ 2 ] := SubStr( cDate, 3, 2 )
				exit
			otherwise
				aParts[ 1 ] := SubStr( cDate, 1, 2 )
				aParts[ 2 ] := SubStr( cDate, 3, 2 )
				aParts[ 3 ] := SubStr( cDate, 5 )
        endswitch

        dRet := CToD( aParts[ 1 ] + "-" + aParts[ 2 ] + "-" + aParts[ 3 ] )
		
        Set( _SET_DATEFORMAT, cFormOld )
    else
        dRet := CToD( "" )
    endif
return dRet

//------------------------------------------------------------------------------
// Formato MDA (MesD�aA�o)

METHOD cMDAToDate( cDate ) CLASS StrToDate

    local cFormOld, aParts, dRet

    if ValType( cDate ) == 'C' .and. Val( cDate ) > 0
        cFormOld := Set( _SET_DATEFORMAT, "dd-mm-yyyy" )

        aParts := HB_ATokens( DToC( ::dDate ), "-" )

        if Mod( Len( cDate ), 2 ) != 0
            cDate := "0" + cDate
        endif

        switch Len( cDate )
			case 2
				aParts[ 1 ] := cDate
				exit
			case 4
				aParts[ 1 ] := SubStr( cDate, 3, 2 )
				aParts[ 2 ] := SubStr( cDate, 1, 2 )
				exit
			otherwise
				aParts[ 1 ] := SubStr( cDate, 3, 2 )
				aParts[ 2 ] := SubStr( cDate, 1, 2 )
				aParts[ 3 ] := SubStr( cDate, 5 )
        endswitch

        dRet := CToD( aParts[ 1 ] + "-" + aParts[ 2 ] + "-" + aParts[ 3 ] )

        Set( _SET_DATEFORMAT, cFormOld )
    else
        dRet := CToD( "" )
    endif

return dRet

//------------------------------------------------------------------------------
// Formato AMD (A�oMesD�a)
 METHOD cAMDToDate( cDate ) CLASS StrToDate
    local cFormOld, aParts, dRet

    if ValType( cDate ) == 'C' .and. Val( cDate ) > 0
        cFormOld := Set( _SET_DATEFORMAT, "dd-mm-yyyy" )

        aParts := HB_ATokens( DToC( ::dDate ), "-" )

        cDate := AllTrim( cDate )

        if Mod( Len( cDate ), 2 ) != 0
            cDate := "0" + cDate
        endif

        switch Len( cDate )
			case 2
				aParts[ 1 ] := cDate
				exit
			case 4
				aParts[ 1 ] := "01"
				aParts[ 2 ] := SubStr( cDate, 3, 2 )
				aParts[ 3 ] := SubStr( cDate, 1, 2 )
				exit
			otherwise
				aParts[ 1 ] := SubStr( cDate, -2, 2 )
				aParts[ 2 ] := SubStr( cDate, -4, 2 )
				aParts[ 3 ] := SubStr( cDate, 1, Len( cDate ) -4 )
        endswitch

        dRet := CToD( aParts[ 1 ] + "-" + aParts[ 2 ] + "-" + aParts[ 3 ] )

        Set( _SET_DATEFORMAT, cFormOld )
    else
        dRet := CToD( "" )
    endif

return dRet

Static Function cStrTran( cOrigin, cPattern, cToConvert )

    Local cResult AS CHARACTER := ''
    Local cChar   AS CHARACTER := ''

    If Len( cPattern ) != Len( cToConvert )

        Return ( cOrigin )

    Endif

    for each cChar in cOrigin

        cResult += Convert( cChar, cPattern, cToConvert )
        
    next

Return ( cResult )

Static Function Convert( cChar, cPattern, cToConvert )

    Local cCharConvert AS CHARACTER := Upper( cChar )
    Local cCharPattern AS CHARACTER := ''

    for each cCharPattern in cPattern
        
        If cCharPattern == cCHar 

            cCharConvert := Substr(cToConvert, cCharPattern:__enumIndex, 1)

        Endif

    next

Return ( cCharConvert )