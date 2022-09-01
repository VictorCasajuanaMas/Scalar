#include 'hbclass.ch'
#include 'test.ch'

CLASS Test_Character FROM TestCase

    EXPORTED:
        DATA aCategories AS ARRAY INIT { TEST_CORE }

        METHOD Test_Alltrim()
        METHOD Test_At()
        METHOD Test_Capitalize()
        METHOD Test_Capitulate()
        METHOD Test_DayOfWeek()
        METHOD Test_Del()
        METHOD Test_DelAccentMark()
        METHOD Test_DelFirst()
        METHOD Test_DelLast()
        METHOD Test_GetJson()
        METHOD Test_Has()
        METHOD Test_IsEmpty()
        METHOD Test_IsJsonEmpty()
        METHOD Test_IsJsonValid()
        METHOD Test_Left()
        METHOD Test_LeftDeleteUntil()
        METHOD Test_Len()
        METHOD Test_Long()
        METHOD Test_Lower()
        METHOD Test_MonthByName()
        METHOD Test_NotEmpty()
        METHOD Test_NotHas()
        METHOD Test_PadLeft()
        METHOD Test_PadRight()
        METHOD Test_RAt()
        METHOD Test_Reverse()
        METHOD Test_Right()
        METHOD Test_Spacesleft()
        METHOD Test_SpacesRight()
        METHOD Test_Str()
        METHOD Test_StrReplace() 
        METHOD Test_StrSql()
        METHOD Test_StrTran()
        METHOD Test_SubStr()
        METHOD Test_ToDate()        
        METHOD Test_Upper()       
        METHOD Test_Val()        
        METHOD Test_ValType()        
        METHOD Test_Value()
        METHOD Test_Zeros()

END CLASS


METHOD Test_Alltrim() CLASS Test_Character

    ::Assert():Equals( 'a b c d e', '  a b c d e   ':Alltrim(), 'test Character:Alltrim()' )

Return ( Nil )


METHOD Test_At() CLASS Test_Character

    ::Assert():Equals( 5, 'a b c d e':At('c'),          'Test Character: At()' )
    ::Assert():Equals( 4, 'aaabbcdef':At('b'),          'Test Character: At()' )
    ::Assert():Equals( 3, 'aabbcdebf':At('b'),          'Test Character: At()' )
    ::Assert():Equals( 8, 'aabbcdebf':At('b', 5),       'Test Character: At()' )
    ::Assert():Equals( 0, 'aabbcdebf':At('b', 5, 7),    'Test Character: At()' )

Return ( Nil )


METHOD Test_Capitalize() CLASS Test_Character

    ::Assert():Equals( 'Hola',                  'hOLA':Capitalize(),                'Test Character: Capitalize()' )
    ::Assert():Equals( 'Hola Mundo',            'hOLA muNdo':Capitalize(),          'Test Character: Capitalize()' )
    ::Assert():Equals( 'Un RincÛn Del Mundo',   'un RincÛn dEL mundo':Capitalize(), 'Test Character: Capitalize()' )

Return ( Nil )


METHOD Test_Capitulate() CLASS Test_Character

    ::Assert():Equals( 'Hola', 'hOLA':Capitulate(), 'test Character:Capitulate()' )
    ::Assert():Equals( 'Hola mundo', 'hOLA muNdo':Capitulate(), 'test Character:Capitulate()' )
    ::Assert():Equals( 'Un rincæn del mundo', 'Un rincæn del mundo':Capitulate(), 'test Character:Capitulate()' )

Return ( Nil )


