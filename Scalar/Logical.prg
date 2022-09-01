/* CLASS: Scalar Logical
          clase que define los m?®todos para el tipo de dato l??gico
*/
#INCLUDE 'hbclass.ch'

CREATE CLASS Logical INHERIT HBScalar FUNCTION HBLogical

    METHOD Empty()
    METHOD NotEmpty()
    METHOD Str()
    METHOD StrSql()
    METHOD ValType()
    METHOD Value()

ENDCLASS

// Group: EXPORTED METHODS


/* METHOD: Empty()
    Siempre devuelve .F. ya que está para compatibilizar con Nil:Empty()

    Devuelve:
        Logical
*/
METHOD Empty() CLASS Logical
Return ( .F. )


/* METHOD: NotEmpty()
    Siempre devuelve .T. ya que está para compatibilizar con Nil:NotEmpty()

    Devuelve:
        Logical
*/
METHOD NotEmpty() CLASS Logical
Return ( .T. )


/* METHOD: Str( cTrue, cFalse)
    Devuelve el literal cTrue o cFalse dependiente del valor lógico del dato, si no se le pasan utiliza .T. y .F.

    Parámetros:
        cTrue - String a devolver en el caso de true
        cFalse - String a devolver en el caso de false

    Devuelve:
        Character

    Ejemplo:
        lValor:Str( 'si', 'no' )
*/
METHOD Str( cTrue, cFalse) CLASS Logical

    hb_Default( @cTrue, '.T.' )
    hb_Default( @cFalse, '.F.' )
    
RETURN iif( Self, cTrue, cFalse )


/* METHOD: StrSql()

    Devuelve 1 si el valor del dato es .T. y string vacío si es .F. Se utiliza para compatibilizar con el resto de métodos StrSql de los scalar

    Devuelve:
        Character

*/
METHOD StrSql() CLASS Logical
Return ::Str( '1','')


/* METHOD: ValType()
    Devuelve el tipo del dato
    
    Devuelve:
        Character
*/
METHOD ValType() CLASS Logical
Return ( 'L' )


/* METHOD: Value()
    Devuelve el valor del dato, es útil para combinarlo con los valores NIL

    Devuelve:
        Logical
*/
METHOD Value() CLASS Logical
Return ( Self )