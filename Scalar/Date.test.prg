#include 'hbclass.ch'
#INCLUDE 'test.ch'
#include 'date.inc'

CLASS Test_Date FROM TestCase

    EXPORTED:
        DATA aCategories INIT {TEST_CORE}

        METHOD Test_AddDay()
        METHOD Test_AddMonth()
        METHOD Test_AddWeek()
        METHOD Test_AddYear()
        METHOD Test_DateDayOfWeek()
        METHOD Test_Day()
        METHOD Test_DayBetween()
        METHOD Test_DayOfnWeekOfMonth()
        METHOD Test_DiffDays()
        METHOD Test_Dow()
        METHOD Test_FirstDayOfMonth()
        METHOD Test_FirstDayOfWeek()
        METHOD Test_FirstDayOfWeekOfMonth()
        METHOD Test_FirstDayOfWeekOfYear()
        METHOD Test_FirstDayOfYear()
        METHOD Test_IsEmpty()
        METHOD Test_LastDayOfMonth()
        METHOD Test_LastDayOfWeek()
        METHOD Test_LastDayOfWeekOfMonth()
        METHOD Test_LastDayOfWeekOfYear()
        METHOD Test_LastDayOfYear()
        METHOD Test_Month()
        METHOD Test_NameOfMonth()
        METHOD Test_NameOfWeekDay()
        METHOD Test_NotEmpty()
        METHOD Test_Str()
        METHOD Test_StrFormat()
        METHOD Test_StrFormatRange()
        METHOD Test_StrSql()
        METHOD Test_StrSqlQuoted()
        METHOD Test_SubDay()
        METHOD Test_SubMonth()
        METHOD Test_SubWeek()
        METHOD Test_SubYear()
        METHOD Test_Tomorrow()
        METHOD Test_Week()
        METHOD Test_Year()
        METHOD Test_Yesterday()

END CLASS


METHOD Test_AddDay( ) CLASS Test_Date

    ::Assert():Equals( 0d20220101, 0d20210101:AddDay( 365 ),    'Test Date: AddDay()' )
    ::Assert():Equals( 0d20201231, 0d20200101:AddDay( 365 ),    'Test Date: AddDay()' ) // bisiesto
    ::Assert():Equals( 0d20200102, 0d20200101:AddDay( ),        'Test Date: AddDay()' )

Return ( Nil )


METHOD Test_AddMonth( ) CLASS Test_Date

    ::Assert():Equals( 0d20210401, 0d20210101:AddMonth( 3 ),   'Test Date: AddMonth()' )
    ::Assert():Equals( 0d20200229, 0d20191231:AddMonth( 2 ),   'Test Date: AddMonth()' ) // A??isiesto
    ::Assert():Equals( 0d20200201, 0d20200101:AddMonth( ),     'Test Date: AddMonth()' )

Return ( Nil )


METHOD Test_AddWeek( ) CLASS Test_Date

    ::Assert():Equals( 0d20200115, 0d20200101:AddWeek( 2 ), 'Test Date: AddWeek()' )
    ::Assert():Equals( 0d20200108, 0d20200101:AddWeek( ),   'Test Date: AddWeek()' )

Return ( Nil )


METHOD Test_AddYear( ) CLASS Test_Date

    ::Assert():Equals( 0d20240101, 0d20210101:AddYear( 3 ),   'Test Date: AddYear()' )
    ::Assert():Equals( 0d20220228, 0d20200229:AddYear( 2 ),   'Test Date: AddYear()' ) // Bisiesto
    ::Assert():Equals( 0d20210101, 0d20200101:AddYear( ),     'Test Date: AddYear()' )

Return ( Nil )