METHOD Test_DayOfWeek() CLASS Test_Character
    ::Assert():Equals( 1, 'Lunes':DayOfWeek(),      'Test Character: DayOfWeek' )
    ::Assert():Equals( 2, 'Ma':DayOfWeek(),         'Test Character: DayOfWeek' )
    ::Assert():Equals( 3, 'Mier':DayOfWeek(),       'Test Character: DayOfWeek' )
    ::Assert():Equals( 4, 'JUev':DayOfWeek(),       'Test Character: DayOfWeek' )
    ::Assert():Equals( 5, 'Vi':DayOfWeek(),         'Test Character: DayOfWeek' )
    ::Assert():Equals( 6, 'Sab':DayOfWeek(),        'Test Character: DayOfWeek' )
    ::Assert():Equals( 7, 'Domingo':DayOfWeek(),    'Test Character: DayOfWeek' )
    ::Assert():Equals( 0, 'test':DayOfWeek(),       'Test Character: DayOfWeek' )
    ::Assert():Equals( 0, '':DayOfWeek(),           'Test Character: DayOfWeek' )

    ::Assert():Equals( 1, 'Domingo':DayOfWeek(.T.), 'Test Character: DayOfWeek' )
    ::Assert():Equals( 2, 'Lunes':DayOfWeek(.T.),   'Test Character: DayOfWeek' )
    ::Assert():Equals( 3, 'Ma':DayOfWeek(.T.),      'Test Character: DayOfWeek' )
    ::Assert():Equals( 4, 'MiÈr':DayOfWeek(.T.),    'Test Character: DayOfWeek' )
    ::Assert():Equals( 5, 'JUev':DayOfWeek(.T.),    'Test Character: DayOfWeek' )
    ::Assert():Equals( 6, 'Vi':DayOfWeek(.T.),      'Test Character: DayOfWeek' )
    ::Assert():Equals( 7, 'Sab':DayOfWeek(.T.),     'Test Character: DayOfWeek' )
    ::Assert():Equals( 0, 'test':DayOfWeek(.T.),    'Test Character: DayOfWeek' )
    ::Assert():Equals( 0, '':DayOfWeek(.T.),        'Test Character: DayOfWeek' )
    
Return ( Nil )


METHOD Test_Del() CLASS Test_Character

    ::Assert():Equals( 'fichero',       'fichero.dbf':del( '.dbf' ),    'Test Character: Del()' )
    ::Assert():Equals( 'fichero.dbf',   'fichero.dbf':del(),            'Test Character: Del()' )
    ::Assert():Equals( 'fichero.dbf',   'fichero.dbf':del( '.DBF' ),    'Test Character: Del()' )
    ::Assert():Equals( 'firo.dbf',      'fichero.dbf':del( 'che' ),     'Test Character: Del()' )
    ::Assert():Equals( 'ichero.db',     'fichero.dbf':del( 'f' ),       'Test Character: Del()' )

Return ( Nil )


METHOD Test_DelAccentMark() CLASS Test_Character

    ::Assert():Equals( 'aeiou', '·ÈÌÛ˙':DelAccentMark(), 'Test Character: DelAccentMark()' )
    ::Assert():Equals( 'aeiou', '‡ËÏÚ˘':DelAccentMark(), 'Test Character: DelAccentMark()' )
    ::Assert():Equals( 'aeiou', '‰ÎÔˆ¸':DelAccentMark(), 'Test Character: DelAccentMark()' )
    ::Assert():Equals( 'aeiou', '‚ÍÓÙ˚':DelAccentMark(), 'Test Character: DelAccentMark()' )

    ::Assert():Equals( 'AEIOU', '¡…Õ”⁄':DelAccentMark(), 'Test Character: DelAccentMark()' )
    ::Assert():Equals( 'AEIOU', '¿»Ã“Ÿ':DelAccentMark(), 'Test Character: DelAccentMark()' )
    ::Assert():Equals( 'AEIOU', 'ƒÀœ÷‹':DelAccentMark(), 'Test Character: DelAccentMark()' )
    ::Assert():Equals( 'AEIOU', '¬ Œ‘€':DelAccentMark(), 'Test Character: DelAccentMark()' )

Return ( Nil )


METHOD Test_DelFirst() CLASS Test_Character

    ::Assert():Equals( 'b,c,d,', 'a,b,c,d,':DelFirst('a,'), 'test Character:DelFirst()' )
    ::Assert():Equals( 'e,f,a,b,', 'a,b,e,f,a,b,':DelFirst('a,b,'), 'test Character:DelFirst()' )
    ::Assert():Equals( 'a,b,', 'a,b,':DelFirst(''), 'test Character:DelFirst()' )
    ::Assert():Equals( '', 'a,b,':DelFirst('a,b,'), 'test Character:DelFirst()' )

Return ( Nil )


METHOD Test_DelLast() CLASS Test_Character

    ::Assert():Equals( 'a,b,c,d', 'a,b,c,d,':DelLast(','), 'test Character:DelLast()' )
    ::Assert():Equals( 'a,b,e,f,', 'a,b,e,f,a,b,':DelLast('a,b,'), 'test Character:DelLast()' )
    ::Assert():Equals( 'a,b,', 'a,b,':DelLast(''), 'test Character:DelLast()' )
    ::Assert():Equals( '', 'a,b,':DelLast('a,b,'), 'test Character:DelLast()' )

Return ( Nil )


