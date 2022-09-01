/* CLASS: Scalar Character
          Clase que define los m�todos para el tipo de dato Character

*/
#INCLUDE 'hbclass.ch'

CREATE CLASS Character INHERIT HBScalar FUNCTION HBCharacter

    EXPORTED:
        METHOD Alltrim()
        METHOD At( cSearch, nStart, nEnd ) 
        METHOD Capitalize()
        METHOD Capitulate()
        METHOD DayOfWeek()
        METHOD Del( cString )
        METHOD DelAccentMark()
        METHOD DelFirst( cString )
        METHOD DelLast( cString )
        METHOD Empty() INLINE ::ISEmpty()
        METHOD GetJson()
        METHOD Has( cSearch )
        METHOD ISEmpty()
        METHOD IsJsonEmpty()
        METHOD IsJsonValid()
        METHOD Left( nLen )
        METHOD LeftDeleteUntil( cCharacter )
        METHOD Len() 
        METHOD Long()
        METHOD Lower()
        METHOD MonthByName()
        METHOD NotEmpty()
        METHOD NotHas( cSearch )
        METHOD PadLeft( nLenght, cCharacter )
        METHOD PadRight( nLenght, cCharacter )
        METHOD RAt( cSearch, nStart, nEnd ) 
        METHOD Reverse( cString )
        METHOD Right( nLen )
        METHOD Spacesleft( nLenght )
        METHOD SpacesRight( nLenght )
        METHOD Str()
        METHOD StrReplace( cSearch, cReplace )
        METHOD StrSql()
        METHOD StrTran( cSearch, cReplace )
        METHOD Substr( nStart, nLen )
        METHOD ToDate( cFormat, xReturn )
        METHOD Upper()
        METHOD Val()
        METHOD ValType()
        METHOD Value()
        METHOD Zeros( nLength, nDecimals )
        
END CLASS


// Group: EXPORTED METHODS

/* METHOD: Alltrim()
    Devuelve el valor del dato sin espacios a la derecha e izquierda

    Devuelve:
        Character  
*/
METHOD Alltrim() CLASS Character
Return Alltrim( Self )


/* METHOD: At( cSearch, nStart, nEnd )
    Devuelve la primera posici�n de cSearch dentro del dato

    Par�metros:
        cSearch - cadena a buscar
        nStart - Posici�n donde empieza la b�squeda
        nStart - Posici�n donde termina la b�squeda

    Devuelve:
        Numeric     
*/    
METHOD At( cSearch, nStart, nEnd ) CLASS Character
Return ( hb_At( cSearch, Self, nStart, nEnd) )


/* METHOD: Capitalize()
    Devuelve el valor del dato con la primera letra de cada palabra en may�sculas
    y el resto en min�sculas

    Devuelve:
        Character
*/
METHOD Capitalize() CLASS Character

    Local cStringCapitalize := ''
    Local aWords := hb_ATokens( Self)
    Local nCount := 0

    If !Empty( Self )

      For nCount := 1 To Len(aWords)
         cStringCapitalize += aWords[nCount]:Capitulate() + ' '
      Next

    Endif

Return ( cStringCapitalize:Alltrim() )


/* METHOD: Capitulate()
    Devuelve el valor del dato con la primera letra en may�sculas y el resto en min�sculas

    Devuelve:
        Character   
*/
METHOD Capitulate() CLASS Character

    Local cStringCapitulate := ''

    If !Empty( Self )
        cStringCapitulate := Upper( Substr( Self, 1, 1 ) ) + ;
                             Lower( Substr( Self, 2, Len( Self:Alltrim() ) ) )
    Endif

Return ( cStringCapitulate )


/* METHOD: DayOfWeek(lFirstSunDay)
    Devuelve el valor num�rico del nombre de un d�a de la semana 
    
    Par�metros:
        lFirstSunDay - Indica si el primer d�a de la semana es Domingo

    Devuelve:
        Numeric
*/