METHOD Test_DateDayOfWeek() CLASS Test_Date
    
    ::Assert():Equals( 0d20220704, 0d20220707:DateDayOfWeek('lun'),     'Test Date: DateDayOfWeek()' )
    ::Assert():Equals( 0d20220705, 0d20220707:DateDayOfWeek('mar'),     'Test Date: DateDayOfWeek()' )
    ::Assert():Equals( 0d20220706, 0d20220707:DateDayOfWeek('mie'),     'Test Date: DateDayOfWeek()' )
    ::Assert():Equals( 0d20220707, 0d20220707:DateDayOfWeek('jue'),     'Test Date: DateDayOfWeek()' )
    ::Assert():Equals( 0d20220708, 0d20220707:DateDayOfWeek('vie'),     'Test Date: DateDayOfWeek()' )
    ::Assert():Equals( 0d20220709, 0d20220707:DateDayOfWeek('sab'),     'Test Date: DateDayOfWeek()' )
    ::Assert():Equals( 0d20220710, 0d20220707:DateDayOfWeek('dom'),     'Test Date: DateDayOfWeek()' )

    ::Assert():Equals( 0d20220703, 0d20220707:DateDayOfWeek('dom',.T.), 'Test Date: DateDayOfWeek()' )
    ::Assert():Equals( 0d20220704, 0d20220707:DateDayOfWeek('lun',.T.), 'Test Date: DateDayOfWeek()' )
    ::Assert():Equals( 0d20220705, 0d20220707:DateDayOfWeek('mar',.T.), 'Test Date: DateDayOfWeek()' )
    ::Assert():Equals( 0d20220706, 0d20220707:DateDayOfWeek('mie',.T.), 'Test Date: DateDayOfWeek()' )
    ::Assert():Equals( 0d20220707, 0d20220707:DateDayOfWeek('jue',.T.), 'Test Date: DateDayOfWeek()' )
    ::Assert():Equals( 0d20220708, 0d20220707:DateDayOfWeek('vie',.T.), 'Test Date: DateDayOfWeek()' )
    ::Assert():Equals( 0d20220709, 0d20220707:DateDayOfWeek('sab',.T.), 'Test Date: DateDayOfWeek()' )

Return ( Nil )


METHOD Test_Day() CLASS Test_Date

    ::Assert():Equals( 1, 0d20200201:Day(), 'Test Date: Day()' )

Return ( Nil )


METHOD Test_DayBetween() CLASS Test_Date

    ::Assert():True(    0d20220825:DayBetween(0d20220810,0d20220830), "Test Date: DayBetween()" )
    ::Assert():True(    0d20220825:DayBetween(0d20220825,0d20220830), "Test Date: DayBetween()" )
    ::Assert():True(    0d20220825:DayBetween(0d20220810,0d20220825), "Test Date: DayBetween()" )
    ::Assert():True(    0d20220825:DayBetween(0d20220825,0d20220825), "Test Date: DayBetween()" )
    ::Assert():True(    0d20220825:DayBetween(0d00000000,0d20220831), "Test Date: DayBetween()" )
    ::Assert():False(   0d20220825:DayBetween(0d20220810,0d20220824), "Test Date: DayBetween()" )
    ::Assert():False(   0d20220825:DayBetween(0d00000000,0d20220824), "Test Date: DayBetween()" )
    ::Assert():False(   0d20220825:DayBetween(0d20220824,0d00000000), "Test Date: DayBetween()" )
    ::Assert():False(   0d20220825:DayBetween(0d00000000,0d00000000), "Test Date: DayBetween()" )

Return ( Nil )


METHOD Test_DayOfnWeekOfMonth() CLASS Test_Date

    ::Assert():Equals( 0d20220718,  0d20220710:DayOfnWeekOfMonth(3, 'lun'),     'Test Date: DayOfnWeekOfMonth' )
    ::Assert():Equals( 0d20220710,  0d20220710:DayOfnWeekOfMonth(2, 'dom'),     'Test Date: DayOfnWeekOfMonth' )
    ::Assert():Equals( 0d20220731,  0d20220710:DayOfnWeekOfMonth(5, 'dom'),     'Test Date: DayOfnWeekOfMonth' )
    ::Assert():Equals( nil,         0d20220710:DayOfnWeekOfMonth(6, 'lun'),     'Test Date: DayOfnWeekOfMonth' )
    ::Assert():Equals( nil,         0d20220710:DayOfnWeekOfMonth(),             'Test Date: DayOfnWeekOfMonth' )
    ::Assert():Equals( nil,         0d20220710:DayOfnWeekOfMonth(1, 'test'),    'Test Date: DayOfnWeekOfMonth' )

Return ( Nil )


