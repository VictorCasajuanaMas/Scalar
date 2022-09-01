#include 'hbclass.ch'

CREATE CLASS StrToDate

    EXPORTED:
		METHOD Convert(cDate, cFormat, xReturn) 
		METHOD SetDate( dDate )

	PROTECTED:

		DATA dDate AS DATE INIT Date()

        METHOD cLetToDate(cLet)  				// Letra a Fecha
		METHOD cSimToDate(cDate) 				// Fecha con un s›mbolo a Fecha
		METHOD cSepToDate(cDate)				// Fecha con Separadores a Fecha
		METHOD cSemToDate(cDate, lFirstSunDay) 	// Dia de la semana a Fecha
		METHOD cDMAToDate(cDate) 				// Numerica en formato DMA a Fecha
		METHOD cMDAToDate(cDate) 				// Numerica en formato MDA a Fecha
		METHOD cAMDToDate(cDate) 				// Numerica en formato AMD a Fecha

END CLASS

/* METHOD: Convert( cDate, cFormat, xReturn )
    Devuelve una fecha a partir de una Cadena interpretable como fecha.

	Parﬂmetros:
	cDate - Formato seg∑n:
            h -- Fecha de actual
            m -- Fecha de ma±ana
            a -- Fecha de ayer
			
			+d -- Dentro de d d›as
			-d -- Hace d d›as
			>  -- ?ltimo d›a del a±o
			<  -- Primer d›as del a±o
			
			d, dd - D›a d del mes y a±o actual
			dmm, ddmm - D›a d y mes mm del a±o actual
			dmmaa, ddmmaa - D›a d y mes mm del a±o aa
			dmmaaaa, ddmmaaaa - D›a d y mes mm del a±o aaaa
			d/m, d/mm, dd/m, dd/mm - D›a d y mes m del a±o actual
			d/m/a - D›a d y mes mm del a±o aa
			sem, semana - Fecha del præximo dia de la semana.

    xReturn - Cadena a devolver si no se logra la conversiæn, ::dDate por defecto
	cFormat - Formato de entrada AMD MDA AMD


Devuelve:
    Fecha
*/

METHOD Convert(cDate, cFormat, xReturn) CLASS StrToDate
	Local dRet
	
	xReturn := iif(empty(xReturn), ::dDate, xReturn)
	hb_default(@cFormat, "DMA" )
	
	cDate := cDate:Alltrim():Lower()
	
	Do Case
		Case cDate:Len() == 1 .and.  cDate $ "htaymw"
			
			dRet := ::cLetToDate( cDate )
			
		Case cDate:Left(1) $ "+-><"
			dRet := ::cSimToDate( cDate )
			
		Case cDate:At(" ") > 0 .or. cDate:At("/") > 0 .or. cDate:At("-") > 0 .or. cDate:At(".") > 0
			dRet := ::cSepToDate( cDate, cFormat )
					
		Case cDate:Val() == 0
			dRet := ::cSemToDate( cDate )
			
		Case cDate:Val() > 0
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

/* METHOD: SetDate( dDAte )
	Asigna dDAte al data de la clase dDAte
	
	Par?metros:
		dDAte - fecha a asignar

Devuelve:
	Self
*/
METHOD SetDate( dDate ) CLASS StrToDate

	If dDate != Nil .And.;
	   HB_ISDATE( dDate )

		::dDate := dDate
		
	Endif
	

Return ( Self )

//------------------------------------------------------------------------------
// Si se le pasa h, t, a, y, m, w devuelve una fecha correspondiente a hoy,
// ayer o ma±ana. Cualquier otra cosa devuelve una fecha vacia
// La fecha devuelta tendra el formato activo

METHOD cLetToDate( cLet ) CLASS StrToDate
	Local dRet
      		
	switch cLet
		// Hoy
		case 'h'
		case 't'
			dRet := ::dDate
			exit
				
		// Ayer
		case 'a'
           case 'y'
			dRet := ::dDate:Yesterday()
			exit
				
           // Ma±ana
		case 'm'
           case 'w'
			dRet := ::dDate:Tomorrow()
			exit
			
		otherwise
			dRet := CToD( "" )
		
	endswitch


	
return dRet


//------------------------------------------------------------------------------
// Si se pasa + æ -  seguido de un n¿mero, suma o resta a la fecha actual
// Si se pasa > æ < devuelve el ¿ltimo d›a del a±o actual o el primero
// La fecha devuelta tendra el formato activo

METHOD cSimToDate (cDate) CLASS StrToDate
	Local cRet := "" , cSymbol, cParam

	cSymbol := cDate:Left(1)
	cParam  := cDate:SubStr(2)	

	switch cSymbol	
		case '+'
			cRet := ::dDate:AddDay( iif(cParam:Val() > 0, cParam:Val(), 1)  ):Str()
			exit

		case '-'
			cRet := ::dDate:SubDay( iif( cParam:Val() > 0, cParam:Val(), 1) ):Str()
			exit

		case '>'
			cRet := '31-12-' + iif (cParam:Val() > 0 .and. cParam:Val() < 10000, cParam, ::dDate:Year():Str() )
			exit

		case '<'
			cRet := '01-01-' + iif( cParam:Val() > 0 .and. cParam:Val() < 10000, cParam, ::dDate:Year():Str() )
			exit
		
	endswitch	