METHOD DayOfWeek( lFirstSunDay )
    local aDaysOfWeek := Array(7)
    local cDayOfWeek := ::AllTrim():lower():DelAccentMark()
    local nLencDayOfWeek := cDayOfWeek:Len()
    local n, nDayFound, nWeekDay, nCountDays := 0

    HB_Default(@lFirstSunDay, .F.)
        
	// Cargamos los d�as de la semana en el idioma actual en min�sculas sin acentos
    AEval(ADays(), {|e,n| aDaysOfWeek[n] := hb_OEMToANSI( e ):lower():DelAccentMark() } )
   
	// Buscamos en el Array de semanas el d�a y cuantos coinciden
	for n:= 1 to 7
		if aDaysOfWeek[ n ]:Left( nLencDayOfWeek ) == cDayOfWeek    // B�squeda blanda
			nCountDays++
			nDayFound := n
		endif
	next

    // Si hay coincidencia en mas de un d�a no es valida la entrada
	if nCountDays == 1
        
        nWeekDay := iif( lFirstSunDay, nDayFound, nDayFound - 1 )
        
        if nWeekDay == 0
            nWeekDay := 7
        end if
        
    else

        nWeekDay := 0
           
	endif

return nWeekDay


/* METHOD: Del( cString )
    Elimina el cString del dato

    Par�metros:
        cString - Cadena a eliminar del dato

    Devuelve:
        Character
*/
METHOD Del( cString ) CLASS Character

    hb_Default( @cString, '' )

Return ( StrTran( Self, cString, '' ) )


/* METHOD: DelAccentMark()
    Transforma los car�cteres acentuados por los mismos sin acento

    Devuelve:
        Character
*/
METHOD DelAccentMark() CLASS Character
RETURN Self:StrReplace('����������������������������������������', 'aeiouaeiouaeiouaeiouAEIOUAEIOUAEIOUAEIOU')


/* METHOD: DelFirst( cString )
    Elimina el principio del dato si coincide con cString

    Par�metros: 
        cString - Cadena a eliminar del dato

    Devuelve:
        Character
*/
METHOD DelFirst( cString ) CLASS Character

    Local cReturn := Self

    If ::Alltrim():Left( cString:Len() ) == cString

        cReturn := ::Alltrim():Substr( cString:Len() + 1  )

    Endif

Return ( cReturn )


/* METHOD: DelLast( cString )
    Elimina el final del dato si coincide con cString

Par�metros: 
    cString - Cadena a eliminar del dato

    Devuelve:
        Character
*/
METHOD DelLast( cString ) CLASS Character

    Local cReturn := Self

    If Self:Alltrim():Right( cString:Len() ) == cString

        cReturn := Self:Alltrim():Substr( 1, ::Len() - cString:Len() )

    Endif

Return ( cReturn )


/* METHOD: GetJson()
    Devuelve el dato en formato Array si el dato es un Json v�lido, de lo contrario devuelve Nil

    Devuelve
        Hash, Array o Nil
*/
METHOD GetJson() CLASS Character

    Local xReturn := hb_jsonDecode( Self )

    If ! (xReturn:ValType() $ 'HA' )

        xReturn := Nil

    Endif

Return ( xReturn )


/* METHOD: Has( cSearch )
    Devuelve .T. si el Dato contiene cSearch

    Devuelve:
        Logical
*/
METHOD Has( cSearch ) CLASS Character
Return ( Self:At( cSearch ) != 0 )


/* METHOD: IsEmtpy()
    Devuelve .T. o .F. dependiendo si el valor contiene algo o no

    Devuelve:
        Logical  
*/
METHOD IsEmpty()  CLASS Character
Return Empty( Self )