METHOD Test_DiffDays() CLASS Test_Date

    ::Assert():Equals(         10, 0d20200101:DiffDays( 0d20200111 ),   'Test Date: DiffDays()' )
    ::Assert():Equals(        -10, 0d20200101:DiffDays( 0d20191222 ),   'Test Date: DiffDays()' )
    ::Assert():Equals( Date() - 0d20200101, 0d20200101:DiffDays( ),     'Test Date: DiffDays()' )
    ::Assert():Equals(          0, 0d20200101:DiffDays( 0d20200101 ),   'Test Date: DiffDays()' )

Return ( Nil )


METHOD Test_Dow() CLASS Test_Date

    ::Assert():Equals( 1, 0d20220725:Dow(),     'Test Date: Dow()' )
    ::Assert():Equals( 2, 0d20220726:Dow(),     'Test Date: Dow()' )
    ::Assert():Equals( 3, 0d20220727:Dow(),     'Test Date: Dow()' )
    ::Assert():Equals( 4, 0d20220728:Dow(),     'Test Date: Dow()' )
    ::Assert():Equals( 5, 0d20220729:Dow(),     'Test Date: Dow()' )
    ::Assert():Equals( 6, 0d20220730:Dow(),     'Test Date: Dow()' )
    ::Assert():Equals( 7, 0d20220731:Dow(),     'Test Date: Dow()' )

    ::Assert():Equals( 1, 0d20220724:Dow(.T.),  'Test Date: Dow()' )
    ::Assert():Equals( 2, 0d20220725:Dow(.T.),  'Test Date: Dow()' )
    ::Assert():Equals( 3, 0d20220726:Dow(.T.),  'Test Date: Dow()' )
    ::Assert():Equals( 4, 0d20220727:Dow(.T.),  'Test Date: Dow()' )
    ::Assert():Equals( 5, 0d20220728:Dow(.T.),  'Test Date: Dow()' )
    ::Assert():Equals( 6, 0d20220729:Dow(.T.),  'Test Date: Dow()' )
    ::Assert():Equals( 7, 0d20220730:Dow(.T.),  'Test Date: Dow()' )

Return ( Nil )


METHOD Test_FirstDayOfMonth() CLASS Test_Date
    
    ::Assert():Equals( 0d20200701, 0d20200710:FirstDayOfMonth(), 'Test Date: FirstDayOfMonth()' )
    
Return ( Nil )


METHOD Test_FirstDayOfWeek() CLASS Test_Date
    
    ::Assert():Equals( 0d20220704, 0d20220704:FirstDayOfWeek(), 'Test Date: FirstDayOfWeek()' )
    ::Assert():Equals( 0d20220704, 0d20220705:FirstDayOfWeek(), 'Test Date: FirstDayOfWeek()' )
    ::Assert():Equals( 0d20220704, 0d20220706:FirstDayOfWeek(), 'Test Date: FirstDayOfWeek()' )
    ::Assert():Equals( 0d20220704, 0d20220707:FirstDayOfWeek(), 'Test Date: FirstDayOfWeek()' )
    ::Assert():Equals( 0d20220704, 0d20220708:FirstDayOfWeek(), 'Test Date: FirstDayOfWeek()' )
    ::Assert():Equals( 0d20220704, 0d20220709:FirstDayOfWeek(), 'Test Date: FirstDayOfWeek()' )
    ::Assert():Equals( 0d20220704, 0d20220710:FirstDayOfWeek(), 'Test Date: FirstDayOfWeek()' )

    ::Assert():Equals( 0d20220703, 0d20220704:FirstDayOfWeek(.T.), 'Test Date: FirstDayOfWeek()' )
    ::Assert():Equals( 0d20220703, 0d20220705:FirstDayOfWeek(.T.), 'Test Date: FirstDayOfWeek()' )
    ::Assert():Equals( 0d20220703, 0d20220706:FirstDayOfWeek(.T.), 'Test Date: FirstDayOfWeek()' )
    ::Assert():Equals( 0d20220703, 0d20220707:FirstDayOfWeek(.T.), 'Test Date: FirstDayOfWeek()' )
    ::Assert():Equals( 0d20220703, 0d20220708:FirstDayOfWeek(.T.), 'Test Date: FirstDayOfWeek()' )
    ::Assert():Equals( 0d20220703, 0d20220709:FirstDayOfWeek(.T.), 'Test Date: FirstDayOfWeek()' )
    ::Assert():Equals( 0d20220710, 0d20220710:FirstDayOfWeek(.T.), 'Test Date: FirstDayOfWeek()' )
    
