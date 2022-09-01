/* CLASS: Scalar Date
		  Clase que difine los métodos para el tipo de dato Date
*/
#include 'hbclass.ch'
#include 'hbcompat.ch'
#include 'date.inc'

CREATE CLASS Date INHERIT HBScalar FUNCTION HBDate

    EXPORTED:

        METHOD AddDay( nDaysToAdd )
        METHOD AddMonth( nMonthsToAdd )
        METHOD AddWeek( nWeeksToAdd )
        METHOD AddYear( nYearsToAdd )
        METHOD DateDayOfWeek(cDayOfWeek, lFirstSunDay)
        METHOD Day()
        METHOD DayBetween(dDateBegin, dDateEnd)
        METHOD DayOfnWeekOfMonth(nWeek, cDayOfWeek)    
        METHOD DiffDays( dDate )
        METHOD Dow()
        METHOD FirstDayOfMonth()
        METHOD FirstDayOfWeek(lFirstSunDay)
        METHOD FirstDayOfWeekOfMonth(cDayOfWeek)
        METHOD FirstDayOfWeekOfYear(cDayOfWeek)
        METHOD FirstDayOfYear()
        METHOD IsEmpty()
        METHOD LastDayOfMonth()
        METHOD LastDayOfWeek(lFirstSunDay) 
        METHOD LastDayOfWeekOfMonth(cDayOfWeek)
        METHOD LastDayOfWeekOfYear(cDayOfWeek)    
        METHOD LastDayOfYear()
        METHOD Month()
        METHOD NameOfMonth()
        METHOD NameOfWeekDay()
        METHOD NotEmpty()
        METHOD Str()
        METHOD StrFormat( cFormat )
        METHOD StrFormatRange( dEndRange, aFormatBegin, aFormatEnd )
        METHOD StrSql()
        METHOD StrSqlQuoted()
        METHOD SubDay( nDaysToSubstract )
        METHOD SubMonth( nMonthsToSubstract )
        METHOD SubWeek( nWeeksToSubstract )
        METHOD SubYear( nYearsToSubstract )
        METHOD Tomorrow()
        METHOD ValType()
        METHOD Week()
        METHOD Year()
        METHOD Yesterday()
        
ENDCLASS

// Group EXPORTED METHODS

/* METHOD: AddDay( ndaysToAdd )
    Devuelve la fecha del dato dentro de ndaystoAdd

    Parámetros:
        nDaystoAdd - Número de días a sumar, 1 día por defecto

    Devuelve:
        Date
*/
METHOD AddDay( nDaysToAdd ) CLASS Date

    hb_Default( @nDaysToAdd, 1 )

Return Self + nDaysToAdd


/* METHOD: AddMonth( nMonthsToAdd )
    Devuelve la fecha del dato dentro de nMonthsToAdd meses

    Parámetros:
        nMonthstoAdd - Número de meses a sumar,  1 mes por defecto

    Devuelve:
        Date
*/
METHOD AddMonth( nMonthsToAdd ) CLASS Date

    hb_Default( @nMonthsToAdd, 1 )

Return AddMonth( Self, nMonthsToAdd )


/* METHOD: AddWeek( nWeekstoAdd )
    Método que añade nWeekstoAdd semanas a la fecha del valor

    Parámetros:
        nWeeksToAdd - Número de semanas a sumar, 1 semana por defecto

    Devuelve:
        Date
*/
METHOD AddWeek( nWeeksToAdd ) CLASS Date

    hb_Default( @nWeeksToAdd, 1 )

Return Self + ( nWeeksToAdd*7 )


/* METHOD: AddYear( nYearsToAdd )
    Devuelve la fecha del dato sumando nYearsToAdd años

    Parámetros:
        nYearsToAdd - Número de años a sumar, 1 año por defecto

    Devuelve:
        Date
*/
METHOD AddYear( nYearsToAdd ) CLASS Date

    hb_Default( @nYearsToAdd, 1 )

Return AddMonth( Self, (nYearsToAdd * 12) )