METHOD Test_GetJson() CLASS Test_Character

    ::Assert():arrayequals( {"codigo"=>1,"codigo"=>2,"codigo"=>3}, '{"codigo":1,"codigo":2,"codigo":3}':GetJson(), 'Test Character:GetJson()')
    ::Assert():arrayequals( {"codigo"=>"1","codigo"=>"2","codigo"=>"3"}, '{"codigo":"1","codigo":"2","codigo":"3"}':GetJson(), 'Test Character:GetJson()')
    ::Assert():arrayequals( {"codigo"=>1,"codigo"=>"2"}, '{"codigo":1,"codigo": "2"}':GetJson(), 'Test Character:GetJson()')
    ::Assert():null( 'esto no es un json':GetJson(), 'Test GetJson()')
    ::Assert():null( '':GetJson(), 'Test GetJson()')

Return ( Nil )


METHOD Test_Has() CLASS Test_Character

    ::Assert:True( 'ABCDE':Has( 'A' ),  'Test Character: Has()' )
    ::Assert:False( 'ABCDE':Has( 'F' ), 'Test Character: Has()' )
    ::Assert:False( 'ABCDE':Has( 'a' ), 'Test Character: Has()' )
    ::Assert:False( 'ABCDE':Has( '' ),  'Test Character: Has()' )

Return ( Nil )


METHOD Test_IsEmpty() CLASS Test_Character

    ::Assert():True( '':IsEmpty,        'Test Character: Isempty()' )
    ::Assert():True( ' ':IsEmpty,       'Test Character: Isempty()' )
    ::Assert():False( 'A':IsEmpty,      'Test Character: Isempty()' )
    ::Assert():False( ' A':IsEmpty,     'Test Character: Isempty()' )
    ::Assert():False( 'A ':IsEmpty,     'Test Character: Isempty()' )
    ::Assert():False( ' A ':ISEmpty,    'Test Character: Isempty()' )

Return ( Nil )


METHOD Test_IsJsonEmpty() CLASS Test_Character

    ::Assert():True( hb_jsonEncode( { => } ):IsJsonEmpty(), 'Test Character: IsJsonEmpty()' )
    ::Assert():True( '':IsJsonEmpty(),                      'Test Character: IsJsonEmpty()' )
    ::Assert():False( '{"dato":1}':IsJsonEmpty(),           'Test Character: IsJsonEmpty()' )
    ::Assert():False( 'a':IsJsonEmpty(),                    'Test Character: IsJsonEmpty()' )

Return ( Nil )


METHOD Test_IsJsonValid() CLASS Test_Character

    ::Assert():True( '{"codigo":1}':IsJsonValid(),  'Test Character: IsJsonValid()' )
    ::Assert():False( '{}':IsJsonValid(),           'Test Character: IsJsonValid()' )
    ::Assert():False( '':IsJsonValid(),             'Test Character: IsJsonValid()' )
    ::Assert():False( 'nada':IsJsonValid(),         'Test Character: IsJsonValid()' )

Return ( Nil )


METHOD Test_Left() CLASS Test_Character

    ::Assert():Equals( 'Ho',    'Hola':Left(2), 'Test Character: Left()' )
    ::Assert():Equals( '',      'Hola':Left(),  'Test Character: Left()' )
    ::Assert():Equals( 'Hola',  'Hola':Left(5), 'Test Character: Left()' )

Return ( Nil )


METHOD Test_LeftDeleteUntil() CLASS Test_Character

    ::Assert():Equals( '204',       '000204':LeftDeleteUntil( '0' ), 'Test Character: LeftDeleteUntil()' )
    ::Assert():Equals( '000204',    '000204':LeftDeleteUntil( ''  ), 'Test Character: LeftDeleteUntil()' )
    ::Assert():Equals( '000204',    '000204':LeftDeleteUntil( '1' ), 'Test Character: LeftDeleteUntil()' )
    ::Assert():Equals( '000204',    '000204':LeftDeleteUntil( '2' ), 'Test Character: LeftDeleteUntil()' )

Return ( Nil )


METHOD Test_Len() CLASS Test_Character

    ::Assert():Equals(  0, '':Len(), 'test long()' )
    ::Assert():Equals( 10, '1234567890':Len(),      'Test Character: Len()' )
    ::Assert():Equals( 11, ' 1234567890':Len(),     'Test Character: Len()' )
    ::Assert():Equals( 11, '1234567890 ':Len(),     'Test Character: Len()' )
    ::Assert():Equals( 12, ' 1234567890 ':Len(),    'Test Character: Len()' )

Return ( Nil )



