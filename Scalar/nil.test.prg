//TODO: Testear el resto de tipos de dato, faltar?í incluir el m?®todo value en cada tipo de dato scalar.

#INCLUDE 'hbclass.ch'
#INCLUDE 'test.ch'

CREATE CLASS Test_NIL FROM TestCase

    EXPORTED:
        DATA aCategories AS ARRAY INIT { TEST_CORE }

        METHOD Test_Empty()        
        METHOD Test_Nil()        
        METHOD Test_NotEmpty()
        METHOD Test_ValType()
        METHOD Test_Value()

END CLASS


METHOD Test_Empty() CLASS Test_NIL

    ::Assert():True( Nil:Empty(), 'Test Nil: Empty()' )

Return ( Nil )


METHOD Test_Nil() CLASS Test_NIL

    ::Assert():equals( 'Nil', Nil:Str(), 'Test Nil: Str()')

Return ( Nil )


METHOD Test_NotEmpty() CLASS Test_NIL

    ::Assert():False( Nil:NotEmpty(), 'Test Nil: NotEmpty()' )

Return ( Nil )


METHOD Test_ValType() CLASS Test_NIL

    ::Assert():Equals( 'U' , Nil:ValType() , 'Test Nil: ValType()' )

Return( Nil )


METHOD Test_Value() CLASS Test_NIL

    ::Assert():Equals( '' , Nil:Value('') , 'Test Nil: Value()' )

Return( Nil )