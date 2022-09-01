/* CLASS: Scalar Array
          clase que define los métodos para los Array
*/
#include 'hbclass.ch'

CREATE CLASS Array INHERIT HBScalar FUNCTION HBArray

    EXPORTED:
        METHOD AddIfNotExist( xAdd )
        METHOD ArrayAdd( aArray )
        METHOD ArrayHashToArray()
        METHOD ArrayInsert( aArray )
        METHOD Empty()
        METHOD Equal ( aCompare, lSameSize )
        METHOD Exist( xSearch )
        METHOD Get( nPosition, xDefault )
        METHOD GetEqualorLess( xSearch )
        METHOD GetFirst( xDefault )
        METHOD GetLast( xDefault )
        METHOD Len()
        METHOD Map( bBLock )
        METHOD NotEmpty()
        METHOD NotExist( xSearch )
        METHOD Scan( xSearch )
        METHOD Sort ( bCondition )
        METHOD Str( cSeparator )
        METHOD Str()
        METHOD ToArrayHash()
        METHOD Transpose()
        METHOD ValType()
        METHOD Value()

    PROTECTED:
        METHOD PositionCorrect( nPosition )

ENDCLASS


// Group: EXPORTED METHODS

/* METHOD: AddIfNotExist( xValue )
    Añade xValue al array si no existe

    Parámetros:
        xValue - Elemento a añadir
    
    Devuelve:
        Logical
*/
METHOD AddIfNotExist( xValue ) CLASS Array

    Local lAdded := .F.

    If Self:NotExist( xValue )

        aAdD( Self, xValue )
        lAdded := .T.

    Endif
    
Return ( lAdded )


/* METHOD: ArraytAdd( aArray )
    Añade un array al final del array

    Parámetros:
        aArray - Array a añadir al final

    Devuelve:
        Array

*/
METHOD ArrayAdd( aArray ) CLASS Array

Return ( ::ArrayInsert(aArray, ::Len + 1))



/* METHOD: ArrayHashToArray()

    Si el dato es un array de Hash, devuelve un array con la primera fila con las cabeceras de las keys encontradas
    en todos los hash y las siguientes filas con los valores en las columnas correspondientes

    Devuelve:
        Array
*/
METHOD ArrayHashToArray() CLASS Array

    Local aReturn  := Array( 0 )
    Local hItems   := { => }
    Local hItem    := { => }
    Local aHeaders := Array( 0 )
    Local aRow     := Array( 0 )
    Local nPositon := 0

    for each hItems in Self

        for each hItem in hItems

            aHeaders:AddIfNotExist( hItem:__enumkey )
            
        next

    next

    aAdD( aReturn, aHeaders )

    for each hItems in Self

        aRow := Array( aHeaders:Len() )

        for each hItem in hItems

            aRow[ aHeaders:Scan( hItem:__enumkey ) ] := hItem:__enumvalue

        next

        aAdD( aReturn, aRow )

    next

Return ( aReturn )


/* METHOD: ArraytInsert( aArray, nPosition )
    Añade un array en una posición, por defecto por delante

    Parámetros:
        aArray . Array que se añadirá
        nPositión . Posición donde insertar

    Devuelve:
        Array
*/
METHOD ArrayInsert( aArray, nPosition) CLASS Array
    hb_default( @nPosition, 1 )

Return ( aEval( aArray, { | Item, n | self := hb_AIns( Self, nPosition + n - 1, item, .T.  ) } ) )


/* METHOD: Empty()
    Indica si el array está vacío

    Devuelve:
        Logical
*/
METHOD Empty() CLASS Array
Return ( Self:Len() == 0)


/* METHOD: Equal ( aCompare )
    Indica si el array es igual al que se le pasa
    
    Parámetros : 
        aCompare . Array a comparar

    Devuelve:
        Logical
*/
METHOD Equal ( aCompare ) CLASS Array

    Local lEqual := .t., nElement

    if valtype ( aCompare ) == 'A'

        If Self:Len() == aCompare:Len() 

            for nElement = 1 to aCompare:Len()
 
                if valtype ( Self [ nElement ] ) == 'A'

                    if ! Self [ nElement ]:Equal ( aCompare [ nElement ] )

                        lEqual := .f.
                        exit

                    endif
                    
                else
                
                    if Self [ nElement ] <> aCompare [ nElement ] 

                        lEqual := .f.
                        exit

                    endif

                endif

            next

        else

            lEqual := .f.
            
        endif

    else

        lEqual := .f.

    endif