METHOD Test_Long() CLASS Test_Character

    ::Assert():Equals(  0, '':Long(), 'test long()' )
    ::Assert():Equals( 10, '1234567890':Long(),     'Test Character: Long()' )
    ::Assert():Equals( 10, ' 1234567890':Long(),    'Test Character: Long()' )
    ::Assert():Equals( 10, '1234567890 ':Long(),    'Test Character: Long()' )
    ::Assert():Equals( 10, ' 1234567890 ':Long(),   'Test Character: Long()' )

Return ( Nil )


METHOD Test_Lower() CLASS Test_Character

    ::Assert():Equals( 'abcde', 'ABCDE':lower(), 'Test Character: lower()' )
    ::Assert():Equals( '·ÈÌÛ˙', '¡…Õ”⁄':lower(), 'Test Character: lower()' )
    ::Assert():Equals( '‡ËÏÚ˘', '¿»Ã“Ÿ':lower(), 'Test Character: lower()' )
    ::Assert():Equals( '‰ÎÔˆ¸', 'ƒÀœ÷‹':lower(), 'Test Character: lower()' )
    
Return ( Nil )


METHOD Test_MonthByName() CLASS Test_Character

    ::Assert():Equals(  1, 'E':MonthByName(),       'Test Character: MonthByName()' )
    ::Assert():Equals(  2, 'FeBR':MonthByName(),    'Test Character: MonthByName()' )
    ::Assert():Equals(  3, 'mar':MonthByName(),     'Test Character: MonthByName()' )
    ::Assert():Equals(  4, 'abr':MonthByName(),     'Test Character: MonthByName()' )
    ::Assert():Equals(  5, 'May':MonthByName(),     'Test Character: MonthByName()' )
    ::Assert():Equals(  6, 'JUN':MonthByName(),     'Test Character: MonthByName()' )
    ::Assert():Equals(  7, 'JULIO':MonthByName(),   'Test Character: MonthByName()' )
    ::Assert():Equals(  8, 'agosTo':MonthByName(),  'Test Character: MonthByName()' )
    ::Assert():Equals(  9, 'Sep':MonthByName(),     'Test Character: MonthByName()' )
    ::Assert():Equals( 10, 'O':MonthByName(),       'Test Character: MonthByName()' )
    ::Assert():Equals( 11, 'NovÌEM':MonthByName(),  'Test Character: MonthByName()' )
    ::Assert():Equals( 12, 'DICI':MonthByName(),    'Test Character: MonthByName()' )
    ::Assert():Equals( 0, 'abc':MonthByName(),      'Test Character: MonthByName()' )
    ::Assert():Equals( 0, 'JU':MonthByName(),       'Test Character: MonthByName()' )

Return ( Nil )


METHOD Test_NotEmpty() CLASS Test_Character

    ::Assert():False( '':NotEmpty,      'Test Character: NotEmpty()' )
    ::Assert():False( ' ':NotEmpty,     'Test Character: NotEmpty()' )
    ::Assert():True( 'A':NotEmpty,      'Test Character: NotEmpty()' )
    ::Assert():True( ' A':NotEmpty,     'Test Character: NotEmpty()' )
    ::Assert():True( 'A ':NotEmpty,     'Test Character: NotEmpty()' )
    ::Assert():True( ' A ':NotEmpty,    'Test Character: NotEmpty()' )

Return ( Nil )


METHOD Test_NotHas() CLASS Test_Character

    ::Assert:False( 'ABCDE':NotHas( 'A' ),  'Test Character: NotHas()' )
    ::Assert:True( 'ABCDE':NotHas( 'F' ),   'Test Character: NotHas()' )
    ::Assert:True( 'ABCDE':NotHas( 'a' ),   'Test Character: NotHas()' )
    ::Assert:True( 'ABCDE':NotHas( '' ),    'Test Character: NotHas()' )

Return ( Nil )


METHOD Test_PadLeft() CLASS Test_Character

    ::Assert():Equals( ' HOLA',         'HOLA':PadLeft( 5 ),            'Test Character: PadLeft()' )
    ::Assert():Equals( 'OLA',           'HOLA':PadLeft( 3 ),            'Test Character: PadLeft()' )
    ::Assert():Equals( '     HOLA ',    'HOLA ':PadLeft( 10 ),          'Test Character: PadLeft()' )
    ::Assert():Equals( '------HOLA',    'HOLA':PadLeft( 10, '-' ),      'Test Character: PadLeft()' )
    ::Assert():Equals( '-----HOLA ',    'HOLA ':PadLeft( 10, '-' ),     'Test Character: PadLeft()' )
    ::Assert():Equals( '----- HOLA',    ' HOLA':PadLeft( 10, '-' ),     'Test Character: PadLeft()' )
    ::Assert():Equals( '---- HOLA ',    ' HOLA ':PadLeft( 10, '-' ),    'Test Character: PadLeft()' )
    ::Assert():Equals( ' HOLA ',        ' HOLA ':PadLeft(),             'Test Character: PadLeft()' )

