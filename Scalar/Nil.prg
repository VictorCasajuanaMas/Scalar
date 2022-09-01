/* CLASS: Scalar Nil
          clase que define los m?®todos para el tipo de dato Nil
*/
#INCLUDE 'hbclass.ch'

CREATE CLASS NIL INHERIT HBScalar FUNCTION HBNil
   
   METHOD Empty()
   METHOD NotEmpty()      
   METHOD Str()
   METHOD ValType()      
   METHOD Value( uValue )

ENDCLASS


/* METHOD: Empty() Devuelve siempre true, ya que un dato nil siempre estaría vacío.

   Devuelve:
      Logical
*/
METHOD Empty() CLASS Nil
Return ( .T. )


/* METHOD: NotEmpty() Devuelve siempre false, ya que un dato Nil no contiene nada

   Devuelve:
      Logical
*/
METHOD NotEmpty() CLASS Nil
Return ( .F. )


/* METHOD: Str()
   Devuelve siempre Nil

   Devuelve: 
      String
*/
METHOD Str() CLASS NIL
Return ( 'Nil' )


/* METHOD: ValType()
    Devuelve el tipo del dato
    
    Devuelve:
        String
*/
METHOD ValType() CLASS NIL
Return ( 'U' )


/* METHOD: Value() Devuelve el valor de uValue, este método se utiliza en combinación con los Value del resto de datos Scalar

   Parámetros: 
      uValue - Valor a Devolver

   Devuelve:
      el tipo de valor de uValue
*/
METHOD Value ( uValue ) CLASS Nil
Return ( uValue )