return ( lEqual )


/* METHOD: Exist( xSearch )
    Devuelve .T. si xSearch existe dentro del array
    
    Devuelve:
        Logical
*/
METHOD Exist( xSearch ) CLASS Array
Return ( Self:Scan( xSearch ) != 0 )


/* METHOD: Get( nPosition, xDefault )
    Devuelve el valor de la posición nPosition. Si el tamaño del array es menor a nPosition, devuelve xDefault
    o en su defecto, Nil

    Parametros:
        nPosition - Posición del elemento a devolver
        xDefault - Valor por defecto a devolver en el caso de que el tamaño del array sea menor a nPosition

    Devuelve:
        Cualquier Tipo        
*/
METHOD Get( nPosition, xDefault ) CLASS Array

    Local xDev := Nil
    
    If ::PositionCorrect( nPosition )

        xDev := Self[ nPosition ]

    Elseif xDefault != Nil

        xDev := xDefault

    Endif

Return ( xDev )


/* METHOD: GetEqualorLess( xSearch )
    Devuelve el item igual o menor a xSearch.

    Parámetros:
        xSearch - Valor a buscar
        
    Devuelve:
        Cualquier tipo
*/
METHOD GetEqualorLess( xSearch ) CLASS Array

    Local aArray    := ASort( Self, , , { | x, y | x > y } )
    Local xReturn   := Nil
    Local nPosition := 1

    If xSearch != Nil

        While xReturn == Nil .And.;
            nPosition <= aArray:Len()

            if aArray:Get( nPosition ) <= xSearch

                xReturn := aArray:Get( nPosition )

            Endif

            nPosition++

        Enddo

    Endif

Return ( xReturn )


/* METHOD: GetFirst( xDefault )
    Devuelve el primer item del array

    Parámetros 
        xDefault - En el caso de que el array está vacío, devolverá este dato

    Devuelve:
        Cualquier tipo
*/
METHOD GetFirst( xDefault )

    Local xReturn
    hb_default( @xDefault, Nil )

    If Self:Empty()

        xReturn := xDefault

    else

        xReturn := Self:Get( 1 )

    Endif

Return xReturn


/* METHOD: GetLast( xDefault )
    Devuelve el último item del array

    Parámetros 
        xDefault - En el caso de que el array está vacío, devolverá este dato

    Devuelve:
        Cualquier tipo
*/
METHOD GetLast( xDefault )

    Local xReturn
    hb_default( @xDefault, Nil )

    If Self:Empty()

        xReturn := xDefault

    else

        xReturn := Self:Get( Self:Len() )

    Endif

Return xReturn


/* METHOD: Len( )
    Calcula el tamaño del array

    Devuelve:
        Numeric
*/
METHOD Len( ) CLASS Array
Return ( Len( Self ) )


/* METHOD: Map( bBlock )
    Recorre el array ejecutando bBlock y devolviendo un array con el resultado de bblock en cada item del array
     
    Parámetros:
        bBlock - Bloque de código a ejecutar
 
    Devuelve:
         Array
 */
 METHOD Map( bBlock ) CLASS Array

    Local aNewArray := Array ( 0 )
    Local xItem     := Nil

    for each xItem in Self

        aAdd( aNewArray, Eval ( bBlock, xItem ) )
        
    next
 
 Return ( aNewArray )


/* METHOD: NotEmpty()
    Indica si el array contiene algún item

    Devuelve:
        Logical
*/
METHOD NotEmpty() CLASS Array
Return ( Self:Len() != 0 )


/* METHOD: NotExist( xSearch )
    Devuelve .T. si xSearch NO existe dentro del array
    
    Devuelve:
        Logical
*/
METHOD NotExist( xSearch ) CLASS Array
Return ( Self:Scan( xSearch ) == 0 )