Return  ( Nil )


METHOD Test_PadRight() CLASS Test_Character

    ::Assert():Equals( 'HOLA ',         'HOLA':PadRight( 5 ),           'Test Character: PadRight()' )
    ::Assert():Equals( 'HOL',           'HOLA':PadRight( 3 ),           'Test Character: PadRight()' )
    ::Assert():Equals( 'HOLA      ',    'HOLA ':PadRight( 10 ),         'Test Character: PadRight()' )
    ::Assert():Equals( 'HOLA------',    'HOLA':PadRight( 10, '-' ),     'Test Character: PadRight()' )
    ::Assert():Equals( 'HOLA -----',    'HOLA ':PadRight( 10, '-' ),    'Test Character: PadRight()' )
    ::Assert():Equals( ' HOLA-----',    ' HOLA':PadRight( 10, '-' ),    'Test Character: PadRight()' )
    ::Assert():Equals( ' HOLA ----',    ' HOLA ':PadRight( 10, '-' ),   'Test Character: PadRight()' )
    ::Assert():Equals( ' HOLA ',        ' HOLA ':PadRight(),            'Test Character: PadRight()' )

Return  ( Nil )


METHOD Test_RAt() CLASS Test_Character

    ::Assert():Equals( 3, 'a b c d e':RAt('b'), 'test Character: RAt()' )
    ::Assert():Equals( 6, 'aaaabbcdef':RAt('b'), 'test Character: RAt()' )
    ::Assert():Equals( 3, 'abbcdeeff':RAt('b'), 'test Character: RAt()' )
    ::Assert():Equals( 0, 'abbcdeeff':RAt('b', 4), 'test Character: RAt()' )
    ::Assert():Equals( 0, 'abbcdeeffb':RAt('b', 4, 8), 'test Character: RAt()' )

Return ( Nil )


METHOD Test_Reverse() CLASS Test_Character

    ::Assert():Equals( 'aloH', 'Hola':Reverse(), "Test CharacterReverse()" )
    ::Assert():Equals( 'odnuM aloH', 'Hola Mundo':Reverse(), "Test CharacterReverse()" )
    ::Assert():Equals( '54321', '12345':Reverse(), "Test CharacterReverse()" )
    ::Assert():Equals( '', '':Reverse(), "Test CharacterReverse()" )

Return ( Nil )


METHOD Test_Right() CLASS Test_Character

    ::Assert():Equals( 'la', 'Hola':Right(2), 'Test Character: Right()' )
    ::Assert():Equals( '', 'Hola':Right(), 'Test Character: Right()' )
    ::Assert():Equals( 'Hola', 'Hola':Right(5), 'Test Character: Right()' )

Return ( Nil )


METHOD Test_SpacesLeft() CLASS Test_Character

    ::Assert():Equals( ' HOLA',         'HOLA':SpacesLeft( 5 ),     'Test Character: SpacesLeft()' )
    ::Assert():Equals( 'OLA',           'HOLA':SpacesLeft( 3 ),     'Test Character: SpacesLeft()' )
    ::Assert():Equals( '      HOLA',    'HOLA ':SpacesLeft( 10 ),   'Test Character: SpacesLeft()' )
    ::Assert():Equals( '      HOLA',    ' HOLA':SpacesLeft( 10 ),   'Test Character: SpacesLeft()' )
    ::Assert():Equals( '      HOLA',    ' HOLA ':SpacesLeft( 10 ),  'Test Character: SpacesLeft()' )
    ::Assert():Equals( 'HOLA',          ' HOLA ':SpacesLeft(),      'Test Character: SpacesLeft()' )
Return  ( Nil )

METHOD Test_SpacesRight() CLASS Test_Character

    ::Assert():Equals( 'HOLA ',         'HOLA':SpacesRight( 5 ),    'Test Character: SpacesRight()' )
    ::Assert():Equals( 'HOL',           'HOLA':SpacesRight( 3 ),    'Test Character: SpacesRight()' )
    ::Assert():Equals( 'HOLA      ',    'HOLA ':SpacesRight( 10 ),  'Test Character: SpacesRight()' )
    ::Assert():Equals( 'HOLA      ',    ' HOLA':SpacesRight( 10 ),  'Test Character: SpacesRight()' )
    ::Assert():Equals( 'HOLA      ',    ' HOLA ':SpacesRight( 10 ), 'Test Character: SpacesRight()' )
    ::Assert():Equals( 'HOLA',          ' HOLA ':SpacesRight(),     'Test Character: SpacesLeft()' )