/* METHOD: DateDayOfWeek(cDayOfWeek, lFirstSunDay)
    Método que devuelve la fecha del día de la semana especificado,
	dentro de la misma semana del dato.

    Parámetros:
        cDayOfWeek - Día de la semana
        lFirstSunDay - Si .T. Domingo es el primer día de la semana

    Devuelve:
        Date
*/
METHOD DateDayOfWeek(cDayOfWeek, lFirstSunDay) CLASS Date
    local dRet, nDayFound

	HB_Default(@lFirstSunDay, .F.)
    
    nDayFound := cDayOfWeek:DayOfWeek( lFirstSunDay )

    If nDayFound == 0
        dRet :=  CtoD('')
    else
        dRet := ::FirstDayOfWeek( lFirstSunDay ) + nDayFound - 1
    endif
    
RETURN dRet


/* METHOD: Day()
    Método que devuelve el día del mes correspondiente al dato

    Devuelve:
        Numeric
*/
METHOD Day() CLASS Date
RETURN Day( Self )


/* METHOD: DayBetween(dDateBegin, dDateEnd)
    Método que devuelve si una fecha entre las 2 pasadas

    Parámetros_
        dDateBegin - Fecha Inferior del Periodo, date() por defecto
        dDateEnd   - Fecha Superior del Periodo, date() por defecto
    
    Devuelve:
        Logical
*/
METHOD DayBetween(dDateBegin, dDateEnd) CLASS Date
    Local lRes := .F.
    hb_default(@dDateBegin, Date())
    hb_default(@dDateEnd, Date())

    if Self >= dDateBegin .and. Self <= dDateEnd
        lRes := .T.
    endif

RETURN lRes


/* METHOD: DayOfnWeekOfMonth(nWeek, cDayOfWeek)
    Método que devuelve la fecha del día de la semana
    en el mes.

    Parámetros:
        nWeek - Número de la Semana en el Mes (1-4)
        cDayOfWeek - Día de la semana a buscar
 
    Devuelve:
        Date

    Ejemplo:
        DayOfnWeekOfMonth(2,"Lunes") - 2º Lunes del Mes
*/
METHOD DayOfnWeekOfMonth(nWeek, cDayOfWeek) CLASS Date
    Local dRet := Nil
   
    hb_default(@cDayOfWeek, "Lunes")
    
    If nWeek:NotEmpty() .and. cDayOfWeek:DayOfWeek() > 0 .and. nWeek:Between(1,5)
        dRet := ::FirstDayOfWeekOfMonth(cDayOfWeek):AddWeek( nWeek - 1)
    endif
     
RETURN dRet


/* METHOD: DiffDays( dDate )
    Devuelve el número de días de diferencia entre el dato y date.
    Si dDate es posterior al dato el valore será positivo y si es anterior el valor será negativo

    Parámetros:
        dDate - Fecha a tomar como diferencia al valor

    Devuelve:
        Numeric
*/
METHOD DiffDays( dDate ) CLASS Date

    hb_Default( @dDate, Date() )

Return dDate - Self


/* METHOD: Dow(  )
    Devuelve el némero del día de la semana teniendo en cuenta que si lFirstSunDay es FALSE
    Lumes = 1 y Domingo = 7, si es TRUE Domingo = 1 y Sábado = 7
     
    Parámetros:
        lFirstSunDay - Indica si el primer día es Domingo
        
    Devuelve:
        Numeric
*/
METHOD Dow( lFirstSunDay ) CLASS Date
    Local nWeekDay
    HB_Default(@lFirstSunDay, .F.)

    nWeekDay := iif(lFirstSunDay, dow(Self), dow(Self) -1 )
    
    if nWeekDay == 0; nWeekDay := 7 ; endif
    
RETURN  nWeekDay


/* METHOD: FirstDayOfMonth()
    Método que devuelve la fecha del primer día del mes correspondiente al dato

    Devuelve:
        Date
*/
METHOD FirstDayOfMonth() CLASS Date
RETURN Ctod ( '01/'+ ::Month():Strint() + '/' + ::Year():Strint() )