Return ( Nil )


METHOD Test_FirstDayOfWeekOfMonth() CLASS Test_Date

    ::Assert():Equals( 0d20220704,  0d20220710:FirstDayOfWeekOfMonth('lun'),     'Test Date: FirstDayOfWeekOfMonth' )
    ::Assert():Equals( 0d20220705,  0d20220710:FirstDayOfWeekOfMonth('mar'),     'Test Date: FirstDayOfWeekOfMonth' )
    ::Assert():Equals( 0d20220706,  0d20220710:FirstDayOfWeekOfMonth('mié'),     'Test Date: FirstDayOfWeekOfMonth' )
    ::Assert():Equals( 0d20220707,  0d20220710:FirstDayOfWeekOfMonth('ju'),      'Test Date: FirstDayOfWeekOfMonth' )
    ::Assert():Equals( 0d20220701,  0d20220710:FirstDayOfWeekOfMonth('VIer'),    'Test Date: FirstDayOfWeekOfMonth' )
    ::Assert():Equals( 0d20220702,  0d20220710:FirstDayOfWeekOfMonth('SÁbado'),  'Test Date: FirstDayOfWeekOfMonth' )
    ::Assert():Equals( 0d20220703,  0d20220710:FirstDayOfWeekOfMonth('Dom'),     'Test Date: FirstDayOfWeekOfMonth' )
    ::Assert():Equals( nil,         0d20220710:FirstDayOfWeekOfMonth(),          'Test Date: FirstDayOfWeekOfMonth' )
    ::Assert():Equals( nil,         0d20220710:FirstDayOfWeekOfMonth('test'),    'Test Date: FirstDayOfWeekOfMonth' )

Return ( Nil )


METHOD Test_FirstDayOfWeekOfYear() CLASS Test_Date

    ::Assert():Equals( 0d20220103, 0d20220710:FirstDayOfWeekOfYear('lun'),    'Test Date: FirstDayOfWeekOfYear' )
    ::Assert():Equals( 0d20220104, 0d20220710:FirstDayOfWeekOfYear('mar'),    'Test Date: FirstDayOfWeekOfYear' )
    ::Assert():Equals( 0d20220105, 0d20220710:FirstDayOfWeekOfYear('mié'),    'Test Date: FirstDayOfWeekOfYear' )
    ::Assert():Equals( 0d20220106, 0d20220710:FirstDayOfWeekOfYear('ju'),     'Test Date: FirstDayOfWeekOfYear' )
    ::Assert():Equals( 0d20220107, 0d20220710:FirstDayOfWeekOfYear('VIer'),   'Test Date: FirstDayOfWeekOfYear' )
    ::Assert():Equals( 0d20220101, 0d20220710:FirstDayOfWeekOfYear('SÁbado'), 'Test Date: FirstDayOfWeekOfYear' )
    ::Assert():Equals( 0d20220102, 0d20220710:FirstDayOfWeekOfYear('Dom'),    'Test Date: FirstDayOfWeekOfYear' )
    ::Assert():Equals( nil,        0d20220710:FirstDayOfWeekOfYear(),         'Test Date: FirstDayOfWeekOfYear' )
    ::Assert():Equals( nil,        0d20220710:FirstDayOfWeekOfYear('test'),   'Test Date: FirstDayOfWeekOfYear' )

    
Return ( Nil )


METHOD Test_FirstDayOfYear() CLASS Test_Date

    ::Assert():Equals( 0d20200101, 0d20200710:FirstDayOfYear(), 'Test Date: FirstDayOfYear()' )

Return ( Nil )


METHOD Test_IsEmpty() CLASS Test_Date

    ::Assert():True( 0d00000000:ISEmpty(),          'Test Date: IsEmpty()' )
    ::Assert():False( 0d20200101:ISEmpty(),         'Test Date: IsEmpty()' )
    ::Assert():True( cTod(''):ISEmpty(),            'Test Date: IsEmpty()' )
    ::Assert():False( cTod('01/01/2020'):ISEmpty(), 'Test Date: IsEmpty()' )
    ::Assert():True( cTod('  /  /    '):ISEmpty(),  'Test Date: IsEmpty()' )

Return ( Nil )