/* METHOD: IsJsonEmpty()

    Devuelve .T. si la cadena corresponde a un Json vac�o : '{}' o est� vac�a y .F. si contiene algo aunque no sea un Json

    Devuelve: 
        Logical
*/
METHOD IsJsonEmpty() CLASS Character
Return ( ::IsEmpty() .Or.;
         Self == '{}' )


/* METHOD: IsJsonValid()

    Devuelve .T. si el dato contiene un Json v�lido y .F. si no contiene un Json v�lido

    Devuelve:
        Logical
*/
METHOD IsJsonValid() CLASS Character
Return ( Self:GetJson() != Nil .And.;
         Self:GetJson():Len() != 0 )


/* METHOD: Left( nLen )
    Devuelve nLen caracteres desde la izquierda del dato

    Par�metros:
        nLen - n�mero caracteres a devolver

    Devuelve:
        Character
*/
METHOD Left( nLen ) CLASS Character
    If nLen != Nil
        Return ( Left( Self, nLen ) )
    else
        Return ( '' )
    Endif
Return ( Nil )


/* METHOD: LeftDeleteUntil( cCharacter )
    Elimina los cString de la izquierda hasta que el primer caracter que no sea cCharacter
    
    Par�metros:
        cCharacter - Caracter a eliminar

    Devuelve:
        Character
*/

METHOD LeftDeleteUntil( cCharacter ) CLASS Character

    Local nCount     := 0
    Local nPositionOfFirstDifference := 0

    For nCount := 1 To ::Len()

        If nPositionOfFirstDifference == 0

            If ::Substr( nCount, 1 ) != cCharacter

                nPositionOfFirstDifference := nCount

            Endif

        Endif

    Next

    Self := ::Substr( nPositionOfFirstDifference, ::Len() )

Return ( Self )


/* METHOD: Len()
    Devuelve el ancho total de la cadena

    Devuelve:
        Numeric    
*/
METHOD Len() CLASS Character
Return Len ( Self  ) 


/* METHOD: Long()
    Devuelve el ancho de la cadena sin espacios

    Devuelve:
        Numeric    
*/
METHOD Long()  CLASS Character
Return ::Alltrim():Len()


/* METHOD: Lower()
    Devuelve el valor del dato en min�sculas

    Devuelve:
        Character
*/
METHOD Lower() CLASS Character
Return Lower( Self )


/* METHOD: MonthByName()
    Devuelve el valor num�rico del nombre de un mes
        
    Devuelve:
        Numeric
*/
METHOD MonthByName() CLASS Character
    local aMonths := Array( 12 )
    local cMonth := ::AllTrim():lower():DelAccentMark()
    local nLencMonth := cMonth:len()
    local  n, nMonthFound, nCountMonths := 0
           
	// Cargamos los meses en el idioma actual en min�sculas sin acentos
    AEval(AMonths(), {|e,n| aMonths[n] := hb_OEMToANSI( e ):lower():DelAccentMark() } )
	
	// Buscamos en el Array de meses cuantos coinciden
	for n:= 1 to 12
		if aMonths[ n ]:Left(nLencMonth) == cMonth    // B�squeda blanda
			nCountMonths++
			nMonthFound := n
		endif
	next

return iif(nCountMonths == 1, nMonthFound, 0)


/* METHOD: NotEmtpy()
    Devuelve .T. si el valor no contiene nada y .F. si contiene algo

    Devuelve:
        Logical    
*/
METHOD NotEmpty()  CLASS Character
Return !Empty( Self )


/* METHOD: NotHas( cSearch )
    Devuelve .T. si el Dato NO contiene cSearch

    Devuelve:
        Logical
*/
METHOD NotHas( cSearch ) CLASS Character
Return ( !Self:Has( cSearch ) )


/* METHOD: padLeft( nLength )
    Devuelve el string con un tama�o de nLength rellenando con cCharacter por la izquierda si nLenght es menor
    que la longitud del dato, lo truncar� por la izquierda.
    
    Par�metros:
        nLength - Ancho total del string a devolver 
        cCharacter - Caracter con el que rellenar por defecto <espacio>

    Devuelve:
        Character
*/
METHOD padLeft( nLenght, cCharacter ) CLASS Character
    hb_default( @nLenght, ::Len() )