/* METHOD: FirstDayOfWeek(lFirstSunDay)
    Método que devuelve la fecha del primer día de la semana según ISO 8601,
	si lFirstSunDay el primer día será domingo en vez de lunes

    Parámetros:
        lFirstSunDay - Indica si el primer día de la semana es domingo

    Devuelve:
        Date
*/
METHOD FirstDayOfWeek(lFirstSunDay) CLASS Date
	HB_Default(@lFirstSunDay, .F.)
RETURN  Self - ::Dow(lFirstSunDay) + 1


/* METHOD: FirstDayOfWeekOfMonth(cDayOfWeek)
    Método que devuelve la fecha del primer día de la semana
    en el mes

    Parámetros:
        cDayOfWeek - Día de la semana

    Devuelve:
        Date

    Ejemplo:
        FirstDayOfWeekOfMonth("Lunes") - Primer Lunes del Mes
*/
METHOD FirstDayOfWeekOfMonth(cDayOfWeek) CLASS Date
    Local dRet := Nil
    Local dDate 
    Local nDays 

    If cDayOfWeek:NotEmpty() .and. cDayOfWeek:DayOfWeek() > 0

        dDate := ::FirstDayOfMonth()
        nDays := cDayOfWeek:DayOfWeek() - dDate:Dow()
  
        if nDays < 0
            nDays := nDays + 7
        end if

        dRet := dDate + nDays

    EndIf
    
RETURN dRet


/* METHOD: FirstDayOfWeekOfYear(cDayOfWeek)
    Método que devuelve la fecha del primer día de la semana
    en el año

    Parámetros:
        cDayOfWeek - Día de la semana

    Devuelve:
        Date

    Ejemplo:
        FirstDayOfWeekOfYear("Mie") - Primer miércoles del Año
*/
METHOD FirstDayOfWeekOfYear(cDayOfWeek) CLASS Date
    Local dRet := Nil
    Local dDate 
    Local nDays 

    If cDayOfWeek:NotEmpty() .and. cDayOfWeek:DayOfWeek() > 0

        dDate := ::FirstDayOfYear()
        nDays := cDayOfWeek:DayOfWeek() - dDate:Dow()
  
        if nDays < 0
            nDays := nDays + 7
        end if

        dRet := dDate + nDays

    EndIf
    
RETURN dRet


/* METHOD: FirstDayOfYear()
    Método que devuelve el primer día del a±o

    Devuelve:
        Date
*/
METHOD FirstDayOfYear() CLASS Date
RETURN Ctod ( '01/01/' + ::Year():Strint() )


/* METHOD: IsEmpty()
    Indica si en el Valor de fecha está vacío devolviendo .T. en este caso y .F. si contiene un valor válido de fecha

    Devuelve:
        Logical
*/
METHOD IsEmpty() CLASS Date
Return ( Self:Str() == FECHAVACIA .or. Empty(Self) )


/* METHOD: LastDayOfMonth()
    Método que devuelve la fecha del último día del mes correspondiente al dato

    Devuelve:
        Date
*/
METHOD LastDayOfMonth() CLASS Date
RETURN Ctod ( '01/'+ ::AddMonth():Month():Strint() + '/' + ::AddMonth():Year():Strint() )-1


/* METHOD: LastDayOfWeek(lFirstSunDay)
    Método que devuelve la fecha del último día de la semana ISO 8601,
	si lFirstSunDay el primer día será domingo en vez de lunes

    Parámetros:
        lFirstSunDay - Indica si el primer día de la semana es domingo

    Devuelve:
        Date
*/
METHOD LastDayOfWeek(lFirstSunDay) CLASS Date
	HB_Default(@lFirstSunDay, .F.)
RETURN ::FirstDayOfWeek(lFirstSunDay):AddDay(6)


/* METHOD: LastDayOfWeekOfMonth(cDayOfWeek)
    Método que devuelve la fecha del último día de la semana
    en el mes

    Parámetros:
        cDayOfWeek - Día de la semana
    
    Devuelve:
        Date
    
    Ejemplo:
        LastDayOfWeekOfMonth("Lunes") - Último Lunes del Mes
*/
METHOD LastDayOfWeekOfMonth(cDayOfWeek) CLASS Date

    Local dRet := Nil
    Local dDate 
    Local nDays 

    If cDayOfWeek:NotEmpty() .and. cDayOfWeek:DayOfWeek() > 0

        dDate := ::LastDayOfMonth()
        nDays := dDate:Dow() - cDayOfWeek:DayOfWeek()
  
        if nDays < 0
            nDays := nDays + 7
        end if

        dRet := dDate - nDays

    EndIf
    