METHOD Test_LastDayOfMonth() CLASS Test_Date

    ::Assert():Equals( 0d20200731, 0d20200710:LastDayOfMonth(), 'Test Date: LastDayOfMonth()' )
    ::Assert():Equals( 0d20200229, 0d20200213:LastDayOfMonth(), 'Test Date: LastDayOfMonth()' )  // bisiesto
    ::Assert():Equals( 0d20210228, 0d20210213:LastDayOfMonth(), 'Test Date: LastDayOfMonth()' )

Return ( Nil )


METHOD Test_LastDayOfWeek() CLASS Test_Date

    ::Assert():Equals( 0d20200712, 0d20200710:LastDayOfWeek(),      'Test Date: LastDayOfWeek()' )
    ::Assert():Equals( 0d20220710, 0d20220707:LastDayOfWeek(),      'Test Date: LastDayOfWeek()' )
    ::Assert():Equals( 0d20220709, 0d20220707:LastDayOfWeek(.t.),   'Test Date: LastDayOfWeek()' )

Return ( Nil )


METHOD Test_LastDayOfWeekOfMonth() CLASS Test_Date

    ::Assert():Equals( 0d20220829, 0d20220810:LastDayOfWeekOfMonth('lun'),    'Test Date: LastDayOfWeekOfMonth' )
    ::Assert():Equals( 0d20220830, 0d20220810:LastDayOfWeekOfMonth('mar'),    'Test Date: LastDayOfWeekOfMonth' )
    ::Assert():Equals( 0d20220831, 0d20220810:LastDayOfWeekOfMonth('mié'),    'Test Date: LastDayOfWeekOfMonth' )
    ::Assert():Equals( 0d20220825, 0d20220810:LastDayOfWeekOfMonth('ju'),     'Test Date: LastDayOfWeekOfMonth' )
    ::Assert():Equals( 0d20220826, 0d20220810:LastDayOfWeekOfMonth('VIer'),   'Test Date: LastDayOfWeekOfMonth' )
    ::Assert():Equals( 0d20220827, 0d20220810:LastDayOfWeekOfMonth('SÁbado'), 'Test Date: LastDayOfWeekOfMonth' )
    ::Assert():Equals( 0d20220828, 0d20220810:LastDayOfWeekOfMonth('Dom'),    'Test Date: LastDayOfWeekOfMonth' )
    ::Assert():Equals( nil,        0d20220710:LastDayOfWeekOfMonth(),         'Test Date: LastDayOfWeekOfMonth' )
    ::Assert():Equals( nil,        0d20220710:LastDayOfWeekOfMonth('test'),   'Test Date: LastDayOfWeekOfMonth' )

Return ( Nil )


METHOD Test_LastDayOfWeekOfYear() CLASS Test_Date

    ::Assert():Equals( 0d20221226, 0d20220710:LastDayOfWeekOfYear('lun'),    'Test Date: LastDayOfWeekOfYear' )
    ::Assert():Equals( 0d20221227, 0d20220710:LastDayOfWeekOfYear('mar'),    'Test Date: LastDayOfWeekOfYear' )
    ::Assert():Equals( 0d20221228, 0d20220710:LastDayOfWeekOfYear('mié'),    'Test Date: LastDayOfWeekOfYear' )
    ::Assert():Equals( 0d20221229, 0d20220710:LastDayOfWeekOfYear('ju'),     'Test Date: LastDayOfWeekOfYear' )
    ::Assert():Equals( 0d20221230, 0d20220710:LastDayOfWeekOfYear('VIer'),   'Test Date: LastDayOfWeekOfYear' )
    ::Assert():Equals( 0d20221231, 0d20220710:LastDayOfWeekOfYear('SÁbado'), 'Test Date: LastDayOfWeekOfYear' )
    ::Assert():Equals( 0d20221225, 0d20220710:LastDayOfWeekOfYear('Dom'),    'Test Date: LastDayOfWeekOfYear' )
    ::Assert():Equals( nil,        0d20220710:LastDayOfWeekOfYear(),         'Test Date: LastDayOfWeekOfYear' )
    ::Assert():Equals( nil,        0d20220710:LastDayOfWeekOfYear('test'),   'Test Date: LastDayOfWeekOfYear' )


Return ( Nil )