/* METHOD: Scan( xSearch )
    Devuelve la posición de xSearch en Self

    Devuelve:
        Numeric
*/
METHOD Scan( xSearch ) CLASS Array
Return ( aScan( Self, xSearch ) )


/* METHOD: Sort( bCondition )
    Ordena el Array conforme a bCondition, ascendente por defecto
    Parámetros:
        bContition - Bloque de codigo que marca la ordenación
 
    Devuelve:
        Array
*/
METHOD Sort ( bCondition ) CLASS Array
// TODO: comentar 
    hb_default( @bCondition, { | x, y | x > y } )
    
    if HB_ISBLOCK ( bCondition )

        aSort ( Self, , , bCondition )

    endif

return ( Self )   


/* METHOD: Str( cSeparator )
    Devuelve el array en formato string separado por cSeparator
    utiliza el caracter ',' por defecto.

    Devuelve:
        Character
*/
METHOD Str( cSeparator ) CLASS Array

    Local cString := ''
    Local xValue

    hb_default( @cSeparator, ',' )

    for each xvalue in Self

        if .Not. HB_ISOBJECT( xValue )

            cString += xValue:Str() + Iif( xValue:__enumindex < Self:Len(), cSeparator, '' )

            If HB_ISARRAY( xValue ) .Or.;
                HB_ISHASH( xValue )
 
                cString += hb_eol()
 
             Endif

        Endif
        
    next

Return ( cString )


/* METHOD: ToArrayHash()
    Convierte el contenido del array del tipo {clave, Dato} en un array de hash.
    
    Devuelve:
        Array de Hashe's
*/
METHOD ToArrayHash(  ) CLASS Array

    Local aArray := Array( 0 )
    Local xItem := Nil
    Local aData := Array( 0 )
        
    for each xItem in Self

        if HB_ISOBJECT( xItem )

            for each aData in __objGetValueList( xItem )

                aAdd( aArray, { aData[ 1 ] => aData[ 2 ] } )
                
            next
        else
            
            aAdd( aArray, hb_hash( xItem[ 1 ], xItem[ 2 ] ) )
           
        endif

    next

Return ( aArray )


/* METHOD: Transpose( lSquare )
    Cambia las columnas X-Y del array y devuelve el resultado, no modifica el array. Función copiada de las funciones de FiveWin 19.06
    
    Parámetros:
        lSquare. "creo" que fuerza las columnas al ancho del primer registro del array

    Devuelve:
        Array
*/
METHOD Transpose( lSquare )

    local nRows, nCols, nRow, nCol, nWidth
    local aNew
 
    hb_Default( @lSquare, .f. )
 
    nRows          := Len( Self )
    if lSquare
       nCols       := Len( Self[ 1 ] )
    else
       nCols       := 1
       for nRow := 1 to nRows
          if ValType( Self[ nRow ] ) == 'A'
             nCols    := Max( nCols, Len( Self[ nRow ] ) )
          endif
       next
    endif
 
    aNew := Array( nCols, nRows )
    for nRow := 1 to nRows
       if ValType( Self[ nRow ] ) == 'A'
          nWidth  := Len( Self[ nRow ] )
          for nCol := 1 to nWidth
             aNew[ nCol, nRow ]   := Self[ nRow, nCol ]
          next
       else
          aNew[ 1, nRow ]      := Self[ nRow ]
       endif
    next

 return ( aNew )


/* METHOD: ValType()
    Devuelve el tipo del dato
    
    Devuelve:
        String
*/
METHOD ValType() CLASS Array
Return ( 'A' )


/* METHOD: Value()
    Devuelve el valor del dato, es útil para combinarlo con los valores NIL

    Devuelve:
        Array
*/
METHOD Value() CLASS Array
Return ( Self )


// Group: PROTECTED METHODS

/* METHOD: PositionCorrect( nPosition )
        Indica si la posición nPosition es correcta dentro del array

    Parámetros:
        nPosition - Posición del elemento
        
    Devuelve:
        Logical
*/        
METHOD PositionCorrect ( nPosition ) CLASS Array

    Local lCorrect

    lCorrect := nPosition != Nil .And.;
                nPosition <= Self:Len() .And.;
                nPosition >= 1

Return ( lCorrect )

