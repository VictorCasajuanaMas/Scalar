#INCLUDE 'hbclass.ch'
#INCLUDE 'test.ch'

CREATE CLASS Test_TimeStamp FROM TestCase

    EXPORTED:
        DATA aCategories INIT {TEST_CORE}

        METHOD Test_Date()
        METHOD Test_Day()
        METHOD Test_Hour()  
        METHOD Test_Minute()
        METHOD Test_Month()  
        METHOD Test_Sec()
        METHOD Test_Str()                                                  
        METHOD Test_Time()
        METHOD Test_ValType()    
        METHOD Test_Year()

END CLASS


METHOD Test_Date() CLASS Test_TimeStamp

    ::Assert():Equals( 0d20200101 , hb_dtot( 0d20200101, "12:34:56.000"):Date() , 'Test TimeStamp: Date()' )

Return( Nil )


METHOD Test_Day() CLASS Test_TimeStamp

    ::Assert():Equals( 3 , hb_dtot( 0d20200203, "12:34:56.000"):Day() , 'Test TimeStamp: Day()' )

Return( Nil )


METHOD Test_Hour() CLASS Test_TimeStamp

    ::Assert():Equals( 12 , hb_dtot( 0d20200101, "12:34:56.000"):Hour() , 'Test TimeStamp: Hour()' )

Return( Nil )


METHOD Test_Minute() CLASS Test_TimeStamp

    ::Assert():Equals( 34 , hb_dtot( 0d20200101, "12:34:56.000"):Minute() , 'Test TimeStamp: Minute()' )

Return( Nil )


METHOD Test_Month() CLASS Test_TimeStamp

    ::Assert():Equals( 2 , hb_dtot( 0d20200201, "12:34:56.000"):Month() , 'Test TimeStamp: Month()' )

Return( Nil )


METHOD Test_Sec() CLASS Test_TimeStamp

    ::Assert():Equals( 56 , hb_dtot( 0d20200101, "12:34:56.000"):Sec() , 'Test TimeStamp: Sec()' )

Return( Nil )


METHOD Test_Str() CLASS Test_TimeStamp

    ::Assert():Equals( '2020-01-01 12:34:56.000', hb_dtot( 0d20200101, "12:34:56.000"):Str(), 'Test TimeStamp: Str()' )

Return ( Nil )


METHOD Test_Time() CLASS Test_TimeStamp

    ::Assert():Equals( "12:34:56" , hb_dtot( 0d20200101, "12:34:56.000"):Time() , 'Test TimeStamp: Time()' )

Return( Nil )


METHOD Test_ValType() CLASS Test_TimeStamp

    ::Assert():Equals( 'T' , hb_dtot( 0d20200101, "12:34:56.000"):ValType() , 'Test TimeStamp: ValType()' )

Return( Nil )


METHOD Test_Year() CLASS Test_TimeStamp

    ::Assert():Equals( 2020 , hb_dtot( 0d20200101, "12:34:56.000"):Year() , 'Test TimeStamp: Year()' )

Return( Nil )






