METHOD Test_LastDayOfYear() CLASS Test_Date

    ::Assert():Equals( 0d20201231, 0d20200710:LastDayOfYear(), 'Test Date: FirstDayOfYear()' )

Return ( Nil )


METHOD Test_Month() CLASS Test_Date

    ::Assert():Equals( 2, 0d20200201:Month(), 'Test Date: Month()' )

Return ( Nil )


METHOD Test_NameOfMonth() CLASS Test_Date
    Local cLangOld
    
    REQUEST HB_LANG_EN
    cLangOld := HB_LangSelect( "EN" )
    ::Assert():Equals('January',    0d20200101:NameOfMonth(), 'Test Date: NameOfMonth()' )
    ::Assert():Equals('December',   0d20201201:NameOfMonth(), 'Test Date: NameOfMonth()' )
    
    REQUEST HB_LANG_ES
    HB_LangSelect( "ES" )
    ::Assert():Equals('Enero',      0d20200101:NameOfMonth(), 'Test Date: NameOfMonth()' )
    ::Assert():Equals('Diciembre',  0d20201201:NameOfMonth(), 'Test Date: NameOfMonth()' )
    
    REQUEST HB_LANG_FR
    HB_LangSelect( "FR" )
    ::Assert():Equals('Janvier',            0d20200101:NameOfMonth(), 'Test Date: NameOfMonth()' )
    ::Assert():Equals('D'+Chr(130)+'cembre',0d20201201:NameOfMonth(), 'Test Date: NameOfMonth()' )
    
    HB_LangSelect( cLangOld )	

Return ( Nil )


METHOD Test_NameOfWeekDay() CLASS Test_Date

    Local cLangOld
    
    REQUEST HB_LANG_EN
    cLangOld := HB_LangSelect( "EN" )
    
    ::Assert():Equals('Wednesday',0d20200101:NameOfWeekDay(), 'Test Date: NameOfWeekDay()' )
    ::Assert():Equals('Tuesday',  0d20201201:NameOfWeekDay(), 'Test Date: NameOfWeekDay()' )
    
    REQUEST HB_LANG_ES
    HB_LangSelect( "ES" )
    ::Assert():Equals('Mi'+Chr(130)+'rcoles',   0d20200101:NameOfWeekDay(),    'Test Date: NameOfWeekDay()' )
    ::Assert():Equals('Martes',                 0d20201201:NameOfWeekDay(),    'Test Date: NameOfWeekDay()' )
        
    REQUEST HB_LANG_FR
    HB_LangSelect( "FR" )
    ::Assert():Equals('Mercredi',0d20200101:NameOfWeekDay(), 'Test Date: NameOfWeekDay()' )
    ::Assert():Equals('Mardi',   0d20201201:NameOfWeekDay(), 'Test Date: NameOfWeekDay()' )
    
    HB_LangSelect( cLangOld )	

Return ( Nil )


METHOD Test_NotEmpty() CLASS Test_Date

    ::Assert():False( 0d00000000:NotEmpty(),        'Test Date: NotEmpty()' )
    ::Assert():True( 0d20200101:NotEmpty(),         'Test Date: NotEmpty()' )
    ::Assert():False( cTod(''):NotEmpty(),          'Test Date: NotEmpty()' )
    ::Assert():True( cTod('01/01/2020'):NotEmpty(), 'Test Date: NotEmpty()' )

Return ( Nil )


METHOD Test_Str() CLASS Test_Date

    ::Assert():Equals( '01/01/2020', 0d20200101:Str(),      'Test Date: Str()' )
    ::Assert():Equals( FECHAVACIA, 0d00000000:Str(),        'Test Date: Str()' ) 
    ::Assert():Equals( FECHAVACIA, ctod('  /  /  '):Str(),  'Test Date: Str()' )
    ::Assert():Equals( FECHAVACIA, ctod('/  /'):Str(),      'Test Date: Str()' )
    ::Assert():Equals( FECHAVACIA, ctod('  /  /'):Str(),    'Test Date: Str()' )
    ::Assert():Equals( FECHAVACIA, ctod('/  /  '):Str(),    'Test Date: Str()' )
    ::Assert():Equals( FECHAVACIA, ctod('//'):Str(),        'Test Date: Str()' )
    ::Assert():Equals( FECHAVACIA, ctod(''):Str(),          'Test Date: Str()' )
    ::Assert():Equals( FECHAVACIA, ctod('123456'):Str(),    'Test Date: Str()' )
    ::Assert():Equals( FECHAVACIA, ctod('abcdef'):Str(),    'Test Date: Str()' ) 