RETURN dRet


/* METHOD: LastDayOfWeekOfYear(cDayOfWeek, lFirstSunDay)
    Método que devuelve la fecha del éltimo día de la semana
    en el año

    Parámetros:
        cDayOfWeek - Día de la semana

    Devuelve:
        Date
    
    Ejemplo:
        LastDayOfWeekOfYear("Mie") - Último miércoles del Año
*/
METHOD LastDayOfWeekOfYear(cDayOfWeek) CLASS Date

    Local dRet := Nil
    Local dDate 
    Local nDays 

    If cDayOfWeek:NotEmpty() .and. cDayOfWeek:DayOfWeek() > 0

        dDate := ::LastDayOfYear()
        nDays := dDate:Dow() - cDayOfWeek:DayOfWeek()
  
        if nDays < 0
            nDays := nDays + 7
        end if

        dRet := dDate - nDays

    EndIf
    
RETURN dRet


/* METHOD: LastDayOfYear()
    Método que devuelve el último día del año

    Devuelve:
        Date
*/
METHOD LastDayOfYear() CLASS Date
RETURN Ctod ( '31/12/' + ::Year():Strint() )


/* METHOD: Month()
    Método que devuelve el número de mes del dato

    Devuelve:
        Numeric
*/
METHOD Month() CLASS Date
RETURN Month( Self )


/* METHOD: NameOfMonth()
    Método que devuelve el nombre del mes correspondiente al dato

    Devuelve:
        Character
*/
METHOD NameOfMonth() CLASS Date
RETURN cMonth( Self )


/* METHOD: NameOfWeekDay()
    Método que devuelve el nombre del día de la semana correspondiente al dato

    Devuelve:
        Character
*/
METHOD NameOfWeekDay() CLASS Date
RETURN cDoW( Self )


/* METHOD: NotEmpty
    Indica si hay un valor de fecha válido devolviendo .T. en este caso y .F. si el valor de la fecha está vacío.

    Devuelve:
        Logical
*/
METHOD NotEmpty() CLASS Date
Return ( Self:Str() != FECHAVACIA .and. !Empty(Self) )


/* METHOD: Str()
    Devuelve el string del valor de la fecha

    Devuelve:
        Character
*/
METHOD Str() CLASS Date
Return DtoC( Self )


