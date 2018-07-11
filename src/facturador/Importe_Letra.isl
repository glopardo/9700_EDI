// ------------------- "Importe_Letra" Library -------------------------

var textototal      : A90

var text_1_19[ 20 ] : A20
   text_1_19[  1 ]          = "cero"
   text_1_19[  2 ]          = "un"
   text_1_19[  3 ]          = "dos"
   text_1_19[  4 ]          = "tres"
   text_1_19[  5 ]          = "cuatro"
   text_1_19[  6 ]          = "cinco"
   text_1_19[  7 ]          = "seis"
   text_1_19[  8 ]          = "siete"
   text_1_19[  9 ]          = "ocho"
   text_1_19[ 10 ]          = "nueve"
   text_1_19[ 11 ]          = "diez"
   text_1_19[ 12 ]          = "once"
   text_1_19[ 13 ]          = "doce"
   text_1_19[ 14 ]          = "trece"
   text_1_19[ 15 ]          = "catorce"
   text_1_19[ 16 ]          = "quince"
   text_1_19[ 17 ]          = "dieciseis" 
   text_1_19[ 18 ]          = "diecisiete"
   text_1_19[ 19 ]          = "dieciocho" 
   text_1_19[ 20 ]          = "diecinueve"

var text_10_90[ 9 ] : A20
   text_10_90[ 1 ]          = "diez"
   text_10_90[ 2 ]          = "veinte"
   text_10_90[ 3 ]          = "treinta"
   text_10_90[ 4 ]          = "cuarenta"
   text_10_90[ 5 ]          = "cincuenta"
   text_10_90[ 6 ]          = "sesenta"
   text_10_90[ 7 ]          = "setenta"
   text_10_90[ 8 ]          = "ochenta"
   text_10_90[ 9 ]          = "noventa"

var text_100_900[ 9 ] : A20
   text_100_900[ 1 ]        = "ciento"
   text_100_900[ 2 ]        = "doscientos"
   text_100_900[ 3 ]        = "trescientos"
   text_100_900[ 4 ]        = "cuatrocientos"
   text_100_900[ 5 ]        = "quinientos"
   text_100_900[ 6 ]        = "seiscientos"
   text_100_900[ 7 ]        = "setecientos"
   text_100_900[ 8 ]        = "ochocientos"
   text_100_900[ 9 ]        = "novecientos"

var text_1000         : A20 = "mil"
var text_1000000      : A20 = "millon"

//-------------------------------------------------------------------------
// print_total_in_text
//-------------------------------------------------------------------------
sub print_total_in_text( var total_cheque:$15, ref retVal_, var iIsForeignCurr_ : N1 )

   var currency_text[2] : A100
   call currency_to_text( total_cheque, currency_text[1], currency_text[2], iIsForeignCurr_ )
   Format textototal as currency_text[1], " con ", currency_text[2]
   Format retVal_ as textototal

endsub

//------------------------------------------------------------------------
// currency_to_text
// Convert currency in n into str
//------------------------------------------------------------------------
sub currency_to_text( var n:$15, ref str1, ref str2, var iIsForeignCurr_ : N1 )

   var pesos_n 	: n13, centavos_n : n13
   var pesos_s 	: A100, centavos_s : A100
   var tmp_s[2] 	: A100
   var iNumOfDecs	: N9
   var iFactor		: N9
   var sTmp			: A100

   str1 = ""
   str2 = ""
   Call getDBNumOfDecs( n, iNumOfDecs )
   Call pow(10,iNumOfDecs,iFactor)

   // Convert to integer and divide into pesos and centavos.
   pesos_n = n * iFactor
   centavos_n = pesos_n % iFactor
   pesos_n = pesos_n / iFactor

   // Convert each value into text.
   call convert_number_to_text( pesos_n, pesos_s )
   call convert_number_to_text( centavos_n, centavos_s )

   if iIsForeignCurr_
   	call format_currency( pesos_n, tmp_s[1], pesos_s, gblsForeignCurrLabel, FALSE )
   else
   	call format_currency( pesos_n, tmp_s[1], pesos_s, "sol", FALSE )
   endif
   Call format_currency( 1, tmp_s[2], centavos_s, "centavos", TRUE )
      	
	Format str1 as tmp_s[1]
	Format str2 as tmp_s[2]

   if str1 = ""
      call capitalize_first_letter( str2 )
   else
      call capitalize_first_letter( str1 )
   endif

