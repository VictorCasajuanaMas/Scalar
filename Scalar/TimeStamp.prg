/* CLASS: Scalar TimeStamp
          Clase que contiene los m?�todos para el tipo de dato TimeStamp
*/
#INCLUDE 'hbclass.ch'

CREATE CLASS TimeStamp INHERIT HBScalar FUNCTION HBTimeStamp

    METHOD Date()
    METHOD Day()   
    METHOD Hour()   
    METHOD Minute()  
    METHOD Month()    
    METHOD Sec()    
    METHOD Str()    
    METHOD Time()
    METHOD ValType()        
    METHOD Year()

ENDCLASS

// Group: EXPORTED METHODS

/* METHOD: Date()
    M�todo que devuelve la fecha del dato

    Devuelve:
        Date
*/
METHOD Date() CLASS TimeStamp
RETURN hb_TToD( Self,, "" )


/* METHOD: Day()
    M�todo que devuelve el d�a del dato

    Devuelve:
        Numeric    
*/
METHOD Day() CLASS TimeStamp
RETURN Day( Self )


/* METHOD: Hour()
    M�todo que devuelve la hora del dato

    Devuelve:
        Numeric
*/
METHOD Hour() CLASS TimeStamp
RETURN hb_Hour( Self )


/* METHOD: Minute()
    M�todo que devuelve el minuto del dato

    Devuelve:
        Numeric
*/
METHOD Minute() CLASS TimeStamp
RETURN hb_Minute( Self )


/* METHOD: Month()
    M�todo que devuelve el mes del dato

    Devuelve:
        Numeric
*/
METHOD Month() CLASS TimeStamp
RETURN Month( Self )


/* METHOD: Sec()
    M�todo Devuelve los segundos del dato

    Devuelve:
        Numeric
*/
METHOD Sec() CLASS TimeStamp
RETURN hb_Sec( Self )


/* METHOD Str()
    Devuelve el timestamp en string, por temas de compatibilizaci�n

    Devuelve:
        Character
*/
METHOD Str() CLASS TimeStamp
Return hb_TSToStr( Self )


/* METHOD: Time()
    M�todo que devuelve la hora del dato

    Devuelve:
        Character
*/
METHOD Time() CLASS TimeStamp
RETURN hb_TToC( Self, "", "hh:mm:ss" )


/* METHOD: ValType()
    Devuelve el tipo del dato
    
    Devuelve:
        Character
*/
METHOD ValType() CLASS TimeStamp
Return ( 'T' )


/* METHOD: Year()
    M�todo que devuelve el a�o del dato

    Devuelve:
        Numeric
*/
METHOD Year() CLASS TimeStamp
RETURN Year( Self )