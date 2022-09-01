#INCLUDE 'hbclass.ch'
#INCLUDE 'test.ch'

CLASS Test_Numeric FROM TestCase

    EXPORTED:
        DATA aCategories INIT { TEST_CORE }
        METHOD Test_Between()
        METHOD Test_Empty()
        METHOD Test_Int()
        METHOD Test_Mod()
        METHOD Test_NotEmpty()                     
        METHOD Test_Round()
        METHOD Test_Str()    
        METHOD Test_StrFloat()                    
        METHOD Test_StrInt()
        METHOD Test_StrRaw()
        METHOD Test_StrSql()
        METHOD Test_ValType()
        METHOD Test_Value()

END CLASS

METHOD Test_Between() CLASS Test_Numeric

    ::Assert():True( 4:Between(1, 10),      'Test Numeric: BetWeen()' )
    ::Assert():True( 0:Between(, 2),        'Test Numeric: BetWeen()' )
    ::Assert():True( 0:Between(),           'Test Numeric: BetWeen()' )
    ::Assert():True( 0:Between('a', 'b'),   'Test Numeric: BetWeen()' )
    
    ::Assert():False( 0:Between(1, 2),      'Test Numeric: BetWeen()' )
    ::Assert():False( 0:Between(1, 2),      'Test Numeric: BetWeen()' )
    ::Assert():False( 0:Between(1, ),       'Test Numeric: BetWeen()' )
    ::Assert():False( 3:Between(),          'Test Numeric: BetWeen()' )
    ::Assert():False( 4:Between('a','b'),   'Test Numeric: BetWeen()' )
    


Return ( Nil )

METHOD Test_Empty() CLASS Test_Numeric

    ::Assert():True( 0:Empty(), 'Test Numeric: Empty()' )
    ::Assert():False( 1:Empty(), 'Test Numeric: Empty()' )

Return ( Nil )

METHOD Test_Int() CLASS Test_Numeric

    ::Assert():Equals( 123456 , 123456:Int(), 'Test Numeric: Int()' )
    ::Assert():Equals( 123456 , 123456.7890:Int(), 'Test Numeric: Int()' )
    ::Assert():Equals( 0 , 0.123:Int(), 'Test Numeric: Int()' )

Return ( Nil )    


METHOD Test_Mod() CLASS Test_Numeric

    ::Assert():Equals( 0, 20:Mod(2), 'Test Numeric: Mod()' )
    ::Assert():Equals( 1, 3:Mod(2), 'Test Numeric: Mod()' )

Return ( Nil )


METHOD Test_NotEmpty() CLASS Test_Numeric

    ::Assert():True( 1:NotEmpty(), 'Test Numeric: NotEmpty()' )
    ::Assert():False( 0:NotEmpty(), 'Test Numeric: NotEmpty()' )

Return ( Nil )


METHOD Test_Round() CLASS Test_Numeric

    ::Assert():Equals( 123456 , 123456:Round(), 'Test Numeric: Round()' )
    ::Assert():Equals( 123456.8 , 123456.78:Round(1), 'Test Numeric: Round()' )
    ::Assert():Equals( 0.12 , 0.123:Round(2), 'Test Numeric: Round()' )

Return ( Nil )    


METHOD Test_Str() CLASS Test_Numeric

    ::Assert():Equals( '123', 123.00:Str(), 'Test Numeric: Str()' )
    ::Assert():Equals( '123', 123.12:Str(), 'Test Numeric: Str()' )
    ::Assert():Equals( '123.12', 123.12:Str(,2), 'Test Numeric: Str()' )
    ::Assert():Equals( '***', 123.12:Str(3,2), 'Test Numeric: Str()' )
    ::Assert():Equals( '123.12', 123.12:Str(6,2), 'Test Numeric: Str()'  )
    ::Assert():Equals( '**', 123.12:Str(2), 'Test Numeric: Str()'  )

Return ( Nil )


METHOD Test_StrFloat() CLASS Test_Numeric

    ::Assert():Equals( '123456.7890' , 123456.7890:StrFloat(4), 'Test Numeric: StrFloat()' )
    ::Assert():Equals( '123456.79' , 123456.7890:StrFloat(2), 'Test Numeric: StrFloat()' )
    ::Assert():Equals( '123456.78' , 123456.7840:StrFloat(2), 'Test Numeric: StrFloat()' )
    ::Assert():Equals( '123456.79' , 123456.7850:StrFloat(2), 'Test Numeric: StrFloat() ' )
    ::Assert():Equals( '123456.789000' , 123456.7890:StrFloat(), 'Test Numeric: StrFloat()' )
    ::Assert():Equals( '0.000000' , 0:StrFloat(), 'Test Numeric: '  )

Return ( Nil )


METHOD Test_StrInt() CLASS Test_Numeric

    ::Assert():Equals( '123456' , 123456:StrInt(), 'Test Numeric: StrInt()' )
    ::Assert():Equals( '123457' , 123456.7890:StrInt(), 'Test Numeric: StrInt()' )
    ::Assert():Equals( '0' , 0:StrInt(), 'Test Numeric: StrInt()' )

Return ( Nil )


METHOD Test_StrRaw() CLASS Test_Numeric

    ::Assert():Equals( '123', 123.00:Str(), 'Test Numeric: Str()' )
    ::Assert():Equals( '123', 123.12:Str(), 'Test Numeric: Str()' )
    ::Assert():Equals( '123.12', 123.12:Str(,2), 'Test Numeric: Str()' )
    ::Assert():Equals( '***', 123.12:Str(3,2), 'Test Numeric: Str()' )
    ::Assert():Equals( '123.12', 123.12:StrRaw(6,2), 'Test Numeric: Str()' )
    ::Assert():Equals( '  123.12', 123.12:StrRaw(8,2), 'Test Numeric: Str()' )
    ::Assert():Equals( '**', 123.12:Str(2), 'Test Numeric: Str()' )

Return ( Nil )


METHOD Test_StrSql() CLASS Test_Numeric

    ::Assert():Equals( '123456', 123456:StrSql(), 'Test Numeric: StrSql()' )
    ::Assert():Equals( '0', 0:StrSql(), 'Test Numeric: StrSql()' )
    ::Assert():Equals( '123456.789000', 123456.789:StrSql(), 'Test Numeric: StrSql()' )
    ::Assert():Equals( '0.000001', 0.000001:StrSql(), 'Test Numeric: StrSql()' )

Return ( Nil )


METHOD Test_ValType() CLASS Test_Numeric

    ::Assert():Equals( 'N', 1:ValType(), 'Test Numeric: ValType()' )
    
Return ( Nil )


METHOD Test_Value() CLASS Test_Numeric

    ::Assert():Equals( 0, 0:Value(), 'Test Numeric: Value()' )
    ::Assert():Equals( 0, Nil:Value(0), 'Test Numeric: Value()' )

Return ( Nil )