endsub

//------------------------------------------------------------------------
sub format_currency( var n:n13, ref str, ref text, var name:A20, var iStdPluralPostFix_ : N1 )

   if n = 1
      format str as text, " ", name
   else
   	if iStdPluralPostFix_
   		format str as text, " ", name, "s"
   	else
      	format str as text, " ", name, "es"
      endif
   endif

endsub

//------------------------------------------------------------------------
sub convert_number_to_text( var n:n13, ref str )

   var lower_s : A100
   var upper_s : A100

   if n < 1000000
      call convert_6_digit( n, str )
   elseif ( n % 1000000 ) <> 0
      call convert_3_digit( n / 1000000, upper_s )
      call convert_6_digit( n % 1000000, lower_s )
      format str as upper_s, " ", text_1000000, " ", lower_s
   else
      call convert_3_digit( n / 1000000, upper_s )
      format str as upper_s, " ", text_1000000
   endif
endsub      

//------------------------------------------------------------------------
sub convert_6_digit( var n:n13, ref str )

   var lower_s : A100
   var upper_s : A100

   if n < 0
      errormessage "Cannot convert to value less than zero (Importe_Letra.isl)"
      exitcancel
   endif

   if n < 1000
      call convert_3_digit( n, str )
   elseif ( n % 1000 ) <> 0
      call convert_3_digit( n / 1000, upper_s )
      call convert_3_digit( n % 1000, lower_s )
      format str as upper_s, " ", text_1000, " ", lower_s
   else
      call convert_3_digit( n / 1000, upper_s )
      format str as upper_s, " ", text_1000
   endif

endsub

//------------------------------------------------------------------------
sub convert_3_digit( var n:n13, ref str )

   var lower_s : A40

   if n < 100
      call convert_2_digit( n, str )
   elseif ( n % 100 ) <> 0
      call convert_2_digit( ( n % 100 ), lower_s )
      format str as text_100_900[ n / 100 ], " ", lower_s
   else
      format str as text_100_900[ n / 100 ]
   endif
endsub

//------------------------------------------------------------------------
sub convert_2_digit( var n:n13, ref str )

   if n < 20
      format str as text_1_19[ n + 1 ]
   elseif ( n % 10 ) <> 0
      format str as text_10_90[ n/10 ], " y ", text_1_19[ (n%10)+1 ]
   else
      format str as text_10_90[ n/10 ]
   endif

endsub

//------------------------------------------------------------------------
sub capitalize_first_letter( ref str )

   var tmp : A1

   tmp = mid( str, 1, 1 )
   uppercase tmp
   mid( str, 1, 1 ) = tmp

EndSub

//------------------------------------------------------------------------
// Returns database configured number of decimals
//------------------------------------------------------------------------
Sub getDBNumOfDecs( var cVal_ : $15, ref retVal_ )

	var sTmp		: A100
	var iIndex	: N9
	
	
	Format sTmp as cVal_

	iIndex = Instr(1, sTmp, ".")
	if iIndex = 0
		iIndex = Instr(1, sTmp, ",")
	EndIf
	
	if iIndex <> 0
		retVal_ = len(sTmp) - iIndex
	else
		retVal_ = 0
	endif

EndSub

//------------------------------------------------------------------------
// Raises a value to a specified power
//------------------------------------------------------------------------
Sub pow( var cVal_ : $20 , var iPower_ : N9, ref retVal_ )

	var i			: N9
	var cTmpVal	: $20

	
	// init vars
	cTmpVal = 1.00

	If iPower_ = 0
		retVal_ = 1
		return
	EndIf	

	for i = 1 to iPower_
		cTmpVal = cTmpVal * cVal_
	endFor

	// Return new value
	retVal_ = cTmpVal

EndSub