Return ( Nil )


METHOD Test_StrFormat() CLASS Test_Date

    ::Assert():Equals( 'Miércoles, 1 de Enero del 2020',    0d20200101:StrFormat( ),                                'Test Date: StrFormat()' )
    ::Assert():Equals( 'Miércoles, 1 de Enero del 2020',    0d20200101:StrFormat( 'Ssss, dd de Mmmm del aaaa' ),    'Test Date: StrFormat()' )
    ::Assert():Equals( 'miércoles, 1 de Enero del 2020',    0d20200101:StrFormat( 'ssss, dd de Mmmm del aaaa' ),    'Test Date: StrFormat()' )
    ::Assert():Equals( 'Mié, 1 de Enero del 2020',          0d20200101:StrFormat( 'Sss, dd de Mmmm del aaaa' ),     'Test Date: StrFormat()' )
    ::Assert():Equals( 'mié, 1 de Enero del 2020',          0d20200101:StrFormat( 'sss, dd de Mmmm del aaaa' ),     'Test Date: StrFormat()' )
    ::Assert():Equals( 'Mi, 1 de Enero del 2020',           0d20200101:StrFormat( 'Ss, dd de Mmmm del aaaa' ),      'Test Date: StrFormat()' )
    ::Assert():Equals( 'mi, 1 de Enero del 2020',           0d20200101:StrFormat( 'ss, dd de Mmmm del aaaa' ),      'Test Date: StrFormat()' )
    ::Assert():Equals( 'MIÉRCOLES, 1 de Enero del 2020',    0d20200101:StrFormat( 'SSSS, dd de Mmmm del aaaa' ),    'Test Date: StrFormat()' )
    ::Assert():Equals( 'MIÉ, 1 de Enero del 2020',          0d20200101:StrFormat( 'SSS, dd de Mmmm del aaaa' ),     'Test Date: StrFormat()' )
    ::Assert():Equals( 'MI, 1 de Enero del 2020',           0d20200101:StrFormat( 'SS, dd de Mmmm del aaaa' ),      'Test Date: StrFormat()' )
    ::Assert():Equals( '01 de Enero del 20',                0d20200101:StrFormat('0d de Mmmm del aa'),              'Test Date: StrFormat()' )
    ::Assert():Equals( '01 de 1 del 20',                    0d20200101:StrFormat( '0d de mm del aa'),               'Test Date: StrFormat()' )
    ::Assert():Equals( '01 de 01 de 2020',                  0d20200101:StrFormat( '0d de 0m de aaaa'),              'Test Date: StrFormat()' )
    ::Assert():Equals( '1 de ene de 2020',                  0d20200101:StrFormat( 'dd de mmm de aaaa'),             'Test Date: StrFormat()' )
    ::Assert():Equals( '1 de ENE de 2020',                  0d20200101:StrFormat( 'dd de MMM de aaaa'),             'Test Date: StrFormat()' )
    ::Assert():Equals( '20200201',                          0d20200201:StrFormat( 'aaaa0m0d'),                      'Test Date: StrFormat()' )
    ::Assert():Equals( 'test sin nada',                     0d20200201:StrFormat( 'test sin nada'),                 'Test Date: StrFormat()' )

Return ( Nil )


