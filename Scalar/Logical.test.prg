#include 'hbclass.ch'
#INCLUDE 'test.ch'

CLASS Test_Logical FROM TestCase

    EXPORTED: 
        DATA aCategories INIT { TEST_CORE }
        
        METHOD Test_Empty()
        METHOD Test_NotEmpty()
        METHOD Test_Str()
        METHOD Test_StrSql()
        METHOD Test_ValType()
        METHOD Test_Value()

END CLASS


METHOD Test_Empty() CLASS Test_Logical

    ::Assert():Equals( .F., .T.:Empty(), "Test Logical: Empty()" )
    ::Assert():Equals( .F., .F.:Empty(), "Test Logical: Empty()" )

Return ( Nil )


METHOD Test_NotEmpty() CLASS Test_Logical

    ::Assert():Equals( .T., .T.:NotEmpty(), "Test Logical: NotEmpty()" )
    ::Assert():Equals( .T., .F.:NotEmpty(), "Test Logical: NotEmpty()" )

Return ( Nil )


METHOD Test_Str() CLASS Test_Logical

    ::Assert():Equals( 'si' , .T.:Str('si','no'),'Test Logical: Str()' )
    ::Assert():Equals( 'no' , .F.:Str('si','no'),'Test Logical: Str()' )
    ::Assert():Equals( '.T.' , .T.:Str(),'Test Logical: Str()' )
    ::Assert():Equals( '.F.' , .F.:Str(),'Test Logical: Str()' )
    ::Assert():Equals( '.T.' , .T.:Str(,'no'),'Test Logical: Str()' )
    ::Assert():Equals( '.F.' , .F.:Str('si',),'Test Logical: Str()' )

Return ( Nil )


METHOD Test_StrSql() CLASS Test_Logical

    ::Assert():Equals( '1', .T.:StrSql(), "Test StrSql()")
    ::Assert():Equals( '', .F.:StrSql(), "Test StrSql()")

Return ( Nil )


METHOD Test_ValType() CLASS Test_Logical

    ::Assert():Equals( 'L', .T.:ValType(), 'Test Logical: ValType()' )
    
Return ( Nil )


METHOD Test_Value() CLASS Test_Logical

    ::Assert():Equals( .T., .T.:Value(), 'Test Logical: Value()' )
    ::Assert():Equals( .T., Nil:Value(.T.), 'Test Logical: Value()' )
    ::Assert():Equals( .F., Nil:Value(.F.), 'Test Logical: Value()' )

Return ( Nil )