/* METHOD: StrFormat( cFormat )
    Devuelve la fecha formateada según "dd de mmmm de aaaa"
    Adaptación inicial de: Bingen Ugaldebere

    Parámetros:
        cFormat - Formato según
              Ssss -- día de la semana completo comenzando con mayúscula
              ssss -- día de la semana completo en minúsculas
               Sss -- día de la semana 3 carácteres comenzando con mayúscula
               sss -- día de la semana 3 carácteres en minúsculas
                Ss -- día de la semana 2 carácteres comenzando con mayúscula
                ss -- día de la semana 2 carácteres en minúsculas
              SSSS -- día de la semana completo en mayúsculas
               SSS -- día de la semana 3 carácteres en mayúsculas
                SS -- día de la semana 2 carácteres en mayúsculas
                dd -- día
                0d -- día anteponiendo 0 en los días de un dígito
                0m -- número del mes anteponiendo 0 en los meses de un dígito
              Mmmm -- el nombre del mes comenzando con mayúscula  
              mmmm -- el nombre del mes en minúsculas
               Mmm -- las primeras tres letras del mes en comenzando con mayúscula 
               mmm -- las primeras tres letras del mes en minúsculas
                mm -- número del mes
              MMMM -- el nombre del mes en mayúsculas
               MMM -- las primeras tres letras del mes en mayúsculas
              aaaa -- año con cuatro dígitos
                aa -- año con dos dígitos

    Devuelve:
        Character

    Ejemplo:
        0d20220825:StrFormat("Ssss, 0d de Mmmm del aaaa") - Jueves, 25 de Agosto del 2022
*/
METHOD StrFormat( cFormat ) CLASS Date
    Local cDate := ''
    Local aSemanas := Array( 7 )
    Local aMeses := Array( 12 )
    Local cSemana, CMes
   
    AEval(aDays(), {|e,n| aSemanas[n] := hb_OEMToANSI( e ) } )
    AEval(aMonths(), {|e,n| aMeses[n] := hb_OEMToANSI( e ) } )
    cSemana := iif(::Dow() == -1, '', aSemanas[ ::Dow(.T.) ] )
    cMes := iif(::Month() == 0, "", aMeses[ ::Month ] )
        
    hb_Default ( @cFormat,  "Ssss, dd de Mmmm del aaaa" )
    
    cDate := hb_StrReplace(cFormat,{"Ssss","ssss","Sss","sss","Ss","ss","SSSS","SSS","SS","dd","0d","0m","Mmmm","mmmm","Mmm","mmm","mm","MMMM","MMM","aaaa","aa"}, ;
        {   cSemana:Lower():Capitalize(), ;                     // Ssss - Miércoles
            cSemana:Lower(), ;                                  // ssss - miércoles
            cSemana:Lower():Left(3):Capitalize(), ;             // Sss  - Mié
            cSemana:Lower():Left(3), ;                          // sss  - mié
            cSemana:Lower():Left(2):Capitalize(), ;             // Ss   - Mi
            cSemana:Lower():Left(2), ;                          // ss   - mi
            cSemana:Upper(), ;                                  // SSSS - MIÉRCOLES
            cSemana:Upper():Left(3), ;                          // SSS  - MIÉ
            cSemana:Upper():Left(2), ;                          // SS   - MI
            ::Day():Str(), ;                                    // dd   - 1
            ('00' + ::Day():Str()):Right(2), ;                  // 0d   - 01
            ('00' + ::Month():Str()):Right(2), ;                // 0m   - 01
            cMes:Lower():Capitalize(), ;                        // Mmmm - Enero
            cMes:Lower(), ;                                     // mmmm - enero
            cMes:Lower():Left(3):Capitalize(), ;                // Mmm  - Ene
            cMes:Lower():Left(3), ;                             // mmm  - ene
            ::Month():Str(), ;                                  // mm   - 1
            cMes:Upper(), ;                                     // MMMM - ENERO
            cMes:Left(3):Upper(), ;                             // MMM  - ENE
            ('0000' + ::Year():Str()):Right(4), ;               // aaaa - 2001
            ('00' + ::Year():Str()):Right(2) ;                  // aa   - 01
        } )
            
Return ( cDate )  


/* METHOD StrFormatRange( dEndRange, aFormatBegin, aFormatEnd )

    Devuelve un rango de fechass formateadas usando StrFormat
    Adaptación inicial de: Bingen Ugaldebere

    Parámetros:
        dEndRange - Fecha del final del rango
        aFormatBegin - Array en formato StrFormat del día, mes y año para la fecha inicial
        aFormatEnd - Array en formato StrFormat del día, mes y año para la fecha final
  
    Devuelve:
        Character

    Ejemplos:
        0d20220825:StrFormatRange(0d20230829)
        0d20220825:StrFormatRange(0d20230829,{'Desde el 0d',' de Mmmm', ' del aa'}, { ' hasta el 0d', ' de Mmmm', ' del aa'})
*/
METHOD StrFormatRange( dEndRange, aFormatBegin, aFormatEnd ) CLASS date
    Local cRes := ''
    
    hb_Default(@aFormatBegin, {'del dd', ' de Mmmm', ' del aaaa'})
    hb_Default(@aFormatEnd, {' al dd', ' de Mmmm', ' del aaaa'})
    
    Do Case
        
        case dEndRange:ValType() != 'D' .or. Self == dEndRange
            cRes := Self:StrFormat(aFormatBegin[1] + aFormatBegin[2] + aFormatBegin[3] )

        case Self:Year() == dEndRange:Year() .and. Self:Month() == dEndRange:Month()
            cRes := Self:StrFormat( aFormatBegin[1] ) + dEndRange:StrFormat( aFormatEnd[1] + aFormatEnd[2] + aFormatEnd[3] )

        case Self:Year() == dEndRange:Year()
            cRes := Self:StrFormat( aFormatBegin[1] + aFormatBegin[2] ) + dEndRange:StrFormat( aFormatEnd[1] + aFormatEnd[2] + aFormatEnd[3] )

        otherwise
            cRes := Self:StrFormat( aFormatBegin[1] + aFormatBegin[2] + aFormatBegin[3] ) + dEndRange:StrFormat( aFormatEnd[1] + aFormatEnd[2] + aFormatEnd[3] )

    end case