Return  ( Nil )


METHOD Test_Str() CLASS Test_Character

    ::Assert():Equals( 'Hola', 'Hola':Str(), 'test_str()')
    ::Assert():Equals( '', '':Str(), 'test_str()')

Return ( Nil )


METHOD Test_StrReplace() CLASS Test_Character

    ::Assert():Equals( '1B2DE', 'ABCDE':StrReplace( 'AC', '12' ), 'Test Character:StrReplace()' )
    ::Assert():Equals( 'AB1D', 'ABCDE':StrReplace( 'CE', '1' ), 'Test Character:StrReplace()' )
    ::Assert():Equals( 'A12DEF9I', 'ABCDEFGHI':StrReplace( {"BC","GH"}, {"12","9"} ), 'Test Character:SrtReplace()' )

Return ( Nil )


METHOD Test_StrSql() CLASS Test_Character

    ::Assert():Equals( 'Hola', 'Hola':StrSql(), 'test_strSql()')
    ::Assert():Equals( '', '':StrSql(), 'test_strSql()')

Return ( Nil )


METHOD Test_StrTran() CLASS Test_Character

    ::Assert():Equals( 'AB1DE', 'ABCDE':StrTran( 'C', '1' ), 'Test Character:StrTran()' )
    ::Assert():Equals( 'ABDE', 'ABCDE':StrTran( 'C', '' ), 'Test Character:StrTran()' )
    ::Assert():Equals( 'ABCDE', 'ABCDE':StrTran( 'F', '1' ), 'Test Character:StrTran()' )

Return ( Nil )


METHOD Test_SubStr() CLASS Test_Character

    ::Assert():Equals( 'BCD', 'ABCDE':SubStr( 2,3 ), 'Test Character:SubStr()' )
    ::Assert():Equals( 'BCDE', 'ABCDE':SubStr( 2 ), 'Test Character:SubStr()' )
 
Return ( Nil )


