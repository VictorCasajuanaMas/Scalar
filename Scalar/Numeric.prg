/* CLASS: Scalar Numeric
    Clase que define los m�todos para el tipo de dato num�rico
   
*/
#INCLUDE 'hbclass.ch'

CREATE CLASS Numeric INHERIT HBScalar FUNCTION HBNumeric

    EXPORTED:
        METHOD Between(nBegin, nEnd)
        METHOD Empty()
        METHOD Int()
        METHOD Mod(nDivision)
        METHOD NotEmpty()
        METHOD Round( nDecimals )
        METHOD Str( nLength, nDecimals )
        METHOD StrFloat( nDecimals )
        METHOD StrInt()
        METHOD StrRaw( nLength, nDecimals )
        METHOD StrSql()
        METHOD ValType()
        METHOD Value()

END CLASS

// Group: EXPORTED METHODS

/* METHOD: Between(nBegin, nEnd)
    Devuelve .T. si el dato esta entre los dos valores
    
    Devuelve:
        Logical
*/
METHOD Between(nBegin, nEnd)

    hb_default(@nBegin, 0)
    hb_default(@nEnd,   0)

Return Self >= nBegin .and. Self <= nEnd

/* METHOD: Empty()
    Devuelve .T. si el valor del dato es 0
    
    Devuelve:
        Logical
*/
METHOD Empty() CLASS Numeric
Return ( Self == 0)


/* METHOD: Int()
    Devuelve el valor entero de la variable 

    Devuelve:
        Numeric
*/

METHOD Int()
Return Int ( Self )


/* METHOD: Mod(nDivisor)
    Devuelve el resto de la divisi�n
    
    Devuelve:
        Numeric
*/
METHOD Mod(nDivisor) CLASS Numeric
Return Mod(Self, nDivisor)


/* METHOD: NotEmpty()
    Devuelve .T. si el valor del dato no es 0

    Devuelve :
        Logical
*/
METHOD NotEmpty() CLASS Numeric
Return ( Self != 0 )


/* METHOD: Round( nDecimals )
    Devuelve resultado del a nDecimals decimales

    Par�metros:
        nDecimals - N�mero de decimales a redondear

    Devuelve:
        Num�rico redondeado
*/
METHOD Round( nDecimals ) CLASS Numeric

    hb_Default( @nDecimals, 0 )

Return Round( Self, nDecimals )

/* METHOD: Str( nLength, nDecimals )
    Devuelve el valor en string del valor num�rico sin espacios

    Par�metros:
        nLength - Ancho del valor entero a devolver. Si se omite ser� el ancho del n�mero entero
        nDecimals - Ancho del valor de los decimales. Si se omite se devolver� un entero
    
    Devuelve:
        Character
*/
METHOD Str( nLength, nDecimals ) CLASS Numeric
Return ( Self:StrRaw( nLength, nDecimals ):Alltrim() )


/* METHOD: StrFloat( nDecimals )
    Devuelve el valor con nDecimals de la variable formato String

    Par�metros:
        nDecimals - N�mero de decimales a devolver

    Devuelve:
        String del valor con nDecimals de la variable 
*/
METHOD StrFloat( nDecimals ) CLASS Numeric

    hb_Default( @nDecimals, 6 )

Return Str( Self, 20, nDecimals ):Alltrim()


/* METHOD: StrInt()
    Devuelve el valor entero de la variable formato String

    Devuelve:
        Character
*/
METHOD StrInt() CLASS Numeric
Return Str( Self, 20, 0 ):Alltrim()


/* METHOD: StrRaw( nLength, nDecimals )
    Devuelve el valor en string del valor num�rico con espacios

    Par�metros:
        nLength - Ancho del valor entero a devolver. Si se omite ser� el ancho del n�mero entero
        nDecimals - Ancho del valor de los decimales. Si se omite se devolver� un entero

    
    Devuelve:
        Character
*/
METHOD StrRaw( nLength, nDecimals ) CLASS Numeric

    hb_Default( @nLength, Str( Self ):Alltrim():Long() )
    hb_Default( @nDecimals, 0 )

Return Str( Self, nLength, nDecimals )


/* METHOD: StrSql()

    Devuelve el dato con el formato SQL, se utiliza para compatibilizarlo con el resto de m�todos StrSql de los scalar

    Devuelve: 
        Character
*/
METHOD StrSql() CLASS Numeric
    If Self:Int() == Self

        Return ::StrInt()

    else

        Return ::StrFloat( 6 )

    Endif

Return ( Nil )


/* METHOD: ValType()
    Devuelve el tipo del dato
    
    Devuelve:
        String
*/
METHOD ValType() CLASS Numeric
Return ( 'N' )


/* METHOD: Value()
    Devuelve el valor del dato, es �til para combinarlo con los valores NIL

    Devuelve:
        Num�ric
*/
METHOD Value() CLASS Numeric
Return ( Self )