Return ( cRes )


/* METHOD: StrSql()
    Devuelve el string del valor en formato fecha SQL  YYYY-MM-DD

    Devuelve:
        Character
*/
METHOD StrSql()
Return ( ::StrFormat( 'aaaa-0m-0d') )


/* METHOD: StrSqlQuoted()
    Devuelve StrSql entre comillado

    Devuelve:
        Character
*/
METHOD StrSqlQuoted()
Return Chr( 39 ) + Self:StrSql() + Chr( 39 )


/* METHOD: SubDay( nDaysToSubstract )
    Devuelve la fecha del dato nDaysToSubstract antes

    Parámetros:
        nDaysToSubstract - Número de días a restar, si no se le pasa resta 1 día

    Devuelve:
        Date
*/
METHOD SubDay ( nDaysToSubstract ) CLASS Date

    hb_Default( @nDaysToSubstract, 1 )

Return Self - nDaysToSubstract


/* METHOD: SubMonth( nMonthsToSubstract )
     Resta tantos meses como nMonthstoSubstract a la fecha del valor

    Parámetros:
        nMonthstoSubstract - Número de meses a restar, si no se le pasa resta 1 mes

    Devuelve:
        Date
*/
METHOD SubMonth( nMonthsToSubstract ) CLASS Date

    hb_Default( @nMonthsToSubstract, 1 )

Return AddMonth( Self,-nMonthsToSubstract ) 


/* METHOD: SubWeek( nWeekstoSubstract )
    Método que resta tantas semanas como nweekstoSubstract a la fecha del valor

    Parámetros:
        nWeeksToSubstract - Némero de semanas a restar, si se omite tomará 1 por defecto

    Devuelve:
        Numeric
*/
METHOD SubWeek( nWeeksToSubstract ) CLASS Date

    hb_Default( @nWeeksToSubstract, 1 )

Return Self - ( nWeeksToSubstract*7 )


/* METHOD: SubYear( nYearsToSubstract )
    Devuelve la decha del datos restando nYearsToSubstract años

    Parámetros:
        nYearsToSubstract - Número de años a restar, si no se le pasa resta 1 año

    Devuelve:
        Date
*/
METHOD SubYear( nYearsToSubstract ) CLASS Date

    hb_Default( @nYearsToSubstract, 1 )

Return AddMonth( Self,-(nYearsToSubstract * 12) )


/* METHOD: Tomorrow()
    Devuelve el día posterior al dato

    Devuelve:
        Date
*/
METHOD Tomorrow() CLASS Date
Return ::AddDay()


/* METHOD: ValType()
    Devuelve el tipo del dato
    
    Devuelve:
        Character
*/
METHOD ValType() CLASS Date
Return ( 'D' )

/* METHOD: Week()
    Método que devuelve el número de la semana en el año

    Devuelve:
        Numeric
*/
METHOD Week() CLASS Date
RETURN hb_Week( Self)


/* METHOD: Year()
    Método que devuelve el año del valor del dato

    Devuelve:
        Numeric
*/
METHOD Year() CLASS Date
RETURN Year( Self )


/* METHOD: Yesterday()
    Devuelve el día anterior al dato

    Devuelve:
        Date
*/
METHOD Yesterday() CLASS Date
Return ::SubDay()