Return ( padleft(Self, nLenght, cCharacter))


/* METHOD: padRight( nLength )
    Devuelve el string con un tama�o de nLength rellenando con cCharacter por la derecha, si nLenght es menor
    que la longitud del dato, lo truncar� por la derecha.
    
    Par�metros:
        nLength - Ancho total del string a devolver
        cCharacter - Caracter con el que rellenar por defecto <espacio>

    Devuelve:
        Character
*/
METHOD padRight( nLenght, cCharacter ) CLASS Character
    hb_default( @nLenght, ::Len() )
Return ( padright(Self, nLenght, cCharacter) )


/* METHOD: RAt ( cSearch, nStart, nEnd )
    Devuelve la �ltima posici�n de cSearch dentro del dato
    
    Par�metros:
        cSearch - Cadena a buscar
        nStart - Posici�n donde empieza la b�squeda
        nStart - Posici�n donde termina la b�squeda
            
    Devuelve:
        Numeric        
*/    
METHOD RAt( cSearch, nStart, nEnd ) CLASS Character
Return ( hb_RAt( cSearch, Self, nStart, nEnd ) ) 


/* METHOD: Reverse()
    Devuelve el inverso de la cadena

    Par�metros:
        cString - Cadena a invertir

    Devuelve:
        Character
*/
METHOD Reverse()

    Local cCharacter := ''
    Local nCount := 0
 
    For nCount := ::Len() to 1 step -1
 
       cCharacter += ::Substr( nCount, 1 )
 
    Next
 
Return ( cCharacter ) 


/* METHOD: Right( nLen )
    Devuelve nLen caracteres desde la derecha del dato

    Par�metros:
        nLen - n�mero caracteres a devolver

    Devuelve:
        Character
*/
METHOD Right( nLen ) CLASS Character
    If nLen != Nil
        Return ( Right( Self, nLen ) )
    Else
        Return ( '' )
    Endif
Return ( Nil )

/* METHOD: SpacesLeft( nLength )
    Devuelve el string con un tama�o de nLength rellenando los espacios que
    faltan por la izquierda
    
    Par�metros:
        nLength - Ancho total del string a devolver, trucara la cadena 
        por la izquierda si nLenght es menor que la misma

    Devuelve:
        Character
*/
METHOD Spacesleft( nLenght ) CLASS Character
Return ::AllTrim():PadLeft(nLenght,space(1) ) 


/* METHOD: SpacesRight( nLength )
    Devuelve el string con un tama�o de nLength rellenando los espacios que
    faltan por la derecha
    
    Par�metros:
        nLength - Ancho total del string a devolver, trucara la cadena 
        por la derecha si nLenght es menor que la misma

    Devuelve:
        Character
*/
METHOD SpacesRight( nLenght ) CLASS Character
Return ::AllTrim():PadRight(nLenght,space(1) )


/* METHOD: Str()
    Devuelve el mismo string, se introduce para compatibilizar con varios tipos de datos que llaman a Str 
    
    Devuelve:
        Character
*/
METHOD Str() CLASS Character
Return ( Self )


/* METHOD: StrReplace( xSearch, xReplace )
    Replaza los car�cteres o elemento de cSearch 
    por el que ocupe la misma posici�n en cReplace.
    
    Par�metros:
        xSearch: String o Array a Buscar
        xReplace: String o Array por el que Remplazar

    Devuelve:
        Character
*/
METHOD StrReplace( xSearch, xReplace ) CLASS Character
Return ( hb_StrReplace( Self, xSearch, xReplace ) )


