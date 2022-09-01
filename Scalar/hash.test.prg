#INCLUDE 'hbclass.ch'
#INCLUDE 'test.ch'

CREATE CLASS Test_Hash FROM TestCase

    EXPORTED:
        DATA aCategories AS ARRAY INIT { TEST_CORE }

        METHOD Test_Empty()
        METHOD Test_HasKey()
        METHOD Test_HasKeys()
        METHOD Test_Len()
        METHOD Test_NotEmpty()
        METHOD Test_NotHasKey()
        METHOD Test_Str()
        METHOD Test_UpperKeys()
        METHOD Test_ValType()
        METHOD Test_Value()
        METHOD Test_ValueOfKey()
        
END CLASS


METHOD Test_Empty() CLASS Test_Hash

    ::Assert():True( {}:Empty(), 'Test Hash: Empty()')
    ::Assert():False( {'uno'=>1}:Empty(), 'Test Hash: Empty()')

Return ( Nil )


METHOD Test_HasKey() CLASS Test_Hash

    ::Assert():True( {'uno' => 1, 'dos' => 2 }:HasKey( 'uno' ), 'Test Hash: HasKey()' )
    ::Assert():False( {'uno' => 1, 'dos' => 2 }:HasKey( 'tres' ), 'Test Hash: HasKey()' )
    ::Assert():False( {'uno' => 1, 'dos' => 2 }:HasKey( 3 ), 'Test Hash: HasKey()' )

Return ( Nil )


METHOD Test_HasKeys() CLASS Test_Hash

    ::Assert():False( {'uno' => 1, 'dos' => 2 }:HasKeys( ), 'Test Hash: HasKeys()' )
    ::Assert():True( {'uno' => 1, 'dos' => 2 }:HasKeys(  'uno' ), 'Test Hash: HasKeys()' )
    ::Assert():True( {'uno' => 1, 'dos' => 2 }:HasKeys( 'uno','dos' ), 'Test Hash: HasKeys()' )
    ::Assert():False( {'uno' => 1, 'dos' => 2 }:HasKeys( 'uno','dos','tres' ), 'Test Hash: HasKeys()' )
    ::Assert():False( {'uno' => 1, 'dos' => 2 }:HasKeys( 'uno',2 ), 'Test Hash: HasKeys()' )

Return ( Nil )


METHOD Test_Len() CLASS Test_Hash

    ::Assert():Equals( 1 , {'key'=>'valor'}:Len() , 'Test Hash: Len()' )
    ::Assert():Equals( 2 , {'key'=>'valor', 'key2'=>'valor2'}:Len() , 'Test Hash: Len()' )

Return ( Nil )


METHOD Test_NotEmpty() CLASS Test_Hash

    ::Assert():False( {}:NotEmpty(), 'Test Hash: NotEmpty()')
    ::Assert():True( {'uno'=>1}:NotEmpty(), 'Test Hash: NotEmpty()')

Return ( Nil )


METHOD Test_NotHasKey() CLASS Test_Hash

    ::Assert():False( {'uno' => 1, 'dos' => 2 }:NotHasKey( 'uno' ), 'Test Hash: NotHasKey()' )
    ::Assert():True( {'uno' => 1, 'dos' => 2 }:NotHasKey( 'tres' ), 'Test Hash: NotHasKey()' )
    ::Assert():True( {'uno' => 1, 'dos' => 2 }:NotHasKey( 3 ), 'Test Hash: NotHasKey()' )

Return ( Nil )


METHOD Test_Str() CLASS Test_Hash

    ::Assert():true( HB_ISSTRING( {'numero'=> 1, 'string'=>'1', 'fecha'=>Date(), 'lógico'=>.T.}:Str() ), 'Test Hash: Str()' )

Return ( Nil )


METHOD Test_UpperKeys() CLASS Test_Hash

    ::Assert():ArrayEquals( {'KEY'=>'valor'} , {'key'=>'valor'}:UpperKeys() , 'Test Hash: UpperKeys()' )

Return( Nil )


METHOD Test_ValType() CLASS Test_Hash

    ::Assert():Equals( 'H' , {'key'=>'valor', 'key2'=>'valor2'}:ValType() , 'Test Hash: ValType()' )

Return( Nil )


METHOD Test_Value() CLASS Test_Hash

    ::Assert():ArrayEquals( {'key'=>'valor'} , {'key'=>'valor'}:Value() , 'Test Hash: Value()' )

Return( Nil )


METHOD Test_ValueOfKey() CLASS Test_Hash

    ::Assert():Null( {'uno'=>'1','dos'=>'2'}:ValueOfKey() , 'Test Hash: ValueOfKey()' )
    ::Assert():Null( {'uno'=>'1','dos'=>'2'}:ValueOfKey('3') , 'Test Hash: ValueOfKey()' )
    ::Assert():Null( {'uno'=>'1','dos'=>'2'}:ValueOfKey(3) , 'Test Hash: ValueOfKey()' )
    ::Assert():Equals( '2', {'uno'=>'1','dos'=>'2'}:ValueOfKey('dos') , 'Test Hash: ValueOfKey()' )
    ::Assert():Equals( 'defecto', {'uno'=>'1','dos'=>'2'}:ValueOfKey(3,'defecto') , 'Test Hash: ValueOfKey()' )

Return( Nil )