METHOD Test_ToDate() CLASS Test_Character
    
    Local oStrToDate := StrToDate():New()
    // Hoy, MaÒana, Ayer
    ::Assert():Equals( 0d20220725, 'h':ToDate(,,0d20220725), "ToDate h  hoy" )
    ::Assert():Equals( 0d20220725, 't':ToDate(,,0d20220725), "ToDate t  today" )
    ::Assert():Equals( 0d20220724, 'a':ToDate(,,0d20220725), "ToDAte a  ayer" )
    ::Assert():Equals( 0d20220724, 'y':ToDate(,,0d20220725), "ToDate y  yesterday" )
    ::Assert():Equals( 0d20220726, 'm':ToDate(,,0d20220725), "ToDate m  ma±ana" )
    ::Assert():Equals( 0d20220726, 'w':ToDate(,,0d20220725), "ToDate w  tomorrow" )

    // Incremetar o decrementar fecha
    ::Assert():Equals( 0d20220726, '+':ToDate(,,0d20220725),    "ToDate +" )
    ::Assert():Equals( 0d20220730, '+5':ToDate(,,0d20220725),   "ToDate +5" )
    ::Assert():Equals( 0d20220724, '-':ToDate(,,0d20220725),    "ToDate -" )
    ::Assert():Equals( 0d20220721, '-4':ToDate(,,0d20220725),   "ToDate -4" )


    // Sin separadores DMA (DÌa/Mes/AÒo) por defecto
    ::Assert():Equals( 0d20220701, '1':ToDate(,,0d20220721),        "ToDate - 1" )
    ::Assert():Equals( 0d20220211, '1102':ToDate(,,0d20220721),     "ToDate - 1102" )
    ::Assert():Equals( 0d20230201, '10223':ToDate(,,0d20220721),    "ToDate - 10223" )
    ::Assert():Equals( 0d20230211, '110223':ToDate(,,0d20220721),   "ToDate - 110223" )

    // Sin separadores MDA (Mes/DÌa/AÒo)
    ::Assert():Equals( 0d20220423, '0423':ToDate("MDA",,0d20220721),"ToDate MDA - 0423" )

    // Sin separadores AMD (A—o/Mes/DÌa)
    ::Assert():Equals( 0d20230421, '2304':ToDate("AMD",,0d20220721),"ToDate AMD - 2304" )
        
    // Con separadores DMA (DÌa/Mes/AÒo) por defecto
    ::Assert():Equals( 0d20220705, '5//':ToDate(,,0d20220725),      "ToDate - 5//" )
    ::Assert():Equals( 0d20220825, '/8/':ToDate(,,0d20220725),      "ToDate - /8/" )
    ::Assert():Equals( 0d20230703, '3 7 23':ToDate(,,0d20220725),   "ToDate - 3 7 23" )
    ::Assert():Equals( 0d20230725, '..23':ToDate(,,0d20220725),     "ToDate - ..23" )

    SET EPOCH TO 2000
    
    ::Assert():Equals( 0d20990525, '/5/99':ToDate(,,0d20220725),    "ToDate - /5/99 Epoch 2000" )
    ::Assert():Equals( 0d20990701, '1--99':ToDate(,,0d20220725),    "ToDate - 1--99 Epoch 2000" )

    SET EPOCH TO 1950

    ::Assert():Equals( 0d19990525, '/5/99':ToDate(,,0d20220725),    "ToDate - /5/99 Epoch 1950" )
    ::Assert():Equals( 0d19990701, '1--99':ToDate(,,0d20220725),    "ToDate - 1--99 Epoch 1950" )

    SET EPOCH TO 2000

    // Con separadores MDA (Mes/DÌa/AÒo)
    ::Assert():Equals( 0d20230105, '1-5':ToDate('MDA',,0d20231201, "ToDate MDA - 1-5") )
    ::Assert():Equals( 0d20221205, '12.5.22':ToDate('MDA',,0d20231201, "ToDate MDA - 2.5.22") )
    ::Assert():Equals( 0d20231214, '12.14':ToDate('MDA',,0d20231201, "ToDate MDA - 12.14") )
    ::Assert():Equals( 0d20231201, '12.1.23':ToDate('MDA',,0d20231201, "ToDate MDA - 12.1.23") )

    // Con separadores AMD (AÒo/Mes/DÌa)
    ::Assert():Equals( 0d20230105, '.1.5':ToDate('AMD',,0d20231201, "ToDate AMD - .1.5") )
    ::Assert():Equals( 0d20221205, '22.12.5':ToDate('AMD',,0d20231201, "ToDate AMD - 2.5.22") )
    ::Assert():Equals( 0d20231214, '.12.14':ToDate('AMD',,0d20231201, "ToDate AMD - 12.14") )
    ::Assert():Equals( 0d20231201, '23.12.01':ToDate('AMD',,0d20231201, "ToDate AMD - 23.12.01") )

    // DÌas de la semana en inglÈs
    REQUEST HB_LANG_EN
	HB_LangSelect( "EN" )
    ::Assert():Equals( 0d20220801, 'mo':ToDate(,,0d20220727), "ToDate - mo" )
    ::Assert():Equals( 0d20220801, 'mon':ToDate(,,0d20220727), "ToDate - mon" )
    ::Assert():Equals( 0d20220802, 'tu':ToDate(,,0d20220727), "ToDate - tu" )
    ::Assert():Equals( 0d20220803, 'we':ToDate(,,0d20220727), "ToDate - we" )
    ::Assert():Equals( 0d20220727, 'wed':ToDate(,,0d20220725), "ToDate - wed" )
    ::Assert():Equals( 0d20220803, 'Wednesday':ToDate(,,0d20220727), "ToDate - Wednesday" )
    ::Assert():Equals( 0d20220728, 'thur':ToDate(,,0d20220725), "ToDate - thur" )
    ::Assert():Equals( 0d20220729, 'fRIdaY':ToDate(,,0d20220725), "ToDate - fRIdaY" )
    ::Assert():Equals( 0d20220730, 'Satu':ToDate(,,0d20220725), "ToDate - Satu" )
    ::Assert():Equals( 0d20220731, 'sun':ToDate(,,0d20220725), "ToDate - sun" )

    // DÌas de la semana en francÈs
    REQUEST HB_LANG_FR
	HB_LangSelect( "FR" )
    ::Assert():Equals( 0d20220801, 'lu':ToDate(,,0d20220727), "ToDate - lu" )
    ::Assert():Equals( 0d20220801, 'lun':ToDate(,,0d20220727), "ToDate - lun" )
    ::Assert():Equals( 0d20220802, 'ma':ToDate(,,0d20220727), "ToDate - ma" )
    ::Assert():Equals( 0d20220803, 'me':ToDate(,,0d20220727), "ToDate - me" )
    ::Assert():Equals( 0d20220727, 'mer':ToDate(,,0d20220725), "ToDate - mer" )
    ::Assert():Equals( 0d20220803, 'mercredi':ToDate(,,0d20220727), "ToDate - mercredi" )
    ::Assert():Equals( 0d20220728, 'jeud':ToDate(,,0d20220727), "ToDate - jeud" )
    ::Assert():Equals( 0d20220729, 'vENdREdi':ToDate(,,0d20220725), "ToDate - vENdREdi" )
    ::Assert():Equals( 0d20220730, 'Same':ToDate(,,0d20220725), "ToDate - Same" )
    ::Assert():Equals( 0d20220731, 'dim':ToDate(,,0d20220725), "ToDate - dim" )

    // DÌas de la semana en espaÒol
    REQUEST HB_LANG_ES
	HB_LangSelect( "ES" )
    ::Assert():Equals( 0d20220801, 'lu':ToDate(,,0d20220727), "ToDate - lu" )
    ::Assert():Equals( 0d20220801, 'lun':ToDate(,,0d20220727), "ToDate - lun" )
    ::Assert():Equals( 0d20220802, 'ma':ToDate(,,0d20220727), "ToDate - ma" )
    ::Assert():Equals( 0d20220803, 'mi':ToDate(,,0d20220727), "ToDate - mi" )
    ::Assert():Equals( 0d20220727, 'miÈ':ToDate(,,0d20220725), "ToDate -miÈ" )
    ::Assert():Equals( 0d20220803, 'miÈrcoles':ToDate(,,0d20220727), "ToDate - miÈrcoles" )
    ::Assert():Equals( 0d20220728, 'juev':ToDate(,,0d20220727), "ToDate - juev" )
    ::Assert():Equals( 0d20220729, 'vIErNEs':ToDate(,,0d20220725), "ToDate - vIErNEs" )
    ::Assert():Equals( 0d20220730, 'S·ba':ToDate(,,0d20220725), "ToDate - S·ba" )
    ::Assert():Equals( 0d20220731, 'dom':ToDate(,,0d20220725), "ToDate - dom" )

    // Errores
    ::Assert():Equals( Date() , '999999':ToDate() )
    ::Assert():Equals( 'NO VALIDA' , '999999':ToDate(,'NO VALIDA') )
    ::Assert():Equals( Date() , 'asd':ToDate() )
    ::Assert():Equals( Date() , '290223':ToDate() )