METHOD Test_StrFormatRange() CLASS Test_Date
    Local aBegin := {'Desde el 0d',' de Mmm', ' del aa'}
    Local aEnd   := { ' hasta el 0d', ' de Mmm', ' del aa'}

    ::Assert():Equals( 'del 1 de Enero del 2020',                               0d20200101:StrFormatRange('test character in date'),        'Test Date: StrFormatRange()' )
    ::Assert():Equals( 'del 1 de Enero del 2020',                               0d20200101:StrFormatRange(0d20200101),                      'Test Date: StrFormatRange()' )
    ::Assert():Equals( 'del 1 al 2 de Enero del 2020',                          0d20200101:StrFormatRange(0d20200102),                      'Test Date: StrFormatRange()' )
    ::Assert():Equals( 'del 1 de Enero al 3 de Febrero del 2020',               0d20200101:StrFormatRange(0d20200203),                      'Test Date: StrFormatRange()' )
    ::Assert():Equals( 'del 1 de Enero del 2020 al 3 de Febrero del 2021',      0d20200101:StrFormatRange(0d20210203),                      'Test Date: StrFormatRange()' )
    ::Assert():Equals( 'Desde el 01 de Ene del 20 hasta el 03 de Feb del 21',   0d20200101:StrFormatRange(0d20210203, aBegin, aEnd),        'Test Date: StrFormatRange()' )
    ::Assert():Equals( 'Desde el 01 de Ene del 20',                             0d20200101:StrFormatRange(0d20210203, aBegin,{'','',''}),   'Test Date: StrFormatRange()' )
    ::Assert():Equals( ' hasta el 03 de Feb del 21',                            0d20200101:StrFormatRange(0d20210203, {'','',''}, aEnd),    'Test Date: StrFormatRange()' )
    
 Return ( Nil )


METHOD Test_StrSql() CLASS Test_Date

    ::Assert():Equals( '2020-01-01', 0d20200101:StrSql(), 'Test Date: StrSql()')
    ::Assert():Equals( '0000-00-00', 0d00000000:StrSql(), 'Test Date: StrSql()')

Return ( Nil )


METHOD Test_StrSqlQuoted() CLASS Test_Date

    ::Assert():Equals( "'2020-01-01'", 0d20200101:StrSqlQuoted(), 'Test Date: StrSqlQuoted()')
    ::Assert():Equals( "'0000-00-00'", 0d00000000:StrSqlQuoted(), 'Test Date: StrSqlQuoted()')

Return ( Nil )


METHOD Test_SubDay( ) CLASS Test_Date

    ::Assert():Equals( 0d20210101, 0d20220101:SubDay( 365 ),    'Test Date: SubDay()' )
    ::Assert():Equals( 0d20200101, 0d20201231:SubDay( 365 ),    'Test Date: SubDay()' ) // Bisiesto
    ::Assert():Equals( 0d20191231, 0d20200101:SubDay( ),        'Test Date: SubDay()' )

Return ( Nil )


METHOD Test_SubMonth( ) CLASS Test_Date

    ::Assert():Equals( 0d20211001, 0d20220101:SubMonth( 3 ),   'Test Date: SubMonth()' )
    ::Assert():Equals( 0d20191130, 0d20201231:SubMonth( 13 ),  'Test Date: SubMonth()' ) // Mes de 30 días desde mes con 31
    ::Assert():Equals( 0d20200201, 0d20200301:SubMonth( ),     'Test Date: SubMonth()' )

Return ( Nil )


METHOD Test_SubWeek( ) CLASS Test_Date

    ::Assert():Equals( 0d20191218, 0d20200101:SubWeek( 2 ), 'Test Date: SubWeek()' )
    ::Assert():Equals( 0d20191225, 0d20200101:SubWeek( ) ,  'Test Date: SubWeek()' )

Return ( Nil )


METHOD Test_SubYear( ) CLASS Test_Date

    ::Assert():Equals( 0d20190101, 0d20220101:SubYear( 3 ),   'Test Date: SubYear()' )
    ::Assert():Equals( 0d20150228, 0d20200229:SubYear( 5 ),   'Test Date: SubYear()' ) // Bisiesto
    ::Assert():Equals( 0d20190301, 0d20200301:SubYear( ),     'Test Date: SubYear()' )

Return ( Nil )


METHOD Test_Tomorrow( ) CLASS Test_Date

    ::Assert():Equals( 0d20200102, 0d20200101:Tomorrow( ), 'Test Date: Tomorrow()' )

Return ( Nil )


METHOD Test_Week() CLASS Test_Date

    ::Assert():Equals( 5, 0d20200201:Week(),    'Test Date: Week()' )
    ::Assert():Equals( 53, 0d20201230:Week(),   'Test Date: Week()' )

Return ( Nil )


METHOD Test_Year() CLASS Test_Date

    ::Assert():Equals( 2020, 0d20200101:Year(), 'Test Date: Year()' )

Return ( Nil )


METHOD Test_Yesterday() CLASS Test_Date

    ::Assert():Equals( 0d20191231, 0d20200101:Yesterday( ), 'Test Date: Yesterday()' )

Return ( Nil )