return CToD( cRet )


//------------------------------------------------------------------------------
// Devuelve la fecha pasado con separadores
// La fecha devuelta tendra el formato activo

METHOD  cSepToDate (cDate, cFormat) CLASS StrToDate
	Local aParts, cRet, cFormOld

	cDate := cDate:strReplace(" ./", "---")
	
	switch cFormat
		
		case "MDA"
			cFormOld := Set( _SET_DATEFORMAT, "mm-dd-yyyy" )
			exit

		case "AMD"
			cFormOld := Set( _SET_DATEFORMAT, "yyyy-mm-dd" )
			exit

		otherwise
			cFormOld := Set( _SET_DATEFORMAT, "dd-mm-yyyy" )
	endswitch

	aParts := HB_ATokens( ::dDate:Str(), "-" )
	
	AEval( HB_ATokens( cDate, "-" ), {| cToken, n | aParts[n] := iif( cToken:Val() > 0, cToken, aParts[n] ) } )
	
	switch cFormat
		
		case "MDA"
			cRet := aParts[ 2 ] + "-" + aParts[ 1 ] + "-" + aParts[ 3 ]
			exit

		case "AMD"
			cRet := aParts[ 3 ] + "-" + aParts[ 2 ] + "-" + aParts[ 1 ]
			exit

		otherwise
			cRet := aParts[ 1 ] + "-" + aParts[ 2 ] + "-" + aParts[ 3 ]

	endswitch

	Set( _SET_DATEFORMAT, cFormOld )
	
return CToD( cRet )


//------------------------------------------------------------------------------
// Formato dÌa de la semana, internacional

METHOD cSemToDate( cDayOfWeek, lFirstSunDay) CLASS StrToDate

    local dRet, nDayFound

	HB_Default(@lFirstSunDay, .F.)
    
    nDayFound := cDayOfWeek:DayOfWeek( lFirstSunDay )

    If nDayFound > 0
		if  nDayFound <= ::dDate:DoW( lFirstSunDay )  // En esta semana o la siguiente
			dRet := ::dDate:AddWeek():FirstDayOfWeek():AddDay(nDayFound - 1)
		else
			dRet := ::dDate:FirstDayOfWeek():AddDay(nDayFound - 1)
		endif
        
    else
        dRet :=  CtoD('')
    endif
	
return dRet


//------------------------------------------------------------------------------
// Formato DMA (DÌaMesAÒo)

METHOD cDMAToDate( cDate ) CLASS StrToDate

    local cFormOld, aParts, dRet

    if cDate:Val() > 0

		cFormOld := Set( _SET_DATEFORMAT, "dd-mm-yyyy" )

        aParts := HB_ATokens( ::dDate:Str(), "-" )

        if cDate:Len():Mod(2) != 0
            cDate := "0" + cDate
        endif

        switch cDate:Len()
			case 2
				aParts[ 1 ] := cDate
				exit
			case 4
				aParts[ 1 ] := cDate:SubStr( 1, 2 )
				aParts[ 2 ] := cDate:SubStr( 3, 2 )
				exit
			otherwise
				aParts[ 1 ] := cDate:SubStr( 1, 2 )
				aParts[ 2 ] := cDate:SubStr( 3, 2 )
				aParts[ 3 ] := cDate:SubStr( 5 )
        endswitch

        dRet := CToD( aParts[ 1 ] + "-" + aParts[ 2 ] + "-" + aParts[ 3 ] )
		
        Set( _SET_DATEFORMAT, cFormOld )
    else
        dRet := CToD( "" )
    endif
return dRet

//------------------------------------------------------------------------------
// Formato MDA (MesDÌaAÒo)

METHOD cMDAToDate( cDate ) CLASS StrToDate

    local cFormOld, aParts, dRet

    if  Val( cDate ) > 0
        cFormOld := Set( _SET_DATEFORMAT, "dd-mm-yyyy" )

        aParts := HB_ATokens( DToC( ::dDate ), "-" )

        if cDate:Len():Mod(2) != 0
            cDate := "0" + cDate
        endif

        switch cDate:Len()
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
// Formato AMD (AÒoMesDÌa)
 METHOD cAMDToDate( cDate ) CLASS StrToDate
    local cFormOld, aParts, dRet

    if Val( cDate ) > 0
        cFormOld := Set( _SET_DATEFORMAT, "dd-mm-yyyy" )

        aParts := HB_ATokens( DToC( ::dDate ), "-" )

        cDate := AllTrim( cDate )

        if cDate:Len():Mod(2) != 0
            cDate := "0" + cDate
        endif

        switch cDate:Len()
			case 2
				aParts[ 1 ] := cDate
				exit

			case 4
				aParts[ 2 ] := cDate:SubStr( 3, 2 )
				aParts[ 3 ] := cDate:SubStr( 1, 2 )
				exit

			otherwise
				aParts[ 1 ] := SubStr( cDate, -2, 2 )
				aParts[ 2 ] := SubStr( cDate, -4, 2 )
				aParts[ 3 ] := SubStr( cDate, 1, cDate:len() - 4 )
        endswitch

        dRet := CToD( aParts[ 1 ] + "-" + aParts[ 2 ] + "-" + aParts[ 3 ] )

        Set( _SET_DATEFORMAT, cFormOld )
    else
        dRet := CToD( "" )
    endif

return dRet