Return ( Nil )


METHOD Test_Upper() CLASS Test_Character

    ::Assert():Equals( 'ABCDE', 'abcde':upper(), 'test Character:upper()')
    ::Assert():Equals( '¡…Õ”⁄', '·ÈÌÛ˙':upper(), 'test Character:upper()')
    ::Assert():Equals( '¿»Ã“Ÿ', '‡ËÏÚ˘':upper(), 'test Character:upper()')
    ::Assert():Equals( 'ƒÀœ÷‹', '‰ÎÔˆ¸':upper(), 'test Character:upper()')
        
Return ( Nil )


METHOD Test_Val() CLASS Test_Character

    ::Assert():Equals( 123, '123':Val(), 'test_val()' )
    ::Assert():Equals( 123.45, '123.45':Val(), 'test_val()' )
    ::Assert():Equals( 123, '123,45':Val(), 'test_val()' )

Return ( Nil )


METHOD Test_ValType() CLASS Test_Character

    ::Assert():Equals( "C", 'abc':ValType(), 'test_valtype()' )
    
Return ( Nil )


METHOD Test_Value() CLASS Test_Character

    ::Assert():Equals( 'hola', 'hola':Value(), 'test_value()' )
    ::Assert():Equals( 'hola', Nil:Value('hola'), 'test_value()' )

Return ( Nil )


METHOD Test_Zeros() CLASS Test_Character

    ::Assert():Equals( '0025', '25':Zeros( 4 ) )
    ::Assert():Equals( '0025', '0025':Zeros( 4 ) )
    ::Assert():Equals( '12345', '12345':Zeros( 4 ) )
    ::Assert():Equals( '25', '25':Zeros( ) )
    ::Assert():Equals( '25', '25':Zeros( 0 ) )
    ::Assert():Equals( '0025', '25 ':Zeros( 4 ) )
    ::Assert():Equals( '0025', ' 25':Zeros( 4 ) )
    ::Assert():Equals( '25', '25':Zeros( 2 ) )

Return ( Nil )