/* METHOD: StrSql()
    Devuelve el mismo string, se introduce para compatibilizar con varios tipos de datos que llaman a StrSql 
    
    Devuelve:
        Character
*/
METHOD StrSql() CLASS Character
Return ( Self )


/* METHOD: StrTran( cSearch, cReplace )
    Sustituye los cSearch por cReplace del dato
    
    Par�metros:
        cSearch: String Buscar
        cReplace: String por el que Remplazar
    
    Devuelve:
        Character
*/
METHOD StrTran( cSearch, cReplace ) CLASS Character
Return ( StrTran( Self, cSearch, cReplace ) )


/* METHOD: Substr( nStart, nLen )
    Devuelve los caracteres del valor desde nstart, si se le pasa nLen hasta el tama�o nLen

    Par�metros:
        nStart - Posici�n a partir se devolver�n los caracteres
        nLen   - N�meros de caracter a devolver, si se omite devuelve hasta el final del valor

    Devuelve:
        Character
*/
METHOD Substr( nStart, nLen ) CLASS Character
    If nLen != Nil
        Return ( SubStr( Self, nStart, nLen ) )
    else    
        Return ( SubStr( Self, nStart) )
Endif

Return ( Nil )


/* METHOD: ToDate( cFormat, xReturn )
    Devuelve la fecha dependiendo del string que contiene self seg�n la siguiente sintaxis:

        h -- Fecha de actual ( t - today )
        m -- Fecha de ma�ana ( w - tomorrow )
        a -- Fecha de ayer   ( y - yesterday )
		
		+d -- Dentro de d d�as
		-d -- Hace d d�as
		>  -- �ltimo d�a del a�o
		<  -- Primer d�a del a�o
		
		d, dd - D�a d del mes y a�o actual
		dmm, ddmm - D�a d y mes mm del a�o actual
		dmmaa, ddmmaa - D�a d y mes mm del a�o aa
		dmmaaaa, ddmmaaaa - D�a d y mes mm del a�o aaaa
		d/m, d/mm, dd/m, dd/mm - D�a d y mes m del a�o actual
		d/m/a - D�a d y mes mm del a�o aa
		sem, semana - Fecha del pr�ximo d�a de la semana.
    
    Par�metros:

        xReturn - Cadena a devolver si no se logra la conversi�n, Date() por defecto
	    cFormat - Formato de entrada AMD MDA AMD
        dDate - Fecha Manual para tests

    Devuelve:
        Date
*/
METHOD ToDate( cFormat, xReturn, dDate ) CLASS Character

    Local oStrToDate AS OBJECT := StrToDate():New()

    oStrToDate:SetDate( dDate )

Return ( oStrToDate:Convert( Self, cFormat, xReturn ) )


/* METHOD: Upper()
    Devuelve el valor del dato en may�sculas

    Devuelve:
        Character
*/
METHOD Upper() CLASS Character
Return Upper( Self )


/* METHOD: Val()
    Devuelve el valor entero del dato
    
    Devuelve:
        Numeric
*/
METHOD Val() CLASS Character
Return ( Val( Self ) )


/* METHOD: ValType()
    Devuelve el tipo del dato
    
    Devuelve:
        Character
*/
METHOD ValType() CLASS Character
Return ( 'C' )


/* METHOD: Value()
    Devuelve el valor del dato, es �til para combinarlo con los valores NIL

    Devuelve:
        Character
*/
METHOD Value() CLASS Character
Return ( Self )


/* METHOD: Zeros( nLen )
    Rellena con ceros por la izquierda la cadena
    
    Par�metros:
        nLen - Tama�o que ha de tener la cadena con los ceros incluidos

    Devuelve:
        Character    
*/
METHOD Zeros( nLen ) CLASS  CHARACTER

    Local cCharacter := ''

    If nLen != Nil 

        cCharacter := Replicate( '0', nLen - ::Long() ) + ::Alltrim()
        
    Else

        cCharacter := Self

    Endif
    
Return ( cCharacter )
