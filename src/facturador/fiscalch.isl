// FIP-CHL for 9700 EDI v4.0.6
// *************************************************************************
// *************************************************************************
//					MICROS 9700 Fiscal Invoice Printer for Chile
//					     		  Current Version: 4.0.5
// *************************************************************************
// *************************************************************************
//
// This application has been created by MICROS System's
// Latin American R & D department. Unauthorized use or
// redistribution is prohibited.
//
// Copyright (c) 2005-2010 MICROS Systems, Inc.
//
// =========================================================================
// History
// =========================================================================
//
//
// 18-03-2015 - v4.0.5 C.Sepulveda
//   - Corrects error when using discounts in a transaction
//   - Corrects error when sharing items.
//
// 27/02/2015 - v4.0.4 C.Sepulveda
//   - Correct functions to work with new Signature Agent
//   - "Nota de Credito" EDI document was added.
//
// 19/11/2014 - v4.0.3 C.Sepulveda
//   - Correct functions to work with new Signature Agent
//   - New electronic documents Added:
//			- Factura Electronica
//      - Guia de despacho electronica
//   - When working with all kind of documents (not only "boleta") the way
//		 used to select documents was changed. Now user must only select from
//     a numbered list the document to be generated.
//
// 28/05/2014 - v4.0.2
//   -Correct wrong call to generate EDI Documents (calling PrintEDICoupon
//     instead PrintFCRCoupon)
//
// 27/05/2014 - v4.0.1
//	 -Code Optimization (PrintFCRCoupon and PrintEDICoupon Merged)
//
// 30/11/2013 - v4.0.0
//	 -Added functionality to process Electronic Documents using Signature
//		integration trough socket
//    (case #14553429)
//
// 03/01/2012 - v3.2.2
//	 -Fixed SarOps error when uploanding more than 1 offline transaction
//    (case #13247632)
//
// 07/12/2010 - v3.2.1
//	 - Fixed path to CKNUM file
//
// 12/18/2009 - v3.2.0
//	 - Added LASCR #418 (Post Fiscal printer ID to DB)
//
// 10/16/2009 - v3.1.1
//	 - Added LASCR #417 (Incorrect amounts are dispayed for subtotals when 
//		consolidating "FACTURA" invoices per itemizer)
//
// 05/12/2009 - v3.1.0
//	 - Added LASCR #394 (Fix menu level consolidation when grouping menu 
//		items on fiscal coupon)
//	 - Added LASCR #395 (Subtotal values do not add up)
//	 - Exempt Subtotal is now posted to the PTP subototals
//
// 03/20/2009 - v3.0.0
//	 - Added LASCR #275 (Add SAROPS support for fiscal printer)
//
// 11/26/2008 - v2.3.0
//	 - Added LASCR #301 (Consider menu levels when grouping menu items on 
//		fiscal coupon)
//	 - Added LASCR #329 (Fix check for discounts over 50% when using Add-on 
//		taxes)
//	 - Added LASCR #346 (Add support for EPSON TM-88IV fiscal printer model)
//	 - Added LASCR #367 (Add FCR recovery console)
//	 - Added LASCR #369 (Tax-exempt posted incorrectly to the fiscal printer)
//	 - Added debug-logging capability (fiscal printer library only)
//
// 11/07/2008 - v2.2.2
//	 - Added workaround for Fiscal coupon looping error #0102
//
// 07/02/2008 - v2.2.1
//	 - Added workaround for rounding issues
//
// 01/22/2008 - v2.2.0
//	 - Added #262 (Support add-on taxes when using fiscal printer)
//
// 01/11/2008 - v2.1.1
//	 - Added LASCR #280 (Fix invoice sub-query issue returning more than 
//	   one business date value)
//
// 07/05/2007 - v2.1.0
//	 - Added Winstation support for TM-88III EPSON fiscal printer (LASCR 
//		#168)
//	 - Added individual invoice settings for printing of charged tip (LASCR 
//		#211)
//	 - The current Business Date is now posted to fiscal coupon & DB (LASCR 
//		#224)
//
//	02/07/2007 - v2.0.4
//	 - UploadPending function is no longer called for Winstation clients
//
//	11/21/2006 - v2.0.3
//	 - Invoice-type selection screen is now skipped when posting non-fiscal 
//		tender medias (LASCR #180 - case #4707689)
//	 - UploadPendingTransToDB() function now clears SCR file correctly on
//		Winstation clients
//
//	09/07/2006 - v2.0.2
//	 - Fiscal customer "EXTRA" and "TELEFONO" fields are now posted to PTP 
//		FIds
//	 - Added FIP version to logger function
//
//	02/22/2006 - v2.0.1
//	 - Added support for OKI Microline 490 printer, for Winstation client
//		(Winstation 5.0 LATAM Build 1 must be used)
//
//	01/23/2006 - v2.0.0
//	 - Added support for Winstation clients. Both SAROPS and Winstation
//		clients are now supported by this script
//
//	12/22/2005 - v1.0.2
//	 - Fixed incorrect YEAR FId posting to PTP
//	 - Added printing of voided items ("BOLETA", "FACTURA" and GUIA" only)
//	 - Modified format for some PTP FID values
//  - "FACTURA" now posts amount in words to PTP (LASCR #140 - Case 
//		#3753615)
//  - Date info is now posted separately to PTP (LASCR #141 - Case 
//		#3753637)
//  - "FACTURA" can now be consolidated by itemizers (LASCR #142 - Case 
//		#3753704)
//  - RVC number is now posted to the fiscal table (LASCR #143 - Case 
//		#3760972)
//  - Modified Invoice-type prompt (LASCR #144 - Case #3767687)
//  - Added configurable option to set "BOLETA" as default invoice type
//		(LASCR #145 - Case #3767687)
//  - Extra info (cashier #, table #, etc.) is now posted to the PTP
//		(LASCR #146 - Case #3767687)
//  - SIM Script execution will not be halted if EXIT or CANCEL keys are
//		used (LASCR #147 - Case #3767687)
//
// 11/29/2005 - v1.0.1
//	 - Modified SQL UPDATE statement in modifyEmittedInvoiceNumber() to 
//		workaround .NET ORACLE driver bug (affected records would always
//		return 0 even if update succeeded)
//
// 11/22/2005 - v1.0.0
//  - First Build.
//
//
// =========================================================================
// Observations
// =========================================================================
//
// =========================================================================
//
//
// =========================================================================
// TO DO
// =========================================================================
// ( )
// =========================================================================



// ------------------------------------------------------------- //
///////////////////////////////////////////////////////////////////
//			The Following code is not to be modified!			 		  //
///////////////////////////////////////////////////////////////////
// ------------------------------------------------------------- //

// SIM Libraries
Include "MDADLib.isl"
//Include "PTPLib.isl"				// Uncomment this line when encrypting for Winstation
Include "PTPLibLite.isl"			// Uncomment this line when encrypting for SAROPS
Include "Importe_Letra.isl"
//Include "ETM88IIILib.isl"		// Uncomment this line when encrypting for Winstation
Include "ETM88IIILibLite.isl"		// Uncomment this line when encrypting for SAROPS

// SIM OPTIONS
RetainGlobalVar

///////////////////////// FIP Constants ////////////////////////////////

var FIP_VERSION		: A10 = "4.0.5"

// Check detail types [@dtl_type]

var DT_CHECK_INFO     : A1 = "I"
var DT_MENU_ITEM      : A1 = "M"
var DT_DISCOUNT       : A1 = "D"
var DT_SERVICE_CHARGE : A1 = "S"
var DT_TENDER         : A1 = "T"
var DT_REFERENCE      : A1 = "R"
var DT_CA_DETAIL      : A1 = "C"

// Detail TypeDef bits

var DTL_ITEM_OPEN_PRICED	: N2 = 1
var DTL_ITEM_IS_WEIGHED		: N2 = 15

// Detail Status bits

Var VOIDED_BY_LINE_NUMBER	: N2 = 10 // Voided by line number items
Var VOID_ENTRY					: N2 = 5  // Void entry
Var RETURN_ENTRY				: N2 = 4  // Return entry

// Invoice types

var INV_TYPE_BOLETA	 : N1 = 1  	// "Boleta" invoice
var INV_TYPE_FACTURA  : N1 = 2	// "Factura" invoice
var INV_TYPE_GUIA		 : N1 = 3	// "Guia" invoice
var INV_TYPE_CREDITO  : N1 = 4  	// "Nota de Credito" invoice

// Invoice numbering types

var PCWS_CONSECUTIVE					: N1 = 2
var PCWS_CONSEC_WITH_CONF			: N1 = 3

// Key types and codes

var KEY_TYPE_FUNCTION		: N1 = 11
var KEY_CODE_CANCEL_TRANS	: N8 = 605

// Other

var TRUE								: N1 = 1
var FALSE							: N1 = 0
var SAROPS							: N1 = 8    // Pos Client (SAROPS) WS type ID
var CHAR_DOUBLE_QUOTE			: N3 = 34	// Ascii value for the double quote character
var MAX_PRINTABLE_CHARS			: N3 = 42   // Maximum printable chars for roll print jobs
var PCWS_TYPE						: N1 = 1		// Type number for PCWS
var WS4_TYPE						: N1 = 2		// Type number for Workstation 4
var PCT_SAROPS						: N1 = 8		// Type number for POSClients
var PCT_OTHER						: N1 = 1		// Type number for Other Clients (PCWS,etc.)
var WIN32_PLATFORM				: N1 = 3		// Win32 platform code returned by @OS_PLATFORM var
var MAX_HIL							: N2 = 10 	// Max number of HIL (Header Info lines)
var MAX_TIL							: N2 = 10 	// Max number of TIL (Trailer Info lines)
var MAX_TAX_NUM					: N2 = 8		// Max Micros configurable taxes
var MAX_RECS_UPLOAD				: N3 = 500  // Max number of records per upload (pending records only)
var MAX_ITMZR_DESC				: N3 = 16	// Max number if configurable itemizer descriptions
var INV_MANAGEMENT_SIM_PRIVILEGE	: N1 = 4	// Sim privilege option bit for Invoice Management procedures 
var DB_REC_SEPARATOR				: A1 = ";"  // Field separator for returned DB records
var MAX_FCR_TENDERS				: N2 = 20   // Maximum number of configurable tender payments in Fiscal Printer
var MAX_DB_TENDERS				: N4 = 100	// Maximum number of handled tenders
var SQLSERVER						: N1 = 1
var ORACLE							: N1 = 2
var HAS_TRANSPORT					: A1 = "T"
var NO_TRANSPORT					: A1 = "N"
var PRINT_ON_FISCAL				: N1 = 2

var DEFAULT_TAX_RATE				: A4 = "1900"  // Default IVA tax rate for Chile
var DEFAULT_TICKET_ITEM_DESC	: A40 = "Diferencia pago c/ ticket"	// Default description for Ticket invoice item
var DEFAULT_FISC_CMD_TMT		: N4 = 1000 // Default fiscal command timeout
var MAX_DISCOUNT_PERC			: $12 = 50.00 // Maximum allowed discount percentage over Total

var BLT_INITIAL_FASE				: N1 = 0  // fiscal coupon ("Boleta") fases
var BLT_SALE_FASE					: N1 = 1  // fiscal coupon ("Boleta") fases
var BLT_DSCSVC_FASE				: N1 = 2  // fiscal coupon ("Boleta") fases
var BLT_PYMNT_FASE				: N1 = 3  // fiscal coupon ("Boleta") fases
var BLT_TTL_FASE					: N1 = 4  // fiscal coupon ("Boleta") fases
	
	
// FCR DLL Constants (Originally for RES)
var DLLFCR_ERROR_FISCAL_DOC_OPEN		: A4 = "FF04"  // "Ticket Fiscal en progreso"
var DLLFCR_ERROR_PRINTER_OFFLINE		: A4 = "FF00"  // "Impresora fuera de linea"
var DLLFCR_ERROR_PRINTER_ERROR		: A4 = "FF01"  // "Error de Impresion"
var DLLFCR_ERROR_LID_OPEN				: A4 = "FF02"  // "Tapa de impresora abierta"
var DLLFCR_ERROR_LOW_PAPER				: A4 = "FF03"  // "Poco papel disponible en Impresora"


////////////////////////// FIP Global vars /////////////////////////////

// Fiscal logic specific

var gbliMaxHIL				 		:N2	// Max number of HIL (Header Info lines)
var gbliMaxTIL				 		:N2	// Max number of TIL (Trailer Info lines)
var gbliNonFCRMinTndObjNum	 	:N9	// Range Starting Non FCR printable tender media object number
var gbliNonFCRMaxTndObjNum	 	:N9	// Range Ending Non FCR printable tender media object number
var gblsHeaderInfoLines[MAX_HIL]		:A42	// saves HIL (Header Info lines) specified in the .cfg file
var gblsTrailerInfoLines[MAX_TIL] 	:A42	// saves TIL (Trailer Info lines) specified in the .cfg file
var gblsSpecialTrailerInfoLines[MAX_TIL] 	:A42	// saves TIL (Trailer Info lines) specified in the .cfg file
var gblsInvoiceNumFromSAR	 	:N1	// To check if Invoice Number was system or locally generated
var gbliInvoiceType			 	:N1	// Invoice type for current check
var gblsDefaultTaxRate			:A10	// Default tax rate for Chile
var gblsIDNumber			 		:A30	// ID Number
var gblsName				 		:A38	// Fiscal Name
var gblsAddress1			 		:A38	// Fiscal Address
var gblsAddress2			 		:A38	// Fiscal Address
var gblsTel					 		:A16	// Fiscal Telephone number
var gblsExtra1				 		:A38	// Fiscal Extra info
var gblsCreditInfo				:A100 // "Nota de Credito" extra info (related invoices, etc.)
var gblsInvoiceNum				:A12	// Invoice Number for last emitted Fiscal Coupon on fiscal printer
var gbliInDebugMode				:N1	// Sets FIP in "debug mode" (used to log extra info)
var gbliPrintUnitPrice		 	:N1	// To select whether to print or not Unit Price in an invoice
var gbliPrintWhenAmount0	 	:N1	// To select whether to print or not an Invoice when total amount is $0.00
var gbliAddChargedTipToTotal[4] 	:N1   // To select whether to add a Tender's Charged Tip amount to a Check Total
var gbliTaxIsInclusive		 	:N1	// To specify if current tax is "inclusive" or not
var gbliBOLETAasDefault			:N1	// To specify if "BOLETA" should be the default invoice type
var gbliFACTURAConsByItmzr		:N1	// To specify if "FACTURA" invoice types should be consolidated by itemizers
var gbliMaxPrintableItems	 	:N9	// Specifies maximum number of items to print for a single check
var gbliPostTndrsToPTPDetail	:N1	// To select whether to post tender items to PTP detail attributes
var gblsaItmzrDesc[MAX_ITMZR_DESC]	:A100	// Stores descriptions for itemizers loaded from the .cfg file
var gbliConfirmPrintJob			:N1	// To select whether to ask (or not) printing confirmation after a print job
var gbliPrintJobsPause			:N9   // Pause between print jobs sent to external printers
var gbliPrintJobBufChrs			:N9	// Chars to buffer for Winstation external print jobs
var gbliDisableFCR				:N1	// Disables FCR if activated
var gblsDBGrpTender[MAX_FCR_TENDERS] 	:A40 	// for saving DB Grouped-Tenders specified in the .cfg file
var gblsDBTender[MAX_DB_TENDERS]	 		:A40	// for saving DB Tender specified in the .cfg file
var gbliTicketInvActive			:N1	// switch for activating alternative Ticket invoices (1 = ON | 0 = OFF)
var gbliTicketMinTndObjNum		:N9	// Tender media object number starting range for "Ticket" tender type
var gbliTicketMaxTndObjNum		:N9	// Tender media object number ending range for "Ticket" tender types
var gblsTicketItemTax			:A10	// Tax to be used for item printing in an alternative Ticket invoice
var gblsTicketItemInvDesc		:A40	// Description to be used for item printing in an alternative Ticket invoice
var gbliPrintBOLETAonLCL		:N1	// To select whether to print "BOLETA" invoice types on local SAROPS printer or external
var gbliPrintFACTURAonLCL		:N1	// To select whether to print "FACTURA" invoice types on local SAROPS printer or external
var gbliPrintGUIAonLCL			:N1	// To select whether to print "GUIA" invoice types on local SAROPS printer or external
var gbliPrintCREDITOonLCL		:N1	// To select whether to print "CREDITO" invoice types on local SAROPS printer or external
var gbliBOLETAMaxItemsPP		:N9	// Maximum number of printable items per document for "BOLETA" invoice type
var gbliFACTURAMaxItemsPP		:N9	// Maximum number of printable items per document for "FACTURA" invoice type
var gbliGUIAMaxItemsPP			:N9	// Maximum number of printable items per document for "GUIA" invoice type
var gbliCREDITOMaxItemsPP		:N9	// Maximum number of printable items per document for "CREDITO" invoice type
var gblsFixedPrintPath			:A300	// Fixed print path to be used when sending print jobs to an external printer
var gblsFixedPrintPort			:A10	// Fixed print port to be used when sending print jobs to an external printer
var gbliMaxAmntInWordsCPL		:N9	// Maximum number of chars per print line when printing check total amount in words
var gbliWSType				 		:N1	// To store the current Workstation type
var gbliDBType				 		:N1	// Specifies Database type being used by 9700 3.0
var gbliFCRPrintedLines			:N9	// for saving the number of lines that have been printed successfully
var gblcAccumSubtotal			:$12	// for saving the accumulated subtotal when printing the Fiscal Coupon
var gblcFCRCurrSubtotal			:$12	// for saving the FCR subtotal when printing the Fiscal Coupon
var gblsFCRTotalAmount			:A15	// Total amount for last emitted Fiscal Coupon
var gblsFCRChange					:A15	// Change due for last emitted Fiscal Coupon
var gbliUseEDI						:N1		// Enable or Disable use of EDI interface (if enabled, it will disable Fiscal Printer Process)
var gblsInvoiceNumEDI			:A10  //To store Invoice Number generated by EDI interface
var gblsGUIDEDI						:A100 //To store GUID generated by EDI Interface
Var gblsEDIStatus					:A20  //To store status returned by EDI Interface for current document
Var gblsEDICode						:A1500 //To store EDI Code to generate PDF 417
var gblsDefIDNumber			 		:A30	// Default ID Number
var gblsDefName				 		:A38	// Default Fiscal Name
var gblsDefAddress1			 		:A38	// Default Fiscal Address
var gblsDefAddress2			 		:A38	// Default Fiscal Address
var gblsDefTel					 		:A16	// Default Fiscal Telephone number
var gblsDefExtra1				 		:A38	// Default Fiscal Extra info

//Variables for EDI Credit note
Var gblsNCReferenceInvNumber 				:A16 	// Invoice type number to be referenced by a "Nota de Crédito" document 
Var gblsNCReferenceInvType					:A1 // Invoice type to be used with Electronic Credit Note
Var gblsNCRefNetAmount							: A10 //Net Amount of original Document (format yyyymmdd)
Var gblsNCRefTaxAmount							: A10 //Tax Amount of original Document (format yyyymmdd)
Var gblsNCReferenceReason						: A30 // Explicit reason to void original document
var gbliEDINonNomCopies			:N2		// Number of copies to be printed for non nominative documents (EDI)
var gbliEDINomCopies				:N2		// Number of copies to be printed for nominative documents (EDI)

// Fiscal Printer specific

var giFCRError					:N2	// For FCR status check
var gsFCRMsg					:A256	// For FCR status check message
var gsFCRCmdReturn			:A4	// For FCR detailed status return
var gsFCRFieldInfo			:A500	// For FCR Field data (input and output)
var gsFCRFPResponse			:A1000 // FiscalPrint command response
var giFCROpenDoc				:N1	// FCR Open document flag
var giFCRCmd[600]				:N3	// for building FCR command
var giFCROK						:N1
var gsDrvFCRMsg				:A256
var gsDrvFCRFiscalStatus	:A4

var gbliTmtPZR					:N9	// "Print Z report" command timeout
var gbliTmtPXR					:N9	// "Print X report" command timeout
var gbliTmtONFC				:N9	// "Open non fiscal coupon" command timeout
var gbliTmtCNFC				:N9	// "Close non fiscal coupon" command timeout
var gbliTmtPNFI				:N9	// "Print non fiscal item" command timeout
var gbliTmtGS					:N9	// "Get status" command timeout
var gbliTmtGST					:N9	// "Get subtotal" command timeout
var gbliTmtGCI					:N9	// "Get Coupon Info" command timeout
var gbliTmtGFD					:N9	// "Get Fiscalization Data" command timeout
var gbliTmtPFI					:N9	// "Print fiscal item" command timeout
var gbliTmtPFT					:N9	// "Print fiscal tender" command timeout
var gbliTmtCFC					:N9	// "Close fiscal coupon" command timeout
var gbliTmtSD					:N9	// "Set date" command timeout
var gbliTmtSFP					:N9	// "Set fiscal payment" command timeout
var gbliTmtGFP					:N9	// "Get fiscal payment" command timeout
var gbliTmtOFC					:N9	// "Open fiscal coupon" command timeout
var gbliTmtPFDS				:N9	// "Print fiscal discount/service" command timeout

// filenames

var CONFIGURATION_FILE_NAME			:A100
var CONFIGURATION_FILE_NAME_PWS		:A100
var SAVED_CUST_RECEIPTS_FILE_NAME	:A100
var PATH_TO_INVOICE_FILES				:A100
var PATH_TO_BOLETA_PRINT_DOC			:A100
var PATH_TO_FACTURA_PRINT_DOC			:A100
var PATH_TO_GUIA_PRINT_DOC				:A100
var PATH_TO_CREDITO_PRINT_DOC			:A100
var PATH_TO_BOLETA_PRINT_TMP			:A100
var PATH_TO_FACTURA_PRINT_TMP			:A100
var PATH_TO_GUIA_PRINT_TMP				:A100
var PATH_TO_CREDITO_PRINT_TMP			:A100
var BOLETA_FILE_NAME						:A100
var FACTURA_FILE_NAME					:A100
var GUIA_FILE_NAME						:A100
var CREDITO_FILE_NAME					:A100
var BOLETA_RANGE_FILE_NAME				:A100
var FACTURA_RANGE_FILE_NAME			:A100
var GUIA_RANGE_FILE_NAME				:A100
var CREDITO_RANGE_FILE_NAME			:A100
var PATH_TO_PTP_DRIVER					:A100
var PATH_TO_RPROC_DRIVER				:A100
var PATH_TO_FCR_DRIVER					:A100
var CHK_NUM_FILE_NAME					:A100
var ERROR_LOG_FILE_NAME					:A100
var PATH_TO_EDI_DRIVER					:A100
var PATH_TO_ESCPOS_DRIVER				:A100

// Driver handles (DLLs for SAROPS)
var gblhPTP					: N18
var gblhRPROC				: N18
var gblhFCR					: N18
var gblhEDI					: N18
var gblhESCPOS			: N18

////////////////////////////////////////////////////////////////
//							EVENTS							  				  //
////////////////////////////////////////////////////////////////

Event init

	ErrorMessage "9700 EDI FIP v5.0"
	// get SAROPS client platform
	Call setWorkstationType()

	// set file paths for this client
	call setFilePaths()

	// Set header-Trailer max print lines
	call setMaxHeaderTrailerInfoLines()

	// Load Custom Settings from .cfg file
	call LoadCustomSettings()
	
	// Initialize PTP driver
	call initPTPdrv()
	
	// Initialize RPROC driver
	Call initRPROCdrv()
	
	// Initialize fiscal printer driver (SAROPS)
	Call initFCRdrv()
	
	// Initialize EDI driver (SAROPS)
	Call initEDIdrv()
	
	// Initialize ESCPOS driver (SAROPS)
	Call initESCPOSdrv()
	
	// initialize Fiscal printer library (Winst.)
	if Not gbliDisableFCR and @WSTYPE <> SAROPS
		Call ETM88III_ResetState()
		ETM88III_gbliInDebugMode = gbliInDebugMode
	endif

	// reset global vars
	call initGlobalVars()

EndEvent

Event trans_cncl
	
	//Try to cancel EDI Doc
	if gbliUseEDI
		call SendCancelDocEDI()
	EndIf
	
	// reset global vars
	call initGlobalVars()

EndEvent

Event srvc_total: *

	// reset global vars
	call initGlobalVars()

EndEvent

Event final_tender

	// process check info and print Customer receipt
	call printCustomerReceipt()

	// reset global vars
	call initGlobalVars()

EndEvent

Event sign_in

	var iOk	: N1
		

	// Upload pending postings to DB
	if @WSTYPE = SAROPS
		call UploadPendingTransToDB(iOk)
	endif

	// check invoice numbers to be used
	call validateInvoiceNumber()

EndEvent

Event sign_out

	// reset global vars
	call initGlobalVars()

EndEvent

Event exit

	// unload used DLLs from memory

	Call UnloadPTPdrv()		
	Call UnloadRPROCdrv()
	Call unloadFCRdrv()	
	Call unloadEDIdrv()

EndEvent

////////////////////////////////////////////////////////////////
//						INQ EVENTS							  //
////////////////////////////////////////////////////////////////

Event INQ : 3

	var iConnOK  : N1

	// -----------------------------------------------
	// INQ for managing invoice numbers
	// -----------------------------------------------
	
	call ManageInvoiceNumbers(iConnOK)

EndEvent

Event INQ : 4

	// -----------------------------------------------
	// INQ for Cancelling invoices
	// -----------------------------------------------

	call cancelEmittedInvoice()

EndEvent

Event INQ : 5

	// -----------------------------------------------
	// INQ for modifying erroneous invoice numbers
	// -----------------------------------------------

	call modifyEmittedInvoiceNumber()

EndEvent

Event INQ : 6

	// -----------------------------------------------
	// INQ for accessing Payments screen
	// -----------------------------------------------

	if not gbliUseEDI
		call checkFCRStatus()
		call validateInvoiceNumber()
	else
		call InitializeEDI()
		call selectInvoiceType()
		Call setExtraFiscalInfo()
	endif
	call SendGenDocEDI()
	
	
EndEvent

Event INQ : 7

	// -----------------------------------------------
	// INQ for printing Z report
	// -----------------------------------------------
	
	if gbliDisableFCR
		// FCR has been deactivated
		ExitContinue
	endif
	
	// update prompt
	prompt "Imprimiendo Reporte Z..."

	call PrintZReport()
	call checkFCRCmdResponse(giFCROK,TRUE, TRUE, TRUE)

	// update prompt
	prompt "Idle"

EndEvent

Event INQ : 8

	// -----------------------------------------------
	// INQ for printing a Cashier report (X report)
	// -----------------------------------------------
	
	if gbliDisableFCR
		// FCR has been deactivated
		ExitContinue
	endif
	
	// update prompt
	prompt "Imprimiendo Reporte Cajero..."

	call PrintCashierReport()
	call checkFCRCmdResponse(giFCROK, TRUE, TRUE, TRUE)

	// update prompt
	prompt "Idle"

EndEvent

Event INQ : 9

	// -----------------------------------------------
	// INQ for printing a Guest Check
	// -----------------------------------------------

	if gbliDisableFCR
		// FCR has been deactivated
		ExitContinue
	endif

	call PrintGuestCheck()

EndEvent

Event INQ : 10

	// -----------------------------------------------
	// INQ for date change on fiscal printer
	// -----------------------------------------------

	if gbliDisableFCR
		// FCR has been deactivated
		ExitContinue
	endif

	call setFCRDateTime()

EndEvent

Event INQ : 11

	// -----------------------------------------------
	// INQ for setting FCR Payments
	// -----------------------------------------------
	
	if gbliDisableFCR
		// FCR has been deactivated
		ExitContinue
	endif
	
	// update prompt
	prompt "Cargando tipos de pago..."

	call SetFCRPayments()

	// update prompt
	prompt "Idle"

EndEvent

Event INQ : 12

	// -----------------------------------------------
	// INQ for getting FCR Payments
	// -----------------------------------------------
	
	if gbliDisableFCR
		// FCR has been deactivated
		ExitContinue
	endif

	call getFCRPayments()

	// update prompt
	prompt "Idle"

EndEvent

Event INQ : 14

	// -----------------------------------------------
	// INQ for calling the FCR Recovery Console
	// -----------------------------------------------
	
	if gbliDisableFCR
		// FCR has been deactivated
		ExitContinue
	endif
	
	call fiscalPrinterRecoveryConsole()

EndEvent

Event INQ : 15

	// -----------------------------------------------
	// INQ for calling the Cancel EDI Process
	// -----------------------------------------------
	
	if not gbliUseEDI
		// EDI is not enabled
		ExitContinue
	endif
	
	call SendCancelDocEDI()

EndEvent

////////////////////////////////////////////////////////////////
//					  FIP PROCEDURES						  				  //
////////////////////////////////////////////////////////////////

//******************************************************************
// Procedure: initPTPdrv()
// Author: Alex Vidal
// Purpose: Initializes the PTP driver
// Parameters:
//******************************************************************
Sub initPTPdrv()
	
	if @WSType <> SAROPS
		Return
	endif
	
	If gblhPTP = 0
		DLLLoad gblhPTP, PATH_TO_PTP_DRIVER
	EndIf
	
	If gblhPTP = 0
		ErrorMessage "Failed to load PTP driver!"
		call logInfo(ERROR_LOG_FILE_NAME,"Failed to load PTP driver",TRUE,TRUE)
	EndIf
	
EndSub

//******************************************************************
// Procedure: initRPROCdrv()
// Author: Alex Vidal
// Purpose: Initializes the RUNPROC driver
// Parameters:
//	- 
//
//******************************************************************
Sub initRPROCdrv()
	
	If gbliWSType = WS4_TYPE or @WSTYPE <> SAROPS
		// driver not supported for WS4 and non-sarops
		// clients
		Return
	endif
	
	If gblhRPROC = 0
		DLLLoad gblhRPROC, PATH_TO_RPROC_DRIVER
	EndIf
	
	If gblhRPROC = 0
		ErrorMessage "Failed to load RPROC driver!"
		call logInfo(ERROR_LOG_FILE_NAME,"Failed to load RPROC driver",TRUE,TRUE)
	EndIf
	
EndSub

//******************************************************************
// Procedure: initFCRdrv()
// Author: Al Vidal
// Modified by: C Sepulveda
// Purpose: Initializes the FCR driver
// Parameters:
//******************************************************************
Sub initFCRdrv()

	if @WSType <> SAROPS or gbliDisableFCR or gbliUseEDI
		Return
	endif

	If ( gblhFCR = 0 )
		DLLLoad gblhFCR, PATH_TO_FCR_DRIVER
    EndIf

	If gblhFCR = 0
        ErrorMessage "Failed to load FCR driver!"
		call logInfo(ERROR_LOG_FILE_NAME,"Failed to load FCR driver",TRUE,TRUE)
    EndIf

EndSub

//******************************************************************
// Procedure: initEDIdrv()
// Author: Al Vidal
// Modified by: C Sepulveda
// Purpose: Initializes the EDI driver
// Parameters:
//******************************************************************
Sub initEDIdrv()

	if @WSType <> SAROPS or gbliUseEDI = FALSE
		Return
	endif

	If ( gblhEDI = 0 )
		DLLLoad gblhEDI, PATH_TO_EDI_DRIVER
  EndIf

	If gblhEDI = 0
    ErrorMessage "Failed to load EDI driver!"
		call logInfo(ERROR_LOG_FILE_NAME,"Failed to load EDI driver",TRUE,TRUE)
    EndIf

EndSub

//******************************************************************
// Procedure: initESCPOSdrv()
// Author: Al Vidal
// Modified by: C Sepulveda
// Purpose: Initializes the ESCPOS driver
// Parameters:
//******************************************************************
Sub initESCPOSdrv()

	if @WSType <> SAROPS or gbliUseEDI = FALSE
		Return
	endif

	If ( gblhESCPOS = 0 )
		DLLLoad gblhESCPOS, PATH_TO_ESCPOS_DRIVER
  EndIf

	If gblhESCPOS = 0
    ErrorMessage "Failed to load ESCPOS driver!"
		call logInfo(ERROR_LOG_FILE_NAME,"Failed to load ESCPOS driver",TRUE,TRUE)
    EndIf

EndSub

//******************************************************************
// Procedure: UnloadPTPdrv()
// Author: Alex Vidal
// Purpose: Unloads the PTP driver
// Parameters:
//	- 
//
//******************************************************************
Sub UnloadPTPdrv()
	
	if @WSType <> SAROPS
		Return
	endif
	
	If gblhPTP <> 0
		// unload Dll from memory
		DLLFree gblhPTP
		gblhPTP = 0
	EndIf
	
EndSub

//******************************************************************
// Procedure: UnloadRPROCdrv()
// Author: Alex Vidal
// Purpose: Unloads the RPROC driver
// Parameters:
//	- 
//
//******************************************************************
Sub UnloadRPROCdrv()
	
	If gbliWSType = WS4_TYPE or @WSTYPE <> SAROPS
		// driver not supported for WS4 and non-sarops
		// clients
		Return
	endif
	
	If gblhRPROC <> 0
		// unload Dll from memory
		DLLFree gblhRPROC
		gblhRPROC = 0
	EndIf
	
EndSub

//******************************************************************
// Procedure: UnloadFCRdrv()
// Author: Al Vidal
// Modified: C Sepulveda
// Purpose: Unloads the FCR driver
// Parameters:
//******************************************************************
Sub UnloadFCRdrv()

	if @WSType <> SAROPS or gbliDisableFCR or gbliUseEDI
		Return
	endif

	If gblhFCR <> 0
		// unload Dll from memory
		DLLFree gblhFCR
		gblhFCR = 0
	EndIf

EndSub

//******************************************************************
// Procedure: UnloadEDIdrv()
// Author: Al Vidal
// Modified : C Sepulveda
// Purpose: Unloads the EDI driver
// Parameters:
//******************************************************************
Sub UnloadEDIdrv()

	if @WSType <> SAROPS or (gbliUseEDI = FALSE)
		Return
	endif

	If gblhEDI <> 0
		// unload Dll from memory
		DLLFree gblhEDI
		gblhEDI = 0
	EndIf

EndSub

//******************************************************************
// Procedure: UnloadESCPOSdrv()
// Author: Al Vidal
// Modified : C Sepulveda
// Purpose: Unloads the ESCPOS driver
// Parameters:
//******************************************************************
Sub UnloadESCPOSdrv()

	if @WSType <> SAROPS or (gbliUseEDI = FALSE)
		Return
	endif

	If gblhESCPOS <> 0
		// unload Dll from memory
		DLLFree gblhESCPOS
		gblhESCPOS = 0
	EndIf

EndSub

//******************************************************************
// Procedure: initGlobalVars()
// Author: Al Vidal
// Purpose: resets values in global variables used in this script
// Parameters:
//	- 
//
//******************************************************************
Sub initGlobalVars()

	gbliInvoiceType = 0
	Call clearFiscalGblVars()
	format gblsGUIDEDI as ""
  format gblsEDICode as ""
  
  if gbliEDINonNomCopies = 0
  	gbliEDINonNomCopies = 1
  endif
  
  if gbliEDINomCopies = 0
  	gbliEDINomCopies = 2
  endif
EndSub

//******************************************************************
// Procedure: LoadCustomSettings()
// Author: Al Vidal
// Purpose: Loads the custom settings from the configuration file,
//			saving them in the corresponding variables
// Parameters:
//	- 
//******************************************************************
Sub LoadCustomSettings()

	var fn			: N5
	var sLineInfo	: A100
	var sFileName	: A100
	
	
	if @WSType = SAROPS
		FOpen fn, CONFIGURATION_FILE_NAME, read, local
	else
		// Check for WS configuration file. If it doesn't exist,
		// use "master" configuration file
		FOpen fn, CONFIGURATION_FILE_NAME_PWS, read
		If fn = 0
			FOpen fn, CONFIGURATION_FILE_NAME, Read
			Format sFileName as CONFIGURATION_FILE_NAME
		Else
			Format sFileName as CONFIGURATION_FILE_NAME_PWS
		EndIf
	endif
		
	If fn <> 0 
		While not Feof(fn)
			freadln fn, sLineInfo

			// process currently read information
			call setCustomSetting(sLineInfo,fn,sFileName)
		EndWhile

		fclose fn
	Else
		// Couldn't open configuration file!
		ErrorMessage "Fiscal Configuration file not found!"
		call logInfo(ERROR_LOG_FILE_NAME,"Fiscal Configuration file not found",TRUE,TRUE)
	EndIf

EndSub

//******************************************************************
// Procedure: setCustomSetting()
// Author: Alex Vidal
// Purpose: processes the information passed by parameter,
//			classifying the type of custom setting read and 
//		    setting its value into the corresponding variable
// Parameters:
//	 - sInfo_ : information string to be processed
//  - fn_	 : pointer to currently open configuration file	
//	 - sFileName_ = Filename of Read configuration file
//******************************************************************
Sub setCustomSetting( ref sInfo_, ref fn_, var sFileName_ : A100 )

	var sTmp 	: A100
	var sTmp2 	: A100
	var i	 		: N3	// for looping

	
	// Get any unsolicited chars out of the way...
	Call stripCrLfCharOff(Trim(sInfo_), sTmp)

	If		mid(sTmp,1,1) = "*"
		
		// Current line is a comment. Ignore it.
			
	elseif	sTmp = "DB_TYPE"
	
		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			
			// set specified database type
			gbliDBType = Trim(sTmp)
			
		Else
			ErrorMessage "DB_TYPE not specified in ", sFileName_
			call logInfo(ERROR_LOG_FILE_NAME,"DB_TYPE not specified",TRUE,TRUE)
		EndIf
	
	elseif	sTmp = "IN_DEBUG_MODE"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			
			// Turn on or off Unit price flag
			gbliInDebugMode = sTmp
			
		Else
			ErrorMessage "PRINT_UNIT_PRICE not specified in ", sFileName_
			call logInfo(ERROR_LOG_FILE_NAME,"PRINT_UNIT_PRICE not specified",TRUE,TRUE)
		EndIf

	elseif	sTmp = "PRINT_UNIT_PRICE"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			
			// Turn on or off Unit price flag
			gbliPrintUnitPrice = sTmp
			
		Else
			ErrorMessage "PRINT_UNIT_PRICE not specified in ", sFileName_
			call logInfo(ERROR_LOG_FILE_NAME,"PRINT_UNIT_PRICE not specified",TRUE,TRUE)
		EndIf

	ElseIf	sTmp = "PRINT_WHEN_AMOUNT_IS_ZERO"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			
			// Turn on or off Print when zero flag
			gbliPrintWhenAmount0 = sTmp
			
		Else
			ErrorMessage "PRINT_WHEN_AMOUNT_IS_ZERO not specified in ", sFileName_
			call logInfo(ERROR_LOG_FILE_NAME,"PRINT_WHEN_AMOUNT_IS_ZERO not specified",TRUE,TRUE)
		EndIf

	ElseIf	sTmp = "ADD_CHARGED_TIP_TO_CHK_TOTAL_ON_BOLETA"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			
			// Turn on or off Charged Tip flag
			gbliAddChargedTipToTotal[INV_TYPE_BOLETA] = sTmp
			
		Else
			ErrorMessage "ADD_CHARGED_TIP_TO_CHK_TOTAL_ON_BOLETA not specified in ", sFileName_
			call logInfo(ERROR_LOG_FILE_NAME,"ADD_CHARGED_TIP_TO_CHK_TOTAL_ON_BOLETA not specified",TRUE,TRUE)
		EndIf
		
	ElseIf	sTmp = "ADD_CHARGED_TIP_TO_CHK_TOTAL_ON_FACTURA"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			
			// Turn on or off Charged Tip flag
			gbliAddChargedTipToTotal[INV_TYPE_FACTURA] = sTmp
			
		Else
			ErrorMessage "ADD_CHARGED_TIP_TO_CHK_TOTAL_ON_FACTURA not specified in ", sFileName_
			call logInfo(ERROR_LOG_FILE_NAME,"ADD_CHARGED_TIP_TO_CHK_TOTAL_ON_FACTURA not specified",TRUE,TRUE)
		EndIf


	ElseIf	sTmp = "ADD_CHARGED_TIP_TO_CHK_TOTAL_ON_GUIA"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			
			// Turn on or off Charged Tip flag
			gbliAddChargedTipToTotal[INV_TYPE_GUIA] = sTmp
			
		Else
			ErrorMessage "ADD_CHARGED_TIP_TO_CHK_TOTAL_ON_GUIA not specified in ", sFileName_
			call logInfo(ERROR_LOG_FILE_NAME,"ADD_CHARGED_TIP_TO_CHK_TOTAL_ON_GUIA not specified",TRUE,TRUE)
		EndIf

	ElseIf	sTmp = "ADD_CHARGED_TIP_TO_CHK_TOTAL_ON_CREDITO"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			
			// Turn on or off Charged Tip flag
			gbliAddChargedTipToTotal[INV_TYPE_CREDITO] = sTmp
			
		Else
			ErrorMessage "ADD_CHARGED_TIP_TO_CHK_TOTAL_ON_CREDITO not specified in ", sFileName_
			call logInfo(ERROR_LOG_FILE_NAME,"ADD_CHARGED_TIP_TO_CHK_TOTAL_ON_CREDITO not specified",TRUE,TRUE)
		EndIf

	ElseIf	sTmp = "TAX_IS_INCLUSIVE"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			
			// Turn on or off Tax-is-inclusive flag
			gbliTaxIsInclusive = sTmp
			
		Else
			ErrorMessage "TAX_IS_INCLUSIVE not specified in ", sFileName_
			call logInfo(ERROR_LOG_FILE_NAME,"TAX_IS_INCLUSIVE not specified",TRUE,TRUE)
		EndIf
		
	ElseIf	sTmp = "FCR_DEFAULT_TAX_RATE"
	
		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			
			// set specified country
			format gblsDefaultTaxRate as Trim(sTmp)

		Else
			gblsDefaultTaxRate = DEFAULT_TAX_RATE

		EndIf
	
	ElseIf	sTmp = "BOLETA_IS_DEFAULT_INVOICE"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			
			// set value
			gbliBOLETAasDefault = sTmp
			
		Else
			
			// set default value
			gbliBOLETAasDefault = 0
			
		EndIf	
	
	ElseIf	sTmp = "CONSOLIDATE_FACTURA_BY_ITMZR"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			
			// set value
			gbliFACTURAConsByItmzr = sTmp
			
		Else
			
			// set default value
			gbliFACTURAConsByItmzr = 0
			
		EndIf		

	ElseIf	sTmp = "MAX_PRINTABLE_ITEMS"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			
			// Set maximum number of printable items
			gbliMaxPrintableItems = sTmp
			
		Else
			ErrorMessage "MAX_PRINTABLE_ITEMS not specified in ", sFileName_
			call logInfo(ERROR_LOG_FILE_NAME,"MAX_PRINTABLE_ITEMS not specified",TRUE,TRUE)
		EndIf
		
	ElseIf	sTmp = "POST_TENDERS_TO_PTP_DETAIL"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			
			// set value
			gbliPostTndrsToPTPDetail = sTmp
			
		Else
			ErrorMessage "POST_TENDERS_TO_PTP_DETAIL not specified in ", sFileName_
			call logInfo(ERROR_LOG_FILE_NAME,"POST_TENDERS_TO_PTP_DETAIL not specified",TRUE,TRUE)
		EndIf
		
	ElseIf	sTmp = "NON_FISC_MIN_TNDR_OBJ_NUM"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			
			// set Min Non-emitting FCR Tender Media object number
			gbliNonFCRMinTndObjNum = sTmp

		Else
			
			// set default Min value
			gbliNonFCRMinTndObjNum = 0

		EndIf

	ElseIf	sTmp = "NON_FISC_MAX_TNDR_OBJ_NUM"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			
			// set Max Non-emitting FCR Tender Media object number
			gbliNonFCRMaxTndObjNum = sTmp

		Else
			
			// set default Max value
			gbliNonFCRMaxTndObjNum = 0

		EndIf
		
	ElseIf	sTmp = "ITMZR_NAMES"

		For i = 1 to MAX_ITMZR_DESC
				
			// get value (should always be found below the key)
			freadln fn_, sTmp2
			Call stripCrLfCharOff(sTmp2, sTmp)
		
			format sTmp as Trim(sTmp)

			If sTmp = "ENDITMZR_NAMES"
				Break
			EndIf

			// Save current itemizer ItmzrID/Name pair
			gblsaItmzrDesc[i] = mid(sTmp,1,MAX_PRINTABLE_CHARS)
			
		Endfor
		
	ElseIf	sTmp = "CONFIRM_PRINT_JOBS"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			// set value
			gbliConfirmPrintJob = sTmp
			
		Else
			// set default value
			gbliConfirmPrintJob = 0
		EndIf
		
	ElseIf	sTmp = "PAUSE_BETWEEN_EXT_PRINT_JOBS"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			
			// set value
			gbliPrintJobsPause = sTmp

		Else
			
			// set default value
			gbliPrintJobsPause = 1000

		EndIf
		
	ElseIf	sTmp = "CHARS_BUFFERED_IN_EXT_PRINT_JOBS"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			
			// set value
			gbliPrintJobBufChrs = sTmp

		Else
			
			// set default value
			gbliPrintJobBufChrs = 0

		EndIf
		
	elseif sTmp = "PRINT_ALT_INVOICE_FOR_TICKETS_ON_FCR"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			
			// set value
			gbliTicketInvActive = mid(sTmp,1,1)

		Else
			
			ErrorMessage "PRINT_ALT_INVOICE_FOR_TICKETS not specified in ", sFileName_
			call logInfo(ERROR_LOG_FILE_NAME,"PRINT_ALT_INVOICE_FOR_TICKETS_ON_FCR not specified",TRUE,TRUE)

		EndIf
		
	elseif	sTmp = "FCR_TICKET_MIN_TNDR_OBJ_NUM"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		if trim(sTmp) <> ""
			
			// set value
			gbliTicketMinTndObjNum = sTmp

		else
			
			// set default value
			gbliTicketMinTndObjNum = 0

		endif

	elseif	sTmp = "FCR_TICKET_MAX_TNDR_OBJ_NUM"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		if trim(sTmp) <> ""
			
			// set value
			gbliTicketMaxTndObjNum = sTmp

		else
			
			// set default value
			gbliTicketMaxTndObjNum = 0

		endif
		
	elseif	sTmp = "FCR_TICKET_ITEM_TAX"
	
		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		if trim(sTmp) <> ""
			
			// set specified country
			format gblsTicketItemTax as Trim(sTmp)

		else
			gblsTicketItemTax = gblsDefaultTaxRate

		endif
		
	elseif	sTmp = "FCR_TICKET_ITEM_DESC"
	
		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		if trim(sTmp) <> ""
			
			// set value
			format gblsTicketItemInvDesc as Mid(sTmp,1,20)

		else
			// set default value
			Format gblsTicketItemInvDesc as DEFAULT_TICKET_ITEM_DESC

		endif
	
	ElseIf	sTmp = "PRINT_BOLETA_ON_LOCAL_PRINTER"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			// set value
			gbliPrintBOLETAonLCL = sTmp
			
		Else
			// set default value
			gbliPrintBOLETAonLCL = 1
		EndIf
		
		if gbliPrintBOLETAonLCL <> PRINT_ON_FISCAL
			gbliDisableFCR = TRUE
		else
			gbliDisableFCR = FALSE
		endif
		
	ElseIf	sTmp = "PRINT_FACTURA_ON_LOCAL_PRINTER"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			// set value
			gbliPrintFACTURAonLCL = sTmp
			
		Else
			// set default value
			gbliPrintFACTURAonLCL = 1
		EndIf
	
	ElseIf	sTmp = "PRINT_GUIA_ON_LOCAL_PRINTER"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			// set value
			gbliPrintGUIAonLCL = sTmp
			
		Else
			// set default value
			gbliPrintGUIAonLCL = 1
		EndIf
	
	ElseIf	sTmp = "PRINT_CREDITO_ON_LOCAL_PRINTER"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			// set value
			gbliPrintCREDITOonLCL = sTmp
			
		Else
			// set default value
			gbliPrintCREDITOonLCL = 1
		EndIf
	
	ElseIf	sTmp = "BOLETA_MAX_ITEMS_PER_COUPON"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			
			// set value
			gbliBOLETAMaxItemsPP = sTmp

		Else
			
			// set default value
			gbliBOLETAMaxItemsPP = 1000

		EndIf
	
	ElseIf	sTmp = "FACTURA_MAX_ITEMS_PER_COUPON"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			
			// set value
			gbliFACTURAMaxItemsPP = sTmp

		Else
			
			// set default value
			gbliFACTURAMaxItemsPP = 1000

		EndIf
		
	ElseIf	sTmp = "GUIA_MAX_ITEMS_PER_COUPON"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			
			// set value
			gbliGUIAMaxItemsPP = sTmp

		Else
			
			// set default value
			gbliGUIAMaxItemsPP = 1000

		EndIf
		
	ElseIf	sTmp = "CREDITO_MAX_ITEMS_PER_COUPON"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			
			// set value
			gbliCREDITOMaxItemsPP = sTmp

		Else
			
			// set default value
			gbliCREDITOMaxItemsPP = 1000

		EndIf

	ElseIf	sTmp = "FIXED_PRINT_PATH"
				
		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		format sTmp as Trim(sTmp)

		// Set value
		Format gblsFixedPrintPath as mid(sTmp,1,VarSize(gblsFixedPrintPath))
	
	ElseIf	sTmp = "EXT_PRINTER_PORT"
				
		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		format sTmp as Trim(sTmp)

		// Set value
		Format gblsFixedPrintPort as mid(sTmp,1,VarSize(gblsFixedPrintPort))	
		
	ElseIf	sTmp = "MAX_CHARS_FOR_AMNT_IN_WORDS"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			
			// set value
			gbliMaxAmntInWordsCPL = sTmp

		Else
			
			// set default value
			gbliMaxAmntInWordsCPL = MAX_PRINTABLE_CHARS

		EndIf	

	ElseIf	sTmp = "HEADER_INFO"

		For i = 1 to gbliMaxHIL
				
			// get value (should always be found below the key)
			freadln fn_, sTmp2
			Call stripCrLfCharOff(sTmp2, sTmp)
			format sTmp as Trim(sTmp)

			If sTmp = "ENDHEADER_INFO"
				Break
			EndIf

			// Save current HIL (Header Info Line)
			gblsHeaderInfoLines[i] = mid(sTmp,1,MAX_PRINTABLE_CHARS)
			
		EndFor

	ElseIf	sTmp = "TRAILER_INFO"

		For i = 1 to gbliMaxTIL
				
			// get value (should always be found below the key)
			freadln fn_, sTmp2
			Call stripCrLfCharOff(sTmp2, sTmp)
			format sTmp as Trim(sTmp)

			If sTmp = "ENDTRAILER_INFO"
				Break
			EndIf

			// Save current TIL (Trailer Info Line)
			gblsTrailerInfoLines[i] = mid(sTmp,1,MAX_PRINTABLE_CHARS)
			
		Endfor
		
	ElseIf	sTmp = "SPECIAL_TRAILER_INFO"

		For i = 1 to gbliMaxTIL
				
			// get value (should always be found below the key)
			freadln fn_, sTmp2
			Call stripCrLfCharOff(sTmp2, sTmp)
			format sTmp as Trim(sTmp)

			If sTmp = "END_SPECIAL_TRAILER_INFO"
				Break
			EndIf

			// Save current TIL (Trailer Info Line)
			gblsSpecialTrailerInfoLines[i] = mid(sTmp,1,MAX_PRINTABLE_CHARS)
			
		Endfor
				
	ElseIf	sTmp = "FCR_PZR_TIMEOUT"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""		
			// set value
			 gbliTmtPZR = sTmp
		Else
			// set default value
			 gbliTmtPZR = DEFAULT_FISC_CMD_TMT
		EndIf	
		
	ElseIf	sTmp = "FCR_PXR_TIMEOUT"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""		
			// set value
			 gbliTmtPXR = sTmp
		Else
			// set default value
			 gbliTmtPXR = DEFAULT_FISC_CMD_TMT
		EndIf
	
	ElseIf	sTmp = "FCR_ONFC_TIMEOUT"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""		
			// set value
			 gbliTmtONFC = sTmp
		Else
			// set default value
			 gbliTmtONFC = DEFAULT_FISC_CMD_TMT
		EndIf
	
	ElseIf	sTmp = "FCR_CNFC_TIMEOUT"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""		
			// set value
			 gbliTmtCNFC = sTmp
		Else
			// set default value
			 gbliTmtCNFC = DEFAULT_FISC_CMD_TMT
		EndIf
	
	ElseIf	sTmp = "FCR_PNFI_TIMEOUT"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""		
			// set value
			 gbliTmtPNFI = sTmp
		Else
			// set default value
			 gbliTmtPNFI = DEFAULT_FISC_CMD_TMT
		EndIf
	
	ElseIf	sTmp = "FCR_GS_TIMEOUT"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""		
			// set value
			 gbliTmtGS = sTmp
		Else
			// set default value
			 gbliTmtGS = DEFAULT_FISC_CMD_TMT
		EndIf
	
	ElseIf	sTmp = "FCR_GST_TIMEOUT"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""		
			// set value
			 gbliTmtGST = sTmp
		Else
			// set default value
			 gbliTmtGST = DEFAULT_FISC_CMD_TMT
		EndIf
	
	ElseIf	sTmp = "FCR_GCI_TIMEOUT"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""		
			// set value
			 gbliTmtGCI = sTmp
		Else
			// set default value
			 gbliTmtGCI = DEFAULT_FISC_CMD_TMT
		EndIf
	
	ElseIf	sTmp = "FCR_GFD_TIMEOUT"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""		
			// set value
			 gbliTmtGFD = sTmp
		Else
			// set default value
			 gbliTmtGFD = DEFAULT_FISC_CMD_TMT
		EndIf	
	
	ElseIf	sTmp = "FCR_PFI_TIMEOUT"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""		
			// set value
			 gbliTmtPFI = sTmp
		Else
			// set default value
			 gbliTmtPFI = DEFAULT_FISC_CMD_TMT
		EndIf
	
	ElseIf	sTmp = "FCR_PFT_TIMEOUT"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""		
			// set value
			 gbliTmtPFT = sTmp
		Else
			// set default value
			 gbliTmtPFT = DEFAULT_FISC_CMD_TMT
		EndIf
	
	ElseIf	sTmp = "FCR_CFC_TIMEOUT"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""		
			// set value
			 gbliTmtCFC = sTmp
		Else
			// set default value
			 gbliTmtCFC = DEFAULT_FISC_CMD_TMT
		EndIf
	
	ElseIf	sTmp = "FCR_SD_TIMEOUT"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""		
			// set value
			 gbliTmtSD = sTmp
		Else
			// set default value
			 gbliTmtSD = DEFAULT_FISC_CMD_TMT
		EndIf
	
	ElseIf	sTmp = "FCR_SFP_TIMEOUT"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""		
			// set value
			 gbliTmtSFP = sTmp
		Else
			// set default value
			 gbliTmtSFP = DEFAULT_FISC_CMD_TMT
		EndIf
	
	ElseIf	sTmp = "FCR_GFP_TIMEOUT"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""		
			// set value
			 gbliTmtGFP = sTmp
		Else
			// set default value
			 gbliTmtGFP = DEFAULT_FISC_CMD_TMT
		EndIf
	
	ElseIf	sTmp = "FCR_OFC_TIMEOUT"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""		
			// set value
			 gbliTmtOFC = sTmp
		Else
			// set default value
			 gbliTmtOFC = DEFAULT_FISC_CMD_TMT
		EndIf
	
	ElseIf	sTmp = "FCR_PFDS_TIMEOUT"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""		
			// set value
			 gbliTmtPFDS = sTmp
		Else
			// set default value
			 gbliTmtPFDS = DEFAULT_FISC_CMD_TMT
		EndIf
		
	ElseIf	sTmp = "FCR_GROUPS"

		For i = 1 to MAX_FCR_TENDERS
				
			// get all listed tenders
			
			freadln fn_, sTmp2
			Call stripCrLfCharOff(sTmp2, sTmp)
			format sTmp as Trim(sTmp)

			If Trim(sTmp) = "ENDFCR_GROUPS"
				Break
			EndIf

			// Save current Group Tender
			format gblsDBGrpTender[i] as mid(sTmp,1,42)
			
		EndFor

	ElseIf	sTmp = "FCR_PAYMENTS"

		For i = 1 to MAX_DB_TENDERS
			
			If Not Feof(fn_)
				// get all listed tenders
				
				freadln fn_, sTmp2
				Call stripCrLfCharOff(sTmp2, sTmp)
				format sTmp as Trim(sTmp)

				If Trim(sTmp) <> ""
					// Save current Tender <ObjectNum=TenderGroup> pair
					format gblsDBTender[i] as sTmp
				EndIf
			Else

				// EOF found. Bail out!
				Break
	
			EndIf
			
		endfor
	ElseIf	sTmp = "PRINT_EDI_DOCUMENTS"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			// set value
			gbliUseEDI = sTmp
			
		Else
			// set default value
			gbliUseEDI = 0
		EndIf
		
	ElseIf	sTmp = "DEFAULT_CUSTOMER_RUT"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			// set value
			gblsDefIDNumber = sTmp
			
		Else
			// set default value
			gblsDefIDNumber = "666666666"
		EndIf
	
	ElseIf	sTmp = "DEFAULT_CUSTOMER_NAME"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			// set value
			gblsDefName = sTmp
			
		Else
			// set default value
			gblsDefName = "CLIENTE GENERICO"
		EndIf
		
	ElseIf	sTmp = "DEFAULT_CUSTOMER_ADDR1"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			// set value
			gblsDefAddress1 = sTmp
			
		Else
			// set default value
			gblsDefAddress1 = "DIRECCION GENERICA1"
		EndIf
		
	ElseIf	sTmp = "DEFAULT_CUSTOMER_ADDR2"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			// set value
			gblsDefAddress2 = sTmp
			
		Else
			// set default value
			gblsDefAddress1 = "DIRECCION GENERICA2"
		EndIf
	
	ElseIf	sTmp = "DEFAULT_CUSTOMER_PHONE"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			// set value
			gblsDefTel = sTmp
			
		Else
			// set default value
			gblsDefTel = ""
		EndIf
	
	ElseIf	sTmp = "DEFAULT_CUSTOMER_BUSSAREA"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			// set value
			gblsDefExtra1 = sTmp
			
		Else
			// set default value
			gblsDefExtra1 = ""
		EndIf
	
	ElseIf	sTmp = "EDI_NON_NOMINATIVE_COPIES"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			// set value
			gbliEDINonNomCopies = sTmp
			
		Else
			// set default value
			gbliEDINonNomCopies = 1
		EndIf
	
	ElseIf	sTmp = "EDI_NOMINATIVE_COPIES"

		// get value (should always be found below the key)
		freadln fn_, sTmp2
		Call stripCrLfCharOff(sTmp2, sTmp)
		
		// check its validity
		If trim(sTmp) <> ""
			// set value
			gbliEDINomCopies = sTmp
			
		Else
			// set default value
			gbliEDINomCopies = 2
		EndIf

	EndIf

EndSub

//******************************************************************
// Procedure: setMaxHeaderTrailerInfoLines()
// Author: Al Vidal
// Purpose: Sets the maximum number of Header and Trailer Info 
//			Files
// Parameters:
//	-
//******************************************************************
Sub setMaxHeaderTrailerInfoLines()

	// get max HIL\TIL
	gbliMaxHIL = MAX_HIL
	gbliMaxTIL = MAX_TIL

EndSub

//******************************************************************
// Procedure: printCustomerReceipt()
// Author: Alex Vidal
// Purpose: Calls the necessary routines to print a Customer
//			receipt for the current Check
// Parameters:
//	-
//******************************************************************
Sub printCustomerReceipt()

	var fn						: N5  // File Handle
	var sPrintLine				: A50
	var iCustRcptGenerated	: N1	
	var iDocCount				: N4
	var iAnswer					: N1
	var iLoop					: N1 = TRUE
	var iHasNonEmittingTndr	: N1
	var iReprinting			: N1 = FALSE
	var iFCROK					: N1 = FALSE
	var iEDIResult			: N5
	var x								: N2 //For looping


	// Check if we should print an invoice or not
	Call CheckNonEmittingTndr(iHasNonEmittingTndr)
	
	if iHasNonEmittingTndr
		// Non-invoice-emitting tender detected. Bail out!
		Return
	endif
	
	if gbliUseEDI
		Prompt "Consolidando Doc. Electronico"
		
		call SendConsDocEDI(iEDIResult)
		
		if iEDIResult <> 0
			exitCancel
		endif
	endif
	
	// select invoice type
	if not gbliUseEDI
		call selectInvoiceType()
	//else
	//	gbliInvoiceType = INV_TYPE_BOLETA
	endif
	
	if gbliInvoiceType = INV_TYPE_BOLETA and gbliPrintBOLETAonLCL = PRINT_ON_FISCAL
		// reset number of printed lines for fiscal printing
		gbliFCRPrintedLines = 0
		gblcAccumSubtotal = 0.00
	endif


	while iLoop
	//if gbliInvoiceType <> INV_TYPE_BOLETA or (gbliInvoiceType = INV_TYPE_BOLETA and \
	if (gbliInvoiceType = INV_TYPE_BOLETA and \
			gbliPrintBOLETAonLCL <> PRINT_ON_FISCAL and not gbliUseEDI)
			
			// ----------------------------------
			// Print on standard printer
			// ----------------------------------
			
			// write the file that will
			// contain the Customer Receipt Lines
			Call generateCustRcptFile(iCustRcptGenerated, iDocCount)
	
			// If Customer Receipt File was not
			// generated then abort printing.
			If Not iCustRcptGenerated
				Return //  bail out!
			EndIf
			
			// Print generated Customer receipt
			Call PrintCoupon(iDocCount)
			
			// Check if printing confirmation is necessary
			if gbliConfirmPrintJob
				call promptYesOrNo(iAnswer, "Se imprimio correctamente?")
				iLoop = Not iAnswer
			else
				iLoop = FALSE
			endif
		
		else
			
			// ----------------------------------
			// Print on Fiscal Printer (BOLETA)
			// ----------------------------------
			
			if gbliUseEDI
				if gbliInvoiceType = INV_TYPE_BOLETA
					for x = 1 to gbliEDINonNomCopies
						Prompt "Imprimiendo Doc. Elec."
						if x=1
							call PrintFCRCoupon(iFCROK,iReprinting, TRUE, FALSE)
						else
							call PrintFCRCoupon(iFCROK,iReprinting, TRUE, TRUE)
						endif
					endfor
				else
					for x = 1 to gbliEDINomCopies
						Prompt "Imprimiendo Doc. Elec."
						if x=1
							call PrintFCRCoupon(iFCROK,iReprinting, TRUE, FALSE)
						else
							call PrintFCRCoupon(iFCROK,iReprinting, TRUE, TRUE)
						endif
					endfor
				endif
			else
				Prompt "Imprimiendo Doc. Fiscal"
				call PrintFCRCoupon(iFCROK,iReprinting, FALSE, FALSE)
			endif
			
			If Not iFCROK
				// An error ocurred. While trying to print
				// the FCR Coupon. Ask user if he wants to 
				// try again...
				if gbliConfirmPrintJob
					call promptYesOrNo(iAnswer, "Desea reintentar la impresion?")
		
					If Not iAnswer
						Call logInfo(ERROR_LOG_FILE_NAME,"Employee answered 'NO' when prompted for printing retry",TRUE,TRUE)
					   Return // bail out!
					else
						iReprinting = TRUE
					EndIf
				else
					iReprinting = TRUE
					ErrorMessage "Se intentara continuar con la impresion"
				endif
			else
				iLoop = not iFCROK
			EndIf
			
		endif
	
	EndWhile

EndSub

//******************************************************************
// Procedure: SendGenDocEDI()
// Based on : printCustomerReceipt
// Author: Alex Vidal
// Modified : C Sepulveda
// Purpose: Calls the necessary routines to print a Customer
//		receipt for the current Check and to send it to EDI Interface
// Parameters:
//
//******************************************************************
Sub SendGenDocEDI()

	var x		: N8  // for looping
	var y		: N8  // for looping
	var i		: N8  // for looping

	var sTmpFormat			: A200	// for formating Customer Receipt lines
	var sTmpFormat2		: A100	// for formating Customer Receipt lines
	var sTmpFormat3		: A100	// for formating Customer Receipt lines
	var iTmp					: N1	// for storing temporary "numeric" values
	var CTmp					: $12	// for storing temporary "currency" values
	var sInvNumber			: A10	// "numeric" portion of an invoice number
	var iCalcPrintJobs	: N4	// FIP calculated print jobs (should match PTP print jobs)
	var iMaxNumItems		: N9	// Maximum number of items per print job (for current invoice type)
	var sCouponNumber[50]	: A14	// for saving invoice (coupon) numbers
	var sCouponSubtotal[50]	: A40	// for saving per-page PTP subtotals (multi-page docs)
	var sTransport			: A1	// Transport identifier for DB records
	var sDate				: A20	// for saving current date
	var sTime				: A20	// for saving current time
	var iNewItem			: N1	// boolean for checking if there's a new
										// item to add in the consolidated group
	var iExtraItemCount	: N9	// for tracking extra items
	var caSITax[16]		: $12	// for storing Sales Itemizer taxes
	var iCkNum				: N4	// Micros Check number

	var MI_Qty[@Numdtlt]				:  N5			// Menu Item Grouped Quantities
	var MI_Name[@Numdtlt]			:  A24		// Menu Item Grouped Names
	var MI_Ttl[@Numdtlt]				:  $12		// Menu Item Grouped Totals
	var MI_NTtl[@Numdtlt]			:  $12		// Menu Item Grouped Net Totals
	var MI_UnitPrc[@Numdtlt]		:  $12		// Menu Item Unit Price
	var MI_ObjNum[@Numdtlt]			:  N7			// Menu Item Object Number
	var MI_MnuLvl[@Numdtlt]	 		:  N7			// Menu Item Menu level
	var MI_PrcLvl[@Numdtlt]	 		:  N7			// Menu Item Price level
	var MI_DefSeq[@NUMDTLT]			:	N7			// Menu Item Definition Sequence
	var MI_Tax[@Numdtlt]				:  $12		// Menu Item Taxes amount	
	Var MI_NetUPrice[@Numdtlt]	: $12		//Menu Item Unit Net Price
	Var MI_NetTotal[@Numdtlt]		:	$12		//Menu Item NetTotal
	var MI_Count						:  N5 = 0	// Menu Item Counter
	var cMI_UnitPrc					:  $12
	var cMI_Tax				 		:  $12
	var sMI_TaxRate			 	:  A12

	var DS_Name[@Numdtlt]	 		:	A24		// Discount Grouped Names
	var DS_Ttl[@Numdtlt]	 			:	$12		// Discount Grouped Totals
	var DS_Tax[@Numdtlt]				:  $12		// Discount Item Taxes amount	
	var DS_ObjNum[@Numdtlt]	 		:  N12		// Discount Object Number
	var DS_Count			 			:  N5 = 0	// Discount Counter

	var SV_Name[@Numdtlt]	 		:	A24		// Service Grouped Names
	var SV_Ttl[@Numdtlt]	 			:	$12		// Service Grouped Totals
	var SV_Tax[@Numdtlt]				:  $12		// Menu Item Taxes amount	
	var SV_ObjNum[@Numdtlt]	 		:  N5			// Service Object Number
	var SV_Count			 			:  N5 = 0	// Service Counter

	var cChange				 			:  $12 = 0.00 // Change Due
	var cChargedTip			 		:  $12		// Charged Tip for all tenders
	var cDS_Tax				 			:  $12

	var cSubtotal			 			:  $12		// Subtotal (tax included | tax excluded) value for Check
	var cBurdenSubtotal		 		:  $12		// 'Burden Subtotal' value for Check (in Spanish: 'Subtotal de gravados')
	var cExemptSubtotal		 		:  $12		// 'Exempt Substotal' value for Check (in Spanish: 'Subtotal de no gravados')
	var cNetSubtotal					:  $12		// 'Net Subtotal' value for Check (in Spanish: 'Subtotal Neto')
	var cTaxSubtotal		 			:  $12		// Tax Subtotal value for Check
	var cCalcTaxSubtotal	 			:  $12		// Calculated Tax Subtotal value, based on the MI_Tax array
	var cItemsNetSubtotal		 	:  $12		// Items Net Subtotal value for Check
	var cDiscSubtotal		 			:  $12		// Discounts Subtotal value for Check
	var cServSubtotal		 			:  $12		// Services Subtotal value for Check
	var cDiscTaxSubtotal		 		:  $12		// Discounts Tax Subtotal value for Check
	var cServTaxSubtotal		 		:  $12		// Services Tax Subtotal value for Check
	var cRoundingAdj		 			:  $12		// Used for Rounding adjustments to Check Calculated TOTAL
	Var cRoundingAdjEDI	 		: $12		// Used for Rounding adjustments to Check Calculated TOTAL
	var cTotal				 			:  $12	    // Total value for Check
	Var sSeparator					:A1 ="|"
	Var cTmpNetUP						: $12 //For temporaries amount
	Var iTmpQty								: $12 //For Temporary Qty
	
	Var iReturnEDI					:N3


	// Cust. Receipt file has not yet been generated...
	iCkNum = @CKNUM
	//CustRcptGenerated_ = FALSE

	// ***********************************************
	// Step #1
	// cycle through the check's items and group them
	// ***********************************************
	
	For x = 1 to @Numdtlt

		If @Dtl_Type[x] = DT_MENU_ITEM

			// --------------------------------------
			//				Group MIs
			// --------------------------------------

			If @DTL_TTL[x] <> 0  
				iNewItem = TRUE	 // Initialize flag

				// Check to see if current "x" menu item (from outer loop) is 
				// in the MI_ "y" array. If so, consolidate its total into the current
				// "y" item. Otherwise, generate a new item in the "y" MI_ array.

				For y = 1 to MI_Count
					
					if Not bit(@Dtl_Typedef[x],DTL_ITEM_OPEN_PRICED) and \
						Not bit(@Dtl_Typedef[x],DTL_ITEM_IS_WEIGHED)
				
						//Check if its shared Item
						If @Dtl_Qty[x] = 0 and @Dtl_Ttl[x] <> 0.00
							//This is a shared Item, It must be added as new Item
							break
						endif
						
						If @Dtl_Objnum[x] = MI_ObjNum[y] and @Dtl_Plvl[x] = MI_PrcLvl[y] and \
								@DTL_DEFSEQ[x] = MI_DefSeq[y] and @DTL_MLVL[x] = MI_MnuLvl[y] 						
							 
							MI_Qty[y] = MI_Qty[y] + @Dtl_Qty[x] // Acumulate Qty
							//MI_Ttl[y] = MI_Ttl[y] + @Dtl_ttl[x] // Acumulate Value
							call getMITax(cMI_Tax,sMI_TaxRate,x)
							MI_Tax[y] = MI_Tax[y] + @Dtl_taxttl[x]		// Acumulate Tax
							if gbliTaxIsInclusive
								MI_Ttl[y] = MI_Ttl[y] + @Dtl_ttl[x] 
							else
								MI_Ttl[y] = MI_Ttl[y] + @Dtl_ttl[x] + cMI_Tax
							endif
							iNewItem = FALSE // Don't add this item!
							Break
						Endif
					else
						// Weighed and open-priced items should not be 
						// accumulated (Unit prices may vary)
						Break
					endif
				EndFor

				If iNewItem
					// add a new item to the MI counter
					MI_Count = MI_Count + 1
										
					// Add a new item to the MI_ group array
					
					MI_Name[MI_Count] = @Dtl_Name[x]
					
					call getMITax(cMI_Tax,sMI_TaxRate,x)
					MI_ObjNum[MI_Count] = @Dtl_Objnum[x]
					MI_MnuLvl[MI_Count] = @DTL_MLVL[x]
					MI_PrcLvl[MI_Count] = @DTL_PLVL[x]
					MI_DefSeq[MI_Count] = @DTL_DEFSEQ[x] 

					MI_Tax[MI_Count] = cMI_Tax
					call getMIUnitPrice(cMI_UnitPrc,x,MI_Tax[],MI_Count,gbliTaxIsInclusive)
					
					MI_UnitPrc[MI_Count] = cMI_UnitPrc
					if gbliTaxIsInclusive
						MI_Ttl[MI_Count]  = @Dtl_Ttl[x]
					else
						MI_Ttl[MI_Count]  = @Dtl_Ttl[x] + cMI_Tax
					endif
					
					If MI_UnitPrc[MI_Count] = 0.00
						MI_Qty[MI_Count]  = 1
						MI_NetUPrice[MI_Count] = @Dtl_Ttl[x] - Abs(cMI_Tax)
					else
						MI_Qty[MI_Count]  = @Dtl_Qty[x]
						MI_NetUPrice[MI_Count] = cMI_UnitPrc - Abs(cMI_Tax / @Dtl_Qty[x])
					endif
					

				EndIf

			EndIf
	
		ElseIf @Dtl_Type[x] = DT_DISCOUNT

			// --------------------------------------
			//				Group Discounts
			// --------------------------------------
  
			if Not @Dtl_is_void[x] or gbliInvoiceType = INV_TYPE_CREDITO

				iNewItem = TRUE	 // Initialize flag

				// Check to see if current "x" Discount (from outer loop) is 
				// in the DS_ "y" array. If so, consolidate its total into the current
				// "y" Discount. Otherwise, generate a new Discount in the "y" DS_ array.

				For y = 1 to DS_Count

					If @Dtl_Objnum[x] = DS_ObjNum[y]
	
						Call getDS_SVTax(cDS_Tax, x)
						if gbliTaxIsInclusive
							DS_Ttl[y] = DS_Ttl[y] + @Dtl_ttl[x] // Acumulate Value
						else
							DS_Ttl[y] = DS_Ttl[y] + (@Dtl_ttl[x] + cDS_Tax)
						endif
						
						DS_Tax[y] = DS_Tax[y] + cDS_Tax // Acumulate Value
						iNewItem = FALSE // Don't add this item!
						Break
					Endif

				EndFor

				If iNewItem
					// add a new item to the DS counter
					DS_Count = DS_Count + 1
					
					Call getDS_SVTax(cDS_Tax, x)
					// Add a new item to the DS_ group array
					DS_Name[DS_Count] = @Dtl_Name[x]
					DS_Ttl[DS_Count]  = @Dtl_Ttl[x]
					DS_Tax[DS_Count]  = cDS_Tax
					DS_ObjNum[DS_Count] = @Dtl_Objnum[x]

				EndIf
			endif

		ElseIf @Dtl_Type[x] = DT_SERVICE_CHARGE

			// --------------------------------------
			//				Group Services
			// --------------------------------------

			if (@Dtl_Ttl[x] > 0 and Not @Dtl_is_void[x]) or \
				gbliInvoiceType = INV_TYPE_CREDITO

				iNewItem = TRUE	 // Initialize flag

				// Check to see if current "x" Service (from outer loop) is 
				// in the SV_ "y" array. If so, consolidate its total into the current
				// "y" Service. Otherwise, generate a new Service in the "y" SV_ array.

				For y = 1 to SV_Count

					If @Dtl_Objnum[x] = SV_ObjNum[y]

						SV_Ttl[y] = SV_Ttl[y] + @Dtl_ttl[x] // Acumulate Value
						SV_Tax[y] = SV_Tax[y] + @Dtl_taxttl[x] // Acumulate Value
						iNewItem = FALSE // Don't add this item!
						Break
					Endif

				EndFor

				If iNewItem
					// add a new item to the SV counter
					SV_Count = SV_Count + 1
					
					// Add a new item to the SV_ group array
					SV_Name[SV_Count] = @Dtl_Name[x]
					SV_Ttl[SV_Count]  = @Dtl_Ttl[x]
					SV_Tax[DS_Count]  = @Dtl_taxTtl[x]
					SV_ObjNum[SV_Count] = @Dtl_Objnum[x]

				EndIf

				// Accumulate Services Subtotal
				cServSubtotal = cServSubtotal + @Dtl_Ttl[x]
			EndIf
		Endif

	Endfor
		
	if  not gbliTaxIsInclusive
		// add TAX "item" for BOLETA when using add-on tax types 
		// so that subtotal values match
		Call getTaxesSubtotal(cTaxSubtotal)
		MI_Count = MI_Count + 1
		MI_Qty[MI_Count]  = 1
		MI_Name[MI_Count] = "Impuesto"
		MI_Ttl[MI_Count]  = cTaxSubtotal
		MI_UnitPrc[MI_Count] = MI_Ttl[MI_Count]
	endif

	
	// ***********************************************
	// Step #2
	// calculate subtotals and totals
	// ***********************************************

	// set "Charged Tip" amount (we cannot use the 
	// "@ChgTip" system var since it only returns the 
	// charged tip amount for the last posted tender)
	cChargedTip = (@Svc - cServSubtotal)

	// Set Services amount (we cannot use the "@Svc"
	// system var since we are manipulating the check
	// total depending on user configuration for this
	// FIP)
	//If gbliAddChargedTipToTotal[gbliInvoiceType]
		// Tip is considered a service charge
		cServSubtotal = @Svc + @Autosvc
	//Else
		// Tip is not a service charge
	//	cServSubtotal = @Svc + @Autosvc - cChargedTip
	//EndIf


	// ----------------------------------------
	// Set subtotals and totals
	// ----------------------------------------
	// We will process all transactions as FACTURA
	// to have the taxes calculed.
			
	// Subtotals for "BOLETA" invoice
	
		// get Tax subtotal
		call getTaxesSubtotal(cTaxSubtotal)
	
		// get subtotal (Gross subtotal)
		call getCheckSubtotal(cSubtotal, MI_Ttl[], cTaxSubtotal, MI_Count, FALSE)
	
		// get calculated Tax subtotal (for 'rounding' issues)
		cCalcTaxSubtotal = cTaxSubtotal
	
		// get Discounts subTotal
		call getDiscountSubtotal(cDiscSubtotal, DS_Ttl[], DS_Count)
		
		// get Discount tax subTotal
		call getDiscountSubtotal(cDiscTaxSubtotal, DS_Tax[], DS_Count)  // (Function accumulates values from the passed array)
	
		// get TOTAL
		cTotal = (cSubtotal + cServSubtotal) + cDiscSubtotal
		
		cNetSubTotal = cSubTotal - cTaxSubTotal + cDiscSubtotal
		
	// check 'rounding' issues 

	If cTaxSubtotal <> 0.00
		cRoundingAdj = cTaxSubtotal - cCalcTaxSubtotal
	Else
		cRoundingAdj = 0.00
	EndIf

	// check for total amount and act depending on the
	// configuration settings...
	// This validation will remain commented until 
	// EDI Credit note can be implemented.
	if gbliInvoiceType <> INV_TYPE_CREDITO
		If Not gbliPrintWhenAmount0
			If cTotal <= 0.00
				ErrorMessage "El total de la cuenta no supera los $0.00"
				ErrorMessage "No se imprimira factura"
				exitcancel
			EndIf
		EndIf
	endif

	// ***********************************************
	// Step #3
	// Now that we will send information to EDI
	// interface to generate Fiscal Document 
	// ***********************************************
	
	Prompt "Generando Doc. Electronico"
	
	
	if gbliInvoiceType = INV_TYPE_FACTURA
		For y = 1 to MI_Count
		
			MI_NetTotal[y] = Abs(MI_NetUPrice[y] * MI_Qty[y])
					
			format sTmpFormat as y, sSeparator, MI_Name[y], sSeparator, MI_NetUPrice[y], sSeparator, MI_Qty[y], sSeparator, MI_NetTotal[y]
						
			if gblhEDI <> 0
	  		DLLCall gblhEDI, fnAddItemCL(ref sTmpFormat)
	  	else
				errormessage "gblhEDI error on fnAddItemCL"
			endif
	  	
		EndFor
	elseif gbliInvoiceType = INV_TYPE_CREDITO
		For y = 1 to MI_Count
		
			if MI_NetUPrice[y] < 0.00
				cTmpNetUP = MI_NetUPrice[y] * -1
			else
				cTmpNetUP = MI_NetUPrice[y]
			endif
			
			if MI_Qty[y] < 0.00
				iTmpQty = MI_Qty[y] * -1
			else
				iTmpQty = MI_Qty[y]
			endif
		
			MI_NetTotal[y] = cTmpNetUP * iTmpQty
			
			format sTmpFormat as y, sSeparator, MI_Name[y], sSeparator, cTmpNetUP , sSeparator, MI_Qty[y], sSeparator, MI_NetTotal[y]
						
			if gblhEDI <> 0
	  		DLLCall gblhEDI, fnAddItemCL(ref sTmpFormat)
	  	else
				errormessage "gblhEDI error on fnAddItemCL"
			endif
		EndFor
		
		if gblsNCReferenceInvType = 1
			sTmpFormat2 = "39"
		elseif gblsNCReferenceInvType = 2
			sTmpFormat2 = "33"
		else
			sTmpFormat2 = "0"
		EndIf
		
		Prompt "Enviando Info Nota de Cred"
		
		format sTmpFormat as "1", sSeparator, sTmpFormat2, sSeparator, " ", sSeparator, \
					gblsNCReferenceInvNumber, sSeparator, " ", sSeparator, " ", sSeparator, "1", sSeparator, \
					gblsNCReferenceReason
						
		if gblhEDI <> 0
			DLLCall gblhEDI, fnAddNCDetCL(ref sTmpFormat)
		else
			errormessage "gblhEDI error on fnAddNCDetCL"
		endif
	else
		For y = 1 to MI_Count
		
			format sTmpFormat as y, sSeparator, MI_Name[y], sSeparator, MI_UnitPrc[y], sSeparator, MI_Qty[y], sSeparator, MI_Ttl[y]
						
			if gblhEDI <> 0
	  		DLLCall gblhEDI, fnAddItemCL(ref sTmpFormat)
	  	else
				errormessage "gblhEDI error on fnAddItemCL"
			endif
	  	
		EndFor
	endif
	
	cRoundingAdjEDI = cTotal - (cNetSubtotal + cTaxSubtotal)
	
	if cRoundingAdjEDI <> 0.00
		cTaxSubtotal = cTaxSubtotal + cRoundingAdjEDI
	Endif
	
	cDiscSubtotal = Abs(cDiscSubtotal)

	cDiscTaxSubtotal = Abs(cDiscTaxSubtotal)
	
	if gblhEDI <> 0
	
		if DS_Count > 1
			DS_Count=1
		endif
		
		if gbliInvoiceType = INV_TYPE_BOLETA
		
			call removeDecimals(cDiscSubtotal, sTmpFormat3)
	
			format sTmpFormat as "BOLETA", sSeparator, MI_Count, sSeparator, cTotal, sSeparator, \
											gblsDefIDNumber, sSeparator, \
											gblsDefName, sSeparator, \
											gblsDefAddress1, sSeparator, \
											gblsDefAddress2, sSeparator, \
											gblsDefExtra1, sSeparator, \
											" ", sSeparator, \
											cNetSubtotal, sSeparator, \
											"0", sSeparator, \
											cTaxSubtotal, sSeparator, \
											gblsDefaultTaxRate, sSeparator, \
											"DESCUENTO ", sSeparator, \
											sTmpFormat3, sSeparator, \
											DS_Count
											
											
											
			DLLCall gblhEDI, fnCloseDocBol(ref sTmpFormat)
		endif
		
		if gbliInvoiceType = INV_TYPE_FACTURA
		
			call removeDecimals((cDiscSubtotal - cDiscTaxSubtotal), sTmpFormat3)
			
			format stmpformat2 as mid(gblsIDNumber, 1,len(gblsIDNumber)-1), "-", mid(gblsIDNumber, len(gblsIDNumber), 1)
			
			format sTmpFormat as "FACTURA", sSeparator, MI_Count, sSeparator, cTotal, sSeparator, \
											stmpformat2, sSeparator, \
											gblsName, sSeparator, \
											gblsAddress1, sSeparator, \
											gblsAddress2, sSeparator, \
											gblsExtra1, sSeparator, \
											" ", sSeparator, \
											cNetSubtotal, sSeparator, \
											"0", sSeparator, \
											cTaxSubtotal, sSeparator, \
											gblsDefaultTaxRate, sSeparator, \
											"DESCUENTO ", sSeparator, \
											sTmpFormat3, sSeparator, \
											DS_Count
											
			DLLCall gblhEDI, fnCloseDoceFac(ref sTmpFormat)
		endif
		
		if gbliInvoiceType = INV_TYPE_CREDITO
		
			call removeDecimals((cDiscSubtotal - cDiscTaxSubtotal), sTmpFormat3)
			
			format stmpformat2 as mid(gblsIDNumber, 1,len(gblsIDNumber)-1), "-", mid(gblsIDNumber, len(gblsIDNumber), 1)
			
			format sTmpFormat as "FACTURA", sSeparator, MI_Count, sSeparator, Abs(cTotal), sSeparator, \
											stmpformat2, sSeparator, \
											gblsName, sSeparator, \
											gblsAddress1, sSeparator, \
											gblsAddress2, sSeparator, \
											gblsExtra1, sSeparator, \
											" ", sSeparator, \
											"1" , sSeparator, \
											abs(cNetSubtotal), sSeparator, \
											"0", sSeparator, \
											Abs(cTaxSubtotal), sSeparator, \
											gblsDefaultTaxRate, sSeparator, \
											"DESCUENTO ", sSeparator, \
											sTmpFormat3, sSeparator, \
											DS_Count
											
			DLLCall gblhEDI, fnCloseDoceNC(ref sTmpFormat)
		endif
 	else
		errormessage "gblhEDI error on fnCloseDoc"
	endif
 	
 	if gblhEDI <> 0
 		DLLCall gblhEDI, fnSocketTest(ref sTmpFormat)
 	else
			errormessage "Error al Generar eDoc"
	endif
 	
 	Split sTmpFormat, ";", iReturnEDI, sTmpFormat3
 	
 	if ireturnEDI<>0
 		errormessage sTmpFormat3
 		exitcancel
 	else
 		split sTmpFormat3, "|", gblsInvoiceNumEDI, gblsGUIDEDI, gblsEDIStatus
 		
 	endif
EndSub

//******************************************************************
// Procedure: SendConsDocEDI()
// Author: C Sepulveda
// Purpose: Execute the Consolidate Process for current EDI Document
// Parameters:
//	- iResult_  : Indicates the result of the process
//******************************************************************
Sub SendConsDocEDI(ref iEDIResult_)
Var sResponse 			:A1600
Var iTmpResult			:N2
Var sTmpFormat			:A200
var sTmpEDI					:A1500

	iTmpResult=99
	
	if gblhEDI <> 0
		DLLCall gblhEDI, fnConsDoc(ref gblsGUIDEDI)
		
  	DLLCall gblhEDI, fnSocketTestCons(ref sResponse)
  	
  	split sResponse, "|", iTmpResult, gblsEDICode
  	
		if iTmpResult <> 0
			errormessage trim(gblsEDICode)
			exitcancel
		else
		 	format sTmpEDI as trim(gblsEDICode){<1023}
  		format gblsEDICode as sTmpEDI
  	endif
  	iEDIResult_ = iTmpResult 

  endif
  	
EndSub

//******************************************************************
// Procedure: SendCancelDocEDI()
// Author: C Sepulveda
// Purpose: Execute the Cancel Process for current EDI Document
// Parameters:
//	
//******************************************************************
Sub SendCancelDocEDI()
Var sResponse 			:A1600
Var iTmpResult			:N2
Var sTmpFormat			:A200

	iTmpResult=99
	
	if gblhEDI <> 0
		if trim(gblsGUIDEDI) <> ""
						
			DLLCall gblhEDI, fnCancelDoc(gblsGUIDEDI)
			
			DLLCall gblhEDI, fnSocketTestCancel(ref sResponse)
  	
  		split sResponse, "|", iTmpResult, gblsEDICode
  	
		if iTmpResult <> 0
			errormessage trim(gblsEDICode)
			exitcancel
  	endif
  	
  	format gblsGUIDEDI as ""
  	format gblsEDICode as ""
  endif
  	
EndSub
//******************************************************************
// Procedure: printCoupon()
// Author: Alex Vidal
// Purpose: Prints the corresponding fiscal coupon, according
//				to the active invoice type
// Parameters:
//	- iDocCount_ = number of print jobs to be done
//******************************************************************
Sub printCoupon( var iDocCount_ : N4 )

	var sPrntFN				: A300
	var iPrintOnLocal		: N1
	var sLineInfo			: A200
	var sBuffer				: A2000
	var i						: N4
	var sPrompt				: A100
	var sCmd					: A500
	var iRet 				: N4
	var sTmp					: A500
	var iTrailQuotes		: N5
	var iTotalQuotes		: N5
	var iStatus      		: N12
	var sResponse    		: A100
	

	for i = 1 to iDocCount_

		// Read the Customer Receipt file and print
		// one line at a time
		
		// set path to print file
		Call getInvPrintPath(sPrntFN, iPrintOnLocal)
	
		// add proper extension # to filename if necessary and
		// set prompt legend
		if iDocCount_ > 1
			Format sPrntFN as sPrntFN, "_", i
			Format sPrompt as "Imprimiendo Comprob. ", i, " de ", iDocCount_, "..."
		else
			Format sPrompt as "Imprimiendo Comprobante..."
		endif
		
	
		if iPrintOnLocal
	
			// print on local SAROPS/Winstation printer
			
			if @WSTYPE = SAROPS
				FOpen fn, sPrntFN, read, local
			else
				FOpen fn, sPrntFN, read
			endif
			
			If fn <> 0 
				// File found! 
				
				Prompt sPrompt
		
				if @WSTYPE = SAROPS
					StartExPrint 1 // Print on local printer
				else
					StartPrint @RCPT // Print on Receipt printer
				endif
				
				While not Feof(fn)
					// read info
					freadln fn, sLineInfo
					// remove double quotes ("") from record (if any)
					format sTmp as sLineInfo
					call getDoubleQuotesInfo(sLineInfo, iTrailQuotes, iTotalQuotes)
					format sLineInfo as mid(sTmp, iTrailQuotes + 1, (len(sTmp) - iTotalQuotes) )
					// print it!
					printline sLineInfo
				EndWhile
				EndPrint
		
				// Close handle to file				
				fclose fn
			Else
				// File is not there...
				errorMessage "The Customer Receipt File was not found! Printing aborted"
				call logInfo(ERROR_LOG_FILE_NAME,"The Customer Receipt File was not found. Printing aborted",TRUE,TRUE)
			EndIf
		else
			
			// print on external printer
			
			if @WSTYPE = SAROPS
				
				// print job on external printer (SAROPS). Format DOS command and execute on system
				Format sCmd as "TYPE ", chr(CHAR_DOUBLE_QUOTE), sPrntFN, chr(CHAR_DOUBLE_QUOTE), " > ", gblsFixedPrintPort
				Call execSystemCmd(sCmd, iRet)
				
				if iRet <> 0
					// an error occurred. Warn user and  log it
					ErrorMessage "An error occurred while trying to print on external printer"
					Format sTmp as "The RPROC command returned the following error: #", iRet, " (printCoupon)"
					call logInfo(ERROR_LOG_FILE_NAME,sTmp,TRUE,TRUE)
					Format sTmp as "command sent to RPROC: ", sCmd, " (printCoupon)"
					call logInfo(ERROR_LOG_FILE_NAME,sTmp,TRUE,TRUE)
				endif
				
				// Check for pauses between print jobs
				if gbliPrintJobsPause > 0
					MSleep(gbliPrintJobsPause)
				endif
			
			else
				
				// On Winstation clients, print on OKI 490 (or compatible) printer
				
				FOpen fn, sPrntFN, read
				
				If fn <> 0 
					// File found! 
					
					Format sBuffer as ""
					Prompt sPrompt
					
					While not Feof(fn)
						// read info
						freadln fn, sLineInfo
						// remove double quotes ("") from record (if any)
						format sTmp as sLineInfo
						call getDoubleQuotesInfo(sLineInfo, iTrailQuotes, iTotalQuotes)
						format sLineInfo as mid(sTmp, iTrailQuotes + 1, (len(sTmp) - iTotalQuotes) )
						
						// print it!
						if gbliPrintJobBufChrs = 0
							FiscalPrint iStatus, sResponse, "1",sLineInfo, chr(10)
						else
							Format sBuffer as sBuffer, sLineInfo, chr(10)
							if Len(sBuffer) >= gbliPrintJobBufChrs
								FiscalPrint iStatus, sResponse, "1",sBuffer
								Format sBuffer as ""
							endif
						endif
							
						if iStatus <> 0
							Call checkExtPrintStatus(iStatus)
							Return // Bail out!
						endif
						
					EndWhile
					
					// print remaining printlines if buffering....
					if gbliPrintJobBufChrs > 0 and sBuffer <> ""
						FiscalPrint iStatus, sResponse, "1",sBuffer
						if iStatus <> 0
							Call checkExtPrintStatus(iStatus)
							Return // Bail out!
						endif
						Format sBuffer as ""
					endif
			
					// Close handle to file				
					fclose fn
				else
					// File is not there...
					errorMessage "The Customer Receipt File was not found! Printing aborted"
					call logInfo(ERROR_LOG_FILE_NAME,"The Customer Receipt File was not found. Printing aborted",TRUE,TRUE)
				endif
				
			endif
	
		endif
			
	endfor

EndSub

//******************************************************************
// Procedure: setExtraFiscalInfo()
// Author: Alex Vidal
// Purpose: Asks for extra fiscal information
// Parameters:
//
// Note: The "selectInvoiceType()" function must always be called 
//		 prior to using this function.
//
//******************************************************************
Sub setExtraFiscalInfo()

	If gbliInvoiceType = INV_TYPE_FACTURA or \
		gbliInvoiceType = INV_TYPE_GUIA or \
		gbliInvoiceType = INV_TYPE_CREDITO
		
		// get customer fiscal information
		call getFiscalData()
		
	elseIf gbliInvoiceType = INV_TYPE_CREDITO
		
		// get extra info for "Nota de Credito" invoice
		Call valuePrompt(gblsCreditInfo, "comprob. asociado?", TRUE)
		
	EndIf

EndSub

//******************************************************************
// Procedure: generateCustRcptFile()
// Author: Al Vidal
// Purpose: Writes the file that contains the Customer Receipt
//			lines to be printed
// Parameters:
//	- CustRcptGenerated_ = Returns TRUE if Customer Receipt file
//						   was generated successfully
//
//******************************************************************
Sub generateCustRcptFile( ref CustRcptGenerated_, ref iDocCount_ )

	var x		: N8  // for looping
	var y		: N8  // for looping
	var i		: N8  // for looping
	var fn			: N5  // for file manipulation
	var iDllRet		: N4  // Dll return code
	var sTmpFile 	: A256 // Path to template file
	var sPDocFile 	: A256 // Path to Print doc file

	var sTmpFormat			: A100	// for formating Customer Receipt lines
	var sTmpFormat2		: A100	// for formating Customer Receipt lines
	var sTmpFormat3		: A100	// for formating Customer Receipt lines
	var iTmp					: N1	// for storing temporary "numeric" values
	var CTmp					: $12	// for storing temporary "currency" values
	var sPTPStr				: A(PTP_MAX_REC_LEN) // used for sending check data to PTP.dll
	var sInvSeries			: A3	// "series" portion of an invoice number
	var sInvNumber			: A10	// "numeric" portion of an invoice number
	var iCalcPrintJobs	: N4	// FIP calculated print jobs (should match PTP print jobs)
	var iMaxNumItems		: N9	// Maximum number of items per print job (for current invoice type)
	var sCouponNumber[50]	: A14	// for saving invoice (coupon) numbers
	var sCouponSubtotal[50]	: A40	// for saving per-page PTP subtotals (multi-page docs)
	var sTransport			: A1	// Transport identifier for DB records
	var sDate				: A20	// for saving current date
	var sTime				: A20	// for saving current time
	var iNewItem			: N1	// boolean for checking if there's a new
										// item to add in the consolidated group
	var iExtraItemCount	: N9	// for tracking extra items
	var caSITax[16]		: $12	// for storing Sales Itemizer taxes
	var iCkNum				: N4	// Micros Check number

	var MI_Qty[@Numdtlt]				:  N5			// Menu Item Grouped Quantities
	var MI_Name[@Numdtlt]			:  A24		// Menu Item Grouped Names
	var MI_Ttl[@Numdtlt]				:  $12		// Menu Item Grouped Totals
	var MI_NTtl[@Numdtlt]			:  $12		// Menu Item Grouped Net Totals
	var MI_UnitPrc[@Numdtlt]		:  $12		// Menu Item Unit Price
	var MI_ObjNum[@Numdtlt]			:  N7			// Menu Item Object Number
	var MI_MnuLvl[@Numdtlt]	 		:  N7			// Menu Item Menu level
	var MI_PrcLvl[@Numdtlt]	 		:  N7			// Menu Item Price level
	var MI_DefSeq[@NUMDTLT]			:	N7			// Menu Item Definition Sequence
	var MI_Tax[@Numdtlt]				:  $12		// Menu Item Taxes amount	
	var MI_Count						:  N5 = 0	// Menu Item Counter
	var cMI_UnitPrc					:  $12

	var DS_Name[@Numdtlt]	 		:	A24		// Discount Grouped Names
	var DS_Ttl[@Numdtlt]	 			:	$12		// Discount Grouped Totals
	var DS_Tax[@Numdtlt]				:  $12		// Discount Item Taxes amount	
	var DS_ObjNum[@Numdtlt]	 		:  N12		// Discount Object Number
	var DS_Count			 			:  N5 = 0	// Discount Counter

	var SV_Name[@Numdtlt]	 		:	A24		// Service Grouped Names
	var SV_Ttl[@Numdtlt]	 			:	$12		// Service Grouped Totals
	var SV_Tax[@Numdtlt]				:  $12		// Menu Item Taxes amount	
	var SV_ObjNum[@Numdtlt]	 		:  N5			// Service Object Number
	var SV_Count			 			:  N5 = 0	// Service Counter

	var TN_Name[@Numdtlt]	 		:	A24		// Tender Grouped Names
	var TN_Ttl[@Numdtlt]	 			:	$12		// Tender Grouped Totals
	var TN_ObjNum[@Numdtlt]	 		:  N5			// Tender Object Number
	var TN_Count			 			:  N5 = 0	// Tender Counter

	var cChange				 			:  $12 = 0.00 // Change Due
	var cChargedTip			 		:  $12		// Charged Tip for all tenders

	var cSubtotal			 			:  $12		// Subtotal (tax included | tax excluded) value for Check
	var cBurdenSubtotal		 		:  $12		// 'Burden Subtotal' value for Check (in Spanish: 'Subtotal de gravados')
	var cExemptSubtotal		 		:  $12		// 'Exempt Substotal' value for Check (in Spanish: 'Subtotal de no gravados')
	var cNetSubtotal					:  $12		// 'Net Subtotal' value for Check (in Spanish: 'Subtotal Neto')
	var cTaxSubtotal		 			:  $12		// Tax Subtotal value for Check
	var cCalcTaxSubtotal	 			:  $12		// Calculated Tax Subtotal value, based on the MI_Tax array
	var cItemsNetSubtotal		 	:  $12		// Items Net Subtotal value for Check
	var cDiscSubtotal		 			:  $12		// Discounts Subtotal value for Check
	var cServSubtotal		 			:  $12		// Services Subtotal value for Check
	var cDiscTaxSubtotal		 		:  $12		// Discounts Tax Subtotal value for Check
	var cServTaxSubtotal		 		:  $12		// Services Tax Subtotal value for Check
	var cRoundingAdj		 			:  $12		// Used for Rounding adjustments to Check Calculated TOTAL
	var cTotal				 			:  $12	    // Total value for Check


	// Cust. Receipt file has not yet been generated...
	iCkNum = @CKNUM
	CustRcptGenerated_ = FALSE

	// ***********************************************
	// Step #1
	// cycle through the check's items and group them
	// ***********************************************
	
	For x = 1 to @Numdtlt

		If @Dtl_Type[x] = DT_MENU_ITEM

			// --------------------------------------
			//				Group MIs
			// --------------------------------------

			If @DTL_TTL[x] <> 0 and \
				( (gbliInvoiceType = INV_TYPE_FACTURA and not gbliFACTURAConsByItmzr) or \
				 gbliInvoiceType = INV_TYPE_GUIA or gbliInvoiceType = INV_TYPE_CREDITO )
  
				iNewItem = TRUE	 // Initialize flag

				// Check to see if current "x" menu item (from outer loop) is 
				// in the MI_ "y" array. If so, consolidate its total into the current
				// "y" item. Otherwise, generate a new item in the "y" MI_ array.

				For y = 1 to MI_Count

					If @Dtl_Objnum[x] = MI_ObjNum[y] and @Dtl_Plvl[x] = MI_PrcLvl[y] and @DTL_DEFSEQ[x] = MI_DefSeq[y] and @DTL_MLVL[x] = MI_MnuLvl[y]
					
						MI_Qty[y] = MI_Qty[y] + @Dtl_Qty[x] // Acumulate Qty
						MI_Ttl[y] = MI_Ttl[y] + @Dtl_ttl[x] // Acumulate Value
						MI_Tax[y] = MI_Tax[y] + @Dtl_taxttl[x]		// Acumulate Tax
						MI_NTtl[y] = (MI_Ttl[y] - MI_Tax[y] )
						iNewItem = FALSE // Don't add this item!
						Break
					Endif

				EndFor

				If iNewItem
					// add a new item to the MI counter
					MI_Count = MI_Count + 1
					
					// Add a new item to the MI_ group array
					MI_Qty[MI_Count]  = @Dtl_Qty[x]
					MI_Name[MI_Count] = @Dtl_Name[x]
					MI_Ttl[MI_Count]  = @Dtl_Ttl[x]
					MI_ObjNum[MI_Count] = @Dtl_Objnum[x]
					MI_MnuLvl[MI_Count] = @DTL_MLVL[x]
					MI_PrcLvl[MI_Count] = @DTL_PLVL[x]
					MI_DefSeq[MI_Count] = @DTL_DEFSEQ[x] 
					MI_Tax[MI_Count] = @Dtl_taxttl[x]
					MI_NTtl[MI_Count] = (MI_TTl[MI_Count] - MI_Tax[MI_Count])
					call getMIUnitPrice(cMI_UnitPrc,x,MI_Tax[],MI_Count,FALSE)
					MI_UnitPrc[MI_Count] = cMI_UnitPrc

				EndIf

			EndIf
	
		ElseIf @Dtl_Type[x] = DT_DISCOUNT

			// --------------------------------------
			//				Group Discounts
			// --------------------------------------
  
			if Not @Dtl_is_void[x] or gbliInvoiceType = INV_TYPE_CREDITO

				iNewItem = TRUE	 // Initialize flag

				// Check to see if current "x" Discount (from outer loop) is 
				// in the DS_ "y" array. If so, consolidate its total into the current
				// "y" Discount. Otherwise, generate a new Discount in the "y" DS_ array.

				For y = 1 to DS_Count

					If @Dtl_Objnum[x] = DS_ObjNum[y]
	
						DS_Ttl[y] = DS_Ttl[y] + @Dtl_ttl[x] // Acumulate Value
						DS_Tax[y] = DS_Tax[y] + @Dtl_taxttl[x] // Acumulate Value
						iNewItem = FALSE // Don't add this item!
						Break
					Endif

				EndFor

				If iNewItem
					// add a new item to the DS counter
					DS_Count = DS_Count + 1
					
					// Add a new item to the DS_ group array
					DS_Name[DS_Count] = @Dtl_Name[x]
					DS_Ttl[DS_Count]  = @Dtl_Ttl[x]
					DS_Tax[DS_Count]  = @Dtl_taxTtl[x]
					DS_ObjNum[DS_Count] = @Dtl_Objnum[x]

				EndIf
			endif

		ElseIf @Dtl_Type[x] = DT_SERVICE_CHARGE

			// --------------------------------------
			//				Group Services
			// --------------------------------------

			if (@Dtl_Ttl[x] > 0 and Not @Dtl_is_void[x]) or \
				gbliInvoiceType = INV_TYPE_CREDITO

				iNewItem = TRUE	 // Initialize flag

				// Check to see if current "x" Service (from outer loop) is 
				// in the SV_ "y" array. If so, consolidate its total into the current
				// "y" Service. Otherwise, generate a new Service in the "y" SV_ array.

				For y = 1 to SV_Count

					If @Dtl_Objnum[x] = SV_ObjNum[y]

						SV_Ttl[y] = SV_Ttl[y] + @Dtl_ttl[x] // Acumulate Value
						SV_Tax[y] = SV_Tax[y] + @Dtl_taxttl[x] // Acumulate Value
						iNewItem = FALSE // Don't add this item!
						Break
					Endif

				EndFor

				If iNewItem
					// add a new item to the SV counter
					SV_Count = SV_Count + 1
					
					// Add a new item to the SV_ group array
					SV_Name[SV_Count] = @Dtl_Name[x]
					SV_Ttl[SV_Count]  = @Dtl_Ttl[x]
					SV_Tax[DS_Count]  = @Dtl_taxTtl[x]
					SV_ObjNum[SV_Count] = @Dtl_Objnum[x]

				EndIf

				// Accumulate Services Subtotal
				cServSubtotal = cServSubtotal + @Dtl_Ttl[x]
			EndIf

		ElseIf @Dtl_Type[x] = DT_TENDER

			// --------------------------------------
			//				Group Tenders
			// --------------------------------------
  
			If (@Dtl_Ttl[x] > 0 and Not @Dtl_is_void[x]) or \
				gbliInvoiceType = INV_TYPE_CREDITO

				if gbliInvoiceType = INV_TYPE_CREDITO and @Dtl_Ttl[x] > 0

					// set change amount (Change is positive on a
					// "Nota de Credito" invoice type)
					cChange = @dtl_ttl[x]
				
				else

					// This is a payment!

					// check if current tender is within the
					// object number range for tenders that are
					// not supposed to print an invoice. If
					// so, bail out and don't print anything!

					If @Dtl_Objnum[x] >= gbliNonFCRMinTndObjNum and \
					   @Dtl_Objnum[x] <= gbliNonFCRMaxTndObjNum
						
						// Current Tender should not print
						// an invoice for this check!
						Return
					EndIf

					iNewItem = TRUE	 // Initialize flag

					// Check to see if current "x" Tender (from outer loop) is 
					// in the TN_ "y" array. If so, consolidate its total into the current
					// "y" Tender. Otherwise, generate a new Tender in the "y" TN_ array.

					For y = 1 to TN_Count

						If @Dtl_Objnum[x] = TN_ObjNum[y]

							TN_Ttl[y] = TN_Ttl[y] + @Dtl_ttl[x] // Acumulate Value
							iNewItem = FALSE // Don't add this item!
							Break
						Endif

					EndFor

					If iNewItem
						// add a new item to the TN counter
						TN_Count = TN_Count + 1
						
						// Add a new item to the TN_ group array
						TN_Name[TN_Count] = @Dtl_Name[x]
						TN_Ttl[TN_Count]  = @Dtl_Ttl[x]
						TN_ObjNum[TN_Count] = @Dtl_Objnum[x]

					EndIf
				endif
			
			Else
				// Get change amount
				cChange = ( @dtl_ttl[x] * -1 )
									
			EndIf

		Endif

	Endfor
	
	
	// ---------------------------------------------------------
	// "BOLETA" and/or "FACTURA" invoice types need to group 
	// items by itemizers
	// ---------------------------------------------------------
	if gbliInvoiceType = INV_TYPE_BOLETA or \
		(gbliInvoiceType = INV_TYPE_FACTURA and gbliFACTURAConsByItmzr)
	
		if gbliInvoiceType = INV_TYPE_FACTURA
			// We need to post FACTURA details with net values. Get
			// aprox. net values for all itemizers
			Call getItemizerTax(caSITax[])
		endif
	
		for i = 1 to MAX_ITMZR_DESC
		
			if @SI[i] <> 0.00
				MI_Count = MI_Count + 1
				
				MI_Qty[MI_Count]  = 1
				Call getItmzrName(i, sTmpFormat)
				MI_Name[MI_Count] = sTmpFormat

				if gbliInvoiceType = INV_TYPE_FACTURA
					MI_Tax[MI_Count] = caSITax[i]
				Endif

				MI_Ttl[MI_Count]  = @SI[i]

				if gbliTaxIsInclusive
					MI_NTtl[MI_Count] = MI_Ttl[MI_Count] - MI_Tax[MI_Count]
				else
					MI_NTtl[MI_Count] = MI_TTl[MI_Count]
				endif

				if gbliInvoiceType = INV_TYPE_FACTURA and gbliTaxIsInclusive
					MI_UnitPrc[MI_Count] = MI_Ttl[MI_Count] - MI_Tax[MI_Count]
				else
					MI_UnitPrc[MI_Count] = MI_Ttl[MI_Count]
				endif
			endif
			
		endfor
		
		if gbliInvoiceType = INV_TYPE_BOLETA and not gbliTaxIsInclusive
			// add TAX "item" for BOLETA when using add-on tax types 
			// so that subtotal values match
			Call getTaxesSubtotal(cTaxSubtotal)
			MI_Count = MI_Count + 1
			MI_Qty[MI_Count]  = 1
			MI_Name[MI_Count] = "Impuesto"
			MI_Ttl[MI_Count]  = cTaxSubtotal
			MI_UnitPrc[MI_Count] = MI_Ttl[MI_Count]
		endif
	endif
	
	// ***********************************************
	// Step #2
	// calculate subtotals and totals
	// ***********************************************

	// set "Charged Tip" amount (we cannot use the 
	// "@ChgTip" system var since it only returns the 
	// charged tip amount for the last posted tender)
	cChargedTip = (@Svc - cServSubtotal)

	// Set Services amount (we cannot use the "@Svc"
	// system var since we are manipulating the check
	// total depending on user configuration for this
	// FIP)
	If gbliAddChargedTipToTotal[gbliInvoiceType]
		// Tip is considered a service charge
		cServSubtotal = @Svc + @Autosvc
	Else
		// Tip is not a service charge
		cServSubtotal = @Svc + @Autosvc - cChargedTip
	EndIf


	// ----------------------------------------
	// Set subtotals and totals
	// ----------------------------------------

	if gbliInvoiceType = INV_TYPE_BOLETA
		
		// Subtotals for "BOLETA" invoice
	
		// get Tax subtotal
		call getTaxesSubtotal(cTaxSubtotal)
	
		// get subtotal (Gross subtotal)
		call getCheckSubtotal(cSubtotal, MI_Ttl[], cTaxSubtotal, MI_Count, FALSE)
		if Not gbliTaxIsInclusive
			// -------------------------------------------------------------------
			// Note:
			//		Taxes have already been added to the MENU ITEMS array. The 
			//		following code is not necessary to compute a correct subtotal
			//		value...
			// -------------------------------------------------------------------
			// cSubtotal = cSubtotal + cTaxSubtotal
			// -------------------------------------------------------------------
		endif
	
		// get calculated Tax subtotal (for 'rounding' issues)
		cCalcTaxSubtotal = cTaxSubtotal
	
		// get Discounts subTotal
		call getDiscountSubtotal(cDiscSubtotal, DS_Ttl[], DS_Count)
	
		// get TOTAL
		cTotal = (cSubtotal + cServSubtotal) + cDiscSubtotal

	elseif gbliInvoiceType = INV_TYPE_FACTURA or gbliInvoiceType = INV_TYPE_GUIA or \
			gbliInvoiceType = INV_TYPE_CREDITO
		
		// Subtotals for all other invoices
			
		// get Exempt ("exento") subtotal
		Call getExemptSubtotal( cExemptSubtotal, MI_Ttl[], MI_Tax[], MI_Count)
		Call getExemptSubtotal( cTmp, SV_Ttl[], SV_Tax[], SV_Count)   // Add exempted services
		cExemptSubtotal = cExemptSubtotal + cTmp	// Add exempted services
		If gbliAddChargedTipToTotal[gbliInvoiceType]
			cExemptSubtotal = cExemptSubtotal + cChargedTip  // Add charged tip (Always exempted)
		endif

		// get Tax subtotal
		call getTaxesSubtotal(cTaxSubtotal)

		// get subtotal (net subtotal)
		if gbliTaxIsInclusive
			call getCheckSubtotal(cSubtotal, MI_Ttl[], cTaxSubtotal, MI_Count, TRUE)
		else
			// Tax is ADD-ON. Taxes are not included in MI ttl!
			call getCheckSubtotal(cSubtotal, MI_Ttl[], cTaxSubtotal, MI_Count, FALSE)
		endif

		// get calculated Tax subtotal (for 'rounding' issues)
		call getCalcTaxesSubtotal(cCalcTaxSubtotal, MI_Tax[], MI_Count)

		// get Discounts subTotal
		call getDiscountSubtotal(cDiscSubtotal, DS_Ttl[], DS_Count)

		// get Items Net subTotal
		call getDiscountSubtotal(cItemsNetSubtotal, MI_NTtl[], MI_Count)  // (Function accumulates values from the passed array)

		// get Discount tax subTotal
		call getDiscountSubtotal(cDiscTaxSubtotal, DS_Tax[], DS_Count)  // (Function accumulates values from the passed array)

		// get Service tax subtotal
		call getDiscountSubtotal(cServTaxSubtotal, SV_Tax[], SV_Count)		// (Function accumulates values from the passed array)

		// get NetSubtotal	
		cNetSubtotal =  cItemsNetSubtotal + (cServSubtotal - cServTaxSubtotal) + (cDiscSubtotal - cDiscTaxSubtotal) - cExemptSubtotal

		// get TOTAL
		cTotal = (cSubtotal + cTaxSubtotal + cServSubtotal) + cDiscSubtotal

	EndIf


	// check 'rounding' issues 

	If cTaxSubtotal <> 0.00
		cRoundingAdj = cTaxSubtotal - cCalcTaxSubtotal
	Else
		cRoundingAdj = 0.00
	EndIf

	// check for total amount and act depending on the
	// configuration settings...
	if gbliInvoiceType <> INV_TYPE_CREDITO
		If Not gbliPrintWhenAmount0
			If cTotal <= 0.00 or (TN_Count = 0 and cChange > 0.00)
				ErrorMessage "El total de la cuenta no supera los $0.00"
				ErrorMessage "No se imprimira factura"
				Return //  bail out!
			EndIf
		EndIf
	endif

	// get extra fiscal info (if needed)
	if not gbliUseEDI
		Call setExtraFiscalInfo()
	endif

	// ***********************************************
	// Step #3
	// Now that we have all the values we need, call
	// PTP.dll methods to pass all check info and 
	// generate print file
	// ***********************************************
	
	Prompt "Generando impresion..."
	
	// reset PTP state
	if @WSTYPE = SAROPS
		DLLCall gblhPTP, PTP_resetSavedAttribs (ref iDllRet)
	else
		Call PTP_resetSavedAttribs(iDllRet)
	endif
	if iDllRet <> PTP_RET_CODE_SUCCESS
		ErrorMessage "Error en PTP.dll al inicializar atributos"
		call logInfo(ERROR_LOG_FILE_NAME,"PTP error: while reseting attributes",TRUE,TRUE)
		call logPTPError()
		Return // bail-out!
	endif
	
	// Add fisc. doc. type
	if gbliInvoiceType = INV_TYPE_BOLETA
		format sTmpFormat as "Boleta"{=32}
	elseif gbliInvoiceType = INV_TYPE_CREDITO
		format sTmpFormat as "Nota de Credito"{=32}
	elseif gbliInvoiceType = INV_TYPE_FACTURA
		format sTmpFormat as "Factura"{=32}
	elseif gbliInvoiceType = INV_TYPE_GUIA
		format sTmpFormat as "Guia"{=32}
	endif
	call setKeyValOnPTPStr(sPTPStr, PTP_COUPON_TYPE,sTmpFormat)

	// add date and time to PTP string
	Format sDate as @Day{02}, "/", @Month{02}, "/", (@YEAR + 1900){04}
	Format sTime as @Hour{02}, ":", @Minute{02}, ":", @Second{02}
	call setKeyValOnPTPStr(sPTPStr, PTP_DATE, sDate)
	call setKeyValOnPTPStr(sPTPStr, PTP_TIME, sTime)
	
	// add "Nota de crédito" fiscal info to PTP string
	if gbliInvoiceType = INV_TYPE_CREDITO
		call setKeyValOnPTPStr(sPTPStr, PTP_HEADER_EXTRA_1,"Comprobante asoc.")
		call setKeyValOnPTPStr(sPTPStr, PTP_HEADER_EXTRA_2,gblsCreditInfo)
	else
		call setKeyValOnPTPStr(sPTPStr, PTP_HEADER_EXTRA_1,"")
		call setKeyValOnPTPStr(sPTPStr, PTP_HEADER_EXTRA_2,"")
	endif
	
	// post date parts separately
	Format sDate as @DAY{02}
	call setKeyValOnPTPStr(sPTPStr, PTP_HEADER_EXTRA_3,sDate)
	Format sDate as @MONTH{02}
	call setKeyValOnPTPStr(sPTPStr, PTP_HEADER_EXTRA_4,sDate)
	Format sDate as (@YEAR + 1900){04}
	call setKeyValOnPTPStr(sPTPStr, PTP_HEADER_EXTRA_5,sDate)

	// add table number
	Format sTmpFormat as Trim(@TBLID){>4}
	Call setKeyValOnPTPStr(sPTPStr, PTP_HEADER_EXTRA_6,sTmpFormat)

	// Post Micros Business Date
	Call getMicrosBizDate(sTmpFormat)
	call setKeyValOnPTPStr(sPTPStr, PTP_HEADER_EXTRA_7,sTmpFormat)

	// add wsid, Employee num to PTP string
	Format sTmpFormat as @WSID{>4}
	Format sTmpFormat2 as @CKEMP{>9}
	Format sTmpFormat3 as @CKCSHR{>9}
	call setKeyValOnPTPStr(sPTPStr, PTP_WSID,sTmpFormat)
	call setKeyValOnPTPStr(sPTPStr, PTP_EMPLOYEE_1,sTmpFormat2)
	call setKeyValOnPTPStr(sPTPStr, PTP_EMPLOYEE_2,sTmpFormat3)

	// add header lines to PTP string
	call setFIPHeaderOnPTPStr(sPTPStr)

	// Add fiscal Data
	if gbliInvoiceType = INV_TYPE_BOLETA or gbliInvoiceType = INV_TYPE_CREDITO
		format sTmpFormat as "CONSUMO FINAL"{=32}
		call setKeyValOnPTPStr(sPTPStr, PTP_CUST_DATA_1,sTmpFormat)

	elseif gbliInvoiceType = INV_TYPE_FACTURA or gbliInvoiceType = INV_TYPE_GUIA
		format sTmpFormat as gblsIDNumber{=32}
		call setKeyValOnPTPStr(sPTPStr, PTP_CUST_DATA_1,sTmpFormat)
		format sTmpFormat as gblsName{=32}
		call setKeyValOnPTPStr(sPTPStr, PTP_CUST_DATA_2,sTmpFormat)
		format sTmpFormat as gblsAddress1{=32}
		call setKeyValOnPTPStr(sPTPStr, PTP_CUST_DATA_3,sTmpFormat)
		format sTmpFormat as gblsAddress2{=32}
		call setKeyValOnPTPStr(sPTPStr, PTP_CUST_DATA_4,sTmpFormat)
		format sTmpFormat as gblsTel{=32}
		call setKeyValOnPTPStr(sPTPStr, PTP_CUST_DATA_5,sTmpFormat)
		format sTmpFormat as gblsExtra1{=32}
		call setKeyValOnPTPStr(sPTPStr, PTP_CUST_DATA_6,sTmpFormat)
	endif 
	
	if @WSTYPE = SAROPS
		// Now set saved PTP Header section data
		DLLCall gblhPTP, PTP_setHeader( ref sPTPStr, ref iDllRet)
		if iDllRet <> PTP_RET_CODE_SUCCESS
			ErrorMessage "Error en PTP.dll al enviar informacion"
			Call logInfo(ERROR_LOG_FILE_NAME,"PTP error: while sending Header data",TRUE,TRUE)
			Call logPTPError()
			Return // bail-out!
		endif
		Format sPTPStr as ""
	endif
	
	// add MIs, SVCs, and DSCs to PTP string
	
	call setKeyValOnPTPStr(sPTPStr, PTP_ITEMS_HEADER, "PRODUCTOS")
	call setFIPMIOnPTPStr(sPTPStr,MI_Count, MI_Qty[], MI_Name[], MI_UnitPrc[], MI_Tax[], MI_Ttl[])

	if gbliInvoiceType = INV_TYPE_BOLETA and Not gbliTaxIsInclusive
		
		// deal with rouding issues if Tax is Add-on. Add rounding as an item.
		if cRoundingAdj <> 0.00
			format sTmpFormat as "AJUSTE REDONDEO"{<16}
			format sTmpFormat2 as cRoundingAdj{>+8}
			call setRndAjstMIOnPTPStr(sPTPStr, sTmpFormat,sTmpFormat2)
			iExtraItemCount = iExtraItemCount + 1
		endif
	endif

	if @WSTYPE = SAROPS
		DLLCall gblhPTP, PTP_setDetail( ref sPTPStr, ref iDllRet)
		if iDllRet <> PTP_RET_CODE_SUCCESS
			ErrorMessage "Error en PTP.dll al enviar informacion"
			call logInfo(ERROR_LOG_FILE_NAME,"PTP error: while sending Detail data (MIs)",TRUE,TRUE)
			call logPTPError()	
			Return // bail-out!
		endif
		Format sPTPStr as ""
	endif

	call setKeyValOnPTPStr(sPTPStr, PTP_SVCS_HEADER, "SERVICIOS")
	call setFIPSVOnPTPStr(sPTPStr,SV_Count, SV_Name[], SV_Ttl[], SV_Tax[])

	// Add tip charge (if tip was paid as a Tender option bit)
	If cChargedTip > 0.00 or (gbliInvoiceType = INV_TYPE_CREDITO and cChargedTip < 0.00)
		If gbliAddChargedTipToTotal[gbliInvoiceType]
			format sTmpFormat as "Propina"{<12}
			call setKeyValOnPTPStr(sPTPStr, PTP_SVC_NAME_,sTmpFormat)
			format sTmpFormat as cChargedTip{>+12}
			call setKeyValOnPTPStr(sPTPStr, PTP_SVC_PRICE_,sTmpFormat)
			iExtraItemCount = iExtraItemCount + 1
		EndIf
	EndIf

	// Add auto-service charge, if any
	If @Autosvc > 0.00 or (gbliInvoiceType = INV_TYPE_CREDITO and @Autosvc < 0.00)
		format sTmpFormat as "Auto-svc"{<12}
		call setKeyValOnPTPStr(sPTPStr, PTP_SVC_NAME_,sTmpFormat)
		format sTmpFormat as Abs(@AUTOSVC){>+12}
		call setKeyValOnPTPStr(sPTPStr, PTP_SVC_PRICE_,sTmpFormat)
		iExtraItemCount = iExtraItemCount + 1
	EndIf

	if @WSTYPE = SAROPS
		// Now set saved PTP Detail section data
		DLLCall gblhPTP, PTP_setDetail( ref sPTPStr, ref iDllRet)
		if iDllRet <> PTP_RET_CODE_SUCCESS
			ErrorMessage "Error en PTP.dll al enviar informacion"
			call logInfo(ERROR_LOG_FILE_NAME,"PTP error: while sending Detail data (SVs)",TRUE,TRUE)
			call logPTPError()
			Return // bail-out!
		endif
		Format sPTPStr as ""
	endif

	call setKeyValOnPTPStr(sPTPStr, PTP_DISCS_HEADER, "DESCUENTOS")
	call setFIPDSOnPTPStr(sPTPStr,DS_Count, DS_Name[], DS_Ttl[], DS_Tax[])
	
	if @WSTYPE = SAROPS
		// Now set saved PTP Detail section data
		DLLCall gblhPTP, PTP_setDetail( ref sPTPStr, ref iDllRet)
		if iDllRet <> PTP_RET_CODE_SUCCESS
			ErrorMessage "Error en PTP.dll al enviar informacion"
			call logInfo(ERROR_LOG_FILE_NAME,"PTP error: while sending Detail data (DSs)",TRUE,TRUE)
			call logPTPError()
			Return // bail-out!
		endif
		Format sPTPStr as ""
	endif
	
	if gbliPostTndrsToPTPDetail
		// Now set saved PTP Detail section data
		call setKeyValOnPTPStr(sPTPStr, PTP_TNDRS_HEADER,"PAGOS")
		call setFIPTNOnPTPStr(sPTPStr, TN_Count, TN_Name[], TN_Ttl[], TRUE)
		
		if @WSTYPE = SAROPS
			// Now set saved PTP Detail section data
			DLLCall gblhPTP, PTP_setDetail( ref sPTPStr, ref iDllRet)
			if iDllRet <> PTP_RET_CODE_SUCCESS
				ErrorMessage "Error en PTP.dll al enviar informacion"
				call logInfo(ERROR_LOG_FILE_NAME,"PTP error: while sending Detail data (TNs)",TRUE,TRUE)
				call logPTPError()
				Return // bail-out!
			endif
			Format sPTPStr as ""
		endif
	endif
	
	// get number of print jobs
	iTmp = (MI_Count + SV_Count + DS_Count + iExtraItemCount)
	if gbliPostTndrsToPTPDetail
		iTmp = iTmp + TN_Count
	endif
	Call getPrintJobs(iTmp, iMaxNumItems, iCalcPrintJobs)

	// set parameters

	Format sTmpFormat as iMaxNumItems
	call setKeyValOnPTPStr(sPTPStr, PTP_MULTI_PAGE_THRESHOLD,sTmpFormat)
	
	if @WSTYPE = SAROPS
		DLLCall gblhPTP, PTP_setParams( ref sPTPStr, ref iDllRet)
		if iDllRet <> PTP_RET_CODE_SUCCESS
			ErrorMessage "Error en PTP.dll al enviar informacion"
			Call logInfo(ERROR_LOG_FILE_NAME,"PTP error: while sending Param data",TRUE,TRUE)
			Call logPTPError()
			Return // bail-out!
		endif
		Format sPTPStr as ""
	endif

	// add micros checknum, series-number to PTP string

	for i = 1 to iCalcPrintJobs
		// If current invoice requires user confirmation, ask for 
		// confirmation for first invoice number only
		if i = 1 then
			iTmp = TRUE  
		else
			iTmp = FALSE
		endif		
		// get invoice number for current coupon/s
		call generateInvoiceNumber(iTmp,sCouponNumber[i])
			
		Call getSeries_Number(sCouponNumber[i],sInvSeries,sInvNumber)
		format sTmpFormat as sInvNumber{>010}
		format sTmpFormat2 as @Cknum{>04}
		call setKeyValOnPTPStr(sPTPStr, PTP_COUPON_NUMBER,sTmpFormat)
		Call setKeyValOnPTPStr(sPTPStr, PTP_CHECK_NUMBER,sTmpFormat2)
	endfor
	Format sTmpFormat3 as sInvSeries{>3}
	Call setKeyValOnPTPStr(sPTPStr, PTP_COUPON_SERIES,sTmpFormat3)
	
	Prompt "Generando impresion..."
	
	if @WSTYPE = SAROPS
		// Now set saved PTP Header section data
		DLLCall gblhPTP, PTP_setHeader( ref sPTPStr, ref iDllRet)
		if iDllRet <> PTP_RET_CODE_SUCCESS
			ErrorMessage "Error en PTP.dll al enviar informacion"
			Call logInfo(ERROR_LOG_FILE_NAME,"PTP error: while sending Header data (2)",TRUE,TRUE)
			Call logPTPError()
			Return // bail-out!
		endif
		Format sPTPStr as ""
	endif

	// Add Subtotals to PTP string

	if cServSubtotal <> 0.00
		format sTmpFormat as "SUBTOTAL SERV."{<14}
		if gbliInvoiceType <> INV_TYPE_BOLETA
			format sTmpFormat2 as (Abs(cServSubtotal) - Abs(cServTaxSubtotal)){>+12}
		else		
			format sTmpFormat2 as Abs(cServSubtotal){>+12}
		endif
	else
		format sTmpFormat as ""
		format sTmpFormat2 as ""
	endif
	call setKeyValOnPTPStr(sPTPStr, PTP_SVC_SUBT_NAME,sTmpFormat)
	call setKeyValOnPTPStr(sPTPStr, PTP_SVC_SUBT_AMNT,sTmpFormat2)

	if DS_Count > 0
		format sTmpFormat as "SUBTOTAL DESC."{<14}
		if gbliInvoiceType <> INV_TYPE_BOLETA
			format sTmpFormat2 as (cDiscSubtotal - cDiscTaxSubtotal){>+12}
		else		
			format sTmpFormat2 as cDiscSubtotal{>+12}
		endif
	else
		format sTmpFormat as ""
		format sTmpFormat2 as ""
	endif
	call setKeyValOnPTPStr(sPTPStr, PTP_DISC_SUBT_NAME,sTmpFormat)
	call setKeyValOnPTPStr(sPTPStr, PTP_DISC_SUBT_AMNT,sTmpFormat2)

		
	if gbliInvoiceType = INV_TYPE_BOLETA
		
		format sTmpFormat as "SUBTOTAL"{<12}
		call setKeyValOnPTPStr(sPTPStr, PTP_GROSS_SUBT_NAME,sTmpFormat)
		format sTmpFormat as Abs(cSubtotal){>+12}
		call setKeyValOnPTPStr(sPTPStr, PTP_GROSS_SUBT_AMNT,sTmpFormat)

	elseif gbliInvoiceType = INV_TYPE_FACTURA or gbliInvoiceType = INV_TYPE_GUIA or \
			gbliInvoiceType = INV_TYPE_CREDITO

		format sTmpFormat as "SUBTOTAL NETO"{<14}
		call setKeyValOnPTPStr(sPTPStr, PTP_BURDEN_SUBT_NAME,sTmpFormat)
		format sTmpFormat as cNetSubtotal{>+12}
		call setKeyValOnPTPStr(sPTPStr, PTP_BURDEN_SUBT_AMNT,sTmpFormat)

		format sTmpFormat as "SUBT. EXENTO"{<14}
		call setKeyValOnPTPStr(sPTPStr, PTP_EXEMPT_SUBT_NAME,sTmpFormat)
		format sTmpFormat as cExemptSubtotal{>+12}
		call setKeyValOnPTPStr(sPTPStr, PTP_EXEMPT_SUBT_AMNT,sTmpFormat)

	endif
	
	// Add Taxes to PTP string
	Call setFIPTaxesOnPTPStr(cNetSubtotal, sPTPStr)

	if @WSTYPE = SAROPS
		// Now set saved PTP Subtotal section data
		DLLCall gblhPTP, PTP_setSubtotal( ref sPTPStr, ref iDllRet)
		if iDllRet <> PTP_RET_CODE_SUCCESS
			ErrorMessage "Error en PTP.dll al enviar informacion"
			call logInfo(ERROR_LOG_FILE_NAME,"PTP error: while sending Subtotal data",TRUE,TRUE)
			call logPTPError()
			Return // bail-out!
		endif
		Format sPTPStr as ""
	endif

	// Add Totals to PTP string

	format sTmpFormat as "TOTAL"{<12}
	call setKeyValOnPTPStr(sPTPStr, PTP_TOTAL_NAME,sTmpFormat)
	format sTmpFormat as Abs(cTotal){>+12}
	call setKeyValOnPTPStr(sPTPStr, PTP_TOTAL_AMNT,sTmpFormat)

	format sTmpFormat as "VUELTO"{<12}
	call setKeyValOnPTPStr(sPTPStr, PTP_CHANGE_TTL_NAME,sTmpFormat)
	if gbliInvoiceType <> INV_TYPE_CREDITO
		If cChargedTip <= 0.00
			format sTmpFormat as cChange{>+12}
		Else
			If gbliAddChargedTipToTotal[gbliInvoiceType]
				format sTmpFormat as cChange{>+12}
			Else
				format sTmpFormat as cChargedTip{>+12}
			EndIf
		EndIf
	else
		If cChargedTip >= 0.00
			format sTmpFormat as cChange{>+12}
		Else
			If gbliAddChargedTipToTotal[gbliInvoiceType]
				format sTmpFormat as cChange{>+12}
			Else
				format sTmpFormat as abs(cChargedTip){>+12}
			EndIf
		EndIf
	endif
	call setKeyValOnPTPStr(sPTPStr, PTP_CHANGE_TTL_AMNT,sTmpFormat)

	// add tenders data to PTP string
	Call setKeyValOnPTPStr(sPTPStr, PTP_TRL_TNDRS_HEADER,"PAGOS")
	Call setFIPTNOnPTPStr(sPTPStr, TN_Count, TN_Name[], TN_Ttl[], FALSE)
	
	// add total amount in letters for "FACTURA" invoice type
	if gbliInvoiceType = INV_TYPE_FACTURA
		Call setAmountInWords(cTotal, TRUE, sPTPStr)
	endif

	if @WSTYPE = SAROPS
		// Now set saved PTP Total section data
		DLLCall gblhPTP, PTP_setTotal( ref sPTPStr, ref iDllRet)
		if iDllRet <> PTP_RET_CODE_SUCCESS
			ErrorMessage "Error en PTP.dll al enviar informacion"
			call logInfo(ERROR_LOG_FILE_NAME,"PTP error: while sending Total data",TRUE,TRUE)
			call logPTPError()
			Return // bail-out!
		endif
		Format sPTPStr as ""
	endif
	
	// Add trailer data to PTP string
	
	call setFIPTrailerOnPTPStr(sPTPStr)
	
	// add total amount in letters for "FACTURA" invoice type
	if gbliInvoiceType = INV_TYPE_FACTURA
		Call setAmountInWords(cTotal, FALSE, sPTPStr)
	endif
	
	if @WSTYPE = SAROPS
		// Now set saved PTP Trailer section data
		DLLCall gblhPTP, PTP_setTrailer( ref sPTPStr, ref iDllRet )
		if iDllRet <> PTP_RET_CODE_SUCCESS
			ErrorMessage "Error en PTP.dll al enviar informacion"
			call logInfo(ERROR_LOG_FILE_NAME,"PTP error: while sending Trailer data",TRUE,TRUE)
			call logPTPError()
			Return // bail-out!
		endif
		Format sPTPStr as ""
	endif

	
	// Create printable doc.
	
	if gbliInvoiceType = INV_TYPE_BOLETA 
		sTmpFile = PATH_TO_BOLETA_PRINT_TMP
		sPDocFile = PATH_TO_BOLETA_PRINT_DOC
	elseif gbliInvoiceType = INV_TYPE_CREDITO
		sTmpFile = PATH_TO_CREDITO_PRINT_TMP
		sPDocFile = PATH_TO_CREDITO_PRINT_DOC
	elseif gbliInvoiceType = INV_TYPE_FACTURA
		sTmpFile = PATH_TO_FACTURA_PRINT_TMP
		sPDocFile = PATH_TO_FACTURA_PRINT_DOC
	elseif gbliInvoiceType = INV_TYPE_GUIA
		sTmpFile = PATH_TO_GUIA_PRINT_TMP
		sPDocFile = PATH_TO_GUIA_PRINT_DOC	
	endif 
	
	if @WSTYPE = SAROPS
		DLLCall gblhPTP, PTP_createDocFromTemplate ( ref sTmpFile, ref sPDocFile, ref iDocCount_, ref iDllRet )
	else
		Call PTP_createDocFromTemplate(sTmpFile, sPDocFile, iDocCount_, iDllRet)
	endif
	if iDllRet <> PTP_RET_CODE_SUCCESS
		ErrorMessage "Error en PTP.dll al crear documento"
		call logInfo(ERROR_LOG_FILE_NAME,"PTP error: Customer Receipt file could not be created",TRUE,TRUE)
		call logPTPError()
		Return // bail-out!
	else
		// Cust. Receipt file has been generated successfully
		CustRcptGenerated_ = TRUE
	endif
	
	
	// ***********************************************
	// Step #5
	// get extra info if necessary (to post to DB)
	// ***********************************************
	
	if iDocCount_ > 1
		
		sTransport = HAS_TRANSPORT // set transport identifier
	
		// if this is a multi-page check, get per-page subtotal values
		Call initStrArray(sCouponSubtotal[],iDocCount_)
		if @WSTYPE = SAROPS	
			DLLCall gblhPTP, PTP_getMultiPageSubtotals ( ref sCouponSubtotal[], ref iDllRet )
		else
			Call PTP_getMultiPageSubtotals( sCouponSubtotal[], iDllRet )
		endif
		if iDllRet <> PTP_RET_CODE_SUCCESS
			ErrorMessage "Error en PTP.dll al obtener subtotales"
			call logInfo(ERROR_LOG_FILE_NAME,"PTP error: could not retrieve multi-page subtotals",TRUE,TRUE)
			call logPTPError()
		endif
	else
		
		sTransport = NO_TRANSPORT // no transport, one coupon printed only
	endif

	// ***********************************************
	// Step #6
	// Post issued invoice info to the Micros DB
	// ***********************************************

	for i = 1 to iDocCount_
		call SaveInvoiceInfoInDB(cSubtotal, cTaxSubtotal, cBurdenSubtotal, \
									 		cExemptSubtotal, cDiscSubtotal, cServSubtotal, \
									 		cRoundingAdj, cTotal, sCouponNumber[i], sCouponSubtotal[i], \
									 		sTransport, sCouponNumber[1], sCouponNumber[iDocCount_], gbliInvoiceType, \
									 		1, iCkNum, @WSID)
	endfor

EndSub

//******************************************************************
// Procedure: getMIUnitPrice()
// Author: Alex Vidal
// Purpose: Calculates and returns the unit price of a given MI
// Parameters:
//	 - retVal_ = Function's return value
//  - iMIIndex_ = @DTL[] array index for the item whose info will
//				  be read in order to make the necessary 
//				  calculations
//  - MI_Tax_ = Saved, grouped MI Tax array
//  - MI_Count_ = Currently saved and grouped MI array Index
//	 - iIncludeTax_ = if TRUE returned unit price will include tax
//******************************************************************
Sub getMIUnitPrice(ref retVal_, var iMIIndex_ : N5, ref MI_Tax_[], var MI_Count_ : N4, \
						 var iIncludeTax_ : N1)

	// Check for Shared Items

	If @Dtl_Qty[iMIIndex_] = 0 and @Dtl_Ttl[iMIIndex_] <> 0.00
		
		retVal_ = 0.00

	Else
		// Calculate unit price
		
		if Not iIncludeTax_
			if Not gbliTaxIsInclusive
				// Add-on taxes do not include MI Tax
				retVal_ =  (@Dtl_Ttl[iMIIndex_]) / @DTL_QTY[iMIIndex_]
			else
				// Inclusive taxes include tax amount. Strip off tax from calculation
				retVal_ =  (@Dtl_Ttl[iMIIndex_] - MI_Tax_[MI_Count_]) / @DTL_QTY[iMIIndex_]
			endif
		else
			if Not gbliTaxIsInclusive
				// Add-on taxes do not include MI Tax. Add them
				retVal_ =  (@Dtl_Ttl[iMIIndex_] + MI_Tax_[MI_Count_]) / @DTL_QTY[iMIIndex_]
			else
				// Inclusive taxes include tax amount.
				retVal_ =  (@Dtl_Ttl[iMIIndex_]) / @DTL_QTY[iMIIndex_]
			endif
		endif

	EndIf

EndSub

//******************************************************************
// Procedure: checkTaxExemption()
// Author: Alex Vidal
// Purpose: Returns TRUE if current Check is Tax exempted
// Parameters:
//	- retVal_ = Function's return value
//
//******************************************************************
Sub checkTaxExemption( ref retVal_ )

	var cTaxAcum  : $12

	// get the subtotal value for all taxes. If this is $0.00
	// Then the current check is Tax exempted

	call getTaxesSubtotal(cTaxAcum)

	retVal_ = ( cTaxAcum = 0.00 )
	
EndSub

//******************************************************************
// Procedure: getCheckSubtotal()
// Author: Alex Vidal
// Purpose: Returns the current check's subtotal
// Parameters:
//	 - retVal_ = Function's return value
//  - MI_Ttl_[] = Array containing grouped Menu Item totals
//	 - cTaxSubtotal_ = Taxes posted amount for current Check
//  - MI_Count_ = Total number of grouped Menu Items
//  - NetSubtotal_ = If TRUE, the function will return the NET
//					 (tax excluded) subtotal for the check. If
//					 FALSE, the returned subtotal value will
//					 include Tax
//
//******************************************************************
Sub getCheckSubtotal( ref retVal_, ref MI_Ttl_[], var cTaxSubtotal_ : $12, var MI_Count_ : N5, var NetSubtotal_ : N1)

	var cAcumSub	: $12
	var i				: N4  // for looping

	// Cycle through the MI arrays and accumulate
	// the subtotal value
	
	For i = 1 to MI_Count_
		cAcumSub = cAcumSub + MI_Ttl_[i]
	EndFor

	If NetSubtotal_
		// NET subtotal: deduct tax amount from Check subtotal
		retVal_ = (cAcumSub - cTaxSubtotal_)
	Else
		// Tax included subtotal
		retVal_ = cAcumSub
	EndIf

EndSub

//******************************************************************
// Procedure: getBurdenSubtotal()
// Author: Al Vidal
// Purpose: Returns the current check's Burden subtotal
// Parameters:
//	 - retVal_ = Function's return value
//  - MI_Ttl_[] = Array containing grouped Menu Item totals
//	 - MI_Tax_[] = Array containing grouped Menu Item Tax Totals
//  - MI_Count_ = Total number of grouped Menu Items
//
//******************************************************************
Sub getBurdenSubtotal( ref retVal_, ref MI_Ttl_[], ref MI_Tax_[], var MI_Count_ : N5)

	var cCurSub		: $12
	var cAcumSub	: $12
	var i				: N4  // for looping

	// Cycle through the MI arrays and accumulate
	// the Burden subtotal value
	
	For i = 1 to MI_Count_

		// deduct tax amount from MI. 
		// Only accumulate values from MIs
		// that are 'tax burdened' (in spanish: 'gravados')

		If MI_Tax_[i] > 0.00
			cCurSub = MI_Ttl_[i] - MI_Tax_[i]
			cAcumSub = cAcumSub + cCurSub
		EndIf

	EndFor

	// return Burden subtotal value
	retVal_ = cAcumSub

EndSub

//******************************************************************
// Procedure: getExemptSubtotal()
// Author: Al Vidal
// Purpose: Returns the current check's Exempt subtotal
// Parameters:
//	 - retVal_ = Function's return value
//  - MI_Ttl_[] = Array containing grouped Menu Item totals
//	 - MI_Tax_[] = Array containing grouped Menu Item Tax Totals
//  - MI_Count_ = Total number of grouped Menu Items
//
//******************************************************************
Sub getExemptSubtotal( ref retVal_, ref MI_Ttl_[], ref MI_Tax_[], var MI_Count_ : N5)

	var cAcumSub	: $12
	var i			: N4  // for looping

	// Cycle through the MI arrays and accumulate
	// the Exempt subtotal value
	
	For i = 1 to MI_Count_

		// Only accumulate values from MIs
		// that are 'tax exempt' (in spanish: 'no gravados')

		If MI_Tax_[i] = 0.00
			cAcumSub = cAcumSub + MI_Ttl_[i]
		EndIf

	EndFor

	// return Burden subtotal value
	retVal_ = cAcumSub

EndSub

//******************************************************************
// Procedure: getTaxesSubtotal()
// Author: Al Vidal
// Purpose: Returns the total tax amount posted to the current
//			Check
// Parameters:
//	- retVal_ = Function's return value
//
//******************************************************************
Sub getTaxesSubtotal( ref retVal_ )

	var cTaxAcum	: $12
	var i				: N2	// for looping

	// Accumulate the total values from all taxes.

	For i = 1 to MAX_TAX_NUM
		if gbliTaxIsInclusive
			cTaxAcum = cTaxAcum + @TAXVAT[i]
		else
			cTaxAcum = cTaxAcum + @TAX[i]
		endif
	EndFor

	// return Taxes subtotal
	retVal_ = cTaxAcum

EndSub

//******************************************************************
// Procedure: getDiscountSubtotal()
// Author: Alex Vidal
// Purpose: Returns the total Discounts value for the current Check
// Parameters:
//	- retVal_ = Function's return value
//  - DS_Ttl_ = Saved, grouped Discounts array
//  - DS_Count_ = Currently saved and grouped Discounts array Index
//
//******************************************************************
Sub getDiscountSubtotal( ref retVal_, ref DS_Ttl_[], var DS_Count_ : N5)

	var i				: N5  // for looping
	var cAcumSub	: $12 = 0.00

	// -------------------------------------
	// We will get the total Discounts 
	// amount by accumulating the totals
	// for all "Discount" items. We won't 
	// be using the @Dsc var because we 
	// have noticed that this variable 
	// fails to update its value when
	// 'Last Item' discount types are used
	//
	//				ALEX VIDAL  06-27-2003
	// -------------------------------------
	
	For i = 1 to DS_Count_
		cAcumSub = cAcumSub + DS_Ttl_[i]
	EndFor

	retVal_ = cAcumSub
	
EndSub

//******************************************************************
// Procedure: getArraySubtotal()
// Author: Alex Vidal
// Purpose: Returns the total (accumulated) value for all amounts
//				present in the aTTL_ array
// Parameters:
//	 - retVal_ = Function's return value
//  - aTtl_ = array contaning amounts
//  - iCount_ = Array's valid element length
//
//******************************************************************
Sub getArraySubtotal( ref retVal_, ref aTtl_[], var iCount_ : N5)

	var i				: N5  // for looping
	var cAcumSub	: $12 = 0.00

	
	For i = 1 to iCount_
		cAcumSub = cAcumSub + aTtl_[i]
	EndFor

	retVal_ = cAcumSub
	
EndSub

//******************************************************************
// Procedure: getCalcTaxesSubtotal()
// Author: Al Vidal
// Purpose: Returns the total calculated Taxes amount for the 
//			current Check, using the MI Tax array previously
//			filled with Tax check info for each MI.
// Parameters:
//	- retVal_ = Function's return value
//  - MI_Tax_ = Saved, grouped MI tax array
//  - MI_Count_ = Currently saved and grouped MI array Index
//
//******************************************************************
Sub getCalcTaxesSubtotal( ref retVal_, ref MI_Tax_[], var MI_Count_ : N5)

	var i			: N5  // for looping
	var cAcumSub	: $12 = 0.00

	For i = 1 to MI_Count_
		cAcumSub = cAcumSub + MI_Tax_[i]
	EndFor

	retVal_ = cAcumSub
	
EndSub

//******************************************************************
// Procedure: getFiscalData()
// Author: Alex Vidal
// Purpose: Shows a dialog where the operator is requested to 
//			enter fiscal information. Saves Fiscal data for
//			later use
// Parameters:
//	-
//
//******************************************************************
Sub getFiscalData()

	var bNewCustomer	: N1 = FALSE
	var sInputedIDNum	: A30 = ""
	var iDone			: N1 = FALSE


	// reset vars...
	call clearFiscalGblVars()

	While not iDone
		call get_processCustomerInfo(bNewCustomer, sInputedIDNum, iDone)
	EndWhile

	if bNewCustomer
		// Previously entered "ID" number does not
		// exist. Create a new record for this customer
		
		call AddFiscalRecord(sInputedIDNum)

	EndIf

EndSub

//******************************************************************
// Procedure: get_processCustomerInfo()
// Author: Alex Vidal
// Purpose: Checks if a customer exists in the DB. If so, asks
//			user to take action: Confirm, Modify  or Delete record.
// Parameters:
//	- bNewCustomer_ = Set to TRUE if inputed "ID" number does 
//					  		not exist in the DB
//	- sInputedIDNum_ = Inputed "ID" number
//	- iDone_ = TRUE if we are done calling this function
//
//******************************************************************
Sub get_processCustomerInfo( ref bNewCustomer_, ref sInputedIDNum_, ref iDone_ )

	var iInfoOK			: N1 = FALSE
	var iOption			: N9
	var kKeyPressed	: KEY
	var iAnswer			: N1
	var iDBOK			: N1
	var sSQLCmd			: A1000 = ""
	var sRecordData	: A1000 = ""
	var iRecordIdx		: N9
	var iAffectedRecs	: N9
	var sQueryRetCode	: A500 = ""
	var sSQLErr			: A500 = ""
	var sTmp				: A2000 = ""


	// check connection to DB
	call MDAD_checkConnection(iDBOK)

	If Not iDBOK
		// connection to DB lost
		ErrorMessage "Conexion a BD perdida!"
		ErrorMessage "Debera ingresar los datos en forma manual."
		// set flags
		iDone_ = TRUE
		bNewCustomer_ = FALSE
		// ask user to input data
		call showCustDataDlg("Ingrese los datos del Cliente:", gblsIDNumber, gblsName, \
							  gblsAddress1, gblsAddress2, gblsTel, gblsExtra1, TRUE)
		return  // bail out!
	EndIf


	// ----------------------------------------------------
	// #1 Ask user to enter a specific "ID" number
	// ----------------------------------------------------

	While Not iInfoOK
	
		// Get DB default alphanumeric touchscreen
		ContinueOnCancel
		Touchscreen @ALPHASCREEN

		// Show Dialog...
		Window 7,50, "Seleccion de Cliente:"
			Display 1,1, "RUT "
			DisplayInput 1,12, sInputedIDNum_{16}, "(max. 16 carac.)"
			Display 4,1, "Ingrese '*' para agregar un nuevo cliente."
		WindowEdit
		
		// Check inputed information
		If @INPUTSTATUS <> 0 and sInputedIDNum_ <> ""
			iInfoOK = TRUE  // turn on exit-loop flag
		Else
			// Input error! Warn user
			ErrorMessage "Se deben completar TODOS los campos con valores validos."
		EndIf

	EndWhile
	WindowClose

	// Check if user wants to add a new customer to the DB first.
	If sInputedIDNum_ = "*"
		iDone = TRUE
		bNewCustomer_ = TRUE
		Return // bail out!
	EndIf

	Prompt "Buscando cliente..."

	// search in the DB for inputed "ID" value
	format sSQLCmd as "SELECT * FROM FCR_CUSTOMER_DATA ", \
					  		"WHERE CUSTOMERID = '", sInputedIDNum_, "'"

	call MDAD_execSQL( MDAD_DBCMD_QUERY, MDAD_DB_QRYTYPE_READ, sSQLCmd, "", \
							 MDAD_DB_RCRDSET_TYPE_LOCAL, iAffectedRecs, sQueryRetCode)
	
	If sQueryRetCode = MDAD_RET_CODE_SUCCESS

		// Try to get first record (if any).
		call MDAD_getNextRec(sRecordData, iRecordIdx)
		
		If iRecordIdx <> -1
			// We have a record match. Retrieve its data.
			Split sRecordData, DB_REC_SEPARATOR, gblsIDNumber, , gblsName, gblsAddress1, \
												gblsAddress2, gblsTel, gblsExtra1
		Else
			// No matching record
			InfoMessage "No existe un cliente con ese RUT."
			call promptYesOrNo(iAnswer, "Desea buscar nuevamente?")
			
			If iAnswer
				iDone = FALSE
				bNewCustomer_ = FALSE

			Else
				iDone = TRUE
				bNewCustomer_ = TRUE

				// reset vars.
				call clearFiscalGblVars()

			EndIf

			Return // bail out
		EndIf
	Else
		// An error occurred. Warn user and log error
		ErrorMessage "Ha ocurrido un error al querer consultar la BD!"
		ErrorMessage "Debera ingresar los datos en forma manual."
		call logInfo(ERROR_LOG_FILE_NAME,"Error while querying DB (Get customer info)",TRUE,TRUE)
		call logInfo(ERROR_LOG_FILE_NAME,sSQLCmd,TRUE,TRUE)
		call MDAD_getLastErrDesc(sSQLErr)
		format sTmp as sQueryRetCode, " | ", sSQLErr 
		call logInfo(ERROR_LOG_FILE_NAME,sTmp,TRUE,TRUE)
		
		// set flags
		iDone_ = TRUE
		bNewCustomer_ = FALSE
		// ask user to input data
		call showCustDataDlg("Ingrese los datos del Cliente:", gblsIDNumber, gblsName, \
							  gblsAddress1, gblsAddress2, gblsTel, gblsExtra1, TRUE)
		return  // bail out!
			
	EndIf
	
	// ----------------------------------------------------
	// #2 Specified customer exists. Ask user what he
	// wants to do about it
	// ----------------------------------------------------

	bNewCustomer_ = FALSE // We now know user doesn't want
						  // to add a new customer to the DB
	
	Window 7,50, "Datos del Cliente:"
		Display 1,1, "RUT      "
		Display 2,1, "Nombre   "
		Display 3,1, "Dir. 1   "
		Display 4,1, "Dir. 2   "
		Display 5,1, "Tel.     "
		Display 6,1, "Extra    "
		Display 1,10, gblsIDNumber{16}
		Display 2,10, gblsName{38}
		Display 3,10, gblsAddress1{38}
		Display 4,10, gblsAddress2{38}
		Display 5,10, gblsTel{16}
		Display 6,10, gblsExtra1{38}

		ClearISLTS
			SetIslTsKey  1,  1, 3, 5, 3, key(1,1), "Continuar" 
		   SetIslTsKey  1,  6, 3, 5, 2, key(1,2), "Modificar"
         SetIslTsKey  4,  1, 3, 5, 2, key(1,3), "Borrar"
			SetIslTsKey  4,  6, 3, 5, 3, key(1,5), "Cancelar"
		DisplayISLTS
			
	InputKey kKeyPressed, iOption, "Elija una opcion:"
	WindowClose
		
	if kKeyPressed = key(1,1)
		// Post current customer info
		iDone = TRUE
		
	ElseIf kKeyPressed = key(1,2)
		// Modify current record
		call ModifyFiscalRecord(gblsIDNumber)
		iDone = TRUE
		
	ElseIf kKeyPressed = key(1,3)
		// delete current record
		call DeleteFiscalRecord(gblsIDNumber)
		// We are not done (user must still select
		// a customer)
		iDone = FALSE

		// reset vars.
		call clearFiscalGblVars()

	ElseIf kKeyPressed = key(1,5)
		// user cancelled current selection.
		// we are not done...
		iDone = FALSE

	EndIf

EndSub

//******************************************************************
// Procedure: AddFiscalRecord()
// Author: Alex Vidal
// Purpose: Adds a new customer to the customers DB table
// Parameters:
//	- sInputedIDNum_ = Inputed "ID" number
//
//******************************************************************
Sub AddFiscalRecord( var sInputedIDNum_ : A30)

	var iDBOK			: N1
	var sSQLCmd			: A1000 = ""
	var sRecordData	: A1000 = ""
	var iAffectedRecs	: N9
	var sQueryRetCode	: A500 = ""
	var sSQLErr			: A500 = ""
	var sTmp				: A2000 = ""


	// init vars
	If sInputedIDNum_ <> "*"
		format gblsIDNumber as sInputedIDNum_
	Else
		// reset vars
		call clearFiscalGblVars()
	EndIf
	
	// Show Dialog
	call showCustDataDlg("Alta de Cliente. Ingrese sus datos:", gblsIDNumber, gblsName, \
							  gblsAddress1, gblsAddress2, gblsTel, gblsExtra1, TRUE)

	// check connection to DB
	call MDAD_checkConnection(iDBOK)

	If Not iDBOK
		// connection to DB lost
		ErrorMessage "Conexion a BD perdida! Los datos no seran guardados."
	Else

		Prompt "Grabando cliente..."

		// insert new customer data
		format sSQLCmd as "INSERT INTO FCR_CUSTOMER_DATA VALUES( ", \
						  "'", gblsIDNumber , "',", \
						  "'',", \
						  "'", gblsName , "',", \
						  "'", gblsAddress1 , "',", \
						  "'", gblsAddress2 , "',", \
						  "'", gblsTel , "',", \
						  "'", gblsExtra1 , "', null, null, null )"
					  						   
		call MDAD_execSQL( MDAD_DBCMD_QUERY, MDAD_DB_QRYTYPE_WRITE, sSQLCmd, "", \
								MDAD_DB_RCRDSET_TYPE_LOCAL, iAffectedRecs, sQueryRetCode)
	
		If sQueryRetCode <> MDAD_RET_CODE_SUCCESS
			// An error has occurred. Warn user and
			// log error		
			ErrorMessage "Ha ocurrido un error al querer insertar el registro en la BD!"
			call logInfo(ERROR_LOG_FILE_NAME,"Error while updating DB (Add fiscal record)",TRUE,TRUE)
			call logInfo(ERROR_LOG_FILE_NAME,sSQLCmd,TRUE,TRUE)
			call MDAD_getLastErrDesc(sSQLErr)
			format sTmp as sQueryRetCode, " | ", sSQLErr 
			call logInfo(ERROR_LOG_FILE_NAME,sTmp,TRUE,TRUE)
		EndIf

	EndIf

EndSub

//******************************************************************
// Procedure: ModifyFiscalRecord()
// Author: Alex Vidal
// Purpose: Modifies an existing customer in the customers DB table
// Parameters:
//	- sInputedIDNum_ = Inputed "ID" number
//
//******************************************************************
Sub ModifyFiscalRecord( var sInputedIDNum_ : A30)

	var iDBOK			: N1
	var sSQLCmd			: A1000 = ""
	var sRecordData	: A1000 = ""
	var iAffectedRecs	: N9
	var sQueryRetCode	: A500 = ""
	var sSQLErr			: A500 = ""
	var sTmp				: A2000 = ""


	// init vars
	format gblsIDNumber as sInputedIDNum_
	
	// Show Dialog
	call showCustDataDlg("Modificacion de Cliente. Edite sus datos:", gblsIDNumber, gblsName, \
							  gblsAddress1, gblsAddress2, gblsTel, gblsExtra1, FALSE)

	// check connection to DB
	call MDAD_checkConnection(iDBOK)

	If Not iDBOK
		// connection to DB lost
		ErrorMessage "Conexion a BD perdida! Los datos no seran modificados."
	Else

		Prompt "Actualizando cliente..."

		// insert new customer data
		Format sSQLCmd as "UPDATE FCR_CUSTOMER_DATA ", \
						  "SET CustInfo1 = '", gblsName , "', " , \
						  "CustInfo2 = '", gblsAddress1, "', " , \
						  "CustInfo3 = '", gblsAddress2, "', " , \
						  "CustInfo4 = '", gblsTel, "', " , \
						  "CustInfo5 = '", gblsExtra1, "' " , \
						  "WHERE CustomerID = '", gblsIDNumber, "'"
					  						   
		call MDAD_execSQL( MDAD_DBCMD_QUERY, MDAD_DB_QRYTYPE_WRITE, sSQLCmd, "", \
								MDAD_DB_RCRDSET_TYPE_LOCAL, iAffectedRecs, sQueryRetCode)
	
		If sQueryRetCode <> MDAD_RET_CODE_SUCCESS
			// An error has occurred. Warn user and
			// log error		
			ErrorMessage "Ha ocurrido un error al querer actualizar el registro en la BD!"
			call logInfo(ERROR_LOG_FILE_NAME,"Error while updating DB (Modify fiscal record)",TRUE,TRUE)
			call logInfo(ERROR_LOG_FILE_NAME,sSQLCmd,TRUE,TRUE)
			call MDAD_getLastErrDesc(sSQLErr)
			format sTmp as sQueryRetCode, " | ", sSQLErr 
			call logInfo(ERROR_LOG_FILE_NAME,sTmp,TRUE,TRUE)
		EndIf

	EndIf

EndSub

//******************************************************************
// Procedure: DeleteFiscalRecord()
// Author: Al Vidal
// Purpose: Deletes an existing customer record from the DB
// Parameters:
//	- sInputedIDNum_ = Inputed "ID" number (Key to use
//						for record deletion)
//
//******************************************************************
Sub DeleteFiscalRecord( var sInputedIDNum_ : A30)

	var iDBOK			: N1
	var sSQLCmd			: A1000 = ""
	var sRecordData	: A1000 = ""
	var iAffectedRecs	: N9
	var sQueryRetCode	: A500 = ""
	var sSQLErr			: A500 = ""
	var sTmp				: A2000 = ""
	var iAnswer			: N1


	// Ask user if he's sure about this...
	call promptYesOrNo(iAnswer, "Esta seguro?")
	If Not iAnswer
		Return // He's not sure. Bail out!
	EndIf

	// check connection to DB
	call MDAD_checkConnection(iDBOK)

	If Not iDBOK
		// connection to DB lost
		ErrorMessage "Conexion a BD perdida! El cliente no sera dado de baja."
	Else

		Prompt "Borrando cliente..."

		// insert new customer data
		Format sSQLCmd as "DELETE FROM FCR_CUSTOMER_DATA ", \
						  "WHERE CustomerID = '", sInputedIDNum_, "'"
					  						   
		call MDAD_execSQL( MDAD_DBCMD_QUERY, MDAD_DB_QRYTYPE_WRITE, sSQLCmd, "", \
								 MDAD_DB_RCRDSET_TYPE_LOCAL,iAffectedRecs, sQueryRetCode)
	
		If sQueryRetCode <> MDAD_RET_CODE_SUCCESS
			// An error has occurred. Warn user and
			// log error		
			ErrorMessage "Ha ocurrido un error al querer dar de baja el registro en la BD!"
			call logInfo(ERROR_LOG_FILE_NAME,"Error while updating DB (Delete fiscal record)",TRUE,TRUE)
			call logInfo(ERROR_LOG_FILE_NAME,sSQLCmd,TRUE,TRUE)
			call MDAD_getLastErrDesc(sSQLErr)
			format sTmp as sQueryRetCode, " | ", sSQLErr 
			call logInfo(ERROR_LOG_FILE_NAME,sTmp,TRUE,TRUE)
		EndIf

	EndIf

EndSub

//******************************************************************
// Procedure: showCustDataDlg()
// Author: Al Vidal
// Purpose: Displays a Dialog that requests input on customer
//			information
// Parameters:
//	- sWindowTtl_ = Caption to be displayed on window
//	- sIDNumber_ = returns "ID" number inputed by the user
//	- sName_ = returns Name inputed by the user
//	- sAddr1_ = returns Address line 1 inputed by the user
//	- sAddr2_ = returns Address line 2 inputed by the user
//	- sTel_ = returns Tel. number inputed by the user
//	- sExtra1_ = returns extra info inputed by the user
//	- EditFirstFld_ = If set to TRUE, first field shown in Window
//					  (ID) will be editable
//
//******************************************************************
Sub showCustDataDlg( var sWindowTtl_ : A50, ref sIDNumber_, ref sName_, \
					 ref sAddr1_, ref sAddr2_, ref sTel_, ref sExtra1_, \
					 var EditFirstFld_: N1 )

	var iInfoOK			: N1 = FALSE
	var iAnswer			: N1
	var iValid			: N1


	// Ask user to enter information
	While Not iInfoOK
	
		// Get DB default alphanumeric touchscreen
		ContinueOnCancel
		Touchscreen @ALPHASCREEN

		If EditFirstFld_
			// First field can be edited

			Window 7,50, sWindowTtl_
				Display 1,1, "RUT      "
				Display 2,1, "Nombre   "
				Display 3,1, "Dir. 1   "
				Display 4,1, "Dir. 2   "
				Display 5,1, "Tel.     "
				Display 6,1, "Extra    "
				DisplayInput 1,10, sIDNumber_{16}, "(max. 16 carac.)"
				DisplayInput 2,10, sName_{38}, "(max. 38 carac.)"
				DisplayInput 3,10, sAddr1_{38}, "(max. 38 carac.)"
				DisplayInput 4,10, sAddr2_{38}, "(max. 38 carac.)"
				DisplayInput 5,10, sTel_{16}, "(max. 16 carac.)"
				DisplayInput 6,10, sExtra1_{38}, "(max. 38 carac.)"
			WindowEdit    
		Else
			// First field cannot be edited

			Window 7,50, sWindowTtl_
				Display 1,1, "RUT      "
				Display 2,1, "Nombre   "
				Display 3,1, "Dir. 1   "
				Display 4,1, "Dir. 2   "
				Display 5,1, "Tel.     "
				Display 6,1, "Extra    "
				Display 1,10, sIDNumber_{16}
				DisplayInput 2,10, sName_{38}, "(max. 38 carac.)"
				DisplayInput 3,10, sAddr1_{38}, "(max. 38 carac.)"
				DisplayInput 4,10, sAddr2_{38}, "(max. 38 carac.)"
				DisplayInput 5,10, sTel_{16}, "(max. 16 carac.)"
				DisplayInput 6,10, sExtra1_{38}, "(max. 38 carac.)"
			WindowEdit    
		EndIf
		
		if @INPUTSTATUS <> 0
			call promptYesOrNo(iAnswer, "Los datos consignados son correctos?")
		endif

		// Check inputed information
		If @INPUTSTATUS <> 0 and (sIDNumber_ <> "" and sName_ <> "" and sAddr1_<> "" and sAddr2_<> "" and sTel_<> "" and sExtra1_ <> "")
			if iAnswer
				Call isValidID(sIDNumber_,iValid)
				if iValid
					iInfoOK = TRUE  // turn on exit-loop flag
				else
					// Inputted ID is invalid!
					ErrorMessage "El RUT ingresado es invalido"
				endif
			EndIf
		Else
			// Input error! Warn user
			ErrorMessage "Se deben completar TODOS los campos con valores validos."
		EndIf

	EndWhile
	WindowClose

EndSub

//******************************************************************
// Procedure: promptYesOrNo()
// Author: Alex Vidal
// Purpose: Shows a prompt message and two buttons: YES and NO, for
//			the user to answer to the prompt
// Parameters:
//	-
//
//******************************************************************
Sub promptYesOrNo(ref retVal_, var sPrompt_ : A100)
    
	var kKeyPressed	: Key
    var sTmpData		: A10
    
	ErrorBeep
    
	ClearIslTs
       SetIslTsKey  1,  1, 5, 5, 3, @Key_Enter, "Si"
		 SetIslTsKey  1,  6, 5, 5, 3, @Key_Clear, "No"
    DisplayIslTs

    InputKey kKeypressed, sTmpData, sPrompt_
    
	retVal_ = (kKeypressed = @KEY_ENTER)

EndSub

//******************************************************************
// Procedure: promptInvType()
// Author: Alex Vidal
// Purpose: Prompts to choose invoice type
// Parameters:
//	- retVal_ = Function's return value (TRUE if BOLETA has been 
//					selected)
//******************************************************************
Sub promptInvType(ref retVal_)
    
	var kKeyPressed	: Key
   var sTmpData		: A10
    
	ErrorBeep
    
	ClearIslTs
     SetIslTsKey  1,  1, 5, 5, 3, @Key_Enter, "Otros Documentos"
		 SetIslTsKey  1,  6, 5, 5, 3, @Key_Clear, "Boleta"
    DisplayIslTs

    InputKey kKeypressed, sTmpData, "Seleccione"
    
	retVal_ = (kKeypressed <> @KEY_ENTER)

EndSub

//******************************************************************
// Procedure: valuePrompt()
// Author: Al Vidal
// Purpose: Shows a prompt message and asks the user to input a
//			value for it.
// Parameters:
//	- retVal_ = Function's return value
//	- prompt_ = Prompt to display
//  - force_ = If TRUE, will keep asking for a prompt value until
//			   a non-empty value is inputed
//
//******************************************************************
Sub valuePrompt( ref retVal_, var prompt_ : A100, var force_ : N1)

	var kKeyPressed	: Key
	var sValue 		: A100
	var iValOK		: N1 = FALSE
	

	While Not iValOK

		// show prompt and ask for value
		
		ContinueOnCancel
		Touchscreen @ALPHASCREEN
		InputKey kKeyPressed, sValue, prompt_
		
		// check input...

		If kKeyPressed = @Key_Clear
		
			If force_
				// user must enter a value.
				errorMessage "Debe ingresar un valor!"
			Else
				iValOK = TRUE  // bail out!
				format retVal_ as ""
			EndIf

		ElseIf kKeyPressed = @Key_Enter
		
			If sValue <> ""
				iValOK = TRUE  // bail out!
				format retVal_ as sValue
			Else
				// user must enter a value.
				errorMessage "Debe ingresar un valor!"
			EndIf

		Else

			// user must enter a value.
			errorMessage "Debe ingresar un valor!"
		EndIf

	EndWhile

EndSub

//******************************************************************
// Procedure: selectInvoiceType()
// Author: Alex Vidal
// Purpose: Allows the user to choose an invoice type for current
//			Check
// Parameters:
//	-
//
//******************************************************************
Sub selectInvoiceType()

	var iSelection			:N1
	var iAnswer				:N1
	var sInvoiceType[3]	:A33
	var cChkTtl				:$12
	var sTmp					:A2
	Var sInvoiceNumber 		: A32
	Var sNCInvoiceType		: A1
	Var sNCRefNetAmount		: A10
	Var sNCRefTaxAmount		: A10
	Var sNCRefReason			: A30
	var iInfoOk				:N1 = FALSE

	
	call getCheckTtl(cChkTtl)
	
	if cChkTtl < 0
		
		// Check total is negative. This is a "Nota de Credito"
		if gbliUseEDI
			While Not iInfoOK
	
				// Get DB default alphanumeric touchscreen
				Touchscreen @ALPHASCREEN
				
				if gbliUseEDI
					// Show Dialog...
					Window 9, 70
						Display 1, @CENTER, "NOTA DE CREDITO ELECTRONICA"
						Display 3, 1, "Tipo Documento Original   : "
						Display 4, 1, "Nro Documento original    : "
						//Display 5, 1, "Monto Neto                : "
						//Display 6, 1, "IVA                       : "
						Display 5, 1, "Razon Anulacion           : " 
						DisplayInput 3, 30, sNCInvoiceType{1}, "1=B|2=F"
						DisplayInput 4, 30, sInvoiceNumber{9}, "Ingrese Nro de Docto"
						//DisplayInput 5, 30, sNCRefNetAmount{10}, "Ingrese Monto Neto"
						//DisplayInput 6, 30, sNCRefTaxAmount{10}, "Ingrese Monto IVA"
						DisplayInput 5, 30, sNCRefReason{30}, "Motivo Anulacion"
					Windowedit
						
			
					// Check inputed information
					If(sInvoiceNumber <> "" and sNCInvoiceType <>"")
						// Ask user to confirm inputed data
						Call promptYesOrNo(iInfoOK, "Los datos consignados son correctos?")
						
						if (sNCInvoiceType < 1 and sNCInvoiceType > 2)
							ErrorMessage "Debe ingresar un tipo de Docto Correcto."
						else
							if sNCRefTaxAmount=""
								sNCRefTaxAmount = "0"
							endif
							
							If(iInfoOK)
								Format gblsNCReferenceInvNumber As sInvoiceNumber
								Format gblsNCReferenceInvType as sNCInvoiceType
								Format gblsNCRefNetAmount as sNCRefNetAmount
								Format gblsNCRefTaxAmount as sNCRefTaxAmount
								Format gblsNCReferenceReason as sNCRefReason
							Endif
						Endif
			
					Else
						// Input error. Warn user
						ErrorMessage "Se deben completar TODOS los campos con datos validos."	
			
					EndIf
				endif
		
			EndWhile	
			
			WindowClose
		endif
		
		gbliInvoiceType = INV_TYPE_CREDITO

	else
		if Not gbliBOLETAasDefault
					
			if gbliUseEDI
				sInvoiceType[1] = "BOLETA ELECTRONICA"
				sInvoiceType[2] = "FACTURA ELECTRONICA"
			else
				sInvoiceType[1] = "BOLETA"
				sInvoiceType[2] = "FACTURA"
				sInvoiceType[3] = "GUIA"
			endif
			
	
			// Display a dialog for the user to choose the 
			// invoice type

			while not iInfoOk
				ContinueOnCancel
				Touchscreen @ALPHASCREEN
				if not gbliUseEDI
					Window 5,45, "Seleccione Tipo de Comprobante:"
						Display 2,1, "          (", INV_TYPE_BOLETA, ") ", sInvoiceType[1]
						Display 3,1, "          (", INV_TYPE_FACTURA, ") ", sInvoiceType[2]
						Display 4,1, "          (", INV_TYPE_GUIA, ") ", sInvoiceType[3]
					WindowEdit
				else
					Window 4,45, "Seleccione Tipo de documento:"
						Display 2,1, "          (", INV_TYPE_BOLETA, ") ", sInvoiceType[1]
						Display 3,1, "          (", INV_TYPE_FACTURA, ") ", sInvoiceType[2]
					WindowEdit
				endif
				
		
				// get selected invoice type from user and save selection
				Call valuePrompt(sTmp, "digite una opcion", TRUE)
				WindowClose
				
				// set selected invoice type
				gbliInvoiceType = sTmp

				if not gbliUseEDI
					if gbliInvoiceType = INV_TYPE_BOLETA or \
						gbliInvoiceType = INV_TYPE_FACTURA OR \
						gbliInvoiceType = INV_TYPE_GUIA
							iInfoOK = TRUE // turn on exit-loop flag
					else
						ErrorMessage "El Tipo de comprobante seleccionado no es valido"
					endif
				else
					if gbliInvoiceType = INV_TYPE_BOLETA or \
						gbliInvoiceType = INV_TYPE_FACTURA 
							iInfoOK = TRUE // turn on exit-loop flag
					else
						ErrorMessage "El Tipo de comprobante seleccionado no es valido"
					endif
				endif
			endwhile
		else
			gbliInvoiceType = INV_TYPE_BOLETA
		endif	
	endif

EndSub

//******************************************************************
// Procedure: getCAStatus()
// Author: Alex Vidal
// Purpose: Returns TRUE if a Credit Card Authorization (CA) has
//			been set. FALSE if otherwise.
// Parameters:
//	- retVal_ = Function's return value
//
//******************************************************************
Sub getCAStatus( ref retVal_ )

	var i				: N5  // for looping
	var iCAFound	: N1 = FALSE

	// cycle through Check detail to see if
	// we can find any CA detail info...

	For i = 1 to @numdtlt
	
		If @dtl_Type[i] = DT_CA_DETAIL
			iCAFound = TRUE 
			break
		EndIf
	
	EndFor

	retVal_ = iCAFound

EndSub

//******************************************************************
// Procedure: SaveInvoiceInfoInDB()
// Author: Alex Vidal
// Purpose: Saves invoice information to the Micros DB for current 
//			check
// Parameters:
//	- cSubtotal_ = issued invoice subtotal amount
// - cTaxSubtotal_ = issued invoice Tax subtotal amount
//	- cBurdenSubtotal_ = issued invoice Burden subtotal amount
//	- cExemptSubtotal_ = issued invoice Exempt subtotal amount
//	- cDiscSubtotal_ = issued invoice Discounts subtotal amount
//	- cServSubtotal_ = issued invoice Services subtotal amount
//	- cRoundingAdj_ = issued invoice Rounding Adjustments amount
//	- cTotal_ = issued invoice Total amount
//	- sCouponNum_ = Coupon (invoice) number
//	- sCouponSubttl_ = Coupon per-page subtotal
// - sTransport_ = Transport identifier
//	- sFirstCoupon_ = first coupon number (for multi-page print
//						   jobs)
//	- sLastCoupon_ = last coupon number (for multi-page print
//						  jobs)
//	- iInvoiceType_ = Iinvoice Type
//	- iInvStatus_ = Invoice status (1 = Active | 2 = Error |
//						 0 = Cancelled)
//	- iCkNum_ = Micros check number
//	- iFCRID_ = FCR's "Numero de Caja"
//******************************************************************
Sub SaveInvoiceInfoInDB( ref cSubtotal_, ref cTaxSubtotal_, ref cBurdenSubtotal_, \
					     		ref cExemptSubtotal_, ref cDiscSubtotal_, ref cServSubtotal_, \
						 		ref cRoundingAdj_, ref cTotal_, ref sCouponNum_, ref sCouponSubttl_, \
						 		ref sTransport_, ref sFirstCoupon_, ref sLastCoupon_, var iInvoiceType_ : N1, \
						 		var iInvStatus_ : N1, ref iCkNum_, var iFCRID_ : N9 )

	var sSQLCmd			: A1000 = ""
	var iAffectedRecs	: N9
	var sQueryRetCode	: A500 = ""
	var sSQLErr			: A500 = ""
	var sTmp				: A2000 = ""
	var iDBOK			: N1
	var sFiscalID		: A40 = ""
	var sPostedData[31] : A100
	var sBszDate		: A100
	var cTax[8]			: $12
	var sExtraField	: A100


	// set parameters...
	If gblsIDNumber <> ""
		sFiscalID = gblsIDNumber
	EndIf
	if gbliInvoiceType = INV_TYPE_CREDITO
		Format sExtraField as gblsCreditInfo
	else
		Format sExtraField as gblsName
	endif
	if sCouponSubttl_ = ""
		sCouponSubttl_ = "0.00"
	endif

	if iInvStatus_ <> 2 // erroneous
		if gbliTaxIsInclusive
			cTax[1] = @TAXVAT[1]
			cTax[2] = @TAXVAT[2]
			cTax[3] = @TAXVAT[3]
			cTax[4] = @TAXVAT[4]
			cTax[5] = @TAXVAT[5]
			cTax[6] = @TAXVAT[6]
			cTax[7] = @TAXVAT[7]
			cTax[8] = @TAXVAT[8]
		else
			cTax[1] = @TAX[1]
			cTax[2] = @TAX[2]
			cTax[3] = @TAX[3]
			cTax[4] = @TAX[4]
			cTax[5] = @TAX[5]
			cTax[6] = @TAX[6]
			cTax[7] = @TAX[7]
			cTax[8] = @TAX[8]
		endif
	endif

	// build current date
	if gbliDBType = SQLSERVER
		format sBszDate as "CONVERT(datetime,'", (@YEAR + 1900){04}, "-", @MONTH{02}, "-", @DAY{02}, \
									" ", @HOUR{02}, ":", @MINUTE{02}, ":", @SECOND{02}, "',120)"
	else
		format sBszDate as "TO_DATE('", (@YEAR + 1900){04}, "/", @MONTH{02}, "/", @DAY{02}, \
									" ", @HOUR{02}, ":", @MINUTE{02}, ":", @SECOND{02}, "',", \
									"'YYYY/MM/DD HH24:MI:SS')"
	endif

	// build SQL statement
	
	if gbliDBType = SQLSERVER
		// SQL Server does not allow subqueries. Use a var to store Micros Biz Date value
		Format sSQLCmd as "DECLARE @BD datetime set @BD = (SELECT MAX(BusinessDate) FROM PERIOD_INSTANCE) "
	endif
	
	Format sSQLCmd as sSQLCmd, "INSERT INTO FCR_INVOICE_DATA(", \
						"PCWSID,FCRInvNumber,MicrosChkNum,InvoiceType,InSARMode,", \
						"CustomerID,InvoiceStatus,MicrosBsnzDate,FCRBsnzDate,", \
						"Subtotal1,Subtotal2,Subtotal3,Subtotal4,Subtotal5,", \
						"Subtotal6,Subtotal7,Subtotal8,Subtotal9,Subtotal10,", \
						"Subtotal11,TaxTtl1,TaxTtl2,TaxTtl3,TaxTtl4,", \
						"TaxTtl5,TaxTtl6,TaxTtl7,TaxTtl8,ExtraField1,Subtotal12,", \
						"ExtraField2,ExtraField3,ExtraField4,ExtraField5,ExtraField6) ", \
						"VALUES( ", \
						@Wsid, ", ", \
						"'", sCouponNum_, "', ", \
						iCkNum_, ", ", \
						iInvoiceType_, ", ", \
						gblsInvoiceNumFromSAR, ", ", \
						"'", sFiscalID, "', ", \
						iInvStatus_, ", "		// Invoice Status
						
	if gbliDBType = SQLSERVER
		Format sSQLCmd as sSQLCmd, "@BD, "
	else
		Format sSQLCmd as sSQLCmd, "(SELECT MAX(BusinessDate) FROM PERIOD_INSTANCE), "
	endif
						
	Format sSQLCmd as sSQLCmd, sBszDate, ", ", \
						cSubtotal_{+}, ", ", \		// Subtotal1
						cDiscSubtotal_{+}, ", ", \   
						cServSubtotal_{+}, ", ", \
						cBurdenSubtotal_{+}, ", ", \
						cExemptSubtotal_{+}, ", ", \
						cTaxSubtotal_{+}, ", ", \
						cRoundingAdj_{+}, ", ", \
						cTotal_{+}, ", ", \
						"null, ", \
						"null, ", \
						"null, ", \
						cTax[1]{+}, ", ", \
						cTax[2]{+}, ", ", \
						cTax[3]{+}, ", ", \
						cTax[4]{+}, ", ", \
						cTax[5]{+}, ", ", \
						cTax[6]{+}, ", ", \
						cTax[7]{+}, ", ", \
						cTax[8]{+}, ", ", \
						"'", sExtraField, "', ", \
						sCouponSubttl_, ", ", \
						"'", sTransport_, "', ", \
						"'", sFirstCoupon_, "', ", \
						"'", sLastCoupon_, "', ", \
						"'", @RVC, "', ", \
						"'", iFCRID_, "' )"

	// Check DB Connection
	call MDAD_checkConnection(iDBOK)


	If iDBOK
		
		Prompt "Grabando datos fiscales..."

		// execute query

		call MDAD_execSQL( MDAD_DBCMD_QUERY, MDAD_DB_QRYTYPE_WRITE, sSQLCmd, "", \
								 MDAD_DB_RCRDSET_TYPE_LOCAL, iAffectedRecs, sQueryRetCode)
	
		If sQueryRetCode <> MDAD_RET_CODE_SUCCESS
			// An error has occurred
			iDBOK = FALSE
			call logInfo(ERROR_LOG_FILE_NAME,"Error while updating DB (Issued invoice info)",TRUE,TRUE)
			call logInfo(ERROR_LOG_FILE_NAME,sSQLCmd,TRUE,TRUE)
			call MDAD_getLastErrDesc(sSQLErr)
			format sTmp as sQueryRetCode, " | ", sSQLErr 
			call logInfo(ERROR_LOG_FILE_NAME,sTmp,TRUE,TRUE)
		EndIf
	Else
		iDBOK = FALSE
	EndIf


	If Not iDBOK
		// record was not inserted in the DB. Keep a local
		// copy of it in order to post it to the DB later

		ErrorMessage "Problema con BD! Los datos del comprobante se grabaran localmente."
		call logInfo(ERROR_LOG_FILE_NAME,"DB Connection lost. Invoice data will be saved locally",TRUE,TRUE)

		format sPostedData[1] as @Wsid
		format sPostedData[2] as sCouponNum_
		format sPostedData[3] as iCkNum_
		format sPostedData[4] as iInvoiceType_
		format sPostedData[5] as gblsInvoiceNumFromSAR
		format sPostedData[6] as sFiscalID
		format sPostedData[7] as sBszDate
		format sPostedData[8] as cSubtotal_{+}
		format sPostedData[9] as Abs(cDiscSubtotal_)
		format sPostedData[10] as cServSubtotal_{+}
		format sPostedData[11] as cBurdenSubtotal_{+}
		format sPostedData[12] as cExemptSubtotal_{+}
		format sPostedData[13] as cTaxSubtotal_{+}
		format sPostedData[14] as Abs(cRoundingAdj_)
		format sPostedData[15] as cTotal_{+}
		format sPostedData[16] as cTax[1]{+}
		format sPostedData[17] as cTax[2]{+}
		format sPostedData[18] as cTax[3]{+}
		format sPostedData[19] as cTax[4]{+}
		format sPostedData[20] as cTax[5]{+}
		format sPostedData[21] as cTax[6]{+}
		format sPostedData[22] as cTax[7]{+}
		format sPostedData[23] as cTax[8]{+}
		format sPostedData[24] as sExtraField
		format sPostedData[25] as sCouponSubttl_
		format sPostedData[26] as sTransport_
		format sPostedData[27] as sFirstCoupon_
		format sPostedData[28] as sLastCoupon_
		format sPostedData[29] as @RVC
		format sPostedData[30] as iInvStatus_
		Format sPostedData[31] as iFCRID_
		

		call SaveInvoiceInfoInFile(sPostedData[],31)

	EndIf

EndSub

//******************************************************************
// Procedure: SaveInvoiceInfoInFile()
// Author: Alex Vidal
// Purpose: Saves last issued invoice information to a local file
// Parameters:
//	-  sInvoiceInfo_[] = Contains all the info that needs to be
//						 saved for issued invoice
//	-  sInvoiceInfoLen_	= Specifies the length of the 
//						  "sInvoiceInfo_" array
//
//******************************************************************
Sub SaveInvoiceInfoInFile( ref sInvoiceInfo_[], var sInvoiceInfoLen_ : N4)

	var i			: N5  // for looping
	var fn		: N5  // file handle
	var sCSVal	: A40 // CheckSum value
	var sInfo	: A1000 = ""

	// open handle to file...
	if @WSTYPE = SAROPS
		FOpen fn, SAVED_CUST_RECEIPTS_FILE_NAME, append, local
	else
		FOpen fn, SAVED_CUST_RECEIPTS_FILE_NAME, append
	endif
		
	If fn <> 0 
		
		// save info

		For i = 1 To sInvoiceInfoLen_
	
			format sInfo as sInfo, sInvoiceInfo_[i]

			If i < sInvoiceInfoLen_
				// add field separator
				format sInfo as sInfo, ";"
			EndIf
			
		EndFor

		// calculate checkSum value for record
		call calculateFileCheckSum(sInfo, sCSVal)

		// write record to file...
		Fwrite fn, sInfo, sCSVal

		fclose fn
	Else
		
		// Couldn't save info to file!
		ErrorMessage "Critical Information could not be saved! Contact your administrator."
		call logInfo(ERROR_LOG_FILE_NAME,"Critical Information could not be saved",TRUE,TRUE)

	EndIf

EndSub

//******************************************************************
// Procedure: UploadPendingTransToDB()
// Author: Al Vidal
// Purpose: Uploads pending postings to the Micros DB. Returns
//			TRUE if everything went OK. FALSE if otherwise.
// Parameters:
//	- reVal = Function's return value
//
//******************************************************************
Sub UploadPendingTransToDB( ref retVal_ )

	var sSQLCmd						: A1000 = ""
	var iAffectedRecs				: N9
	var sQueryRetCode				: A500 = ""
	var sSQLErr						: A500 = ""
	var sTmp							: A2000 = ""
	var sSystemCmd					: A200
	var iDBOK						: N1 = FALSE
	var fn							: N5  // file handle
	var sInfo[MAX_RECS_UPLOAD]		: A500
	var iInfoCS[MAX_RECS_UPLOAD]	: N40 // record's Checksum
	var iInfoCSOK					: N1
	var sTmpInfo					: A1000
	var sField[31]					: A100
	var sTrailQuotes				: N5
	var sTotalQuotes				: N5
	var i								: N5 = 0 // for looping
	var j								: N5 = 0 // for looping
	var x								: N5 = 0 // for looping


	// Check if "pending postings" file exists. If so, post
	// every saved transaction to the DB

	if @WSTYPE = SAROPS
		Fopen fn, SAVED_CUST_RECEIPTS_FILE_NAME, read, local
	else
		Fopen fn, SAVED_CUST_RECEIPTS_FILE_NAME, read
	endif

	If fn <> 0 

		While Not Feof(fn)
	
			// Add to info lines counter		
			i = i + 1

			// read current record
			fread fn, sInfo[i], iInfoCS[i]

			If Trim(sInfo[i]) <> ""

				// Check for corruption
				call validateFileCheckSum(sInfo[i],iInfoCS[i], iInfoCSOK)
				
				If Not iInfoCSOK
					ErrorMessage "El archivo ", SAVED_CUST_RECEIPTS_FILE_NAME, " esta corrupto!"
					ErrorMessage "Contacte a su supervisor."
					format sTmpInfo as SAVED_CUST_RECEIPTS_FILE_NAME, \
									   " file is corrupt on record ", i
					call logInfo(ERROR_LOG_FILE_NAME,sTmpInfo,TRUE,TRUE)
					Fclose fn // close file handle
					Return	 //  bail out!
				EndIf

				// get double quotes ("") info from record...
				call getDoubleQuotesInfo(sInfo[i], sTrailQuotes, sTotalQuotes)

				// remove double quotes ("") from string
				format sTmpInfo as sInfo[i]
				format sInfo[i] as mid(sTmpInfo, sTrailQuotes + 1, (len(sTmpInfo) - sTotalQuotes) )

			Else

				// invalid line: subtract it from info lines counter		
				i = i - 1
			EndIf

			if i = MAX_RECS_UPLOAD
				// limit has been reached!
				Break 
			endif

		EndWhile

		Fclose fn
	EndIf

	If i > 0
		// There are records to be posted to the DB
		
		// Check DB Connection
		call MDAD_checkConnection(iDBOK)

		If iDBOK

			Prompt "Enviando datos SAR..."
			
			For j = 1 to i

				If Trim(sInfo[j]) <> ""
				
					format sSQLCmd as ""

					// Get field values
					Split sInfo[j], ";", sField[1], sField[2], sField[3], sField[4], \
										 sField[5], sField[6], sField[7], sField[8], \
										 sField[9], sField[10], sField[11], sField[12], \
										 sField[13], sField[14], sField[15], sField[16], \
										 sField[17], sField[18], sField[19], sField[20], \
										 sField[21], sField[22], sField[23], sField[24], \
										 sField[25], sField[26], sField[27], sField[28], \
										 sField[29], sField[30], sField[31]

					// build SQL statement
					
					if gbliDBType = SQLSERVER
						// SQL Server does not allow subqueries. Use a var to store Micros Biz Date value
						Format sSQLCmd as "DECLARE @BD datetime set @BD = (SELECT MAX(BusinessDate) FROM PERIOD_INSTANCE) "
					endif
					
					Format sSQLCmd as sSQLCmd , "INSERT INTO FCR_INVOICE_DATA(", \
												"PCWSID,FCRInvNumber,MicrosChkNum,InvoiceType,InSARMode,", \
												"CustomerID,InvoiceStatus,MicrosBsnzDate,FCRBsnzDate,", \
												"Subtotal1,Subtotal2,Subtotal3,Subtotal4,Subtotal5,", \
												"Subtotal6,Subtotal7,Subtotal8,Subtotal9,Subtotal10,", \
												"Subtotal11,TaxTtl1,TaxTtl2,TaxTtl3,TaxTtl4,", \
												"TaxTtl5,TaxTtl6,TaxTtl7,TaxTtl8,ExtraField1,Subtotal12,", \
												"ExtraField2,ExtraField3,ExtraField4,ExtraField5,ExtraField6) ", \
												"VALUES( ", \
												sField[1], ", ", \
												"'", sField[2], "', ", \
												sField[3], ", ", \
												sField[4], ", ", \
												sField[5], ", ", \
												"'", sField[6], "', ", \
												sField[30], ", "		// Invoice Status
												
					if gbliDBType = SQLSERVER
						Format sSQLCmd as sSQLCmd, "@BD, "
					else
						Format sSQLCmd as sSQLCmd, "(SELECT MAX(BusinessDate) FROM PERIOD_INSTANCE), "
					endif
					
					Format sSQLCmd as sSQLCmd, sField[7], ", ", \
												sField[8], ", ", \	// Subtotal1
												sField[9], ", ", \
												sField[10], ", ", \
												sField[11], ", ", \
												sField[12], ", ", \
												sField[13], ", ", \
												sField[14], ", ", \
												sField[15], ", ", \
												"null, ", \
												"null, ", \
												"null, ", \
												sField[16], ", ", \
												sField[17], ", ", \
												sField[18], ", ", \
												sField[19], ", ", \
												sField[20], ", ", \
												sField[21], ", ", \
												sField[22], ", ", \
												sField[23], ", ", \
												"'", sField[24], "', ", \
												sField[25], ", ", \
												"'", sField[26], "', ", \
												"'", sField[27], "', ", \
												"'", sField[28], "', ", \
												"'", sField[29], "', ", \
												"'", sField[31], "' )"

					// execute query

					call MDAD_execSQL( MDAD_DBCMD_QUERY, MDAD_DB_QRYTYPE_WRITE, sSQLCmd, "", \
											MDAD_DB_RCRDSET_TYPE_LOCAL, iAffectedRecs, sQueryRetCode)
	
					If sQueryRetCode <> MDAD_RET_CODE_SUCCESS
						// An error has occurred. Break from loop!
						iDBOK = FALSE
						call logInfo(ERROR_LOG_FILE_NAME,"Error while updating DB (Upload pending trans.)",TRUE,TRUE)
						call logInfo(ERROR_LOG_FILE_NAME,sSQLCmd,TRUE,TRUE)
						call MDAD_getLastErrDesc(sSQLErr)
						format sTmp as sQueryRetCode, " | ", sSQLErr 
						call logInfo(ERROR_LOG_FILE_NAME,sTmp,TRUE,TRUE)
						Break
					EndIf
				
				EndIf
			EndFor


			If Not iDBOK
				// an error occurred while trying to post all
				// pending transactions. The "pending postings"
				// File will be created again, this time containing 
				// only the records that couldn't be sent due to 
				// the error.

				// open handle to file...
				if @WSTYPE = SAROPS
					Fopen fn, SAVED_CUST_RECEIPTS_FILE_NAME, write, local
				else
					Fopen fn, SAVED_CUST_RECEIPTS_FILE_NAME, write
				endif

				If fn <> 0
					For x = j To i
						If Trim(sInfo[x]) <> ""
							Fwrite fn, sInfo[x], iInfoCS[x]
						EndIf
					EndFor

					FClose fn
				Else
					// Error! Warn user.
					errorMessage "Failed to recreate saved Customer Receipts file!"
					call logInfo(ERROR_LOG_FILE_NAME,"Failed to recreate saved Customer Receipts file",TRUE,TRUE)
				EndIf
			Else

				// Clear contents from Cust. Receipts saved file since
				// all postings where successful!
				
				if @WSTYPE = SAROPS
					fopen fn, SAVED_CUST_RECEIPTS_FILE_NAME, write, local
				else
					fopen fn, SAVED_CUST_RECEIPTS_FILE_NAME, write
				endif
				
				if fn <> 0
					fwrite fn, ""
					fclose fn
				endif
								
			EndIf

		EndIf
	EndIf

	// Set return value
	retVal_ = iDBOK

EndSub

//******************************************************************
// Procedure: cancelEmittedInvoice()
// Author: Alex Vidal
// Purpose: Shows a dialog where the operator is requested to 
//			enter the invoice number of the emited Invoice that
//			needs to be cancelled.
// Parameters:
//	-
//
//******************************************************************
Sub cancelEmittedInvoice()

	var sInvoiceNumber	: A12 = ""
	var iInvoiceType		: N1 = 0
	var iInvCount			: N2
	var sCheckNumber		: A12 = ""
	var iInfoOK				: N1 = FALSE
	var sTmpInvNum			: A12
	var iAnswer				: N1
	var sSQLCmd				: A500
	var sRecordData		: A1000 = ""
	var iRecordIdx			: N9
	var iAffectedRecs		: N9
	var sQueryRetCode		: A500 = ""
	var sSQLErr				: A500 = ""
	var sTmp					: A2000 = ""
	var iDBOK				: N1 = FALSE


	While Not iInfoOK
	
		// Get DB default alphanumeric touchscreen
		ContinueOnCancel
		Touchscreen @ALPHASCREEN

		// Show Dialog...

		Window 6,50, "Anulacion de Factura:"
			Display 1,1, "Comprob. Nro.:"
			Display 2,1, "Cheque Nro. :"
			Display 3,1, "Tipo Factura:"
			DisplayInput 1,20, sInvoiceNumber{12}, "Nro. de Comprob."
			DisplayInput 2,20, sCheckNumber{12}, "Nro. de Cheque"
			DisplayInput 3,20, iInvoiceType, "1=B|2=F|3=G"
		WindowEdit

		// Check inputed information
		If @INPUTSTATUS <> 0 and sInvoiceNumber <> "" and \
			sCheckNumber <> "" and \
		   ( iInvoiceType = INV_TYPE_BOLETA or \
		     iInvoiceType = INV_TYPE_FACTURA or \
		     iInvoiceType = INV_TYPE_GUIA )
			
			iInfoOK = TRUE // turn on exit-loop flag
		Else
			
			// Input error. Warn user
			ErrorMessage "Se deben completar TODOS los campos con datos validos."	
		EndIf

	EndWhile
	WindowClose

	// Check DB Connection
	call MDAD_checkConnection(iDBOK)

	If iDBOK

		Prompt "Cancelando comprobante..."

		// build SQL statement (in order to cancel an emited
		// invoice, all we have to do is change its status to
		// "0" = "cancelled")
		
		Format sSQLCmd as "UPDATE FCR_INVOICE_DATA ", \
						  		"SET InvoiceStatus = 0 ", \
						  		"WHERE PCWSID = ", @Wsid, " and ", \ 
								"FCRInvNumber = '", sInvoiceNumber, "' and ", \
								"MicrosChkNum = ", sCheckNumber, " and ", \
								"InvoiceType = ", iInvoiceType

		// Execute update

		call MDAD_execSQL( MDAD_DBCMD_QUERY, MDAD_DB_QRYTYPE_WRITE, sSQLCmd, "", \
								 MDAD_DB_RCRDSET_TYPE_LOCAL, iAffectedRecs, sQueryRetCode)
	
		If sQueryRetCode <> MDAD_RET_CODE_SUCCESS
			// An error has occurred
			iDBOK = FALSE
			call logInfo(ERROR_LOG_FILE_NAME,"Error while updating DB (invoice cancellation)",TRUE,TRUE)
			call logInfo(ERROR_LOG_FILE_NAME,sSQLCmd,TRUE,TRUE)
			call MDAD_getLastErrDesc(sSQLErr)
			format sTmp as sQueryRetCode, " | ", sSQLErr 
			call logInfo(ERROR_LOG_FILE_NAME,sTmp,TRUE,TRUE)
		EndIf
	Else
		
		// Error! Warn user
		ErrorMessage "Conexion a DB perdida! Por favor, intente mas tarde."
		return  // bail out!
	EndIf

	// check DB status...
	If Not iDBOK
		// error! Warn user
		ErrorMessage "Error al tratar de anular el comprobante!"
		call logInfo(ERROR_LOG_FILE_NAME,"Error while trying to cancel an invoice",TRUE,TRUE)
		return // bail out!
	EndIf


	// Now check if the update succedeed

	If iAffectedRecs > 0
		// invoice has been successfully voided!
		errorMessage "El comprobante ", sInvoiceNumber, " fue anulado."
	Else
		// no update took place.
		errorMessage "El comprobante ", sInvoiceNumber, " no pudo ser anulado."
	EndIf

EndSub

//******************************************************************
// Procedure: modifyEmittedInvoiceNumber()
// Author: Alex Vidal
// Purpose: Shows a dialog where the operator is requested to 
//			enter the invoice number of an emited Invoice number that
//			needs to be modified.
// Parameters:
//	-
//******************************************************************
Sub modifyEmittedInvoiceNumber()
	
	var sInvoiceNumber	: A12 = ""
	var iInvoiceType		: N1 = 0
	var iInvCount			: N2
	var sCheckNumber		: A12 = ""
	var iInfoOK				: N1 = FALSE
	var sTmpInvNum			: A12
	var iAnswer				: N1
	var sSQLCmd				: A500
	var sRecordData		: A1000 = ""
	var iRecordIdx			: N9
	var iAffectedRecs		: N9
	var sQueryRetCode		: A500 = ""
	var sSQLErr				: A500 = ""
	var sTmp					: A2000 = ""
	var iDBOK				: N1 = FALSE
	var sChkNum				: A10
	var sTransport			: A10
	var sNewInvNum			: A20


	While Not iInfoOK
	
		// Get DB default alphanumeric touchscreen
		ContinueOnCancel
		Touchscreen @ALPHASCREEN

		// Show Dialog...
		Window 6,50, "Modificacion de nro. de comprobante:"
			Display 1,1, "Comprob. Nro.:"
			Display 2,1, "Tipo Factura:"
			DisplayInput 1,20, sInvoiceNumber{12}, "Nro. de comprob."
			DisplayInput 2,20, iInvoiceType, "1=B|2=F|3=G|4=C"
		WindowEdit

		// Check inputed information
		If @INPUTSTATUS <> 0 and sInvoiceNumber <> ""  and \
		   ( iInvoiceType = INV_TYPE_BOLETA or \
		     iInvoiceType = INV_TYPE_FACTURA or \
		     iInvoiceType = INV_TYPE_GUIA or \
		     iInvoiceType = INV_TYPE_CREDITO )
			
			iInfoOK = TRUE // turn on exit-loop flag
		Else
					
			// Input error. Warn user
			ErrorMessage "Se deben completar TODOS los campos con datos validos."	
		EndIf

	EndWhile
	WindowClose

	// Check DB Connection
	call MDAD_checkConnection(iDBOK)

	If iDBOK

		// #1 search in the DB for corresponding micros check
		
		Prompt "Obteniendo cheque asociado..."
		
		format sSQLCmd as "SELECT MicrosChkNum, ExtraField2 FROM FCR_INVOICE_DATA ", \
						  		"WHERE PCWSID = ", @WSID, " and ", \
						  		"FCRInvNumber = '", sInvoiceNumber, "' and ", \
						  		"InvoiceType = ", iInvoiceType
	
		call MDAD_execSQL( MDAD_DBCMD_QUERY, MDAD_DB_QRYTYPE_READ, sSQLCmd, "", \
								 MDAD_DB_RCRDSET_TYPE_LOCAL, iAffectedRecs, sQueryRetCode)
		
		If sQueryRetCode = MDAD_RET_CODE_SUCCESS
	
			// Try to get first record (if any).
			call MDAD_getNextRec(sRecordData, iRecordIdx)
			
			If iRecordIdx <> -1
				// We have a record match. Retrieve its data.
				Split sRecordData, DB_REC_SEPARATOR, sChkNum, sTransport
				
				if sTransport = HAS_TRANSPORT
					InfoMessage "El cheque asociado tiene transporte."
					Return // bail out
				endif
			Else
				// No matching record for inputted data
				InfoMessage "No existe un cheque asociado con esos datos."
				Return // bail out
			EndIf
		Else
			// An error occurred. Warn user and log error
			ErrorMessage "Ha ocurrido un error al querer consultar la BD!"
			call logInfo(ERROR_LOG_FILE_NAME,"Error while querying DB (modifyEmittedInvoiceNumber)",TRUE,TRUE)
			call logInfo(ERROR_LOG_FILE_NAME,sSQLCmd,TRUE,TRUE)
			call MDAD_getLastErrDesc(sSQLErr)
			format sTmp as sQueryRetCode, " | ", sSQLErr 
			call logInfo(ERROR_LOG_FILE_NAME,sTmp,TRUE,TRUE)
			Return // bail out!
		endif
		
		// Show info
		Format sTmp as "Cheque asociado: ", sChkNum, ". Ingrese nuevo nro. de comprobante"
		InfoMessage sTmp
		Call valuePrompt(sNewInvNum, "Nuevo numero?", TRUE)
		
		
		// #2 check if new inputted invoice number doesn't already exist
		
		Prompt "Verificando nro. ingresado..."
		
		format sSQLCmd as "SELECT * FROM FCR_INVOICE_DATA ", \
						  		"WHERE PCWSID = ", @WSID, " and ", \
						  		"FCRInvNumber = '", sNewInvNum, "' and ", \
						  		"InvoiceType = ", iInvoiceType
	
		call MDAD_execSQL( MDAD_DBCMD_QUERY, MDAD_DB_QRYTYPE_READ, sSQLCmd, "", \
								 MDAD_DB_RCRDSET_TYPE_LOCAL, iAffectedRecs, sQueryRetCode)
		
		If sQueryRetCode = MDAD_RET_CODE_SUCCESS
	
			if iAffectedRecs > 0
				// Inputted invoice number already exists!
				InfoMessage "El nro. de comprobante ya existe!"
				Return // bail out
			endif
		Else
			// An error occurred. Warn user and log error
			ErrorMessage "Ha ocurrido un error al querer consultar la BD!"
			call logInfo(ERROR_LOG_FILE_NAME,"Error while querying DB (modifyEmittedInvoiceNumber 2)",TRUE,TRUE)
			call logInfo(ERROR_LOG_FILE_NAME,sSQLCmd,TRUE,TRUE)
			call MDAD_getLastErrDesc(sSQLErr)
			format sTmp as sQueryRetCode, " | ", sSQLErr 
			call logInfo(ERROR_LOG_FILE_NAME,sTmp,TRUE,TRUE)
			Return // bail out!
		endif
		
		
		// #3 Update record with inputted invoice number
		
		Prompt "Modificando registro..."
		
		Format sSQLCmd as "UPDATE FCR_INVOICE_DATA ", \
						  		"SET FCRInvNumber = '", sNewInvNum, "' ", \
						  		"WHERE PCWSID = ", @WSID, " and ", \
						  		"FCRInvNumber = '", sInvoiceNumber, "' and ", \
						  		"MicrosChkNum = ", sChkNum, " and ", \
						  		"InvoiceType = ", iInvoiceType

		// Execute update

		call MDAD_execSQL( MDAD_DBCMD_QUERY, MDAD_DB_QRYTYPE_WRITE, sSQLCmd, "", \
								 MDAD_DB_RCRDSET_TYPE_LOCAL, iAffectedRecs, sQueryRetCode)
	
		If sQueryRetCode <> MDAD_RET_CODE_SUCCESS
			// An error has occurred
			iDBOK = FALSE
			call logInfo(ERROR_LOG_FILE_NAME,"Error while updating DB (modifyEmittedInvoiceNumber)",TRUE,TRUE)
			call logInfo(ERROR_LOG_FILE_NAME,sSQLCmd,TRUE,TRUE)
			call MDAD_getLastErrDesc(sSQLErr)
			format sTmp as sQueryRetCode, " | ", sSQLErr 
			call logInfo(ERROR_LOG_FILE_NAME,sTmp,TRUE,TRUE)
		EndIf
		
		// Now check if the update succedeed
		If iAffectedRecs > 0
			// invoice has been successfully voided!
			errorMessage "El nro. de comprobante fue modificado."
		Else
			// no update took place.
			errorMessage "El nro. comprobante no pudo ser modificado."
		EndIf
		
	Else
		
		// Error! Warn user
		ErrorMessage "Conexion a DB perdida! Por favor, intente mas tarde."
	EndIf

EndSub

//******************************************************************
// Procedure: ManageInvoiceNumbers()
// Author: Alex Vidal
// Purpose: Allows the user to add a new invoice range-base for the 
//			System or current PCWS, for a given invoice type.
//			(dependent on country)
// Parameters:
//	- iDBConnOK_ = If FALSE, no management could be done since a 
//				   connection to the DB could not be established
// 
//******************************************************************
Sub ManageInvoiceNumbers( ref iDBConnOK_ )
	
	var sPCWSID					: A10
	var iInvoiceType			: N1
	var iInvNumType			: N1
	var sSeries					: A30
	var iInvalidSeries		: N1
	var sStartInvoiceNum		: A30
	var iInvoiceNum			: N10
	var iEndInvoiceNum		: N10
	var sEndInvoiceNum		: A30
	var sTmpResDate			: A30
	var sResolutionDate		: A30
	var sResolutionDesc		: A30
	var iInfoOK					: N1 = FALSE
	var iDBOK					: N1
	var iAnswer					: N1
	var sSQLCmd					: A1000 = ""
	var sRecordData			: A1000 = ""
	var iRecordIdx				: N9
	var iAffectedRecs			: N9
	var sQueryRetCode			: A500 = ""
	var sSQLErr					: A500 = ""
	var sTmp						: A2000 = ""
	var iTmp						: N1
	

	// Connection to DB ok! (default)
	iDBConnOK_ = TRUE
	// Valid series (default)
	iInvalidSeries = FALSE
	// set PCWSID
	sPCWSID = @Wsid


	While Not iInfoOK	
	
		// Get DB default alphanumeric touchscreen
		ContinueOnCancel
		Touchscreen @ALPHASCREEN

		// Show Dialog
		Window 5,50, "Alta de rangos de comprobantes: "
			Display  1,  2, "Tipo de Factura :"
			Display  2,  2, "Serie           :"
			Display  3,  2, "Tipo Numeracion :"

			DisplayInput  1, 20, iInvoiceType, "1=B|2=F|3=G|4=C"
			DisplayInput  2, 20, sSeries{3},   "formato <A-ZZZ>"
			DisplayInput  3, 20, iInvNumType, "2=PCWS|3=Preimp."
		WindowEdit
		

		// set invoice type
		If @INPUTSTATUS = 0 or \
			(iInvoiceType <> INV_TYPE_BOLETA and \
			iInvoiceType <> INV_TYPE_FACTURA and \
			iInvoiceType <> INV_TYPE_GUIA and \
			iInvoiceType <> INV_TYPE_CREDITO)
		   
			iInvoiceType = 0
		EndIf
		
		if iInvoiceType <> 0
			If iInvNumType = PCWS_CONSECUTIVE
				// ---------------------------
				// PCWS Consecutive
				// ---------------------------
		
				// Show Dialog
				Window 10,50, "Alta de rangos de comprobantes: "
					Display  1,  2, "Serie           :"
					Display  2,  2, "Factura Inicial :"
					Display  3,  2, "Factura Final   :"
					DisplayInput  1, 20, sSeries{3},			"Formato <A-ZZZ>"
					DisplayInput  2, 20, sStartInvoiceNum{10},  "max. 10 digitos"
					DisplayInput  3, 20, sEndInvoiceNum{10},    "max. 10 digitos"
				WindowEdit
	
			elseif iInvNumType = PCWS_CONSEC_WITH_CONF
	
				// Add bogus data for this invoice type
				Format sStartInvoiceNum as "1"
				Format sEndInvoiceNum as "99999999"
	
			EndIf
		endif

		// Check required fields...
	
		If	@INPUTSTATUS <> 0 and \
			iInvoiceType <> 0 and \
			sSeries	<> "" and \
			len(sSeries) <= 3 and \
			sStartInvoiceNum <> "" and \
			sEndInvoiceNum <> ""

			// Check for series validity (alphabetic chars only)
			call isAlpha(sSeries, iTmp)
			iInvalidSeries = Not iTmp
	
			If Not iInvalidSeries
				// Ask user to confirm inputed data
				call promptYesOrNo(iAnswer, "Los datos consignados son correctos?")

				If iAnswer
					// turn on exit-loop flag
					iInfoOK = TRUE	
				EndIf
			Else
				// reset flag
				iInvalidSeries = FALSE
				// Input error! Warn user
				ErrorMessage "Se deben completar TODOS los campos con valores validos."
			EndIf
		Else

			// Input error! Warn user
			ErrorMessage "Se deben completar TODOS los campos con valores validos."			
		EndIf

	EndWhile
	WindowClose


	// check connection to DB
	call MDAD_checkConnection(iDBOK)

	If iDBOK

		Prompt "Creando serie..."

		If iInvNumType = PCWS_CONSECUTIVE
			
			// ---------------------------
			// PCWS Consecutive
			// ---------------------------

			// #1 Check if invoices have already been emitted with the 
			// inputed series (and range) by any PCWS. If so, don't 
			// allow the series to be inserted into the DB!

			// format query
			format sSQLCmd as "SELECT MicrosChkNum ", \
							  		"FROM FCR_INVOICE_DATA ", \
							  		"WHERE InvoiceType = ", iInvoiceType, " and "

			if gbliDBType = SQLSERVER
				format sSQLCmd as sSQLCmd, "SUBSTRING(FCRInvNumber,1,", len(sSeries), ") = '", sSeries, "' and (", \
											"CAST( case SUBSTRING(FCRInvNumber,",  len(sSeries) + 1, ",12) when '' ", \
											"then '-1' else SUBSTRING(FCRInvNumber,",  len(sSeries) + 1, ",12) end AS NUMERIC) "
			else
				format sSQLCmd as sSQLCmd, "SUBSTR(FCRInvNumber,1,", len(sSeries), ") = '", sSeries, "' and (", \
											"TO_NUMBER( SUBSTR(FCRInvNumber,",  len(sSeries) + 1, ")) "
			endif

			format sSQLCmd as sSQLCmd, "BETWEEN ", sStartInvoiceNum, " and ", sEndInvoiceNum, ")"

			call MDAD_execSQL( MDAD_DBCMD_QUERY, MDAD_DB_QRYTYPE_READ, sSQLCmd, "", \
									 MDAD_DB_RCRDSET_TYPE_LOCAL, iAffectedRecs, sQueryRetCode)

			If sQueryRetCode = MDAD_RET_CODE_SUCCESS
				If iAffectedRecs > 0
					// The query returned records! Invoices have
					// already been emited with the current
					// inputed series (and range) for this PCWS! 
					// Don't allow insertion!
					
					ErrorMessage "La serie ya ha sido utilizada!"
					Return  // bail out!
				EndIf
			Else

				// Error. Warn user!
				ErrorMessage "Error while updating record in DB!"
				call logInfo(ERROR_LOG_FILE_NAME,"Error while updating record in DB (invoice management 1)",TRUE,TRUE)
				call logInfo(ERROR_LOG_FILE_NAME,sSQLCmd,TRUE,TRUE)
				call MDAD_getLastErrDesc(sSQLErr)
				format sTmp as sQueryRetCode, " | ", sSQLErr 
				call logInfo(ERROR_LOG_FILE_NAME,sTmp,TRUE,TRUE)
				return  // bail out!
			EndIf


			// #2 Check if inputed invoice range-base already 
			// exists in the DB for other PCWS

			format sSQLCmd as "SELECT CtrlID, PCWSID FROM FCR_INVOICE_CONTROL ", \
							  		"WHERE PCWSID <> ", sPCWSID, " and ", \
									"InvoiceType = ", iInvoiceType, " and ", \
									"Series = '", sSeries, "' and ", \
									"Status = 1 and ( (", \
									sStartInvoiceNum, " BETWEEN StartInvNum and EndInvNum or ", \
									sEndInvoiceNum, " BETWEEN StartInvNum and EndInvNum ) or (", \
									sStartInvoiceNum, " < StartInvNum and ", \
									sEndInvoiceNum, " > EndInvNum) )"

			call MDAD_execSQL( MDAD_DBCMD_QUERY, MDAD_DB_QRYTYPE_READ, sSQLCmd, "", \
									 MDAD_DB_RCRDSET_TYPE_LOCAL, iAffectedRecs, sQueryRetCode)
	
			If sQueryRetCode = MDAD_RET_CODE_SUCCESS
				If iAffectedRecs > 0

					// The query returned records! Existing 
					// range-base series already exists for other PCWS
					// Don't allow the inputed series to be inserted 
					// into the DB!

					ErrorMessage "La serie ha sido dada de alta por otra terminal!"
					Return  // bail out!

				EndIf
			Else

				// Error. Warn user!
				ErrorMessage "Error while updating record in DB!"
				call logInfo(ERROR_LOG_FILE_NAME,"Error while updating record in DB (invoice management 2)",TRUE,TRUE)
				call logInfo(ERROR_LOG_FILE_NAME,sSQLCmd,TRUE,TRUE)
				call MDAD_getLastErrDesc(sSQLErr)
				format sTmp as sQueryRetCode, " | ", sSQLErr 
				call logInfo(ERROR_LOG_FILE_NAME,sTmp,TRUE,TRUE)
				return  // bail out!
			EndIf

		endif

		
		If iInvNumType = PCWS_CONSECUTIVE or iInvNumType = PCWS_CONSEC_WITH_CONF
		
			// #3 If we got to this point, the SQL query returned no 
			// matching records. Deactivate current series (if any)

			format sSQLCmd as "UPDATE FCR_INVOICE_CONTROL ", \
							  		"SET Status = 0 ", \
							  		"WHERE PCWSID = ", sPCWSID, " and ", \
									"InvoiceType = ", iInvoiceType
			
			call MDAD_execSQL( MDAD_DBCMD_QUERY, MDAD_DB_QRYTYPE_WRITE, sSQLCmd, "", \
									 MDAD_DB_RCRDSET_TYPE_LOCAL, iAffectedRecs, sQueryRetCode)
	
			If sQueryRetCode <> MDAD_RET_CODE_SUCCESS
				// Error. Warn user!
				ErrorMessage "Error while updating record in DB!"
				call logInfo(ERROR_LOG_FILE_NAME,"Error while updating record in DB (invoice management 3)",TRUE,TRUE)
				call logInfo(ERROR_LOG_FILE_NAME,sSQLCmd,TRUE,TRUE)
				call MDAD_getLastErrDesc(sSQLErr)
				format sTmp as sQueryRetCode, " | ", sSQLErr 
				call logInfo(ERROR_LOG_FILE_NAME,sTmp,TRUE,TRUE)
				return  // bail out!
			EndIf
			
		endif


		// cast invoice range numbers to integer...
		iInvoiceNum = sStartInvoiceNum
		iEndInvoiceNum = sEndInvoiceNum

		// #4 Insert the new series into the DB

		If (iInvNumType = PCWS_CONSECUTIVE or iInvNumType = PCWS_CONSEC_WITH_CONF)

			format sSQLCmd as "INSERT INTO FCR_INVOICE_CONTROL "

			if gbliDBType = SQLSERVER
				format sSQLCmd as sSQLCmd, "("
			else
				format sSQLCmd as sSQLCmd, "(CTRLID,"
			endif
			
			format sSQLCmd as sSQLCmd, "PCWSID, InvoiceType, Series, StartInvNum, ", \
									   "EndInvNum, Status, ExtraField1, ResolutionDate, ", \
									   "ExtraField2, CurrInvNum, LockedBy) ", \ 
									   "VALUES( "

			if gbliDBType = ORACLE
				format sSQLCmd as sSQLCmd, "SEQ_FCR_INVOICE_CONTROL.NEXTVAL,"
			endif
									   
			format sSQLCmd as sSQLCmd, sPCWSID, ", ", \
									   iInvoiceType, ", ", \
									   "'", sSeries, "', ", \
									   sStartInvoiceNum, ", ", \
									   sEndInvoiceNum, ", ", \
									   "1, ", \
									   "'", sResolutionDesc, "', "

			if gbliDBType = SQLSERVER
				format sSQLCmd as sSQLCmd, "'", sResolutionDate, "', "
			else
				format sSQLCmd as sSQLCmd, "TO_DATE('", sResolutionDate, "', 'YYYY/MM/DD HH:MI:SS'), "
			endif

			if gbliDBType = SQLSERVER
				format sSQLCmd as sSQLCmd, "CONVERT(varchar,GETDATE(),120), "
			else
				format sSQLCmd as sSQLCmd, "sysdate,"
			endif

			format sSQLCmd as sSQLCmd, (iInvoiceNum - 1){+}, ", ", \
									   "-1 )"

			call MDAD_execSQL( MDAD_DBCMD_QUERY, MDAD_DB_QRYTYPE_WRITE, sSQLCmd, "", \
									 MDAD_DB_RCRDSET_TYPE_LOCAL, iAffectedRecs, sQueryRetCode)
	
			If sQueryRetCode <> MDAD_RET_CODE_SUCCESS
				// Error. Warn user!
				ErrorMessage "Error while inserting record in DB!"
				call logInfo(ERROR_LOG_FILE_NAME,"Error while inserting record in DB (invoice management)",TRUE,TRUE)
				call logInfo(ERROR_LOG_FILE_NAME,sSQLCmd,TRUE,TRUE)
				call MDAD_getLastErrDesc(sSQLErr)
				format sTmp as sQueryRetCode, " | ", sSQLErr 
				call logInfo(ERROR_LOG_FILE_NAME,sTmp,TRUE,TRUE)
				return  // bail out!
			EndIf
		
		EndIf

		// #4 Write invoice data locally

		call WriteToInvoiceFile(sSeries, (iInvoiceNum - 1), iInvoiceType, iInvNumType)
		call WriteToInvoiceRangeFile(sSeries, iInvoiceNum, iEndInvoiceNum, iInvoiceType, iInvNumType)

	Else	

		// connection to DB is down!
		iDBConnOK_ = FALSE

		// Error! Warn user
		ErrorMessage "Conexion a DB perdida! Por favor, intente mas tarde."
	EndIf

EndSub

//******************************************************************
// Procedure: WriteToInvoiceFile()
// Author: Alex Vidal
// Purpose: Writes the passed invoice number to the local invoice
//			number sequence generator file.
// Parameters:
//	- sSeries_ = current invoice series
//  - iStartInvoiceNum_ = current starting invoice number
//	- iInvoiceType_ = current invoice type file to be created
//	- iInvNumType_ = System or PCWS consecutive invoice numbering
// 
//******************************************************************
Sub WriteToInvoiceFile( var sSeries_ : A3, var iStartInvoiceNum_ : N10, \
								var iInvoiceType_ : N1, var iInvNumType_ : N1)

	var sFileName	: A100
	var sTmp			: A20
	var sTmpInfo	: A100
	var sCSVal		: A40 // record Checksum value
	var fn			: N5  // file handle

	
	// Create files depending on invoice type

	If iInvoiceType_ = INV_TYPE_BOLETA
		
		format sFileName as PATH_TO_INVOICE_FILES, BOLETA_FILE_NAME
		
	ElseIf iInvoiceType_ = INV_TYPE_FACTURA
		
		format sFileName as PATH_TO_INVOICE_FILES, FACTURA_FILE_NAME
	
	ElseIf iInvoiceType_ = INV_TYPE_GUIA
		
		format sFileName as PATH_TO_INVOICE_FILES, GUIA_FILE_NAME

	ElseIf iInvoiceType_ = INV_TYPE_CREDITO
		
		format sFileName as PATH_TO_INVOICE_FILES, CREDITO_FILE_NAME
		
	EndIf

	// open handle to file...
	if @WSTYPE = SAROPS
		Fopen fn, sFileName, write, local
	else
		Fopen fn, sFileName, write
	endif

	If fn <> 0
		If iInvNumType_ = PCWS_CONSECUTIVE or iInvNumType_ = PCWS_CONSEC_WITH_CONF

			// Current invoice has PCWS consecutive
			// numbers. Invoice numbers for each
			// PCWS will be generated from the file we are
			// creating

			// workaround "fwrite" bug with numbers
			format sTmp as iStartInvoiceNum_

			// set record to be saved
			format sTmpInfo as sSeries_, sTmp

			// calculate checkSum value for record
			call calculateFileCheckSum(sTmpInfo, sCSVal)

			// write to file
			fwrite fn, sSeries_, sTmp, sCSVal

		EndIf

		// close handle to file
		Fclose fn

	Else
		// Error! Warn user
		ErrorMessage "Failed to create invoice file!"
		call logInfo(ERROR_LOG_FILE_NAME,"Failed to create invoice file",TRUE,TRUE)

	EndIf

EndSub

//******************************************************************
// Procedure: WriteToInvoiceRangeFile()
// Author: Al Vidal
// Purpose: Writes the passed invoice range to the local invoice
//			range file.
// Parameters:
//	- sSeries_ = current invoice series
// - iStartInvoiceNum_ = starting invoice range number
// - iEndInvoiceNum_ = ending invoice range number
//	- iInvoiceType_ = current invoice type file to be created
//	- iInvNumType_ = System or PCWS consecutive invoice numbering
// 
//******************************************************************
Sub WriteToInvoiceRangeFile( var sSeries_ : A3, var iStartInvoiceNum_ : N10, \
							 var iEndInvoiceNum_ : N10, var iInvoiceType_ : N1, \
							 var iInvNumType_ : N1)

	var sFileName	: A100
	var sTmp			: A20
	var sTmp2		: A20
	var sTmpInfo	: A100
	var sCSVal		: A40 // record Checksum value
	var fn			: N5  // file handle

	
	// Create files depending on invoice type

	If iInvoiceType_ = INV_TYPE_BOLETA
		
		format sFileName as PATH_TO_INVOICE_FILES, BOLETA_RANGE_FILE_NAME
		
	ElseIf iInvoiceType_ = INV_TYPE_FACTURA
		
		format sFileName as PATH_TO_INVOICE_FILES, FACTURA_RANGE_FILE_NAME
		
	ElseIf iInvoiceType_ = INV_TYPE_GUIA
		
		format sFileName as PATH_TO_INVOICE_FILES, GUIA_RANGE_FILE_NAME

	ElseIf iInvoiceType_ = INV_TYPE_CREDITO
		
		format sFileName as PATH_TO_INVOICE_FILES, CREDITO_RANGE_FILE_NAME

	EndIf

	// open handle to file...
	if @WSTYPE = SAROPS
		Fopen fn, sFileName, write, local
	else
		Fopen fn, sFileName, write
	endif

	If fn <> 0
		
		// workaround "fwrite" bug with numbers
		format sTmp as iStartInvoiceNum_
		format sTmp2 as iEndInvoiceNum_
		
		// set record to be saved
		format sTmpInfo as sSeries_, sTmp, sTmp2, iInvNumType_

		// calculate checkSum value for record
		call calculateFileCheckSum(sTmpInfo, sCSVal)

		// write range to file
		fwrite fn, sSeries_, sTmp, sTmp2, iInvNumType_, sCSVal

		// close handle to file
		Fclose fn

	Else
		// Error! Warn user
		ErrorMessage "Failed to create invoice range file!"
		call logInfo(ERROR_LOG_FILE_NAME,"Failed to create invoice range file",TRUE,TRUE)
	EndIf

EndSub

//******************************************************************
// Procedure: ReadFromInvoiceFile()
// Author: Alex Vidal
// Purpose: reads the required invoice type number from the local 
//			invoice number sequence generator file.
// Parameters:
//	- sSeries_ = returns the invoice series read from the file
// - iStartInvoiceNum_ = returns the starting invoice number
//						  		read from the file
//	- iInvoiceType_ = invoice type number to search for
// 
//******************************************************************
Sub ReadFromInvoiceFile( ref sSeries_, ref iStartInvoiceNum_, var iInvoiceType_ : N1)

	var sTmpInfo	: A100
	var iInfoCS		: N40
	var iInfoCSOK	: N1
	var sFileName	: A100
	var fn			: N5  // file handle

	
	// Read invoice number depending on invoice type

	If iInvoiceType_ = INV_TYPE_BOLETA
		
		format sFileName as PATH_TO_INVOICE_FILES, BOLETA_FILE_NAME
		
	ElseIf iInvoiceType_ = INV_TYPE_FACTURA
		
		format sFileName as PATH_TO_INVOICE_FILES, FACTURA_FILE_NAME
		
	ElseIf iInvoiceType_ = INV_TYPE_GUIA
		
		format sFileName as PATH_TO_INVOICE_FILES, GUIA_FILE_NAME

	ElseIf iInvoiceType_ = INV_TYPE_CREDITO
		
		format sFileName as PATH_TO_INVOICE_FILES, CREDITO_FILE_NAME
		
	EndIf


	// open handle to file...
	if @WSTYPE = SAROPS
		Fopen fn, sFileName, read, local
	else
		Fopen fn, sFileName, read
	endif

	If fn <> 0
		Fread fn, sSeries_, iStartInvoiceNum_, iInfoCS

		// set record info
		format sTmpInfo as sSeries_, iStartInvoiceNum_

		// Check for corruption
		call validateFileCheckSum(sTmpInfo,iInfoCS, iInfoCSOK)
		
		If Not iInfoCSOK
			If iInvoiceType_ = INV_TYPE_BOLETA
				ErrorMessage "El archivo ", BOLETA_FILE_NAME, " esta corrupto!"
				format sTmpInfo as BOLETA_FILE_NAME, " file is corrupt"
			ElseIf iInvoiceType_ = INV_TYPE_FACTURA
				ErrorMessage "El archivo ", FACTURA_FILE_NAME, " esta corrupto!"
				format sTmpInfo as FACTURA_FILE_NAME, " file is corrupt"
			ElseIf iInvoiceType_ = INV_TYPE_GUIA
				ErrorMessage "El archivo ", GUIA_FILE_NAME, " esta corrupto!"
				format sTmpInfo as GUIA_FILE_NAME, " file is corrupt"
			ElseIf iInvoiceType_ = INV_TYPE_CREDITO
				ErrorMessage "El archivo ", CREDITO_FILE_NAME, " esta corrupto!"
				format sTmpInfo as CREDITO_FILE_NAME, " file is corrupt"
			EndIf
			ErrorMessage "Contacte a su supervisor."
			call logInfo(ERROR_LOG_FILE_NAME,sTmpInfo,TRUE,TRUE)
			
			// return bogus values...
			format sSeries_ as "@@"
			iStartInvoiceNum_ = -1
		EndIf

		// close handle to file
		Fclose fn

	Else
		// Error! Warn user
		ErrorMessage "Failed to read invoice file!"
		call logInfo(ERROR_LOG_FILE_NAME,"Failed to read invoice file",TRUE,TRUE)
	EndIf

EndSub

//******************************************************************
// Procedure: ReadFromInvoiceRangeFile()
// Author: Al Vidal
// Purpose: reads the required invoice type number from the local 
//			invoice range file.
// Parameters:
//	- sSeries_ = returns the invoice series read from the file
// - sStartInvoiceNum_ = returns the starting invoice range 
//						  		number read from the file
// - sEndInvoiceNum_ = returns the ending invoice range 
//							number read from the file
//	- iInvNumType_ = Returns the invoice numbering type
//	- iInvoiceType_ = invoice type number to search for
// 
//******************************************************************
Sub ReadFromInvoiceRangeFile( ref sSeries_, ref iStartInvoiceNum_, \
							  			ref iEndInvoiceNum_, ref iInvNumType_, \
							  			var iInvoiceType_ : N1)

	var sTmpInfo	: A100
	var iInfoCS		: N40
	var iInfoCSOK	: N1
	var sFileName	: A100
	var fn			: N5  // file handle

	
	// Read invoice number depending on invoice type

	If iInvoiceType_ = INV_TYPE_BOLETA
		
		format sFileName as PATH_TO_INVOICE_FILES, BOLETA_RANGE_FILE_NAME
		
	ElseIf iInvoiceType_ = INV_TYPE_FACTURA
		
		format sFileName as PATH_TO_INVOICE_FILES, FACTURA_RANGE_FILE_NAME
		
	ElseIf iInvoiceType_ = INV_TYPE_GUIA
		
		format sFileName as PATH_TO_INVOICE_FILES, GUIA_RANGE_FILE_NAME

	ElseIf iInvoiceType_ = INV_TYPE_CREDITO
		
		format sFileName as PATH_TO_INVOICE_FILES, CREDITO_RANGE_FILE_NAME

	EndIf


	// open handle to file...
	if @WSTYPE = SAROPS
		Fopen fn, sFileName, read, local
	else
		Fopen fn, sFileName, read
	endif

	If fn <> 0
		Fread fn, sSeries_, iStartInvoiceNum_, iEndInvoiceNum_, iInvNumType_, iInfoCS

		// set record info
		format sTmpInfo as sSeries_, iStartInvoiceNum_, iEndInvoiceNum_, iInvNumType_

		// Check for corruption
		call validateFileCheckSum(sTmpInfo,iInfoCS, iInfoCSOK)
		
		If Not iInfoCSOK
			If iInvoiceType_ = INV_TYPE_BOLETA
				ErrorMessage "El archivo ", BOLETA_RANGE_FILE_NAME, " esta corrupto!"
				format sTmpInfo as BOLETA_RANGE_FILE_NAME, " file is corrupt"
			ElseIf iInvoiceType_ = INV_TYPE_FACTURA
				ErrorMessage "El archivo ", FACTURA_RANGE_FILE_NAME, " esta corrupto!"
				format sTmpInfo as FACTURA_RANGE_FILE_NAME, " file is corrupt"
			ElseIf iInvoiceType_ = INV_TYPE_GUIA
				ErrorMessage "El archivo ", GUIA_RANGE_FILE_NAME, " esta corrupto!"
				format sTmpInfo as GUIA_RANGE_FILE_NAME, " file is corrupt"
			ElseIf iInvoiceType_ = INV_TYPE_CREDITO
				ErrorMessage "El archivo ", CREDITO_RANGE_FILE_NAME, " esta corrupto!"
				format sTmpInfo as CREDITO_RANGE_FILE_NAME, " file is corrupt"
			EndIf
			ErrorMessage "Contacte a su supervisor."
			call logInfo(ERROR_LOG_FILE_NAME,sTmpInfo,TRUE,TRUE)
			
			// return bogus values...
			format sSeries_ as "@@"
			iStartInvoiceNum_ = -1
			iEndInvoiceNum_ = -1
		EndIf

		// close handle to file
		Fclose fn

	Else
		// Error! Warn user
		ErrorMessage "Failed to read invoice range file!"
		call logInfo(ERROR_LOG_FILE_NAME,"Failed to read invoice range file",TRUE,TRUE)
	EndIf

EndSub

//******************************************************************
// Procedure: generateInvoiceNumber()
// Author: Alex Vidal
// Purpose: returns the invoice number to be used for the Customer
//				Receipt to be printed for the current check
// Parameters:
//	- iAskForConfirmation_ = if TRUE, invoice types that require
//									 user confirmation will display the
//									 corresponding prompt
//	- retVal_ = Function's return value
//******************************************************************
Sub generateInvoiceNumber( var iAskForConfirmation_ : N1, ref retVal_ )

	var iDBOK				: N1
	var iInvNumType		: N1
	var sSQLCmd				: A1000 = ""
	var sSetData			: A1000 = ""
	var sRecordData		: A1000 = ""
	var iRecordIdx			: N9
	var iAffectedRecs		: N9
	var sQueryRetCode		: A500 = ""
	var sSQLErr				: A500 = ""
	var sTmp					: A2000 = ""
	var sInvoiceSeries	: A3
	var iInvoiceNum		: N10
	var iLockedBy			: N5
	var iGotXLock			: N1 = FALSE


	// get numbering type for the current invoice
	// (System, PCWS consecutive, PCWS Consecutive with confirmation)
	Call getInvNumType(gbliInvoiceType, iInvNumType)
		
	if iInvNumType = PCWS_CONSECUTIVE or iInvNumType = PCWS_CONSEC_WITH_CONF
		// ----------------------------------------------------------
		// Get next invoice number from the local file (PCWS 
		// consecutive or PCWS consecutive with confirmation)
		// ----------------------------------------------------------

		Prompt "Obteniendo nro. comprob..."
	
		call ReadFromInvoiceFile(sInvoiceSeries, iInvoiceNum, gbliInvoiceType)

		// update invoice number
		iInvoiceNum = iInvoiceNum + 1
		
		if iInvNumType = PCWS_CONSEC_WITH_CONF and iAskForConfirmation_
			// read invoice number needs to be confirmed by user
			Call confirmInvNum(sInvoiceSeries,iInvoiceNum, gbliInvoiceType)
		endif

		// update invoice number in invoice file
		Call WriteToInvoiceFile(sInvoiceSeries, iInvoiceNum, gbliInvoiceType,iInvNumType)
		
		// set origin of invoice number
		gblsInvoiceNumFromSAR = FALSE

	EndIf

	// return invoice number for current check
	format retVal_ as sInvoiceSeries, iInvoiceNum

EndSub

//******************************************************************
// Procedure: CallForInvoiceManagement()
// Author: Alex Vidal
// Purpose: If the signed-in user has enough privileges, it calls
//			for the Invoice range management routine, and checks
//			for valid invoice range. If otherwise, it tries to 
//			cancel the current transaction.
// Parameters:
//	- 
// 
//******************************************************************
Sub CallForInvoiceManagement()

	var iInvOK	: N1 = FALSE
	var iConnOK	: N1 = FALSE


	If @emplopt[INV_MANAGEMENT_SIM_PRIVILEGE] 

		// current user has privileges to manage invoice
		// ranges.

		While Not iInvOK
			// create a new range for current
			// invoice type
			call ManageInvoiceNumbers(iConnOK)

			If iConnOK
				// Check if new range has been created.
				// If not, keep on looping until it has.				
				call checkNextInvoiceNumber(iInvOK)

			Else
				iInvOK = TRUE  // Exit loop
			EndIf

		EndWhile

	Else
		// signed-in user doesn't have enough privileges.
		ErrorMessage "Contacte a su supervisor."
		
	EndIf
		
	// Cancel current transaction
	loadKybdmacro key(KEY_TYPE_FUNCTION, KEY_CODE_CANCEL_TRANS), @Key_Enter

EndSub

//******************************************************************
// Procedure: checkNextInvoiceNumber()
// Author: Alex Vidal
// Purpose: Returns TRUE if next invoice number is inside the 
//			range specified in the DB for all invoice types. FALSE 
//			if otherwise.
// Parameters:
//	- retVal_ = Function's return value
// 
//******************************************************************
Sub checkNextInvoiceNumber( ref retVal_ )

	var iInvNumType		: N1

	
	// get numbering type for all invoice types

	call getInvNumType(INV_TYPE_BOLETA, iInvNumType)
	call CheckForInvTypeSetup(INV_TYPE_BOLETA, iInvNumType, retVal_)
	If Not retVal_
		ErrorMessage "Su rango de boletas expiro!"
		Return
	EndIf

	call getInvNumType(INV_TYPE_FACTURA, iInvNumType)
	call CheckForInvTypeSetup(INV_TYPE_FACTURA, iInvNumType, retVal_)
	If Not retVal_
		ErrorMessage "Su rango de Facturas expiro!"
		Return
	EndIf
	
	call getInvNumType(INV_TYPE_GUIA, iInvNumType)
	call CheckForInvTypeSetup(INV_TYPE_GUIA, iInvNumType, retVal_)
	If Not retVal_
		ErrorMessage "Su rango de Guias expiro!"
		Return
	EndIf
	
	call getInvNumType(INV_TYPE_CREDITO, iInvNumType)
	call CheckForInvTypeSetup(INV_TYPE_CREDITO, iInvNumType, retVal_)
	If Not retVal_
		ErrorMessage "Su rango de Notas de Credito expiro!"
	EndIf
	
EndSub

//******************************************************************
// Procedure: CheckForInvTypeSetup()
// Author: Alex Vidal
// Purpose: Returns TRUE if passed invoice number is inside the 
//			range specified in the DB for the passed invoice &
//			numbering types
// Parameters:
//	- iInvType_ = Invoice type
//	- iInvNumType_ = Invoice numbering type
//	- retVal_ = Function's return value
// 
//******************************************************************
Sub CheckForInvTypeSetup( var iInvType_ :N1, var iInvNumType_ :N1, \
						  		  ref retVal_ )

	var sInvoiceSeries		: A3
	var iInvoiceNum			: N11
	var iStartInvoiceNum		: N10
	var iEndInvoiceNum		: N10
	var iInvNumType			: N1
	var sFileName				: A100
	var fn						: N5

		
	If iInvNumType_ = PCWS_CONSECUTIVE
		
		// -------------------------------------------------------
		// Current invoice has a consecutive, per PCWS invoice
		// number. Check for a valid range
		// -------------------------------------------------------
			
		// #1 Get next invoice number from local invoice number 
		//    sequence generator file

		call ReadFromInvoiceFile(sInvoiceSeries, iInvoiceNum, iInvType_)

		// get next invoice number
		iInvoiceNum = iInvoiceNum + 1

		// 2# Check if current invoice number is inside the specified
		//    range for the current PCWS.
		
		call ReadFromInvoiceRangeFile(sInvoiceSeries, iStartInvoiceNum, iEndInvoiceNum, \
								      iInvNumType, iInvType_)

		If iInvoiceNum >= iStartInvoiceNum and \
		   iInvoiceNum <= iEndInvoiceNum
			
			// invoice is valid!
			retVal_ = TRUE
		Else

			// current invoice range has expired!
			retVal_ = FALSE
		EndIf
		
	ElseIf iInvNumType_ = PCWS_CONSEC_WITH_CONF
		
		// No validation is necessary for this invoice 
		// numbering type
		retVal_ = TRUE
	
	Else

		// No invoice numbering type specified. 
		// return error.
		retVal_ = FALSE
	EndIf

EndSub

//******************************************************************
// Procedure: logInfo()
// Author: Alex Vidal
// Purpose: Logs information passed as a parameter to a specified
//			log file
// Parameters:
//	- sFileName_ = Log file name
//	- sInfo_ = Information to log
//	- iAppend_ = If TRUE, it will append the "sInfo_" to the
//				 specified "sFileName_". If FALSE, it will
//				 overwrite existing data
//	- iAddTimeStamp_ = If TRUE, adds a timestamp for the logged
//					  record.
//  
//******************************************************************
Sub logInfo(var sFileName_ : A100, var sInfo_ : A3000, var iAppend_ : N1, \
				var iAddTimeStamp_ : N1)

	var fn			: N5  // file handle
	var sTmpInfo	: A3100

	
	If iAppend_
		// append info to log file
		if @WSTYPE = SAROPS
			Fopen fn, sFileName_, append, local
		else
			Fopen fn, sFileName_, append
		endif
	Else
		// overwrite existing info
		if @WSTYPE = SAROPS
			Fopen fn, sFileName_, write, local
		else
			Fopen fn, sFileName_, write
		endif
	EndIf

	If fn <> 0
		
		If iAddTimeStamp_
			// add a time stamp to the record
			format sTmpInfo as @MONTH{02}, "/", @DAY{02}, "/", (@YEAR + 1900){04}, \
							   " - ", @HOUR{02}, ":", @MINUTE{02}, ":", @SECOND{02}, \
								" | FIP: ", FIP_VERSION, " | WSID: ", @WSID, " | Emp: ", \
							   @CKEMP, " | Chk: ", @CKNUM, " -> ", sInfo_

		Else
			// only log passed info
			format sTmpInfo as "WSID: ", @WSID, " -> ", sInfo_

		EndIf

		// write info to log file
		FWrite fn, sTmpInfo

		// close handle to file
		Fclose fn
	Else
		// error! Warn user
		errorMessage "Could not log information in ", sFileName_

	EndIf

EndSub

//******************************************************************
// Procedure: getDoubleQuotesInfo()
// Author: Al Vidal
// Purpose: returns information regarding trailing and ending 
//			double quotes present in the passed information string
// Parameters:
//	- sInfoString_  = string to get quotes info from
//	- sTrailQuotes_ = Number of trailing quotes found in string
//	- sTotalQuotes_	= Total Number of trailing and ending quotes
//					  found in string
//  
//******************************************************************
Sub getDoubleQuotesInfo( var sInfoString_ : A1000, ref sTrailQuotes_, ref sTotalQuotes_ )

	var iNumOfTrailQ 	: N4 = 0
	var iNumOfQuotes 	: N4 = 0
	var sTmpInfo	 	: A1000
	var i			 		: N5


	// check for trailing double quotes (1 char at
	// a time)
	For i = 1 to len(sInfoString_)
		format sTmpInfo as mid(sInfoString_,i,1)

		If sTmpInfo = Chr(CHAR_DOUBLE_QUOTE)
			iNumOfTrailQ = iNumOfTrailQ + 1
		Else
			break
		EndIf

	EndFor

	// add to quote totalizer
	iNumOfQuotes = iNumOfTrailQ

	// check for ending double quotes (1 char at
	// a time)
	For i = len(sInfoString_) to 1 Step -1
		format sTmpInfo as mid(sInfoString_,i,1)
		
		If sTmpInfo = Chr(CHAR_DOUBLE_QUOTE)
			iNumOfQuotes = iNumOfQuotes + 1
		Else
			break
		EndIf

	EndFor


	// return quotes info...

	sTrailQuotes_ = iNumOfTrailQ
	sTotalQuotes_ = iNumOfQuotes

EndSub

//******************************************************************
// Procedure: validateInvoiceNumber()
// Author: Al Vidal
// Purpose: Check if next invoice number to be used is valid for 
//			all invoice types used by the current country
// Parameters:
//	- 
//  
//******************************************************************
Sub validateInvoiceNumber()
	
	var iInvOK : N1

	if @WSTYPE = SAROPS and gbliUseEDI = TRUE
			return
	endif
	
	call checkNextInvoiceNumber(iInvOK)
	
	If Not iInvOK
		call CallForInvoiceManagement()
	EndIf

EndSub

//******************************************************************
// Procedure: InitializeEDI()
// Author: C Sepulveda
// Purpose: Initialize EDI DLL Internal Variables
// Parameters:
//	- 
//  
//******************************************************************
Sub InitializeEDI()
	
	var iInvOK : N1

	if @WSTYPE = SAROPS
		if gblhEDI <> 0
			DLLCall gblhEDI, fnInitialize()
		else
			errormessage "gblhEDI error on initialize"	
		endif 
	endif

EndSub

//******************************************************************
// Procedure: getSeries_Number()
// Author: Al Vidal
// Purpose: Returns the "series" and "numeric" portion of an 
//			invoice number separately
// Parameters:
//	- sInvNum_ = Invoice number to get series from
//	- sSeries_ = returned series portion
//	- sNumber_ = returned numeric portion
//  
//******************************************************************
Sub getSeries_Number( var sInvNum_ : A12, ref sSeries_, ref sNumber_ )

	var iCnt		: N9 = 1


	// all we have to do is return the heading portion
	// of the "Invoice" string that has no numeric chars

	While ( Asc( mid(sInvNum_,iCnt,1) ) < 48 or \
			Asc( mid(sInvNum_,iCnt,1) ) > 57 )
		
		iCnt = iCnt + 1

	EndWhile

	iCnt = iCnt - 1

	sSeries_ = mid(sInvNum_,1,iCnt)
	sNumber_ = mid(sInvNum_,iCnt + 1, ( len(sInvNum_) - len(sSeries_) ) )		
	
EndSub

//******************************************************************
// Procedure: calculateFileCheckSum()
// Author: Alex Vidal
// Purpose: calculates a "custom" checksum value for a given string
// Parameters:
//	- sStringVal_ = string to calculate checksum from
//	- sCheckSum_ = returned checksum value
//  
//******************************************************************
Sub calculateFileCheckSum( var sStringVal_ : A1000, ref sCheckSum_ )

	var i					: N5  // for looping
	var iRawCheckSum		: N30
	var iTreatedCheckSum	: N40


	// get ascii value for current char and
	// add it to the CS accumulator

	For i = 1 to len(sStringVal_)	
		iRawCheckSum = iRawCheckSum + Asc( mid(sStringVal_,i,1) )
	EndFor

	// Treat current Checksum value with "custom" algorithm
	iTreatedCheckSum = iRawCheckSum * 6  + 1024  // keep it simple...

	// return "custom" checksum value
	sCheckSum_ = iTreatedCheckSum

EndSub

//******************************************************************
// Procedure: validateFileCheckSum()
// Author: Alex Vidal
// Purpose: checks if a "custom" checksum value for a given
//			string is valid
// Parameters:
//	- sStringVal_ = string to validate checksum from
//  - iCurrCS_  = string's Checksum to be validated
//	- retVal_ = Function's return value (TRUE = CS OK | 
//				   FALSE = CS Not OK!)
//  
//******************************************************************
Sub validateFileCheckSum( var sStringVal_ : A1000, var iCurrCS_ : N40, \
						  ref retVal_ )

	var iTreatedCheckSum	: N40


	// get Checksum for string
	call calculateFileCheckSum(sStringVal_, iTreatedCheckSum)

	// Now compare passed CS with calculated CS and
	// set function's return value
	retVal_	= ( iCurrCS_ = iTreatedCheckSum )

EndSub

//******************************************************************
// Procedure: clearFiscalGblVars()
// Author: Al Vidal
// Purpose: Resets all "fiscal" global variables
// Parameters:
//	-
//
//******************************************************************
Sub clearFiscalGblVars()

	Format gblsIDNumber as ""
	Format gblsName as ""
	Format gblsAddress1 as ""
	Format gblsAddress2 as ""
	Format gblsTel as ""
	Format gblsExtra1 as ""
	Format gblsCreditInfo as ""
	gblcAccumSubtotal = 0

EndSub

//******************************************************************
// Procedure: setWorkstationType()
// Author: Al Vidal
// Purpose: sets the SAROPS workstation type (Win32 | WinCE)
// Parameters:
//	-
//
//******************************************************************
Sub setWorkstationType()
	
	If gbliWSType = 0

		If @OS_PLATFORM = WIN32_PLATFORM
			// This is a PCWS
			gbliWSType = PCWS_TYPE
		Else
			// This is a WS4
			gbliWSType = WS4_TYPE
		EndIf
	EndIf
	
EndSub

//******************************************************************
// Procedure: setFilePaths()
// Author: Alex Vidal
// Purpose: Sets file paths used by this script, depending on the
//			type of WS (Win32 | WS4) running it
// Parameters:
//	-
//
//******************************************************************
Sub setFilePaths()
		
	

	if @WSTYPE = SAROPS

		// -------------------------------------------------
		// Set paths for SAROPS clients
		// -------------------------------------------------

		// general paths		
		format BOLETA_FILE_NAME as "BLT"
		format FACTURA_FILE_NAME as "FCT"
		format GUIA_FILE_NAME as "GIA"
		format CREDITO_FILE_NAME as "CDT"
		format BOLETA_RANGE_FILE_NAME as "R_BLT"
		format FACTURA_RANGE_FILE_NAME as "R_FCT"
		format GUIA_RANGE_FILE_NAME as "R_GIA"
		format CREDITO_RANGE_FILE_NAME as "R_CDT"
	
	
		If gbliWSType = WS4_TYPE
			// This is a WS4 client
			
			format ERROR_LOG_FILE_NAME as "\CF\PosClient\log\FiscalCHL.txt"
			format MDAD_LOG_FILE_NAME as "\CF\PosClient\log\MDAD_SIM.txt"
		
			format PATH_TO_INVOICE_FILES as "\CF\PosClient\Cfg\"
			format SAVED_CUST_RECEIPTS_FILE_NAME as "\CF\PosClient\Cfg\SCR"
			format PATH_TO_BOLETA_PRINT_DOC as "\CF\PosClient\Cfg\BLT_PRNT"
			format PATH_TO_FACTURA_PRINT_DOC as "\CF\PosClient\Cfg\FCT_PRNT"
			format PATH_TO_GUIA_PRINT_DOC as "\CF\PosClient\Cfg\GIA_PRNT"
			format PATH_TO_CREDITO_PRINT_DOC as "\CF\PosClient\Cfg\CDT_PRNT"
			format PATH_TO_BOLETA_PRINT_TMP as "\CF\PosClient\Prnt\BLT.ptd"
			format PATH_TO_FACTURA_PRINT_TMP as "\CF\PosClient\Prnt\FCT.ptd"
			format PATH_TO_GUIA_PRINT_TMP as "\CF\PosClient\Prnt\GIA.ptd"
			format PATH_TO_CREDITO_PRINT_TMP as "\CF\PosClient\Prnt\CDT.ptd"
			
			format CONFIGURATION_FILE_NAME as "\CF\PosClient\cfg\FiscalCHL.cfg"
			Format CHK_NUM_FILE_NAME as "\CF\PosClient\cfg\CKNUM"
			
			format PATH_TO_PTP_DRIVER as "\CF\PosClient\bin\PTPWCE.dll"
			Format PATH_TO_FCR_DRIVER as "\CF\PosClient\bin\FCRDriver.dll"
			Format PATH_TO_EDI_DRIVER as "\CF\PosClient\bin\SigSocket.dll"
			Format PATH_TO_ESCPOS_DRIVER as "\CF\PosClient\bin\ESCPMicrosDllCE.dll"
			
		Else
			// This is a Win32 client
	
			format ERROR_LOG_FILE_NAME as "../log/FiscalCHL.log"
			format MDAD_LOG_FILE_NAME as "../log/MDAD_SIM.log"
		
			format PATH_TO_INVOICE_FILES as "../Cfg/"
			format SAVED_CUST_RECEIPTS_FILE_NAME as "../Cfg/SCR"
			format PATH_TO_BOLETA_PRINT_DOC as "../Cfg/BLT_PRNT"
			format PATH_TO_FACTURA_PRINT_DOC as "../Cfg/FCT_PRNT"
			format PATH_TO_GUIA_PRINT_DOC as "../Cfg/GIA_PRNT"
			format PATH_TO_CREDITO_PRINT_DOC as "../Cfg/CDT_PRNT"
			format PATH_TO_BOLETA_PRINT_TMP as "../Prnt/BLT.ptd"
			format PATH_TO_FACTURA_PRINT_TMP as "../Prnt/FCT.ptd"
			format PATH_TO_GUIA_PRINT_TMP as "../Prnt/GIA.ptd"
			format PATH_TO_CREDITO_PRINT_TMP as "../Prnt/CDT.ptd"
			
			format CONFIGURATION_FILE_NAME as "../Cfg/FiscalCHL.cfg"
			Format CHK_NUM_FILE_NAME as "../cfg/CKNUM"
			
			format PATH_TO_PTP_DRIVER as "../bin/PTPW32.dll"
			format PATH_TO_RPROC_DRIVER as "../bin/RUNPROC.dll"
			Format PATH_TO_FCR_DRIVER as "../bin/Fcrdll.dll"
			Format PATH_TO_EDI_DRIVER as "../bin/SigW32.dll"
			Format PATH_TO_ESCPOS_DRIVER as "../bin/ESCPMicrosDllW32.dll"
		
		endif
	
	else
		
		// -------------------------------------------------
		// Set paths for Winstation clients
		// -------------------------------------------------
		
		// general paths		
		format BOLETA_FILE_NAME as "BLT", @WSID
		format FACTURA_FILE_NAME as "FCT", @WSID
		format GUIA_FILE_NAME as "GIA", @WSID
		format CREDITO_FILE_NAME as "CDT", @WSID
		format BOLETA_RANGE_FILE_NAME as "R_BLT", @WSID
		format FACTURA_RANGE_FILE_NAME as "R_FCT", @WSID
		format GUIA_RANGE_FILE_NAME as "R_GIA", @WSID
		format CREDITO_RANGE_FILE_NAME as "R_CDT", @WSID
	
		format ERROR_LOG_FILE_NAME as "../log/FiscalCHL", @WSID, ".log"
		format MDAD_LOG_FILE_NAME as "../log/MDAD_SIM", @WSID, ".log"
		
		Format PATH_TO_INVOICE_FILES as "../Cfg/"
		Format SAVED_CUST_RECEIPTS_FILE_NAME as "../Cfg/SCR", @WSID
		Format PATH_TO_BOLETA_PRINT_DOC as "../Cfg/BLT_PRNT", @WSID
		Format PATH_TO_FACTURA_PRINT_DOC as "../Cfg/FCT_PRNT", @WSID
		Format PATH_TO_GUIA_PRINT_DOC as "../Cfg/GIA_PRNT", @WSID
		Format PATH_TO_CREDITO_PRINT_DOC as "../Cfg/CDT_PRNT", @WSID
		Format PATH_TO_BOLETA_PRINT_TMP as "../Prnt/BLT", @WSID, ".ptd"
		Format PATH_TO_FACTURA_PRINT_TMP as "../Prnt/FCT", @WSID, ".ptd"
		Format PATH_TO_GUIA_PRINT_TMP as "../Prnt/GIA", @WSID, ".ptd"
		Format PATH_TO_CREDITO_PRINT_TMP as "../Prnt/CDT", @WSID, ".ptd"
			
		Format CONFIGURATION_FILE_NAME as "../Cfg/FiscalCHL.cfg"
		Format CONFIGURATION_FILE_NAME_PWS as "../Cfg/FiscalCHL", @WSID, ".cfg"
		Format CHK_NUM_FILE_NAME as "../Cfg/CKNUM", @WSID
		
	endif
	
EndSub

//******************************************************************
// Procedure: getInvNumType()
// Author: Alex Vidal
// Purpose: Returns the numbering type (Per syster, PCWS
//				consecutive or PCWS Consecutive with confirmation) for 
//				a specified invoice type
// Parameters:
//	- iInvType_ = Invoice type (Factura, Boleta, etc.)
//	- retVal_ = function's return value
//
//******************************************************************
Sub getInvNumType( var iInvType_ : N1, ref retVal_ )

	var sTmp		: A20
	var iTmp		: N10
	var iTmp2	: N10
	var iTmp3	: N1

	
	call ReadFromInvoiceRangeFile( sTmp, iTmp, iTmp2, iTmp3, iInvType_)
	retVal_ = iTmp3
	
EndSub

//******************************************************************
// Procedure: getPTPErrorInfo()
// Author: Alex Vidal
// Purpose: returns PTP.dll detailed error info
// Parameters:
//	- iErrCode_ = PTP.dll error code for last error
//	- sErrDesc_ = PTP.dll error description for last error
//
//******************************************************************
Sub getPTPErrorInfo( ref iErrCode_, ref sErrDesc_ )

	format sErrDesc_ as ""

	if @WSTYPE = SAROPS
		if gblhPTP <> 0
			DLLCall gblhPTP, PTP_getErrorData(ref iErrCode_, ref sErrDesc_)
		endif
	else
		Call PTP_getErrorData(iErrCode_, sErrDesc_)
	endif

EndSub

//******************************************************************
// Procedure: logPTPError()
// Author: Alex Vidal
// Purpose: Logs PTP.dll detailed error info
// Parameters:
//	- 
//
//******************************************************************
Sub logPTPError()

	var iErrCode	: N9
	var sErrDesc	: A(PTP_MAX_EXCPT_LEN)
	var sTmp			: A(PTP_MAX_EXCPT_LEN + 100)


	call getPTPErrorInfo(iErrCode,sErrDesc)
	format sTmp as "Error in PTP driver: ", iErrCode, " -> ", sErrDesc
	call logInfo(ERROR_LOG_FILE_NAME,sTmp,TRUE,TRUE)

EndSub

//******************************************************************
// Procedure: setKeyValOnPTPStr()
// Author: Alex Vidal
// Purpose: Adds a specific Key/Value pair to current PTP string
// Parameters:
//	- sPTPStr_ = Current PTP string
//	- sKey_ = Key to add to PTP string
//	- sValue_ = Value to add to PTP string
//
//******************************************************************
Sub setKeyValOnPTPStr( ref sPTPStr_, ref sKey_, var sValue_ : A500)

	var sTmp	: A(PTP_MAX_REC_LEN)
	
	if @WSTYPE = SAROPS
		Format sTmp as sKey_, PTP_KEY_VALUE_SEPARATOR, sValue_, PTP_FIELDS_SEPARATOR
		Format sPTPStr_ as sPTPStr_, sTmp
	else
		Format sTmp as sKey_, PTP_KEY_VALUE_SEPARATOR, sValue_
		Call PTP_setFIDValue(sTmp)
		Format sPTPStr_ as ""
	endif

EndSub

//******************************************************************
// Procedure: setFIPHeaderOnPTPStr()
// Author: Alex Vidal
// Purpose: Adds FIP header data to current PTP string
// Parameters:
//	- sPTPStr_ = Current PTP string
//
//******************************************************************
Sub setFIPHeaderOnPTPStr( ref sPTPStr_ )

	var i		: N9
	var sTmp	: A(PTP_MAX_REC_LEN)

	
	for i = 1 to gbliMaxHIL 

		format sTmp as gblsHeaderInfoLines[i]{=32}

		// add key
		if i = 1
			call setKeyValOnPTPStr(sPTPStr_, PTP_HEADER_LINE_1,sTmp)
		elseif i = 2
			call setKeyValOnPTPStr(sPTPStr_, PTP_HEADER_LINE_2,sTmp)
		elseif i = 3
			call setKeyValOnPTPStr(sPTPStr_, PTP_HEADER_LINE_3,sTmp)
		elseif i = 4
			call setKeyValOnPTPStr(sPTPStr_, PTP_HEADER_LINE_4,sTmp)
		elseif i = 5
			call setKeyValOnPTPStr(sPTPStr_, PTP_HEADER_LINE_5,sTmp)
		elseif i = 6
			call setKeyValOnPTPStr(sPTPStr_, PTP_HEADER_LINE_6,sTmp)
		elseif i = 7
			call setKeyValOnPTPStr(sPTPStr_, PTP_HEADER_LINE_7,sTmp)
		elseif i = 8
			call setKeyValOnPTPStr(sPTPStr_, PTP_HEADER_LINE_8,sTmp)
		elseif i = 9
			call setKeyValOnPTPStr(sPTPStr_, PTP_HEADER_LINE_9,sTmp)
		elseif i = 10
			call setKeyValOnPTPStr(sPTPStr_, PTP_HEADER_LINE_10,sTmp)
		endif

	endfor

EndSub

//******************************************************************
// Procedure: setFIPMIOnPTPStr()
// Author: Alex Vidal
// Purpose: Adds FIP Menu item data to current PTP string
// Parameters:
//	- sPTPStr_ = Current PTP string
// - MI_Count_ = Total number of grouped Menu Items
//	- MI_Qty_[] = Array containing grouped Menu Item quantities
// - MI_Name_[] = Array containing grouped Menu Item names
// - MI_UnitPrc_[] = Array containing grouped Menu Item Unit prices
//	- MI_Tax_[] = Array containing grouped Menu Item taxes
// - MI_Ttl_[] = Array containing grouped Menu Item totals
//
//******************************************************************
Sub setFIPMIOnPTPStr( ref sPTPStr_, ref MI_Count_, ref MI_Qty_[], ref MI_Name_[], \
					  		 ref MI_UnitPrc_[], ref MI_Tax_[], ref MI_Ttl_[] )

	var sTmp			: A(PTP_MAX_REC_LEN)
	var sTmpFormat	: A100


	// Cycle through MI info and add it accordingly
	For i = 1 to MI_Count_

		if @WSTYPE = SAROPS
			// check on string length
			if len(sTmp) > (PTP_MAX_REC_LEN / 2)
				Call PTP_setDetail(sTmp,iDllRet)
				if iDllRet <> PTP_RET_CODE_SUCCESS
					ErrorMessage "Error en PTP.dll al enviar informacion"
					call logInfo(ERROR_LOG_FILE_NAME,"PTP error: while sending Detail data (MIs)",TRUE,TRUE)
					call logPTPError()	
					ExitCancel // bail-out!
				endif
				format sTmp as ""
			endif
		endif
		
		If MI_UnitPrc_[i] <> 0.00
			format sTmpFormat as Abs(MI_Qty_[i]){>3}
		Else
			format sTmpFormat as ""{>3}
		EndIf
		call setKeyValOnPTPStr(sTmp, PTP_ITEM_QTY_,sTmpFormat)

		if gbliPrintUnitPrice
			format sTmpFormat as mid(MI_Name_[i],1,8){<8}
			call setKeyValOnPTPStr(sTmp, PTP_ITEM_NAME_,sTmpFormat)

			If MI_UnitPrc_[i] <> 0.00
			
				Format sTmpFormat as "(", abs(MI_UnitPrc_[i]){>+6}, ")"
			Else
				
				format sTmpFormat as "(cmprt.)"
			EndIf
			call setKeyValOnPTPStr(sTmp, PTP_ITEM_UNIT_PRICE_,sTmpFormat)

		else
			format sTmpFormat as mid(MI_Name_[i],1,12){<12}
			call setKeyValOnPTPStr(sTmp, PTP_ITEM_NAME_,sTmpFormat)
			call setKeyValOnPTPStr(sTmp, PTP_ITEM_UNIT_PRICE_,"")

		endif

		If MI_Tax_[i] = 0.00
			call setKeyValOnPTPStr(sTmp, PTP_ITEM_EXTRA_DESC_1_,"E")
		else
			call setKeyValOnPTPStr(sTmp, PTP_ITEM_EXTRA_DESC_1_," ")
		endif

		if gbliInvoiceType = INV_TYPE_BOLETA
			
			// Item total should include tax

			if gbliTaxIsInclusive
				if gbliPrintUnitPrice
					Format sTmpFormat as MI_Ttl_[i]{>+8}
				else
					Format sTmpFormat as MI_Ttl_[i]{>+12}
				endif
			else
				// taxes are ADD-ON, Add IVA Tax class to item total
				if gbliPrintUnitPrice
					format sTmpFormat as (MI_Ttl_[i] + MI_Tax_[i]){>+8}
				else
					format sTmpFormat as (MI_Ttl_[i] + MI_Tax_[i]){>+12}
				endif
			endif

		elseif gbliInvoiceType = INV_TYPE_FACTURA or gbliInvoiceType = INV_TYPE_GUIA or \
						gbliInvoiceType = INV_TYPE_CREDITO

			// Item total should be a net total (no tax included)

			if gbliTaxIsInclusive
				if gbliInvoiceType = INV_TYPE_CREDITO
					if gbliPrintUnitPrice
						Format sTmpFormat as Abs(MI_Ttl_[i] - MI_Tax_[i]){>+8}
					else
						Format sTmpFormat as Abs(MI_Ttl_[i] - MI_Tax_[i]){>+12}
					endif
				else
					if gbliPrintUnitPrice
						Format sTmpFormat as (MI_Ttl_[i] - MI_Tax_[i]){>+8}
					else
						Format sTmpFormat as (MI_Ttl_[i] - MI_Tax_[i]){>+12}
					endif
				endif
			else
				// taxes are ADD-ON, Item total does not include Tax
				if gbliInvoiceType = INV_TYPE_CREDITO
					if gbliPrintUnitPrice
						Format sTmpFormat as Abs(MI_Ttl_[i]){>+8}
					else
						Format sTmpFormat as Abs(MI_Ttl_[i]){>+12}
					endif
				else
					if gbliPrintUnitPrice
						Format sTmpFormat as MI_Ttl_[i]{>+8}
					else
						format sTmpFormat as MI_Ttl_[i]{>+12}
					endif
				endif
			endif
			
		endif
		call setKeyValOnPTPStr(sTmp, PTP_ITEM_PRICE_,sTmpFormat)
	
	EndFor

	if @WSTYPE = SAROPS
		Format sPTPStr_ as sPTPStr_, sTmp
	endif

EndSub

//******************************************************************
// Procedure: setFIPSVOnPTPStr()
// Author: Alex Vidal
// Purpose: Adds FIP Services data to current PTP string
// Parameters:
//	 - sPTPStr_ = Current PTP string
//  - SV_Count_ = Total number of grouped services
//  - SV_Name_[] = Array containing grouped service names
//  - SV_Ttl_[] = Array containing grouped service totals
//  - SV_Tax_[] = Array containing grouped service tax totals
//******************************************************************
Sub setFIPSVOnPTPStr(ref sPTPStr_, ref SV_Count_, ref SV_Name_[], ref SV_Ttl_[], ref SV_Tax_[])

	var sTmp			: A(PTP_MAX_REC_LEN)
	var sTmpFormat	: A100


	For i = 1 to SV_Count_

		if @WSTYPE = SAROPS
			// check on string length
			if len(sTmp) > (PTP_MAX_REC_LEN / 2)
				Call PTP_setDetail(sTmp,iDllRet)
				if iDllRet <> PTP_RET_CODE_SUCCESS
					ErrorMessage "Error en PTP.dll al enviar informacion"
					call logInfo(ERROR_LOG_FILE_NAME,"PTP error: while sending Detail data (SVs)",TRUE,TRUE)
					call logPTPError()	
					ExitCancel // bail-out!
				endif
				format sTmp as ""
			endif
		endif

		format sTmpFormat as SV_Name_[i]{<12}
		call setKeyValOnPTPStr(sTmp, PTP_SVC_NAME_,sTmpFormat)
		if gbliInvoiceType <> INV_TYPE_BOLETA
			format sTmpFormat as (Abs(SV_Ttl_[i]) - Abs(SV_Tax_[i])){>+12}
		else
			format sTmpFormat as Abs(SV_Ttl_[i]){>+12}{>+12}
		endif
		call setKeyValOnPTPStr(sTmp, PTP_SVC_PRICE_,sTmpFormat)
		
	EndFor

	if @WSTYPE = SAROPS
		Format sPTPStr_ as sPTPStr_, sTmp
	endif

EndSub

//******************************************************************
// Procedure: setFIPDSOnPTPStr()
// Author: Alex Vidal
// Purpose: Adds FIP Discounts data to current PTP string
// Parameters:
//	 - sPTPStr_ = Current PTP string
//  - DS_Count_ = Total number of grouped discounts
//  - DS_Name_[] = Array containing grouped discount names
//  - DS_Ttl_[] = Array containing grouped discount totals
//  - DS_Tax_[] = Array containing grouped service tax totals//
//******************************************************************
Sub setFIPDSOnPTPStr(ref sPTPStr_, ref DS_Count_, ref DS_Name_[], ref DS_Ttl_[], ref DS_Tax_[])

	var sTmp			: A(PTP_MAX_REC_LEN)
	var sTmpFormat	: A100

	
	For i = 1 to DS_Count_
		
		if @WSTYPE = SAROPS
			// check on string length
			if len(sTmp) > (PTP_MAX_REC_LEN / 2)
				Call PTP_setDetail(sTmp,iDllRet)
				if iDllRet <> PTP_RET_CODE_SUCCESS
					ErrorMessage "Error en PTP.dll al enviar informacion"
					call logInfo(ERROR_LOG_FILE_NAME,"PTP error: while sending Detail data (DSs)",TRUE,TRUE)
					call logPTPError()	
					ExitCancel // bail-out!
				endif
				format sTmp as ""
			endif
		endif

		format sTmpFormat as DS_Name_[i]{<12}
		call setKeyValOnPTPStr(sTmp, PTP_DISC_NAME_,sTmpFormat)
		if gbliInvoiceType <> INV_TYPE_BOLETA
			format sTmpFormat as (DS_Ttl_[i] - DS_Tax_[i]){>+12}
		else
			format sTmpFormat as DS_Ttl_[i]{>+12}
		endif
		call setKeyValOnPTPStr(sTmp, PTP_DISC_PRICE_,sTmpFormat)
		
	EndFor
	
	if @WSTYPE = SAROPS
		Format sPTPStr_ as sPTPStr_, sTmp
	endif

EndSub

//******************************************************************
// Procedure: setFIPTaxesOnPTPStr()
// Author: Alex Vidal
// Purpose: Adds FIP Taxes data to current PTP string
// Parameters:
//	 - sPTPStr_ = Current PTP string
//	 - cNetSubtotal_ = Net subtotal for check
//******************************************************************
Sub setFIPTaxesOnPTPStr( var cNetSubtotal_ : $12,  ref sPTPStr_ )

	var i			: N9
	var sTmp		: A(PTP_MAX_REC_LEN)
	var sTmp2	: A(PTP_MAX_REC_LEN)
	var sTmp3	: A20
	var cTax		: $12
	var cTmp		: $12

	
	if gbliInvoiceType <> INV_TYPE_BOLETA

		// ------------------------------------------------------------
		// FACTURA/GUIA/NOTA: Calculate tax based on printed subtotals
		// ------------------------------------------------------------
		
		// get description string
		call getTaxRateStr(1, sTmp3)
		format sTmp2 as "SUBT.IMP. ", sTmp3, "%"
		format sTmp as sTmp2{<16}

		// Do math...
		cTmp = @TAXRATE[1]
		cTax = (((cNetSubtotal_ * 10) * cTmp) / 1000)  // I'm eliminating decimals from the equation, in case DB has been confirgured
																	  // To use 0 decimal places
		format sTmp2 as Abs(cTax){>12}


		// Set calculated tax value
		Call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_NAME_1,sTmp)
		Call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_AMNT_1,sTmp2)

		// All other taxes will be printed empty
		Format sTmp as ""
		Format sTmp2 as ""
		Call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_NAME_2,sTmp)
		Call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_AMNT_2,sTmp2)
		Call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_NAME_3,sTmp)
		Call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_AMNT_3,sTmp2)
		Call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_NAME_4,sTmp)
		Call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_AMNT_4,sTmp2)
		Call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_NAME_5,sTmp)
		Call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_AMNT_5,sTmp2)
		Call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_NAME_6,sTmp)
		Call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_AMNT_6,sTmp2)
		Call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_NAME_7,sTmp)
		Call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_AMNT_7,sTmp2)
		Call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_NAME_8,sTmp)
		Call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_AMNT_8,sTmp2)

	else

		// ------------------------------------------------------------
		// BOLETA: Print tax values from micros calculations
		// ------------------------------------------------------------

		for i = 1 to MAX_TAX_NUM		
			
			if gbliTaxIsInclusive
				cTax = @TAXVAT[i]
			else
				cTax = @TAX[i]
			endif
	
			If cTax <> 0.00
				call getTaxRateStr(i, sTmp3)
				format sTmp2 as "SUBT.IMP. ", sTmp3, "%"
				format sTmp as sTmp2{<16}
				format sTmp2 as Abs(cTax){>12}
			else
				format sTmp as ""
				format sTmp2 as ""
			endif
			
			// add key
			if i = 1
				call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_NAME_1,sTmp)
				call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_AMNT_1,sTmp2)
			elseif i = 2
				call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_NAME_2,sTmp)
				call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_AMNT_2,sTmp2)
			elseif i = 3
				call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_NAME_3,sTmp)
				call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_AMNT_3,sTmp2)
			elseif i = 4
				call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_NAME_4,sTmp)
				call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_AMNT_4,sTmp2)
			elseif i = 5
				call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_NAME_5,sTmp)
				call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_AMNT_5,sTmp2)
			elseif i = 6
				call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_NAME_6,sTmp)
				call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_AMNT_6,sTmp2)
			elseif i = 7
				call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_NAME_7,sTmp)
				call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_AMNT_7,sTmp2)
			elseif i = 8
				call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_NAME_8,sTmp)
				call setKeyValOnPTPStr(sPTPStr_, PTP_TAX_SUBT_AMNT_8,sTmp2)
			endif
	
		endfor
	endif

EndSub

//******************************************************************
// Procedure: getTaxRateStr()
// Author: Alex Vidal
// Purpose: Returns a formatted TaxRate string for printint 
//			purposes
// Parameters:
//	 - iTaxRateIdx_ = index for tax rate to be converted
//	 - retVal_ = function's return value
//
//******************************************************************
Sub getTaxRateStr( var iTaxRateIdx_ : N9, ref retVal_ )

	var sTmp	: A20
	var sTmp2	: A20
	var sTmp3	: A20

	format sTmp as @TAXRATE[iTaxRateIdx_]
	// get integer and decimal portions
	split sTmp, ".", sTmp2, sTmp3

	// check for missing zeroes on decimals
	if len(sTmp3) = 0
		format retVal_ as sTmp, "00"
	elseif len(sTmp3) = 1
		format retVal_ as sTmp, "0"
	else
		format retVal_ as sTmp
	endif

EndSub

//******************************************************************
// Procedure: setFIPTendersOnPTPStr()
// Author: Alex Vidal
// Purpose: Adds FIP Tenders data to current PTP string
// Parameters:
//	 - sPTPStr_ = Current PTP string
//  - TN_Count_ = Total number of grouped Tenders
//  - TN_Name_[] = Array containing grouped Tender names
//  - TN_Ttl_[] = Array containing grouped Tender totals
//
//******************************************************************
Sub setFIPTNOnPTPStr( ref sPTPStr_, ref TN_Count_, ref TN_Name_[], \
						 			ref TN_Ttl_[], var iAddInDetail_ : N1 )

	var i				: N9
	var sTmp			: A(PTP_MAX_REC_LEN)
	var sTmpFormat	: A100

	
	for i = 1 to TN_Count_
		format sTmpFormat as TN_Name_[i]{<12}
		if iAddInDetail_
			call setKeyValOnPTPStr(sTmp, PTP_TNDR_NAME_,sTmpFormat)
		else
			call setKeyValOnPTPStr(sTmp, PTP_TRL_TNDR_NAME_,sTmpFormat)
		endif
		
		format sTmpFormat as Abs(TN_Ttl_[i]){>+12}
		if iAddInDetail_
			call setKeyValOnPTPStr(sTmp, PTP_TNDR_PRICE_,sTmpFormat)
		else
			call setKeyValOnPTPStr(sTmp, PTP_TRL_TNDR_PRICE_,sTmpFormat)
		endif
	endfor

	if @WSTYPE = SAROPS
		Format sPTPStr_ as sPTPStr_, sTmp
	endif

EndSub

//******************************************************************
// Procedure: setFIPTrailerOnPTPStr()
// Author: Alex Vidal
// Purpose: Adds FIP trailer data to current PTP string
// Parameters:
//	- sPTPStr_ = Current PTP string
//
//******************************************************************
Sub setFIPTrailerOnPTPStr( ref sPTPStr_ )

	var i		: N9
	var sTmp	: A(PTP_MAX_REC_LEN)

	
	for i = 1 to gbliMaxTIL
			
		format sTmp as gblsTrailerInfoLines[i]{=32}

		// add key
		if i = 1
			call setKeyValOnPTPStr(sPTPStr_, PTP_TRAILER_LINE_1,sTmp)
		elseif i = 2
			call setKeyValOnPTPStr(sPTPStr_, PTP_TRAILER_LINE_2,sTmp)
		elseif i = 3
			call setKeyValOnPTPStr(sPTPStr_, PTP_TRAILER_LINE_3,sTmp)
		elseif i = 4
			call setKeyValOnPTPStr(sPTPStr_, PTP_TRAILER_LINE_4,sTmp)
		elseif i = 5
			call setKeyValOnPTPStr(sPTPStr_, PTP_TRAILER_LINE_5,sTmp)
		elseif i = 6
			call setKeyValOnPTPStr(sPTPStr_, PTP_TRAILER_LINE_6,sTmp)
		elseif i = 7
			call setKeyValOnPTPStr(sPTPStr_, PTP_TRAILER_LINE_7,sTmp)
		elseif i = 8
			call setKeyValOnPTPStr(sPTPStr_, PTP_TRAILER_LINE_8,sTmp)
		elseif i = 9
			call setKeyValOnPTPStr(sPTPStr_, PTP_TRAILER_LINE_9,sTmp)
		elseif i = 10
			call setKeyValOnPTPStr(sPTPStr_, PTP_TRAILER_LINE_10,sTmp)
		endif

	endfor

EndSub

//******************************************************************
// Procedure: isAlpha()
// Author: Alex Vidal
// Purpose: Returns TRUE if string passed only contains alphabetic
//			characters
// Parameters:
//	- sString_ = String to test
//	- retVal_ = Function's return value
//
//******************************************************************
Sub isAlpha( ref sString_, ref retVal_ )

	var i	: N9


	retVal_ = TRUE

	for i = 1 to len(sString_)
		if Asc( mid(sString_,i,1) ) < 65 or \
			Asc( mid(sString_,i,1) ) > 122	
		
			// current character is not alphabetic!
			retVal_ = FALSE
			return // Bail out!	
		endif
	endfor

EndSub

//******************************************************************
// Procedure: checkFIPStatus()
// Author: Alex Vidal
// Purpose: Checks that all mandatory conditions are met before
//			letting the user access the payments screen
// Parameters:
//	- 
//******************************************************************
Sub checkFIPStatus()

	var iItemCnt	: N9


	// Check Number of printable lines
	call getItemCount(iItemCnt)
	if iItemCnt > gbliMaxPrintableItems
		ErrorMessage "La cantidad de items excede el maximo permitido"
		ErrorMessage "Debe separar la cuenta"
		ExitCancel
	endif

EndSub

//******************************************************************
// Procedure: getItemCount()
// Author: Alex Vidal
// Purpose: Returns the number of items valid for printing
// Parameters:
//	- retVal_ = Function's return value
//******************************************************************
Sub getItemCount( ref retVal_ )

	var x			: N9
	var iInvType	: N1
	var iItemCnt	: N9 = 0
	

	// get invoice type
	if @TTLDUE < 0.00
		// only "nota de Credito" invoice types are negative
		iInvType = INV_TYPE_CREDITO	
	else
		// can be a "Boleta" or "Factura"/"Guia" invoice type
		iInvType = INV_TYPE_BOLETA
	endif


	for x = 1 to @Numdtlt

		if @Dtl_Type[x] = DT_MENU_ITEM or @Dtl_Type[x] = DT_SERVICE_CHARGE
			
			if (@Dtl_Ttl[x] > 0 and Not @Dtl_is_void[x]) or \
				iInvType = INV_TYPE_CREDITO

				iItemCnt = iItemCnt + 1
			endif

		elseif @Dtl_Type[x] = DT_DISCOUNT
		
			if Not @Dtl_is_void[x] or iInvType = INV_TYPE_CREDITO
					
				iItemCnt = iItemCnt + 1
			endif
		
		elseif @Dtl_Type[x] = DT_TENDER

			if (@Dtl_Ttl[x] > 0 and Not @Dtl_is_void[x]) or \
				(iInvType = INV_TYPE_CREDITO and @Dtl_Ttl[x] <= 0)
		
				iItemCnt = iItemCnt + 1
			endif

		endif
	endfor

	// return accumulated value
	retVal_ = iItemCnt

EndSub

//******************************************************************
// Procedure: getCheckTtl()
// Author: Alex Vidal
// Purpose: Returns current check total
// Parameters:
//	- retVal_ = Function's return value
//******************************************************************
Sub getCheckTtl( ref retVal_ )

	var x			: N9
	var cChkTtl		: $12


	for x = 1 to @Numdtlt

		if @Dtl_Type[x] = DT_MENU_ITEM or @Dtl_Type[x] = DT_SERVICE_CHARGE or \
			@Dtl_Type[x] = DT_DISCOUNT

			cChkTtl = cChkTtl + @Dtl_Ttl[x]

		endif
	endfor

	// return accumulated value
	retVal_ = cChkTtl

EndSub

//******************************************************************
// Procedure: ItemIsVoid()
// Author: Alex Vidal
// Purpose: Returns TRUE if item passed is void or has been 
//			returned
// Parameters:
//	- iItemIdx_ = index in @NUMDTLT of Item to be evaluated
//	- retVal_ = Function's return value
//******************************************************************
Sub ItemIsVoid( var iItemIdx_ : N9, ref retVal_ )

	retVal_ = ( bit(@DTL_STATUS[iItemIdx_],VOIDED_BY_LINE_NUMBER) or \
					bit(@DTL_STATUS[iItemIdx_],VOID_ENTRY) or \
					bit(@DTL_STATUS[iItemIdx_],RETURN_ENTRY) )

EndSub

//******************************************************************
// Procedure: setRndAjstMIOnPTPStr()
// Author: Alex Vidal
// Purpose: Adds FIP Rounding Adjustment to PTP string as a Menu
//			Item
// Parameters:
//	 - sPTPStr_ = Current PTP string
//	 - sRndName_ = Rounding printable name
//	 - cRndAmnt_ = Rounding amount
//
//******************************************************************
Sub setRndAjstMIOnPTPStr( ref sPTPStr_, var sRndName_ : A100, var cRndAmnt_ : $12 )

	var sTmpFormat	: A100

	format sTmpFormat as ""{>3}
	call setKeyValOnPTPStr(sPTPStr_, PTP_ITEM_QTY_,sTmpFormat)
	call setKeyValOnPTPStr(sPTPStr_, PTP_ITEM_UNIT_PRICE_,"")
	format sTmpFormat as mid(sRndName_,1,16){<16}
	call setKeyValOnPTPStr(sPTPStr_, PTP_ITEM_NAME_,sTmpFormat)
	call setKeyValOnPTPStr(sPTPStr_, PTP_ITEM_EXTRA_DESC_1_," ")
	format sTmpFormat as cRndAmnt_{>+8}
	call setKeyValOnPTPStr(sPTPStr_, PTP_ITEM_PRICE_,sTmpFormat)

EndSub

//******************************************************************
// Procedure: isValidID()
// Author: Alex Vidal
// Purpose: Returns TRUE if passed customer ID is valid. FALSE if
//				otherwise
// Parameters:
//	 - sIDNumber_ = ID number to be validated
//	 - retVal_ = Function's return value
//
//******************************************************************
Sub isValidID( var sIDNumber_ : A30, ref retVal_)

	var I				: N9
	var nFactor		: N9
	var nSuma		: N9
	var nCar			: N9
	var cRut			: A50
	var cDV			: A50
	var cCalcDV		: A50
	var sTmp			: A50

	
	Format cRut as Trim(sIDNumber_)
	UpperCase cRut
	Format sTmp as cRut
	cDV = Mid(sTmp,len(sTmp),1)
	cRut = Mid(sTmp, 1, len(sTmp) - 1)
	
	nFactor=1
	
	for I=len(cRut) to 1 step -1
		nFactor = nFactor + 1
		nCar = Mid(cRut, I, 1)
		nSuma = nSuma + (nCar * nFactor)
	
		if nFactor = 7
			nFactor = 1
		endif
	endfor

	nFactor = nSuma % 11
		
	if nFactor = 0
		cCalcDV = "0"
	elseif nFactor = 1
	 	cCalcDV = "K"
	else
	 	Format cCalcDV as (11 - nFactor)
	endif

	retVal_ = (cCalcDV = cDV)

EndSub

//******************************************************************
// Procedure: confirmInvNum()
// Author: Alex Vidal
// Purpose: Asks user to confirm passed invoice number and returns
//				the new inputted value if incorrect.
// Parameters:
//	 - sInvoiceSeries_ = Invoice series to be validated
//	 - iInvoiceNum_ = Invoice number to be validated
//	 - IInvoiceType_ = Invoice type to be validated
//******************************************************************
Sub confirmInvNum( ref sInvoiceSeries_, ref iInvoiceNum_, var IInvoiceType_ : N2 )

	var iYes			: N1
	var sTmp			: A200


	Format sTmp as "Proximo nro. es ", iInvoiceNum_, "?"
	
	call promptYesOrNo(iYes, sTmp)
	If iYes
		Return // Number is correct. Bail out!
	else
		forever
			Format sTmp as ""
			Call valuePrompt( sTmp, "Ingrese el nro. correcto", TRUE)	
			call promptYesOrNo(iYes, "Esta seguro?")
			If iYes
				iInvoiceNum_ = sTmp
				
				// check if inputted invoice number is not present in the DB
				Call validInvoiceNum(sInvoiceSeries_,iInvoiceNum_,IInvoiceType_,iYes)
				
				if iYes
					Break
				else
					ErrorMessage "El numero ingresado ya existe en la BD!"
					call logInfo(ERROR_LOG_FILE_NAME,"Employee entered existing invoice number",TRUE,TRUE)
				endif
			endif
		endfor
	EndIf

EndSub

//******************************************************************
// Procedure: stripCrLfCharOff()
// Author: Alex Vidal
// Purpose: Removes char "13" from a string if found
// Parameters:
//	- sInfo_ = String to process
//  - sRetVal_ = Function's return value
//******************************************************************
Sub stripCrLfCharOff(var sInfo_ : A2048, ref sRetVal_)

	if Instr(1, sInfo_, Chr(13)) > 0
		format sRetVal_ as mid(sInfo_,1, (len(sInfo_) - 1) )
	else
		format sRetVal_ as sInfo_
	endIf

EndSub

//******************************************************************
// Procedure: validInvoiceNum()
// Author: Alex Vidal
// Purpose: Returns FALSE if specified invoice number has already
//				been posted to the DB for this WS/invoice-type
//				combination. Returns TRUE if otherwise
// Parameters:
//	- sInvoiceSeries_ = Invoice series to be validated
//	- iInvoiceNum_ = Invoice number to be validated
//	- iInvoiceType_ = Invoice type to be validated
// - RetVal_ = Function's return value
//******************************************************************
Sub validInvoiceNum(var sInvoiceSeries_ : A3, var iInvoiceNum_ : A20, var iInvoiceType_ : N2, ref RetVal_)

	var sSQLCmd				: A500
	var sRecordData		: A1000 = ""
	var iRecordIdx			: N9
	var iAffectedRecs		: N9
	var sQueryRetCode		: A500 = ""
	var sSQLErr				: A500 = ""
	var iDBOK				: N1 = FALSE
	var sTmp					: A256


	RetVal_ = TRUE

	// Check DB Connection
	call MDAD_checkConnection(iDBOK)

	If iDBOK
		
		format sSQLCmd as "SELECT * FROM FCR_INVOICE_DATA ", \
						  		"WHERE PCWSID = ", @WSID, " and ", \
						  		"FCRInvNumber = '", sInvoiceSeries_, iInvoiceNum_, "' and ", \
						  		"InvoiceType = ", iInvoiceType_
	
		call MDAD_execSQL( MDAD_DBCMD_QUERY, MDAD_DB_QRYTYPE_READ, sSQLCmd, "", \
								 MDAD_DB_RCRDSET_TYPE_LOCAL, iAffectedRecs, sQueryRetCode)
		
		If sQueryRetCode = MDAD_RET_CODE_SUCCESS
		
			if iAffectedRecs > 0
				// Invoice number already exists!
				RetVal_ = FALSE
			endif
		Else
			// An error occurred. Warn user and log error
			ErrorMessage "Ha ocurrido un error al querer consultar la BD!"
			call logInfo(ERROR_LOG_FILE_NAME,"Error while querying DB (validInvoiceNum)",TRUE,TRUE)
			call logInfo(ERROR_LOG_FILE_NAME,sSQLCmd,TRUE,TRUE)
			call MDAD_getLastErrDesc(sSQLErr)
			format sTmp as sQueryRetCode, " | ", sSQLErr 
			call logInfo(ERROR_LOG_FILE_NAME,sTmp,TRUE,TRUE)
		endif
		
	Else
		
		// Error! No connection to DB
		Format sTmp as "Unable to verify inputted invoice # ", iInvoiceNum_, "(DB is down)"
		call logInfo(ERROR_LOG_FILE_NAME,"",TRUE,TRUE)
	EndIf	

EndSub

//******************************************************************
// Procedure: getItmzrName()
// Author: Alex Vidal
// Purpose: Returns the description set in the cfg file for the
//				specified itemizer ID
// Parameters:
//	- iItmzrID_ = Itemizer ID
// - retVal_ = Function's return value
//******************************************************************
Sub getItmzrName( var iItmzrID_ : N2, ref retVal_)

	var i			: N9
	var iTmp		: N2
	var sTmp		: A100
	
	
	for i = 1 to MAX_ITMZR_DESC
		Split gblsaItmzrDesc[i], ";", iTmp, sTmp
		
		if iTmp = iItmzrID_
			retVal_ = sTmp
			Return
		endif
	endfor
	
	// If we got here, no description was found!
	retVal_ = "<NO DESC>"
	
EndSub

//******************************************************************
// Procedure: getPrintJobs()
// Author: Alex Vidal
// Purpose: Returns the number of print jobs (documents) that will
//			   be printed for a Micros Check
// Parameters:
//	- iItemCount_ = Number of items in check
//	- iCurrInvMaxItems_ = maximum number of configured items for
//								 current invoice will be returned in this
//							    parameter
// - retVal_ = Function's return value
//******************************************************************
Sub getPrintJobs( var iItemCount_ : N9, ref iCurrInvMaxItems_, ref retVal_ )
	
	var iItemMax	: N9
	
	
	retVal_ = 0

	// get number of necessary print jobs based on how many items
	// are allowed to be printed per page
	
	if gbliInvoiceType = INV_TYPE_BOLETA
		iItemMax = gbliBOLETAMaxItemsPP
	elseif gbliInvoiceType = INV_TYPE_FACTURA
		iItemMax = gbliFACTURAMaxItemsPP
	elseif gbliInvoiceType = INV_TYPE_GUIA
		iItemMax = gbliGUIAMaxItemsPP
	elseif gbliInvoiceType = INV_TYPE_CREDITO
		iItemMax = gbliCREDITOMaxItemsPP
	endif
	
	if iItemMax <> 0
		retVal_ = iItemCount_ / iItemMax
		// check for rounding issues...
		if (retVal_ * iItemMax) < iItemCount_
			retVal_ = retVal_ + 1
		endif
	else
		// Max number of items cannot be zero!
		call logInfo(ERROR_LOG_FILE_NAME,"Max. number of items PP is zero (getPrintJobs)",TRUE,TRUE)
	endif
	
	if retVal_ < 1
		retVal_ = 1
	endif
	
	// return max. number of items for current invoice type
	iCurrInvMaxItems_ = iItemMax

EndSub

//******************************************************************
// Procedure: initArray()
// Author: Alex Vidal
// Purpose: Initializes a string array in C-style
// Parameters:
//	- aArray_[] = array to initialize
//	- iDimNum_ = Number of array dimensions to consider
//******************************************************************
Sub initStrArray( ref aArray_[], var iDimNum_ : N9 )

	var i		: N9
	

	for i = 1 to iDimNum_
		SetString aArray_[i], chr(0)
	endfor

EndSub

//******************************************************************
// Procedure: initArray()
// Author: Alex Vidal
// Purpose: executes a local system command throught the RUNPROC
//				driver
// Parameters:
//	- sCmd_ = Command to be executed
//	- retVal_ = execution result
//******************************************************************
Sub execSystemCmd( var sCmd_ : A500, ref retVal_ )

	DLLCall gblhRPROC, RPROC_execCmd( ref sCmd_, ref retVal_)
	
EndSub

//******************************************************************
// Procedure: getInvPrintPath()
// Author: Alex Vidal
// Purpose: Returns print path for current invoice and flag stating
//				whether printing should occur on a local or external
//				printer
// Parameters:
//	- sPrintPath_ = Returned print path
//	- iOnLocal_ = TRUE if printing was specified on local printer,
//					  FALSE if on external
//******************************************************************
Sub getInvPrintPath( ref sPrintPath_, ref iOnLocal_ )

	
	iOnLocal_ = TRUE // local print job by default
	
	
	If gbliInvoiceType = INV_TYPE_BOLETA
		if gbliPrintBOLETAonLCL
			format sPrintPath_ as PATH_TO_BOLETA_PRINT_DOC
		else
			iOnLocal_ = FALSE
			if @WSTYPE = SAROPS
				Format sPrintPath_ as gblsFixedPrintPath, "\BLT_PRNT"
			else
				format sPrintPath_ as PATH_TO_BOLETA_PRINT_DOC
			endif
		endif
		
	elseif gbliInvoiceType = INV_TYPE_CREDITO
		if gbliPrintCREDITOonLCL
			format sPrintPath_ as PATH_TO_CREDITO_PRINT_DOC
		else
			iOnLocal_ = FALSE
			if @WSTYPE = SAROPS
				Format sPrintPath_ as gblsFixedPrintPath, "\CDT_PRNT"
			else
				format sPrintPath_ as PATH_TO_CREDITO_PRINT_DOC
			endif
		endif
		
	elseif gbliInvoiceType = INV_TYPE_FACTURA
		if gbliPrintFACTURAonLCL
			format sPrintPath_ as PATH_TO_FACTURA_PRINT_DOC
		else
			iOnLocal_ = FALSE
			if @WSTYPE = SAROPS
				Format sPrintPath_ as gblsFixedPrintPath, "\FCT_PRNT"
			else
				format sPrintPath_ as PATH_TO_FACTURA_PRINT_DOC
			endif
		endif
		
	elseif gbliInvoiceType = INV_TYPE_GUIA
		if gbliPrintGUIAonLCL
			format sPrintPath_ as PATH_TO_GUIA_PRINT_DOC
		else
			iOnLocal_ = FALSE
			if @WSTYPE = SAROPS
				Format sPrintPath_ as gblsFixedPrintPath, "\GIA_PRNT"
			else
				format sPrintPath_ as PATH_TO_GUIA_PRINT_DOC
			endif
		endif
	endif
	
EndSub

//******************************************************************
// Procedure: setAmountInWords()
// Author: Alex Vidal
// Purpose: sets the check's total amount in words on the 
//				corresponding TOTAL|TRAILER section Fids
// Parameters:
//	- cTotal_ = Check total amount
//	- iAddToTOTALSection_ = If TRUE, amount in words will be set
//									on PTP "TOTAL section" specific FIDs.
//									If FALSE, amount in words will be set
//									on PTP "TRAILER section" FIDs.
// - sPTPStr_ = PTP string to which FID data will be appended
//******************************************************************
Sub setAmountInWords( var cTotal_ : $15, var iAddToTOTALSection_ : N1, ref sPTPStr_)

	var sTmp					: A200
	var sWords[50]			: A100
	var sPrintLines[50] 	: A200
	var iPrintLinesCnt	: N9
	

	// get amount in letters
	Call print_total_in_text(cTotal_, sTmp)
	// get individual words
	split sTmp, " ", #50, sWords[]
	// get print lines
	Call getPrintLines(gbliMaxAmntInWordsCPL, sWords[], iPrintLinesCnt, sPrintLines[])
	
	if iAddToTOTALSection_
		// Add amount in words to PTP "TOTAL section" FIDs
		
		if iPrintLinesCnt >= 1
			Call setKeyValOnPTPStr(sPTPStr_, PTP_TTL_EXTRA_NAME_1,sPrintLines[1])
		else
			Call setKeyValOnPTPStr(sPTPStr_, PTP_TTL_EXTRA_NAME_1,"")
		endif
		if iPrintLinesCnt >= 2
			Call setKeyValOnPTPStr(sPTPStr_, PTP_TTL_EXTRA_NAME_2,sPrintLines[2])
		else
			Call setKeyValOnPTPStr(sPTPStr_, PTP_TTL_EXTRA_NAME_2,"")
		endif
		if iPrintLinesCnt >= 3
			Call setKeyValOnPTPStr(sPTPStr_, PTP_TTL_EXTRA_NAME_3,sPrintLines[3])
		else
			Call setKeyValOnPTPStr(sPTPStr_, PTP_TTL_EXTRA_NAME_3,"")
		endif
		if iPrintLinesCnt >= 4
			Call setKeyValOnPTPStr(sPTPStr_, PTP_TTL_EXTRA_NAME_4,sPrintLines[4])
		else
			Call setKeyValOnPTPStr(sPTPStr_, PTP_TTL_EXTRA_NAME_4,"")
		endif
		
	else
		// Add amount in words to PTP "TRAILER section" FIDs
		
		if iPrintLinesCnt >= 1
			Call setKeyValOnPTPStr(sPTPStr_, PTP_TRAILER_EXTRA_1,sPrintLines[1])
		else
			Call setKeyValOnPTPStr(sPTPStr_, PTP_TRAILER_EXTRA_1,"")
		endif
		if iPrintLinesCnt >= 2
			Call setKeyValOnPTPStr(sPTPStr_, PTP_TRAILER_EXTRA_2,sPrintLines[2])
		else
			Call setKeyValOnPTPStr(sPTPStr_, PTP_TRAILER_EXTRA_2,"")
		endif
		if iPrintLinesCnt >= 3
			Call setKeyValOnPTPStr(sPTPStr_, PTP_TRAILER_EXTRA_3,sPrintLines[3])
		else
			Call setKeyValOnPTPStr(sPTPStr_, PTP_TRAILER_EXTRA_3,"")
		endif
		if iPrintLinesCnt >= 4
			Call setKeyValOnPTPStr(sPTPStr_, PTP_TRAILER_EXTRA_4,sPrintLines[4])
		else
			Call setKeyValOnPTPStr(sPTPStr_, PTP_TRAILER_EXTRA_4,"")
		endif
		
	endif
	
EndSub

//******************************************************************
// Procedure: getPrintLines()
// Author: Alex Vidal
// Purpose: returns formatted lines to send to the printer, based on 
/// 			the maximum number of printable characters per line
// Parameters:
// - MaxCharsPerLine_ = Max. number of printable chars per line
//	- sWords_[] = data to be printed
// - iPrintLinesCount_ = total number of returned print lines
//	- sRetBuff__[] = function's return value
//******************************************************************
Sub getPrintLines( var MaxCharsPerLine_ : N9, ref sWords_[], ref iPrintLinesCount_, \
						 ref sRetBuff_[] )

	var i					: N9
	var sTmp				: A100
	var sTmp2			: A100
	var iWordsCount	: N9
		
		
	// init vars
	iPrintLinesCount_ = 0
	
	// get number of "significant" words
	for i = 1 to ArraySize(sWords_)
		if sWords_[i] <> ""	
			iWordsCount = iWordsCount + 1
		else
			Break
		endif
	endfor
		
	Format sTmp as sWords_[1]

	for i = 2 to iWordsCount
		Format sTmp2 as sTmp, " ", sWords_[i]
		if Len(sTmp2) <= MaxCharsPerLine_
			Format sTmp as sTmp2
		else
			iPrintLinesCount_ = iPrintLinesCount_ + 1
			Format sRetBuff_[iPrintLinesCount_] as sTmp
			Format sTmp as sWords_[i]
		endif
	endfor

	// check if we have included the last word in the return buffer
	if iPrintLinesCount_ > 0
		if sRetBuff_[iPrintLinesCount_] <> sTmp
			iPrintLinesCount_ = iPrintLinesCount_ + 1
			Format sRetBuff_[iPrintLinesCount_] as sTmp
		endif
	else
		if sTmp <> ""
			iPrintLinesCount_ = iPrintLinesCount_ + 1
			Format sRetBuff_[iPrintLinesCount_] as sTmp
		endif
	endif

EndSub

//******************************************************************
// Procedure: getItemizerTax()
// Author: Alex Vidal
// Purpose: returns aprox. tax amount for each sales itemizer
// Parameters:
// - caSITax_[] = Function's return value
//******************************************************************
Sub getItemizerTax( ref caSITax_[] )

	var x				: N9


	for x = 1 to @NUMDTLT
		if @Dtl_Type[x] = DT_MENU_ITEM
			caSITax_[@DTL_SLSI[x]] = caSITax_[@DTL_SLSI[x]] + @Dtl_taxttl[x]
		endif
	endfor

EndSub

//******************************************************************
// Procedure: checkExtPrintStatus()
// Author: Alex Vidal
// Purpose: Checks fiscalprint command status
// Parameters:
// - iStatus_ = status to be analyzed
//******************************************************************
Sub checkExtPrintStatus( var iStatus_ : N12 )

	var sMsg 		: A100 
	var sTmp			: A100
	  

	If	iStatus_ = 1 or iStatus_ < 0
		sMsg  = "Tiempo agotado esperando respuesta de impresora"
	elseif iStatus_ = 2
		sMsg  = "Impresora no configurada en UWS"
	elseif iStatus_ = 3
		sMsg  = "No hubo respuesta desde la impresora"
	else
		sMsg  = "Error inesperado en la impresora" 
	endif	
	
	errormessage sMsg, " ", " #", iStatus_
	
	// log the error
	Format sTmp as "FiscalPrint state: ", iStatus_
	Call logInfo(ERROR_LOG_FILE_NAME,sTmp,TRUE,TRUE)

EndSub

//******************************************************************
// Procedure: CheckNonEmittingTndr()
// Author: Alex Vidal
// Purpose: Returns TRUE if a non-invoice-emitting tender has been 
// 			posted to the current check
// Parameters:
//	- retVal_ = Function's return value
//******************************************************************
Sub CheckNonEmittingTndr( ref retVal_ )

	var i		: N9

	
	// init vars
	retVal_	= FALSE

	for i = 1 to @NUMDTLT
		If @DTL_TYPE[i] = DT_TENDER
			If @DTL_OBJNUM[i] >= gbliNonFCRMinTndObjNum and \
				@DTL_OBJNUM[i] <= gbliNonFCRMaxTndObjNum
				retVal_ = TRUE
				Return
			endif
		endif		
	endfor

EndSub

//******************************************************************
// Procedure: checkFCRStatus()
// Author: Alex Vidal
// Purpose: checks the Fiscal Printer's current status. If printer
//			state is erroneous, then tries to VOID-VOID the last
//			inputed item.
// Parameters:
//	- 
//******************************************************************
Sub checkFCRStatus()

	Var iFCROK 		: N1
	var iDiscOK		: N1

	
	if gbliDisableFCR
		// FCR has been deactivated
		Return
	endif
	
	if gbliUseEDI = TRUE
		//This procedure must apply only for fiscal printer
		Return
	Endif

	// check printer status and info
	Prompt "Dialogando con impresora..."
	Call getFCRStatus()
	Call checkFCRCmdResponse(giFCROK,TRUE,TRUE,TRUE)

	If Not giFCROK
		// Something is wrong with the printer. Return to the previous screen!
		ExitCancel
	Else
		// Check for pending coupons
		if giFCROpenDoc
			ErrorMessage "Documento Fiscal abierto en impresora!"
			ErrorMessage "Se cerrara el Documento Fiscal"
			call ForceClosureOnFiscalDoc()
		endif

		// Check on discounts exceeding 50% of total
		// (printer fiscal limitation)
		call checkOnDiscountTotal(iDiscOK)

		If Not iDiscOK
			ErrorMessage "Los descuentos exceden el 50% del total de la cuenta"
			ExitCancel
		EndIf
		
		// Go to "Payments" screen
		ExitContinue

	EndIf

EndSub

//******************************************************************
// Procedure: checkOnDiscountTotal()
// Author: Alex Vidal
// Purpose: If discounts are within MAX_DISCOUNT_PERC of the 
//			check's total, this function returns TRUE. If 
//			otherwise, FALSE
// Parameters:
//	- retVal_ = Function's return value
//
//******************************************************************
Sub checkOnDiscountTotal( ref retVal_ )

	var i				: N5
	var cDiscTotal	: $12 = 0.00


	// Acummulate Discounts, including
	// "last item" discounts (not included
	// in the @dsc system var)
	
	For i = 1 to @Numdtlt
		If Not @Dtl_is_void[i]
			If @Dtl_Type[i] = DT_DISCOUNT
				if gbliTaxIsInclusive
					cDiscTotal = cDiscTotal + @Dtl_ttl[i]
				else
					// Add-on tax: Add tax to final amount
					cDiscTotal = cDiscTotal + @Dtl_ttl[i] + @Dtl_taxttl[i]
				endif
			EndIf
		EndIf
	EndFor
	
	// compare Discounts total to total due

	If @Ttldue > 0.00 and Abs(cDiscTotal) > 0.00
		retVal_ = ( (Abs(cDiscTotal) * 100) / (@Ttldue + Abs(cDiscTotal)) ) <= MAX_DISCOUNT_PERC
	Else
		retVal_ = TRUE
	EndIf
	
EndSub

//******************************************************************
// Procedure: PrintFCRCoupon()
// Author: Alex Vidal
// Modified: C Sepulveda
// Purpose: Prints a Fiscal Coupon
// Parameters:
//	- iFCRStatusOK_ = Function's return value 
//					  (1 = OK | 0 = a critical error occurred)
//	- iReprinting_ = If TRUE we are retrying a previous erroneous
//					 FCRCoupon print job
//  - iEdiDoc_ = If TRUE prints an Electronic Document instead of
//           Normal or fiscal Document
//
//******************************************************************
Sub PrintFCRCoupon( ref iFCRStatusOK_, var iReprinting_ : N1, var iEdiDoc_ :N1, var iEDIDup_ : N1)

	var x	: N8  // for looping
	var y	: N8  // for looping
	var i	: N8  // for looping
	var fn	: N5  // for file manipulation

	var iCkNum				 		: N4		// Micros check number
	var iFCRID						: N6		// FCR's "Nro. de Caja"
	var sTmpFormat			 		: A100	// for formating Customer Receipt lines
	var sTmpFormat2				: A100	// for formating Customer Receipt lines
	var sTmpFormat3			 	: A100	// for formating Customer Receipt lines
	var sTmpFormat4			 	: A100	// for formating Customer Receipt lines
	var sTmp							: A100
	var cTmpAmount			 		: $12 	// for saving temporary currency amounts
	var cTmpAmount2			 	: $12 	// for saving temporary currency amounts
	var iNewItem			 		: N1		// boolean for checking if there's a new
													// item to add in the consolidated group
	var iFCRCurrPrintedLines 	: N9  	// Keeps count of the currently printed lines
	var bTndrRndDiff		 		: N1		// to check if Rounding was applied on Tenders
	var iPrintAltTicketInv	 	: N1 		// to check if a ticket invoice type need to be printed
	var iPrintCoupon		 		: N1 		// to check if a coupon can be printed 

	var MI_Qty[@Numdtlt]	 		:	N5		// Menu Item Grouped Quantities
	var MI_Name[@Numdtlt]	 	:	A24	// Menu Item Grouped Names
	var MI_Ttl[@Numdtlt]	 		:	$12	// Menu Item Grouped Totals
	var MI_UnitPrc[@Numdtlt] 	:  $12	// Menu Item Unit Price
	var MI_NetUPrice[@Numdtlt]:  $12	// Menu Item Net Unit Price
	var MI_NetTPrice[@Numdtlt]:  $12	// Menu Item Net Unit Price
	var MI_ObjNum[@Numdtlt]	 	:  N7		// Menu Item Object Number
	var MI_MnuLvl[@Numdtlt]	 	:  N7		// Menu Item Menu level
	var MI_PrcLvl[@Numdtlt]	 	:  N7		// Menu Item Price level
	var MI_DefSeq[@Numdtlt]		:  N7		// Menu Item Definition Sequence
	var MI_TaxRate[@Numdtlt] 	:  A12	// Menu Item Tax rate			
	var MI_Tax[@Numdtlt]	 		:  $12	// Menu Item Taxes amount
	var MI_Count			 		:  N5 = 0	// Menu Item Counter
	var cMI_UnitPrc			 	:  $12
	var cMI_Tax				 		:  $12
	var sMI_TaxRate			 	:  A12

	var DS_Name[@Numdtlt]	 	:	A24		// Discount Grouped Names
	var DS_Ttl[@Numdtlt]	 		:	$12		// Discount Grouped Totals
	var DS_Tax[@Numdtlt]				:  $12		// Discount Item Taxes amount	
	var DS_ObjNum[@Numdtlt]	 	:  N12		// Discount Object Number
	var DS_Count			 		:  N5 = 0	// Discount Counter
	var cDS_Tax				 		:  $12

	var SV_Name[@Numdtlt]	 	:	A24		// Service Grouped Names
	var SV_Ttl[@Numdtlt]	 		:	$12		// Service Grouped Totals
	var SV_ObjNum[@Numdtlt]	 	:  N5			// Service Object Number
	var SV_Tax[@Numdtlt]	 		:  $12		// Service Taxes amount
	var SV_Count			 		:  N5 = 0	// Service Counter
	var cSV_Tax				 		:  $12

	var TN_Name[@Numdtlt]	 	:	A24		// Tender Grouped Names
	var TN_Ttl[@Numdtlt]	 		:	$12		// Tender Grouped Totals
	var TN_ObjNum[@Numdtlt]	 	:  N5		// Tender Object Number
	var TN_Count			 		:  N5 = 0	// Tender Counter
	var cChange				 		:  $12 = 0.00 // Change Due

	var cSubtotal			 		:  $12		// Subtotal (tax included | tax excluded) value for Check
	var cTaxSubtotal		 		:  $12		// Tax Subtotal value for Check
	var cDiscSubtotal		 		:  $12		// Discounts Subtotal value for Check
	var cServSubtotal		 		:  $12		// Services Subtotal value for Check
	var cServTaxSubtotal			:  $12		// Services Tax Subtotal value for Check
	var cBurdenSubtotal		 	:  $12		// Burden Subtotal value for Check
	var cExemptSubtotal		 	:  $12		// Tax Exempt Subtotal value for Check
	var cFCRSubtotal		 		:  $12		// Subtotal value from Fiscal Printer
	var cFCRRoundingAdj		 	:  $12		// Used for Rounding adjustments to Check Fiscal Printer Subtotal
	var cStdrTndrAmount		 	:  $12		// Used for Ticket invoice types
	var cTicketTndrAmount	 	:  $12		// Used for Ticket invoice types
	var cTicketItemTaxTtl	 	:  $12		// Used for Ticket invoice types
	var cTotal				 		:  $12	  // Total value for Check

	var iPrntStage					: N1
	var sTransport			 		: A1 = NO_TRANSPORT


	// init variables
	iFCRStatusOK_ = FALSE   // Assume an FCR erroneous state by default
	cTmpAmount = 0.00
		
	If iReprinting_
		giFCROK = TRUE		// Reset FCR status
	EndIf

	gblcAccumSubtotal = 0

	// ***********************************************
	// Step #1
	// cycle through the check's items and group them
	// ***********************************************
	
	For x = 1 to @Numdtlt
 
		If @Dtl_Type[x] = DT_MENU_ITEM

			// --------------------------------------
			//				Group MIs
			// --------------------------------------

			If @Dtl_Ttl[x] <> 0
   
				iNewItem = TRUE	 // Initialize flag

				// Check to see if current "x" menu item (from outer loop) is 
				// in the MI_ "y" array. If so, consolidate its total into the current
				// "y" item. Otherwise, generate a new item in the "y" MI_ array.

				For y = 1 to MI_Count

					if Not bit(@Dtl_Typedef[x],DTL_ITEM_OPEN_PRICED) and \
						Not bit(@Dtl_Typedef[x],DTL_ITEM_IS_WEIGHED)
						
						//Check if its shared Item
						If @Dtl_Qty[x] = 0 and @Dtl_Ttl[x] <> 0.00
							//This is a shared Item, It must be added as new Item
							break
						endif
						
						If @Dtl_Objnum[x] = MI_ObjNum[y] and @DTL_PLVL[x] = MI_PrcLvl[y] and \
								@DTL_DEFSEQ[x] = MI_DefSeq[y] and @DTL_MLVL[x] = MI_MnuLvl[y] 
	
							MI_Qty[y] = MI_Qty[y] + @Dtl_Qty[x] // Acumulate Qty
							//MI_Ttl[y] = MI_Ttl[y] + @Dtl_ttl[x] // Acumulate Value
							call getMITax(cMI_Tax,sMI_TaxRate,x)
							MI_Tax[y] = MI_Tax[y] + cMI_Tax		// Acumulate Tax
							if gbliTaxIsInclusive
								MI_Ttl[y] = MI_Ttl[y] + @Dtl_ttl[x] 
							else
								MI_Ttl[y] = MI_Ttl[y] + @Dtl_ttl[x] + cMI_Tax
							endif
															
	
							iNewItem = FALSE // Don't add this item!
							Break
						Endif
					
					else
						// Weighed and open-priced items should not be 
						// accumulated (Unit prices may vary)
						Break
					endif

				Endfor 

				If iNewItem
					// add a new item to the MI counter
					
					MI_Count = MI_Count + 1
					
					// Add a new item to the MI_ group array
				
					MI_Name[MI_Count] = @Dtl_Name[x]
					
					call getMITax(cMI_Tax,sMI_TaxRate,x)
					MI_ObjNum[MI_Count] = @Dtl_Objnum[x]
					MI_MnuLvl[MI_Count] = @DTL_MLVL[x]
					MI_PrcLvl[MI_Count] = @Dtl_Plvl[x]
					MI_DefSeq[MI_Count] = @DTL_DEFSEQ[x] 
					//call getMITax(cMI_Tax, sMI_TaxRate, x)
					MI_Tax[MI_Count] = cMI_Tax
					MI_TaxRate[MI_Count] = sMI_TaxRate
					Call getMIUnitPrice(cMI_UnitPrc,x,MI_Tax[],MI_Count,gbliTaxIsInclusive)
					if gbliTaxIsInclusive
						MI_Ttl[MI_Count]  = @Dtl_Ttl[x]
					else
						MI_Ttl[MI_Count]  = @Dtl_Ttl[x] + cMI_Tax
					endif
					
					If MI_UnitPrc[MI_Count] = 0.00
						MI_Qty[MI_Count]  = 1
						MI_NetUPrice[MI_Count] = @Dtl_Ttl[x] - Abs(cMI_Tax)
					else
						MI_Qty[MI_Count]  = @Dtl_Qty[x]
						MI_NetUPrice[MI_Count] = cMI_UnitPrc - Abs(cMI_Tax / @Dtl_Qty[x])
					endif
					
					//MI_UnitPrc[MI_Count] = cMI_UnitPrc
					//MI_NetUPrice[MI_Count] = cMI_UnitPrc - Abs(cMI_Tax / @Dtl_Qty[x])
					
				EndIf
			EndIf

		ElseIf @Dtl_Type[x] = DT_DISCOUNT

			// --------------------------------------
			//				Group Discounts
			// --------------------------------------
   
   		If Not @Dtl_is_void[x]
				
				iNewItem = TRUE	 // Initialize flag
	
				// Check to see if current "x" Discount (from outer loop) is 
				// in the DS_ "y" array. If so, consolidate its total into the current
				// "y" Discount. Otherwise, generate a new Discount in the "y" DS_ array.
	
				For y = 1 to DS_Count
	
					If @Dtl_Objnum[x] = DS_ObjNum[y]
	
						Call getDS_SVTax(cDS_Tax, x)
						if gbliTaxIsInclusive
							DS_Ttl[y] = DS_Ttl[y] + @Dtl_ttl[x]
						else
							DS_Ttl[y] = DS_Ttl[y] + (@Dtl_ttl[x] + cDS_Tax) // Acumulate Value
						endif
	
						iNewItem = FALSE // Don't add this item!
						Break
					Endif
	
				EndFor
	
				If iNewItem
					// add a new item to the DS counter
					DS_Count = DS_Count + 1
					
					// Add a new item to the DS_ group array
					DS_Name[DS_Count] = @Dtl_Name[x]
					Call getDS_SVTax(cDS_Tax, x)

					if gbliTaxIsInclusive
						DS_Ttl[DS_Count]  = @Dtl_Ttl[x]
					else
						DS_Ttl[DS_Count]  = (@Dtl_Ttl[x] + cDS_Tax)
					endif
					DS_Tax[y] = DS_Tax[y] + cDS_Tax // Acumulate Value
					DS_ObjNum[DS_Count] = @Dtl_Objnum[x]
	
				EndIf
			endif

		ElseIf @Dtl_Type[x] = DT_SERVICE_CHARGE

			// --------------------------------------
			//				Group Services
			// --------------------------------------

			If Not @Dtl_is_void[x]
				If @Dtl_Ttl[x] > 0
					
					iNewItem = TRUE	 // Initialize flag
	
					// Check to see if current "x" Service (from outer loop) is 
					// in the SV_ "y" array. If so, consolidate its total into the current
					// "y" Service. Otherwise, generate a new Service in the "y" SV_ array.
	
					For y = 1 to SV_Count
	
						If @Dtl_Objnum[x] = SV_ObjNum[y]
	
							Call getDS_SVTax(cSV_Tax, x)
							SV_Tax[y] = SV_Tax[y] + cSV_Tax // Acumulate Value
							SV_Ttl[y] = SV_Ttl[y] + @DTL_TTL[x] // Acumulate Value
	
							iNewItem = FALSE // Don't add this item!
							Break
						Endif
	
					EndFor
	
					If iNewItem
						// add a new item to the SV counter
						SV_Count = SV_Count + 1
						
						// Add a new item to the SV_ group array
						SV_Name[SV_Count] = @Dtl_Name[x]
						Call getDS_SVTax(cSV_Tax, x)
						SV_Tax[SV_Count]  = cSV_Tax
						SV_Ttl[SV_Count]  = @DTL_TTL[x]
						SV_ObjNum[SV_Count] = @Dtl_Objnum[x]
	
					EndIf
				EndIf
			endif

		ElseIf @Dtl_Type[x] = DT_TENDER

			// --------------------------------------
			//				Group Tenders
			// --------------------------------------
   
   		If Not @Dtl_is_void[x]
				If @Dtl_Ttl[x] > 0
					// This is a payment!
	
					// check if current tender is within the
					// object number range for tenders that are
					// not supposed to print an FCR Coupon. If
					// so, bail out and don't print anything!
	
					If @Dtl_Objnum[x] >= gbliNonFCRMinTndObjNum and \
					   @Dtl_Objnum[x] <= gbliNonFCRMaxTndObjNum
						
						// Current Tender should not print
						// an FCR Coupon for this check!
						iFCRStatusOK_ = TRUE
						Return
	
					EndIf
	
	
					iNewItem = TRUE	 // Initialize flag
	
					// Check to see if current "x" Tender (from outer loop) is 
					// in the TN_ "y" array. If so, consolidate its total into the current
					// "y" Tender. Otherwise, generate a new Tender in the "y" TN_ array.
	
					For y = 1 to TN_Count
	
						If @Dtl_Objnum[x] = TN_ObjNum[y]
	
							TN_Ttl[y] = TN_Ttl[y] + @Dtl_ttl[x] // Acumulate Value
	
							iNewItem = FALSE // Don't add this item!
							Break
						Endif
	
					EndFor
	
					If iNewItem
						// add a new item to the TN counter
						TN_Count = TN_Count + 1
						
						// Add a new item to the TN_ group array
						TN_Name[TN_Count] = @Dtl_Name[x]
						TN_Ttl[TN_Count]  = @Dtl_Ttl[x]
						TN_ObjNum[TN_Count] = @Dtl_Objnum[x]
	
					EndIf
				
				Else
					// Get change amount
					cChange = ( @dtl_ttl[x] * -1 )
										
				EndIf
			endif
			
		Endif
	Endfor

	
	// ***********************************************
	// Step #2
	// calculate subtotals and totals
	// ***********************************************
			
	// get Tax subtotal
	Call getTaxesSubtotal(cTaxSubtotal)

	// get subtotal (Tax Included)
	Call getCheckSubtotal(cSubtotal, MI_Ttl[], cTaxSubtotal, MI_Count, FALSE)
	if Not gbliTaxIsInclusive
		call getArraySubtotal(cTmpAmount, MI_Tax[], MI_Count)
		cSubtotal = cSubtotal + cTmpAmount
	endif

	// get Discounts subTotal
	Call getDiscountSubtotal(cDiscSubtotal, DS_Ttl[], DS_Count)

	// get services' tax subtotal
	call getArraySubtotal(cServTaxSubtotal, SV_Tax[], SV_Count)

	// get TOTAL
	if gbliTaxIsInclusive
		cTotal = (cSubtotal + @SVC) + cDiscSubtotal
	else
		cTotal = (cSubtotal + (@SVC + cServTaxSubtotal)) + cDiscSubtotal
	endif
	
	If (cServSubtotal <> @SVC) and not gbliAddChargedTipToTotal[gbliInvoiceType]
		// Charged tip should not be posted to the
		// check total. Subtract it from accumulated total
		cTotal = cTotal - (@Svc - cServSubtotal)
	endif
	
	// check for Ticket invoice type printing
	Call checkForTicketInvType(TN_ObjNum[],TN_Ttl[],TN_Count,iPrintAltTicketInv, \
										iPrintCoupon, cTicketTndrAmount, cStdrTndrAmount)
	
	if not iPrintCoupon
		ErrorMessage "El total de la cuenta ha sido abonada con tickets"
		ErrorMessage "No se imprimira la boleta fiscal"
		
		// return "OK" for FCR status
		iFCRStatusOK_ = TRUE
		Return // Bail out!
	endif
	
	// Check for total. If <= 0 then don't print a
	// fiscal coupon
	if gbliInvoiceType <> INV_TYPE_CREDITO
		If cTotal <= 0.00 or (cChange > 0.00 and TN_Count = 0)
			ErrorMessage "El total de la cuenta no supera los $0.00"
			ErrorMessage "No se imprimira la boleta fiscal"
			
			// return "OK" for FCR status
			iFCRStatusOK_ = TRUE
			Return // Bail out!
		endif
	endif

	If Not iReprinting_
		// save current check number in a file just in
		// case the invoice for this check is not
		// printed correctly
		
		call saveChkNumToFile()
	EndIf


	// ***********************************************
	// Step #3
	// Open Fiscal Coupon
	// ***********************************************

	// a line will be printed. Keep count...
	if not iEdiDoc_
		iFCRCurrPrintedLines = iFCRCurrPrintedLines + 1 
	EndIf
	
	// ---------------------------------------------------
	// Note:
	//
	//		A counter is increased for each time a 
	// command is sent to the Fiscal Printer. This
	// is done so that we can keep track of each
	// exact step in case an error occurs. By means
	// of this tracking mechanism is that reprinting
	// of a Fiscal Coupon can be achieved, since we
	// can only start reprinting a Fiscal document
	// only from the step where the error occurred, 
	// onwards.
	//		However, there's an issue when trying
	// to reprint a truncated Fiscal Coupon:
	// Depending on the exact moment the error 
	// occurred, the printer might return an error code, 
	// but yet print the item anyway. This is a problem 
	// since we might reprint an item which has already 
	// been printed due to this issue. Therefore, we
	// must also keep track of the current subtotal,
	// cancelling an item that has been printed twice
	//
	//									- Alex Vidal -
	// ---------------------------------------------------

	if not iEdiDoc_
		// get current fase (if reprinting)
		if iReprinting_
			Call getFCRCouponInfo(iPrntStage)
		endif
	

		If iFCRCurrPrintedLines > gbliFCRPrintedLines
			if not iReprinting_ or (iReprinting_ and iPrntStage < BLT_INITIAL_FASE)
				Prompt "Abriendo cupon fiscal..."
				call OpenFCRCoupon()
				call checkFCRCmdResponse(giFCROK, TRUE, TRUE, TRUE)
			Endif
		EndIf
	else
		call checkEDIPrinter(giFCROK, TRUE, TRUE, FALSE)
	
		if not giFCROK
			iFCRStatusOK_ = FALSE
			Return // Bail out!
		endif
			
		Prompt "Abriendo Doc. Electronico..."

		call OpenEDICoupon()
		
		call checkEDIPrinter(giFCROK, TRUE, TRUE, FALSE)
		
		if not giFCROK
			iFCRStatusOK_ = FALSE
			Return // Bail out!
		endif
	EndIf
		

	// ***********************************************
	// Step #4
	// Now that we have all the values we need, build
	// each command line that will be sent to the 
	// Fiscal Printer in order to print the current 
	// Fiscal Coupon
	// ***********************************************
	
	// ---------------------------------
	// format and print invoice Items
	// ---------------------------------

	// #4.1 Print MIs

	if not iPrintAltTicketInv
		if not iEdiDoc_
			For i = 1 to MI_Count
			
				Prompt "Enviando item ", i, "/", MI_Count, "..."
				
				if not iEdiDoc_
					If Not giFCROK
						Return // bail out!
					Else
						If iFCRCurrPrintedLines > gbliFCRPrintedLines
							// Update line counter...
							gbliFCRPrintedLines = gbliFCRPrintedLines + 1
						EndIf
					EndIf
				endif
				
				// -- Get Qty --
				//If MI_UnitPrc[i] <> 0.00
					format sTmpFormat as Abs(MI_Qty[i])
				//Else
				//	format sTmpFormat as "1"
				//EndIf
		
				// -- set Unit price --
				if not iEdiDoc_
					If MI_UnitPrc[i] <> 0.00
						// remove decimals from amount (if any) and set it
						call removeDecimals(Abs(MI_UnitPrc[i]), sTmpFormat2)
			
					Else
						// This is a shared item. Post total.
						// remove decimals from amount (if any) and set it
						if gbliTaxIsInclusive
							call removeDecimals(Abs(MI_Ttl[i]), sTmpFormat2)
						else
							call removeDecimals(Abs(MI_Ttl[i] + MI_Tax[i]), sTmpFormat2)
						endif
					EndIf
				else
					if gbliTaxIsInclusive
						call removeDecimals(Abs(MI_Ttl[i]), sTmpFormat2)
						call removeDecimals(Abs(MI_UnitPrc[i]), sTmpFormat4)
					else
						call removeDecimals(Abs(MI_Ttl[i] + MI_Tax[i]), sTmpFormat2)
						call removeDecimals(Abs((MI_Ttl[i] + MI_Tax[i]) / Abs(MI_Qty[i])), sTmpFormat4)
					endif
				endif
			
				// -- set tax rate (pad with 2 zeroes because of "casting" bug) --
				call removeDecimalSeparator(MI_TaxRate[i], sTmpFormat3,4)
		
				if not iEdiDoc_
					// a line will be printed. Keep count...
					iFCRCurrPrintedLines = iFCRCurrPrintedLines + 1 
			
					If iFCRCurrPrintedLines > gbliFCRPrintedLines
						
						if not iReprinting_ or (iReprinting_ and iPrntStage <= BLT_SALE_FASE)
							// print item
							if MI_Ttl[i] > 0.00
								Call printFCRFiscalItem(MI_Name[i], sTmpFormat, sTmpFormat2, sTmpFormat3) // Normal item
							elseif MI_Ttl[i] < 0.00
								Call printFCRFiscalItemReturn(MI_Name[i], sTmpFormat, sTmpFormat2, sTmpFormat3) // "Return" item
							endif
							
							call checkFCRCmdResponse(giFCROK, TRUE, TRUE, FALSE)
							
							If giFCROK
								// get total for current item
								if gbliTaxIsInclusive
									call removeDecimals(MI_Ttl[i], sTmp)
								else
									call removeDecimals((MI_Ttl[i] + MI_Tax[i]), sTmp)
								endif
								cTmpAmount = sTmp
								// save current subtotal posted to the FCR
								gblcAccumSubtotal = gblcAccumSubtotal + cTmpAmount
				
								// Check on reprinting issue...
								If iReprinting_
									call CheckForReprintingIssue(DT_MENU_ITEM, gblcAccumSubtotal, \
																			 MI_Name[i], sTmpFormat, sTmpFormat2, \
																			 sTmpFormat3)
								EndIf
							EndIf
						Endif
					EndIf
				else
					// print item
					if MI_Ttl[i] > 0.00
						
						Call printEDIFiscalItem(MI_Name[i], sTmpFormat, sTmpFormat2, sTmpFormat3, sTmpFormat4) // Normal item
						
						call checkEDIPrinter(giFCROK, TRUE, TRUE, FALSE)
				
						if not giFCROK
							iFCRStatusOK_ = FALSE
							Return // Bail out!
						endif
					endif
							
					// get total for current item
					if gbliTaxIsInclusive
						call removeDecimals(MI_Ttl[i], sTmp)
					else
						call removeDecimals((MI_Ttl[i] + MI_Tax[i]), sTmp)
					endif
								
					cTmpAmount = sTmp
					// save current subtotal posted to the FCR
					gblcAccumSubtotal = gblcAccumSubtotal + cTmpAmount
				EndIf
			endfor
		else
			For i = 1 to MI_Count
	
				Prompt "Enviando item ", i, "/", MI_Count, "..."
		
				// -- Get Qty --
				If MI_UnitPrc[i] <> 0.00
					format sTmpFormat as Abs(MI_Qty[i])
				Else
					format sTmpFormat as "1"
				EndIf
				
		
				// -- set Unit price --
				//If MI_UnitPrc[i] <> 0.00
					// remove decimals from amount (if any) and set it
				//	call removeDecimals(Abs(MI_UnitPrc[i]), sTmpFormat2)
		
				//Else
					// This is a shared item. Post total.
					// remove decimals from amount (if any) and set it
					
					if gbliInvoiceType = INV_TYPE_BOLETA
						if gbliTaxIsInclusive
							call removeDecimals(Abs(MI_Ttl[i]), sTmpFormat2)
							call removeDecimals(Abs(MI_UnitPrc[i]), sTmpFormat4)
						else
							call removeDecimals(Abs(MI_Ttl[i] + MI_Tax[i]), sTmpFormat2)
							call removeDecimals(Abs((MI_Ttl[i] + MI_Tax[i]) / Abs(MI_Qty[i])), sTmpFormat4)
						endif
					else
						call removeDecimals(Abs(MI_NetUPrice[i] * MI_Qty[i]), sTmpFormat2)
						call removeDecimals(Abs(MI_NetUPrice[i]), sTmpFormat4)
					endif
				//EndIf
			
				// -- set tax rate (pad with 2 zeroes because of "casting" bug) --
				call removeDecimalSeparator(MI_TaxRate[i], sTmpFormat3,4)
		
				// print item
				if MI_Ttl[i] <> 0.00
					
					Call printEDIFiscalItem(MI_Name[i], sTmpFormat, sTmpFormat2, sTmpFormat3, sTmpFormat4) // Normal item
					
					call checkEDIPrinter(giFCROK, TRUE, TRUE, FALSE)
			
					if not giFCROK
						iFCRStatusOK_ = FALSE
						Return // Bail out!
					endif
				endif
						
				// get total for current item
				if gbliTaxIsInclusive
					call removeDecimals(MI_Ttl[i], sTmp)
				else
					call removeDecimals((MI_Ttl[i] + MI_Tax[i]), sTmp)
				endif
							
				cTmpAmount = sTmp
				// save current subtotal posted to the FCR
				gblcAccumSubtotal = gblcAccumSubtotal + cTmpAmount

			endfor
		endif
		
	else
		
		// print Ticket invoice item
		
		Prompt "Enviando item..."
		
		If Not giFCROK
			Return // bail out!
		Else
			If iFCRCurrPrintedLines > gbliFCRPrintedLines
				// Update line counter...
				gbliFCRPrintedLines = gbliFCRPrintedLines + 1
			EndIf
		EndIf

		// -- Set Qty --
		Format sTmpFormat as "1"

		// -- set Unit price --
		cTmpAmount = cTotal - cTicketTndrAmount		
		// remove decimals from amount (if any) and set it
		Call removeDecimals(cTmpAmount, sTmpFormat2)
	
		// a line will be printed. Keep count...
		iFCRCurrPrintedLines = iFCRCurrPrintedLines + 1 

		If iFCRCurrPrintedLines > gbliFCRPrintedLines
			
			if not iReprinting_ or (iReprinting_ and iPrntStage <= BLT_SALE_FASE)		
				// print item
				call printFCRFiscalItem(gblsTicketItemInvDesc, sTmpFormat, sTmpFormat2, gblsTicketItemTax)
				call checkFCRCmdResponse(giFCROK, TRUE, TRUE, FALSE)
				
				If giFCROK
					// save current subtotal posted to the FCR
					cTmpAmount = sTmpFormat2
					gblcAccumSubtotal = gblcAccumSubtotal + cTmpAmount
	
					// Check on reprinting issue...
					If iReprinting_
						call CheckForReprintingIssue(DT_MENU_ITEM, gblcAccumSubtotal, \
																 gblsTicketItemInvDesc, sTmpFormat, sTmpFormat2, \
																 gblsTicketItemTax)
					EndIf
				EndIf
			endif
		EndIf
	endif


	// #4.2 Print Subtotal

	if not iEdiDoc_
		If Not giFCROK
			Return // bail out!
		Else
			If iFCRCurrPrintedLines > gbliFCRPrintedLines
				gbliFCRPrintedLines = gbliFCRPrintedLines + 1
			EndIf
		EndIf
	
		// a line will be printed. Keep count...
		iFCRCurrPrintedLines = iFCRCurrPrintedLines + 1 
	
		If iFCRCurrPrintedLines > gbliFCRPrintedLines
			// Print Subtotal
			Prompt "Calculando subtotal..."
			call PrintFCRSubtotal()
			call checkFCRCmdResponse(giFCROK, TRUE, TRUE, FALSE)
		EndIf
	else
		Prompt "Calculando subtotal..."
		
		if gbliInvoiceType = INV_TYPE_BOLETA
			call PrintEDISubtotal(gblcAccumSubtotal)
		else
			cTmpAmount = Abs(cSubTotal) - Abs(cTaxSubTotal) - Abs(cDS_Tax)
			call PrintEDISubtotal(cTmpAmount)
		endif
		
		call checkEDIPrinter(giFCROK, TRUE, TRUE, FALSE)
		
		if not giFCROK
			iFCRStatusOK_ = FALSE
			Return // Bail out!
		endif
	endif
	
	// #4.3 Print Services

	if not iPrintAltTicketInv
		For i = 1 to SV_Count
	
			Prompt "Enviando servicios..."
	
			If Not giFCROK
				Return // bail out!
			Else
				If iFCRCurrPrintedLines > gbliFCRPrintedLines
					// Update line counter
					gbliFCRPrintedLines = gbliFCRPrintedLines + 1
				EndIf
			EndIf
	
			// -- get amount --
			if gbliTaxIsInclusive
				call removeDecimals(SV_Ttl[i], sTmpFormat)
			else
				call removeDecimals((SV_Ttl[i] + SV_Tax[i]), sTmpFormat)
			endif
			
			// a line will be printed. Keep count...
			iFCRCurrPrintedLines = iFCRCurrPrintedLines + 1 
	
			if not iEdiDoc_
				If iFCRCurrPrintedLines > gbliFCRPrintedLines
					if not iReprinting_ or (iReprinting_ and iPrntStage <= BLT_DSCSVC_FASE)
						
						// -- print service --
						call printFCRService(SV_Name[i], sTmpFormat)
						call checkFCRCmdResponse(giFCROK, TRUE, TRUE, FALSE)
			
						If giFCROK				
							// get total for current item
							cTmpAmount = sTmpFormat
							// save current subtotal posted to the FCR
							gblcAccumSubtotal = gblcAccumSubtotal + cTmpAmount
			
							// Check on reprinting issue...
							If iReprinting_
								call CheckForReprintingIssue(DT_SERVICE_CHARGE, gblcAccumSubtotal, \
									 									 SV_Name[i], sTmpFormat, "", "")
							EndIf
						EndIf
					endif
				EndIf
			else
				// -- print service --
				
				call printEDIService(SV_Name[i], sTmpFormat)
				
				call checkEDIPrinter(giFCROK, TRUE, TRUE, FALSE)
			
				if not giFCROK
					iFCRStatusOK_ = FALSE
					Return // Bail out!
				endif
				
				// get total for current item
				cTmpAmount = sTmpFormat
				// save current subtotal posted to the FCR
				gblcAccumSubtotal = gblcAccumSubtotal + cTmpAmount

			EndIf
	
			// Accumulate Services Subtotal
			cServSubtotal = cServSubtotal + SV_Ttl[i]
	
		endfor
	endif
	
	// Add tip charge (if tip was paid as a Tender option bit) 
	// and Charged tip has been configured to be posted to 
	// check totals

	if not iPrintAltTicketInv
		If cServSubtotal <> @Svc
			
			If gbliAddChargedTipToTotal[gbliInvoiceType]
	
				Prompt "Enviando excedente..."
	
				If Not giFCROK
					Return // bail out!
				Else
					If iFCRCurrPrintedLines > gbliFCRPrintedLines
						// update line counter
						gbliFCRPrintedLines = gbliFCRPrintedLines + 1
					EndIf
				EndIf
			
				// -- get amount --
				cTmpAmount = (@Svc - cServSubtotal)
				call removeDecimals(cTmpAmount, sTmpFormat)
				
				if not iEdiDoc_
					// a line will be printed. Keep count...
					iFCRCurrPrintedLines = iFCRCurrPrintedLines + 1 
					
					If iFCRCurrPrintedLines > gbliFCRPrintedLines
						if not iReprinting_ or (iReprinting_ and iPrntStage <= BLT_DSCSVC_FASE)
							
							// -- print service --
							call printFCRService("Excedente", sTmpFormat)
							call checkFCRCmdResponse(giFCROK, TRUE, TRUE, FALSE)
							
							If giFCROK
								// get total for current item
								cTmpAmount = sTmpFormat
								// get current subtotal posted to the FCR
								gblcAccumSubtotal = gblcAccumSubtotal + cTmpAmount
			
								// Check on reprinting issue...
								If iReprinting_
									call CheckForReprintingIssue(DT_SERVICE_CHARGE, gblcAccumSubtotal, \
																			 SV_Name[i], sTmpFormat, "", "")
								EndIf
							EndIf
						endif
					EndIf
				else
					// -- print service --
					call printEDIService("Excedente", sTmpFormat)
					
					call checkEDIPrinter(giFCROK, TRUE, TRUE, FALSE)
		
					if not giFCROK
						iFCRStatusOK_ = FALSE
						Return // Bail out!
					endif
					
					// get total for current item
					cTmpAmount = sTmpFormat
					// get current subtotal posted to the FCR
					gblcAccumSubtotal = gblcAccumSubtotal + cTmpAmount
				EndIf
			endif
		endif
	endif

	// #4.4 Write Discounts

	if not iPrintAltTicketInv
		For i = 1 to DS_Count
	
			Prompt "Enviando descuentos..."
	
			If Not giFCROK
				Return // bail out!
			Else
				If iFCRCurrPrintedLines > gbliFCRPrintedLines
					// Update line counter
					gbliFCRPrintedLines = gbliFCRPrintedLines + 1
				EndIf
			EndIf
		
			// -- set amount --
			DS_Ttl[i] = Abs(DS_Ttl[i])
			if gbliInvoiceType = INV_TYPE_BOLETA
				call removeDecimals(DS_Ttl[i], sTmpFormat)
			else
				call removeDecimals((DS_Ttl[i] - cDS_Tax), sTmpFormat)
			endif
			
			// a line will be printed. Keep count...
			iFCRCurrPrintedLines = iFCRCurrPrintedLines + 1 
			
			if not iEdiDoc_
				If iFCRCurrPrintedLines > gbliFCRPrintedLines
					if not iReprinting_ or (iReprinting_ and iPrntStage <= BLT_DSCSVC_FASE)
						
						// -- print Discount --
						call printFCRDiscount(DS_Name[i], sTmpFormat)
						call checkFCRCmdResponse(giFCROK, TRUE, TRUE, FALSE)
			
						If giFCROK
							// get total for current item
							cTmpAmount = sTmpFormat
							// get current subtotal posted to the FCR
							gblcAccumSubtotal = gblcAccumSubtotal - cTmpAmount
			
							// Check on reprinting issue...
							If iReprinting_
								call CheckForReprintingIssue(DT_DISCOUNT, gblcAccumSubtotal, \
																		 DS_Name[i], sTmpFormat, "", "")
							EndIf
						EndIf
					endif
				endif
			else
				// -- print Discount --
				call printEDIService(DS_Name[i], sTmpFormat)
				
				call checkEDIPrinter(giFCROK, TRUE, TRUE, FALSE)
		
				if not giFCROK
					iFCRStatusOK_ = FALSE
					Return // Bail out!
				endif
				
				// get total for current item
				cTmpAmount = sTmpFormat
				// get current subtotal posted to the FCR
				if gbliinvoicetype=INV_TYPE_BOLETA
					gblcAccumSubtotal = gblcAccumSubtotal - cTmpAmount
				else
					gblcAccumSubtotal = Abs(gblcAccumSubtotal) - Abs(cTmpAmount) - Abs(cDS_Tax)
			EndIf
			
		endfor
	endif

	// Check for rounding issues between check
	// subtotal and total tendered and post an
	// extra discount if necessary
	Call checkTndrRnd(gblcFCRCurrSubtotal, TN_Ttl[], TN_Count, bTndrRndDiff, cFCRRoundingAdj)

	If bTndrRndDiff
	
		if not iEdiDoc_
			If Not giFCROK
				Return // bail out!
			Else
				If iFCRCurrPrintedLines > gbliFCRPrintedLines
					// update line counter
					gbliFCRPrintedLines = gbliFCRPrintedLines + 1
				EndIf
			EndIf
		EndIf
	
		// -- get discount amount --
		call removeDecimals(cFCRRoundingAdj, sTmpFormat)

		if iEdiDoc_
			// a line will be printed. Keep count...
			iFCRCurrPrintedLines = iFCRCurrPrintedLines + 1 
			
			If iFCRCurrPrintedLines > gbliFCRPrintedLines
				if not iReprinting_ or (iReprinting_ and iPrntStage <= BLT_DSCSVC_FASE)
					// -- print discount --
					call printFCRDiscount("AJUSTE POR REDONDEO", sTmpFormat)
					call checkFCRCmdResponse(giFCROK, TRUE, TRUE, FALSE)
					
					If giFCROK
						// get current subtotal posted to the FCR
						cTmpAmount = sTmpFormat
						gblcAccumSubtotal = gblcAccumSubtotal - cTmpAmount
		
						// Check on reprinting issue...
						If iReprinting_
							call CheckForReprintingIssue(DT_DISCOUNT, gblcAccumSubtotal, \
																 "AJUSTE POR REDONDEO", sTmpFormat, "", "")
						EndIf
					EndIf
				endif
			EndIf
		else
			// -- print discount --
			call printEDIService("AJUSTE POR REDONDEO", sTmpFormat)
			
			call checkEDIPrinter(giFCROK, TRUE, TRUE, FALSE)
		
			if not giFCROK
				iFCRStatusOK_ = FALSE
				Return // Bail out!
			endif
	
			// get current subtotal posted to the FCR
			cTmpAmount = sTmpFormat
			gblcAccumSubtotal = gblcAccumSubtotal - cTmpAmount
		EndIf
	EndIf

	// #4.6 Print total

	if iEdiDoc_
		// Print Subtotal
		cTmpAmount = cSubTotal - cTaxSubTotal + cDiscSubtotal
		Prompt "Imprimiendo Total..."
		call PrintEDItotal(gblcAccumSubtotal, cTmpAmount, cTaxSubTotal)
		
		call checkEDIPrinter(giFCROK, TRUE, TRUE, FALSE)
		
		if not giFCROK
			iFCRStatusOK_ = FALSE
			Return // Bail out!
		endif
	EndIf
	
	// #4.7 Write Tenders

	For i = 1 to TN_Count
		
		if not iEdiDoc_
			if not iPrintAltTicketInv or \
				(iPrintAltTicketInv and not (TN_ObjNum[i] >= gbliTicketMinTndObjNum and \
				TN_ObjNum[i] <= gbliTicketMaxTndObjNum))
				
				Prompt "Enviando pagos..."
					
				If Not giFCROK
					Return // bail out!
				Else
					If iFCRCurrPrintedLines > gbliFCRPrintedLines
						// Update line counter
						gbliFCRPrintedLines = gbliFCRPrintedLines + 1
					EndIf
				EndIf
		
				// -- set Payment ID --
				call getFCRPaymentID(TN_ObjNum[i], sTmpFormat)
		
				// -- set amount --
				call removeDecimals(TN_Ttl[i], sTmpFormat2)
				
				// a line will be printed. Keep count...
				iFCRCurrPrintedLines = iFCRCurrPrintedLines + 1 
				
				If iFCRCurrPrintedLines > gbliFCRPrintedLines
					if not iReprinting_ or (iReprinting_ and iPrntStage <= BLT_PYMNT_FASE)
						
						// -- Print tender --
						call printFCRTender(sTmpFormat, sTmpFormat2)
						call checkFCRCmdResponse(giFCROK, TRUE, TRUE, FALSE)
			
						If giFCROK
							// get total for current item
							cTmpAmount = sTmpFormat2
							// get current subtotal posted to the FCR
							gblcAccumSubtotal = gblcAccumSubtotal - cTmpAmount
			
							// Check on reprinting issue...
							If iReprinting_					
								call CheckForReprintingIssue(DT_TENDER, gblcAccumSubtotal, \
																		 sTmpFormat, sTmpFormat2, "", "")
							EndIf
			
						Else
							// Check on reprinting issue...
							If iReprinting_
								If gsFCRCmdReturn = ETM88III_ERRCODE_PYMNT_DONE
									// Tell user to stay cool...
									ErrorMessage "El error ha sido corregido"
									
									// We are done with payments. Reset 
									// FCR Error Status...
									giFCROK = TRUE
									Break  // bail out!
								EndIf 
							Endif
						EndIf
					endif
				endif
			endif
		else
			if not (TN_ObjNum[i] >= gbliTicketMinTndObjNum and \
				TN_ObjNum[i] <= gbliTicketMaxTndObjNum)
			
				Prompt "Enviando pagos..."
		
				// -- set amount --
				call removeDecimals(TN_Ttl[i], sTmpFormat2)
									
				// -- Print tender --
				call printEDITenders(TN_Name[i], sTmpFormat2)
				
				call checkEDIPrinter(giFCROK, TRUE, TRUE, FALSE)
		
				if not giFCROK
					iFCRStatusOK_ = FALSE
					Return // Bail out!
				endif
			
				// get total for current item
				cTmpAmount = sTmpFormat2
				// get current subtotal posted to the FCR
				gblcAccumSubtotal = gblcAccumSubtotal - cTmpAmount
			endif	
		EndIf
		
	endfor


	// ***********************************************
	// Step #5
	// Close Fiscal Coupon (invoice number is saved
	// in this procedure)
	// ***********************************************
		
	if not iEdiDoc_
		If Not giFCROK
			Return // bail out!
		Else
			If iFCRCurrPrintedLines > gbliFCRPrintedLines
				// Update line counter
				gbliFCRPrintedLines = gbliFCRPrintedLines + 1
			EndIf
		EndIf
	
		// a line will be printed. Keep count...
		iFCRCurrPrintedLines = iFCRCurrPrintedLines + 1 
	
		If iFCRCurrPrintedLines > gbliFCRPrintedLines
			if not iReprinting_ or (iReprinting_ and iPrntStage < BLT_TTL_FASE)
				Prompt "Finalizando cupon fiscal..."
				call CloseFCRCoupon(@Cknum, @TBLID)
				call checkFCRCmdResponse(giFCROK, TRUE, TRUE, FALSE)
			endif
		EndIf
	else
		Prompt "Finalizando Doc. Electronico..."
		
		call CloseEDICoupon()
		
		call checkEDIPrinter(giFCROK, TRUE, TRUE, FALSE)
		
		if not giFCROK
			iFCRStatusOK_ = FALSE
			Return // Bail out!
		endif
	EndIf
	
	// ***********************************************
	// Step #6
	// Post issued invoice info to the Micros DB
	// ***********************************************

	if not iEdiDoc_
		If Not giFCROK
			Return // bail out!
		Else
			If iFCRCurrPrintedLines > gbliFCRPrintedLines
				gbliFCRPrintedLines = gbliFCRPrintedLines + 1
			EndIf
		EndIf
	
		if not iPrintAltTicketInv
			// Get original services subtotal
			if gbliTaxIsInclusive
				cServSubtotal = @SVC
			else
				cServSubtotal = (@SVC + cServTaxSubtotal)
			endif
		else
			// A Ticket invoice type has been printed. set
			// subtotals/totals accordingly
			cSubtotal = (cTotal - cTicketTndrAmount)
			cTotal = cSubtotal
			Call getTaxAmount(cTotal,gblsTicketItemTax,cTaxSubtotal)
			cDiscSubtotal = 0.00
			cServSubtotal = 0.00
			
			// Log this
			Format sTmpFormat as "Issued 'Ticket' invoice type: Coupon ", gblsInvoiceNum
			call logInfo(ERROR_LOG_FILE_NAME,sTmpFormat,TRUE,TRUE)
		endif
	
		// Get check number
		iCkNum = @CKNUM
		// series
		Format sTmpFormat as ""
		
		// get FCR's "Numero de Caja"
		Prompt "Obteniendo nro. de Caja..."
		Call getFCRFiscalizationData(iFCRID)
	else
		cSubtotal = (cTotal - cTicketTndrAmount)
		cTotal = cSubtotal
		Call getTaxAmount(cTotal,gblsTicketItemTax,cTaxSubtotal)
		cDiscSubtotal = 0.00
		cServSubtotal = 0.00
			
		// Log this
		Format sTmpFormat as "Issued 'Ticket' invoice type: Coupon ", gblsInvoiceNumEDI
		call logInfo(ERROR_LOG_FILE_NAME,sTmpFormat,TRUE,TRUE)
	
		// Get check number
		iCkNum = @CKNUM
		// series
		Format sTmpFormat as ""
									 
		iFCRID = @WSID
	EndIf						 
	
	if not iEDIDup_
		if not gbliUseEDI						 
			Call SaveInvoiceInfoInDB(cSubtotal, cTaxSubtotal, cBurdenSubtotal, \
										 cExemptSubtotal, cDiscSubtotal, cServSubtotal, \
										 cFCRRoundingAdj, gblsFCRTotalAmount, gblsInvoiceNum, gblsFCRTotalAmount, \
										 sTransport, gblsInvoiceNum, gblsInvoiceNum, INV_TYPE_BOLETA, 1, iCkNum, iFCRID)
		else
			Call SaveInvoiceInfoInDB(cSubtotal, cTaxSubtotal, cBurdenSubtotal, \
										 cExemptSubtotal, cDiscSubtotal, cServSubtotal, \
										 cFCRRoundingAdj, gblsFCRTotalAmount, gblsInvoiceNumEDI, gblsFCRTotalAmount, \
										 sTransport, gblsInvoiceNumEDI, gblsInvoiceNumEDI, gbliInvoiceType, 1, iCkNum, iFCRID)
		endif
	endif

	// return "OK" for FCR status
	iFCRStatusOK_ = giFCROK

EndSub

//******************************************************************
// Procedure: getMITax()
// Author: Alex Vidal
// Purpose: Returns the Tax amount and rate for the specified Menu 
//			Item
// Parameters:
//	 - TaxVal_ = Returned Tax amount for specified MI
//  - TaxRate_ = Returned Tax Rate for specified MI
//  - iMIIndex_ = @DTL[] array index for the item whose info will
//				  		be read in order to check its taxes
//
//******************************************************************
Sub getMITax(ref TaxVal_, ref TaxRate_, var iMIIndex_ : N5)

	Var sCurRate		: A12
	Var sTaxType		: A2
	Var sTaxText1		: A12
	Var sTaxText2		: A12
	Var sTaxFactor		: A12
	var cTaxTtl			: $12
	var iHit				: N1 = FALSE
	Var i					: N8  // for looping
	

	//Get the taxtype for the specified MI
	sTaxType = @dtl_TaxType[iMIIndex_]				
	
	// Cycle through all taxes
	For i = 1 to MAX_TAX_NUM
		If bit( sTaxType, i) = TRUE

			//get the taxz rate
			sCurRate = @TaxRate[i]

			// allow only 2 decimals in the taxtotal
			split sCurRate, ".", sTaxText1, sTaxText2
			format sTaxText2 as Mid(sTaxText2, 1, 2)

			// set only the first tax rate found
			If Not iHit
				format TaxRate_ as sTaxText1{02}, ".", sTaxText2{02}
			EndIf
			
			if gbliTaxIsInclusive
				//convert to easy calculating tax factor.
				format sTaxFactor as "1.", sTaxText1{02}, sTaxText2{02}
				// accumulate current tax amount for MI
				//cTaxTtl = cTaxTtl + (Abs(@Dtl_ttl[iMIIndex_]) - ( Abs(@Dtl_ttl[iMIIndex_]) / sTaxFactor ))
				
				cTaxTtl = cTaxTtl + (Abs(@Dtl_ttl[iMIIndex_]) - ( Abs(@Dtl_ttl[iMIIndex_]) * 100 / (100 + @TaxRate[i])))
			else
				//convert to easy calculating tax factor.
				format sTaxFactor as "0.", sTaxText1{02}, sTaxText2{02}
				// accumulate current tax amount for MI
				cTaxTtl = cTaxTtl + (Abs(@Dtl_ttl[iMIIndex_]) * (100/ @TaxRate[i]) )
			endif
			
			// set flag that at least 1 tax was found for current MI!
			iHit = TRUE
			
		EndIf
	EndFor
	
	// Return Tax amount for current MI
	
	If Not iHit  
		// MI is Tax exempt
		TaxVal_ = 0.00
		format TaxRate_ as "00.00"

	Else
		TaxVal_ = cTaxTtl

	EndIf

EndSub

//******************************************************************
// Procedure: getDS_SVTax()
// Author: Alex Vidal
// Purpose: Returns the Tax amount and rate for the specified 
//				Discount/Service
// Parameters:
//	 - TaxVal_ = Returned Tax amount for specified MI
//  - iIndex_ = @DTL[] array index for the item whose info will
//				  		be read in order to check its taxes
//******************************************************************
Sub getDS_SVTax(ref TaxVal_, var iIndex_ : N5)

	Var sCurRate		: A12
	Var sTaxType		: A2
	Var sTaxText1		: A12
	Var sTaxText2		: A12
	Var sTaxFactor		: A12
	var cTaxTtl			: $12
	var iHit				: N1 = FALSE
	Var i					: N8  // for looping
	

	
	//Get the taxtype for the specified MI
	sTaxType = @dtl_TaxType[iIndex_]
	
	// Cycle through all taxes
	For i = 1 to MAX_TAX_NUM
		If bit( sTaxType, i) = TRUE
			//get the taxz rate
			sCurRate = @TaxRate[i]
			
			// allow only 2 decimals in the taxtotal
			split sCurRate, ".", sTaxText1, sTaxText2
			format sTaxText2 as Mid(sTaxText2, 1, 2)
			
			//convert to easy calculating tax factor.
			Format sTaxFactor as "0.", sTaxText1{02}, sTaxText2{02}
			// accumulate current tax amount for MI
			if gbliTaxIsInclusive
				cTaxTtl = cTaxTtl + (Abs(@Dtl_ttl[iIndex_]) - ( Abs(@Dtl_ttl[iIndex_]) * 100 / (100 + @TaxRate[i])))
				//cTaxTtl = cTaxTtl + (@DTL_TTL[iIndex_] * sTaxFactor )
			else
				cTaxTtl = cTaxTtl + (Abs(@Dtl_ttl[iIndex_]) * (100/ @TaxRate[i]) )
			endif
			// set flag that at least 1 tax was found for current MI!
			iHit = TRUE
		EndIf
	Endfor

	
	// Return Tax amount for current MI
	
	If Not iHit  
		// MI is Tax exempt
		TaxVal_ = 0.00
	Else
		TaxVal_ = cTaxTtl
	EndIf

EndSub

//******************************************************************
// Procedure: checkForTicketInvType()
// Author: Alex Vidal
// Purpose: Returns if a Ticket invoice should be printed instead
//					of the standard coupon
// Parameters:
//  - TN_ObjNum_ = Saved, grouped Tender object numbers array
//  - TN_Ttl_ = Saved, grouped Tender totals array
//  - TN_Count_ = Currently saved and grouped Tenders array length
//  - iPrintAltTicketInv_ = TRUE if a Ticket invoice type should be
//									 printed
//	 - iPrintCoupon_ = TRUE if coupon should be sent to printer
//	 - cTicketTndrSubTtl_ = returns total amount for Ticket tenders
//	 - cStdrTndrSubTtl_ = returns total amount for tenders other 
//								 than tickets
//******************************************************************
Sub checkForTicketInvType( ref TN_ObjNum_[], ref TN_Ttl_[], var TN_Count_ : N5, \
									ref iPrintAltTicketInv_, ref iPrintCoupon_, \
									ref cTicketTndrSubTtl_, ref cStdrTndrSubTtl_)
														
	var i						: N9														
	
	
	cStdrTndrSubTtl_		= 0.00
	cTicketTndrSubTtl_	= 0.00
	
																											
	if gbliTicketInvActive
	
		// get totals for standard tenders and ticket tenders
		
		for i = 1 to TN_Count_
			if TN_ObjNum_[i] >= gbliTicketMinTndObjNum and \
					TN_ObjNum_[i] <= gbliTicketMaxTndObjNum
					
				// Ticket tender
				cTicketTndrSubTtl_ = cTicketTndrSubTtl_ + TN_Ttl_[i]
			else
				
				// Standard tender
				cStdrTndrSubTtl_ = cStdrTndrSubTtl_ + TN_Ttl_[i]
			endif
		endfor
		
		if cTicketTndrSubTtl_ <= 0.00
			iPrintAltTicketInv_ = FALSE
			iPrintCoupon_ = TRUE
		elseif cTicketTndrSubTtl_ > 0.00 and cStdrTndrSubTtl_ > 0.00
			iPrintAltTicketInv_ = TRUE
			iPrintCoupon_ = TRUE
		elseif cTicketTndrSubTtl_ > 0.00 and cStdrTndrSubTtl_ = 0.00
			iPrintAltTicketInv_ = TRUE
			iPrintCoupon_ = FALSE
		endif
		
	else

		// ticket printing is disabled
		iPrintAltTicketInv_ = FALSE
		iPrintCoupon_ = TRUE
	endif
			
EndSub

//******************************************************************
// Procedure: checkTndrRnd()
// Author: Alex Vidal
// Purpose: Checks if rounding has been applied to the Tender in a
//			check, verifying that the total tendered amount
//			won't be less that the total due. If so, the difference
//			is returned and the "bTndrRndDiff_" parameter is set
//			to TRUE
// Parameters:
//	- cTotal_ = Current Check total (Total Due)
// - TN_Ttl_ = Saved, grouped Tenders array
// - TN_Count_ = Currently saved and grouped Tenders array Index
// - bTndrRndDiff_ = TRUE if a Difference between Tender total 
//					  		and Total Due exists. FALSE if otherwise
//	- cDifference_ = Difference between Tender total and Total 
//					  		Due (if any)
//******************************************************************
Sub checkTndrRnd( ref cTotal_, ref TN_Ttl_[], var TN_Count_ : N5, \
				  		ref bTndrRndDiff_, ref cDifference_)

	var i				: N5  // for looping
	var cTndrAcumSub	: $12 = 0.00
	var cTmpDiff		: $12 = 0.00

	
	// get total tender amount
	For i = 1 to TN_Count_
		cTndrAcumSub = cTndrAcumSub + TN_Ttl_[i]
	Endfor

	// compare Tenders total against Total Due and
	// if a difference is found, act accordingly...
	cTmpDiff = cTotal_ - cTndrAcumSub
	
	If cTmpDiff > 0
		// Not enough Tendering to cover the Total due!
		// report difference!
		cDifference_ = cTmpDiff
		bTndrRndDiff_ = TRUE
	Else
		
		// All is well. It's OK if Tendered total
		// is more than Total Due (this procedure
		// will return there's no difference if
		// this is so)

		bTndrRndDiff_ = FALSE

	EndIf
	
EndSub

//******************************************************************
// Procedure: saveChkNumToFile()
// Author: Alex Vidal
// Purpose: Saves current check number to a file
// Parameters:
//******************************************************************
Sub saveChkNumToFile()

	var	fn	: N9


	if @WSTYPE = SAROPS
		FOpen fn, CHK_NUM_FILE_NAME, Write, local
	else
		FOpen fn, CHK_NUM_FILE_NAME, Write
	endif
	
	If fn <> 0
		Fwrite fn, @Cknum
		FClose fn
	Else
		ErrorMessage "Unable to open ", CHK_NUM_FILE_NAME, " file!"
	EndIf

EndSub

//******************************************************************
// Procedure: getChkNumFromFile()
// Author: Al Vidal
// Purpose: returns check number saved to a specific file
// Parameters:
//	- retVal_ = function's return value
//
//******************************************************************
Sub getChkNumFromFile( ref retVal_ )

	var	fn	: N9


	if @WSTYPE = SAROPS
		FOpen fn, CHK_NUM_FILE_NAME, Read, local
	else
		FOpen fn, CHK_NUM_FILE_NAME, Read
	endif
	
	If fn <> 0
		FRead fn, retVal_
		FClose fn
	Else
		ErrorMessage "Unable to open ", CHK_NUM_FILE_NAME, " file!"
	EndIf

EndSub

//******************************************************************
// Procedure: checkFCRCmdResponse()
// Author: Alex Vidal
// Purpose: Checks the Printer status and <Command Return> field 
//			for the last executed fiscal command. If an erroneous 
//			state is detected, user receives a specific warning
//			message.
// Parameters:
//	- iStatusOK_ = Function's return value 
//			     		(1 = OK | 0 = Critical error)
//	- ShowError_ = if TRUE, shows an error message when an 
//				   	erroneous state is found
//	- LogError_	= if TRUE, logs an error code when an erroneous
//				  	  state is found
//  - LowPaperIsCritical_ = if TRUE, a "Low Paper" error status
//						   		 is considered critical
//******************************************************************
Sub checkFCRCmdResponse( ref iStatusOK_, var ShowError_ : N1, var LogError_ : N1, var LowPaperIsCritical_ : N1 )
	
	var sTmp				: A2000
	var sLowPaperErr	: A10
	var sLowPaperErr2	: A10
	var sZRepNeeded	: A10
	
	
	Format sLowPaperErr as ETM88III_ERRCODE_PRNT_LOWPAPER
	Format sLowPaperErr2 as ETM88III_ERRCODE_HARDWARE, ETM88III_03ERRID_05
	Format sZRepNeeded as ETM88III_ERRCODE_FISCAL_DAY, ETM88III_08ERRID_04

	if giFCRError <> 0 or gsFCRCmdReturn <> ETM88III_ERRCODE_OK
		// An error was detected.
		
		if LogError_
			if @WSTYPE <> SAROPS
				Format sTmp as "FCR Error: ", gsFCRMsg, " | FPCmd: ", ETM88III_gblsPCmd, \
									" | FPResponse: ", gsFCRFPResponse
			else
				Format sTmp as "FCR Error: ", gsFCRMsg
			endif
			call logInfo(ERROR_LOG_FILE_NAME,sTmp,TRUE,TRUE)
		endif
		
		if ShowError_
			ErrorMessage gsFCRMsg
		endif
	endif
	
	if giFCRError <> 0
		iStatusOK_ = FALSE
		Return
	endif
	
	if gsFCRCmdReturn = ETM88III_ERRCODE_OK
		iStatusOK_ = TRUE
	else
		if gsFCRCmdReturn <> sLowPaperErr and gsFCRCmdReturn <> sLowPaperErr2
			iStatusOK_ = FALSE
			
			if gsFCRCmdReturn = sZRepNeeded
				// A Z report needs to be executed. Print one
				If ShowError_
					ErrorMessage "Se ejecutara un cierre Z"
				endif
				call PrintZReport()
			endif
			
		else
			// Low paper error. If critical, report as error
			if LowPaperIsCritical_
				iStatusOK_ = FALSE
			else
				iStatusOK_ = TRUE
			endif
		endif
	endif

EndSub

//******************************************************************
// Procedure: checkEDIPrinter()
// Author: C Sepulveda
// Purpose: Checks the Printer status for printing EDI Documents 
// Parameters:
//	- iStatusOK_ = Function's return value 
//			     		(1 = OK | 0 = Critical error)
//	- ShowError_ = if TRUE, shows an error message when an 
//				   	erroneous state is found
//	- LogError_	= if TRUE, logs an error code when an erroneous
//				  	  state is found
//  - LowPaperIsCritical_ = if TRUE, a "Low Paper" error status
//						   		 is considered critical
//******************************************************************
Sub checkEDIPrinter( ref iStatusOK_, var ShowError_ : N1, var LogError_ : N1, var LowPaperIsCritical_ : N1 )
	
	var sTmp				: A100
	var sTmp1				: A20
	var iStatusEDI	: N10
	var sErrMessage	: A100
	
	iStatusOK_ = TRUE
	
	if gblhEDI <> 0
  	DLLCall gblhESCPOS, GetStatus(ref sTmp)
  else
		errormessage "EDI DLL not initialized"
		iStatusOK_ = FALSE
		return
	endif
	
	iStatusEDI = sTmp
	
	if iStatusEDI = 0
		iStatusOK_ = TRUE
		return
	endif

	//Checking for Low Paper Status
	if (mid(sTmp,2,1) = "1")
		format sTmp1 as "Impresora sin Papel"
		iStatusOK_ = FALSE
	endif
	
	if ((mid(sTmp,1,1) = "1") and LowPaperIsCritical_ and iStatusOK_)
		format sTmp1 as "Poco Papel en Impresora"
		iStatusOK_ = FALSE
	endif
	
	if (mid(sTmp,3,1) = "1") and iStatusOK_
		format sTmp1 as "Error en mecanismo de Impresora"
		iStatusOK_ = FALSE
	endif
	
	if (mid(sTmp,4,1) = "1") and iStatusOK_
		format sTmp1 as "Error en guillotina de Impresora"
		iStatusOK_ = FALSE
	endif
	
	if (mid(sTmp,5,1) = "1") and iStatusOK_
		format sTmp1 as "Tapa de Impresora Abierta"
		iStatusOK_ = FALSE
	endif
	
	if (mid(sTmp,6,1) = "1") and iStatusOK_
		format sTmp1 as "Boton de avance Papel Presionado"
		iStatusOK_ = FALSE
	endif
	
	if (mid(sTmp,7,1) = "1") and iStatusOK_
		format sTmp1 as "Impresora sin Papel"
		iStatusOK_ = FALSE
	endif
	
	if (mid(sTmp,8,1) = "1") and iStatusOK_
		format sTmp1 as "Error en Impresora"
		iStatusOK_ = FALSE
	endif
	
	if (mid(sTmp,9,1) = "1") and iStatusOK_
		format sTmp1 as "Impresora OffLine"
		iStatusOK_ = FALSE
	endif
	
	if iStatusOK_ = FALSE
		if LogError_
			Format sTmp as "Printer Error: ", sTmp1
			call logInfo(ERROR_LOG_FILE_NAME,sTmp,TRUE,TRUE)
		endif
		
		if ShowError_
			ErrorMessage sTmp
		endif
	endif
EndSub

//******************************************************************
// Procedure: printGuestCheck()
// Author: Alex Vidal
// Purpose: Calls the necessary routines to print a Guest Check
//			for the current Check
// Parameters:
//******************************************************************
Sub printGuestCheck()

	var iFCROK	: N1 = FALSE
	var iAnswer	: N1


	// update prompt
	prompt "Imprimiendo pre-check..."

	// Print Guest Check in Fiscal Printer
	call PrintFCRGuestCheck(iFCROK)
	
	// update prompt
	prompt "Idle"

EndSub

//******************************************************************
// Procedure: printFCRBlankLine()
// Author: Alex Vidal
// Purpose: Prints a blank line in the Fiscal Printer (only valid
//			for use with Non-fiscal coupons).
// Parameters:
//******************************************************************
Sub printFCRBlankLine()

	call printFCRNonFiscalItem("")

EndSub

//******************************************************************
// Procedure: getTaxAmount()
// Author: Alex Vidal
// Purpose: Returns inclusive tax amount for a specified amount,
//					based on a given tax rate
// Parameters:
//	- cGrossAmount_ = amount to calculate tax from
//	- sTaxRate_	= Tax rate to be applied
//	- retVal_ = Function's return value
//
//******************************************************************
Sub getTaxAmount( var cGrossAmount_ : $12, var sTaxRate_ : A10, ref retVal_)

	var cTaxFactor	: $12
	
	
	// set tax factor
	cTaxFactor = sTaxRate_
	cTaxFactor = (cTaxFactor / 100)
	cTaxFactor = cTaxFactor + 100
	
	retVal_ = cGrossAmount_ - ((cGrossAmount_ * 100) / cTaxFactor)
	
EndSub

//******************************************************************
// Procedure: PrintFCRGuestCheck()
// Author: Al Vidal
// Purpose: Prints a Guest Check in the Fiscal Printer
// Parameters:
//	- iFCRStatusOK_ = Function's return value 
//					  (1 = OK | 0 = a critical error occurred)
//
//******************************************************************
Sub PrintFCRGuestCheck( ref iFCRStatusOK_ )

	var x				: N8  // for looping
	var y				: N8  // for looping
	var i				: N8  // for looping
	var fn			: N5  // for file manipulation

	var sTmpFormat	 : A100	// for formating Customer Receipt lines
	var sTmpFormat2 : A100	// for formating Customer Receipt lines
	var cTmpAmount	 : $12	// for saving temporary currency amounts
	var iNewItem	 : N1	// boolean for checking if there's a new
								// item to add in the consolidated group

	var MI_Qty[@Numdtlt]			:	N5			// Menu Item Grouped Quantities
	var MI_Name[@Numdtlt]		:	A24		// Menu Item Grouped Names
	var MI_Ttl[@Numdtlt]	 		:	$12		// Menu Item Grouped Totals
	var MI_Tax[@Numdtlt]	 		:  $12		// Menu Item Taxes amount
	var MI_ObjNum[@Numdtlt]		:  N7			// Menu Item Object Number
	var MI_MnuLvl[@Numdtlt]	 	:  N7			// Menu Item Menu level
	var MI_PrcLvl[@Numdtlt]	 	:  N7			// Menu Item Price level
	var MI_DefSeq[@Numdtlt]		:	N7			// Menu Item Definition Sequence
	var MI_UnitPrc[@Numdtlt] 	:  $12		// Menu Item Unit Price
	var MI_Count			 		:  N5 = 0	// Menu Item Counter
	var cMI_UnitPrc			 	:  $12
	var cMI_Tax				 		:  $12
	var sMI_TaxRate			 	:  A12

	var DS_Name[@Numdtlt]	 	:	A24		// Discount Grouped Names
	var DS_Ttl[@Numdtlt]	 		:	$12		// Discount Grouped Totals
	var DS_ObjNum[@Numdtlt]	 	:  N12		// Discount Object Number
	var DS_Count			 		:  N5 = 0	// Discount Counter
	var cDS_Tax				 		:  $12

	var SV_Name[@Numdtlt]	 	:	A24		// Service Grouped Names
	var SV_Ttl[@Numdtlt]	 		:	$12		// Service Grouped Totals
	var SV_Tax[@Numdtlt]	 		:  $12		// Service Taxes amount
	var SV_ObjNum[@Numdtlt]	 	:  N5			// Service Object Number
	var SV_Count			 		:  N5 = 0	// Service Counter
	var cSV_Tax				 		:  $12

	var TN_Name[@Numdtlt]	 	:	A24		// Tender Grouped Names
	var TN_Ttl[@Numdtlt]	 		:	$12		// Tender Grouped Totals
	var TN_ObjNum[@Numdtlt]	 	:  N5			// Tender Object Number
	var TN_Count			 		:  N5 = 0	// Tender Counter

	var cSubtotal			 		:  $12		// Subtotal (tax included | tax excluded) value for Check
	var cTaxSubtotal		 		:  $12		// Tax Subtotal value for Check
	var cDiscSubtotal		 		:  $12		// Discounts Subtotal value for Check
	var cServSubtotal		 		:  $12		// Services Subtotal value for Check
	var cServTaxSubtotal		 	:  $12		// Services Tax Subtotal value for Check
	var cTenderSubtotal		 	:  $12		// Tenders Subtotal value for Check
	var cTotal				 		:  $12	   // Total value for Check


	// init vars
	gbliFCRPrintedLines = 0


	// ***********************************************
	// Step #1
	// cycle through the check's items and group them
	// ***********************************************
	
	For x = 1 to @Numdtlt
 
		If Not @Dtl_is_void[x]

			If @Dtl_Type[x] = DT_MENU_ITEM

				// --------------------------------------
				//				Group MIs
				// --------------------------------------

				If @Dtl_Ttl[x] > 0
      
					iNewItem = TRUE	 // Initialize flag

					// Check to see if current "x" menu item (from outer loop) is 
					// in the MI_ "y" array. If so, consolidate its total into the current
					// "y" item. Otherwise, generate a new item in the "y" MI_ array.

					For y = 1 to MI_Count
					
						if Not bit(@Dtl_Typedef[x],DTL_ITEM_OPEN_PRICED) and \
							Not bit(@Dtl_Typedef[x],DTL_ITEM_IS_WEIGHED)
							
							If @Dtl_Objnum[x] = MI_ObjNum[y]	and @Dtl_Plvl[x] = MI_PrcLvl[y] and @DTL_DEFSEQ[x] = MI_DefSeq[y] and @DTL_MLVL[x] = MI_MnuLvl[y]
								MI_Qty[y] = MI_Qty[y] + @Dtl_Qty[x] // Acumulate Qty
								call getMITax(cMI_Tax,sMI_TaxRate,x)
								MI_Tax[y] = MI_Tax[y] + cMI_Tax		// Acumulate Tax
								// Acumulate Value
								if Not gbliTaxIsInclusive
									MI_Ttl[y] = MI_Ttl[y] + (@Dtl_ttl[x] + cMI_Tax) 
								else
									MI_Ttl[y] = MI_Ttl[y] + @DTL_TTL[x]
								endif
								iNewItem = FALSE // Don't add this item!
								Break
							Endif
							
						else
							// Weighed and open-priced items should not be 
							// accumulated (Unit prices may vary)
							Break
						endif

					EndFor

					If iNewItem
						// add a new item to the MI counter
						MI_Count = MI_Count + 1
						
						// Add a new item to the MI_ group array
						MI_Qty[MI_Count]  = @Dtl_Qty[x]
						MI_Name[MI_Count] = @Dtl_Name[x]
						Call getMITax(cMI_Tax, sMI_TaxRate, x)
						MI_Tax[MI_Count] = cMI_Tax
						if Not gbliTaxIsInclusive
							MI_Ttl[MI_Count] = (@Dtl_Ttl[x] + cMI_Tax)
						else
							MI_Ttl[MI_Count] = @DTL_TTL[x]
						endif
						MI_ObjNum[MI_Count] = @Dtl_Objnum[x]
						MI_MnuLvl[MI_Count] = @DTL_MLVL[x]
						MI_PrcLvl[MI_Count] = @DTL_PLVL[x]
						MI_DefSeq[MI_Count] = @DTL_DEFSEQ[x] 
						Call getMIUnitPrice(cMI_UnitPrc,x,MI_Tax[],MI_Count, TRUE)
						MI_UnitPrc[MI_Count] = cMI_UnitPrc
					EndIf

				EndIf

			ElseIf @Dtl_Type[x] = DT_DISCOUNT

				// --------------------------------------
				//				Group Discounts
				// --------------------------------------
      
				iNewItem = TRUE	 // Initialize flag

				// Check to see if current "x" Discount (from outer loop) is 
				// in the DS_ "y" array. If so, consolidate its total into the current
				// "y" Discount. Otherwise, generate a new Discount in the "y" DS_ array.

				For y = 1 to DS_Count

					If @Dtl_Objnum[x] = DS_ObjNum[y]

						Call getDS_SVTax(cDS_Tax, x)
						DS_Ttl[y] = DS_Ttl[y] + (@Dtl_ttl[x] + cDS_Tax) // Acumulate Value

						iNewItem = FALSE // Don't add this item!
						Break
					Endif

				EndFor

				If iNewItem
					// add a new item to the DS counter
					DS_Count = DS_Count + 1
					
					// Add a new item to the DS_ group array
					DS_Name[DS_Count] = @Dtl_Name[x]
					Call getDS_SVTax(cDS_Tax, x)
					DS_Ttl[DS_Count]  = (@DTL_TTL[x] + cDS_Tax)
					DS_ObjNum[DS_Count] = @Dtl_Objnum[x]

				EndIf

			ElseIf @Dtl_Type[x] = DT_SERVICE_CHARGE

				// --------------------------------------
				//				Group Services
				// --------------------------------------

				If @Dtl_Ttl[x] > 0
					iNewItem = TRUE	 // Initialize flag

					// Check to see if current "x" Service (from outer loop) is 
					// in the SV_ "y" array. If so, consolidate its total into the current
					// "y" Service. Otherwise, generate a new Service in the "y" SV_ array.

					For y = 1 to SV_Count

						If @Dtl_Objnum[x] = SV_ObjNum[y]

							Call getDS_SVTax(cSV_Tax, x)
							SV_Tax[y] = SV_Tax[y] + cSV_Tax // only valid for add-on taxes
							SV_Ttl[y] = SV_Ttl[y] + @DTL_TTL[x] // Acumulate Value

							iNewItem = FALSE // Don't add this item!
							Break
						Endif

					EndFor

					If iNewItem
						// add a new item to the SV counter
						SV_Count = SV_Count + 1
						
						// Add a new item to the SV_ group array
						SV_Name[SV_Count] = @Dtl_Name[x]
						Call getDS_SVTax(cSV_Tax, x)
						SV_Tax[SV_Count] = cSV_Tax // only valid for add-on taxes
						SV_Ttl[SV_Count]  = (@Dtl_Ttl[x])
						SV_ObjNum[SV_Count] = @Dtl_Objnum[x]

					EndIf
				EndIf

			ElseIf @Dtl_Type[x] = DT_TENDER

				// --------------------------------------
				//				Group Tenders
				// --------------------------------------
      
				If @Dtl_Ttl[x] > 0
					// This is a payment!

					iNewItem = TRUE	 // Initialize flag

					// Check to see if current "x" Tender (from outer loop) is 
					// in the TN_ "y" array. If so, consolidate its total into the current
					// "y" Tender. Otherwise, generate a new Tender in the "y" TN_ array.

					For y = 1 to TN_Count

						If @Dtl_Objnum[x] = TN_ObjNum[y]

							TN_Ttl[y] = TN_Ttl[y] + @Dtl_ttl[x] // Acumulate Value

							iNewItem = FALSE // Don't add this item!
							Break
						Endif

					EndFor

					If iNewItem
						// add a new item to the TN counter
						TN_Count = TN_Count + 1
						
						// Add a new item to the TN_ group array
						TN_Name[TN_Count] = @Dtl_Name[x]
						TN_Ttl[TN_Count]  = @Dtl_Ttl[x]
						TN_ObjNum[TN_Count] = @Dtl_Objnum[x]

					EndIf		
				EndIf
			EndIf
		EndIf
	EndFor


	// check if there are items to print
	If MI_Count <= 0	
		ErrorMessage "No hay items para imprimir."
		Return //  bail out!
	EndIf

	
	// ***********************************************
	// Step #2
	// calculate subtotals and totals
	// ***********************************************

	// get Tax subtotal
	Call getTaxesSubtotal(cTaxSubtotal)

	// get subtotal (MI array already contains tax for non-inclusive taxes)
	Call getCheckSubtotal(cSubtotal, MI_Ttl[], cTaxSubtotal, MI_Count, FALSE)

	// get Discounts subTotal
	call getDiscountSubtotal(cDiscSubtotal, DS_Ttl[], DS_Count)
	
	// get services' tax subtotal
	call getArraySubtotal(cServTaxSubtotal, SV_Tax[], SV_Count)

	// get TOTAL
	if gbliTaxIsInclusive
		cTotal = (cSubtotal + @Svc) + cDiscSubtotal
	else
		cTotal = (cSubtotal + (@SVC + cServTaxSubtotal)) + cDiscSubtotal
	endif


	// ***********************************************
	// Step #3
	// Open Non-Fiscal Coupon
	// ***********************************************

	call OpenFCRNonFiscalCoupon()
	call checkFCRCmdResponse(giFCROK, TRUE, TRUE, FALSE)
	// workaround TM-88III's non-fiscal doc 30-line limit
	call checkFCRGCLineLimitation()

	// ***********************************************
	// Step #4
	// Now that we have all the values we need, build
	// each command line that will be sent to the 
	// Fiscal Printer in order to print the current 
	// Guest Check
	// ***********************************************
	
	// ---------------------------------
	// format and print Header
	// ---------------------------------
	
	// print Guest Check Title...
	
	// -- set Text --
	format sTmpFormat as "************ PRE-CHECK ************"

	// -- Print title --
	call printFCRNonFiscalItem(sTmpFormat)
	call checkFCRCmdResponse(giFCROK, TRUE, TRUE, FALSE)

	// print blank line
	
	call printFCRBlankLine()
	call checkFCRCmdResponse(giFCROK, TRUE, TRUE, FALSE)

	// print configured Guest Check Header lines

	For i = 1 to MAX_HIL		
		// -- Print Header --
		if Trim(gblsHeaderInfoLines[i]) <> ""
			call printFCRNonFiscalItem(gblsHeaderInfoLines[i])
			call checkFCRCmdResponse(giFCROK, TRUE, TRUE, FALSE)
			// workaround TM-88III's non-fiscal doc 30-line limit
			call checkFCRGCLineLimitation()
		endif
	Endfor

	// print blank line
	
	call printFCRBlankLine()
	call checkFCRCmdResponse(giFCROK, TRUE, TRUE, FALSE)
	// workaround TM-88III's non-fiscal doc 30-line limit
	call checkFCRGCLineLimitation()


	// ---------------------------------
	// format and print Menu Items
	// ---------------------------------

	For i = 1 to MI_Count
	
		// -- set Qty --
		If MI_UnitPrc[i] > 0.00
			format sTmpFormat as MI_Qty[i]{>3}, ""{3}
		Else
			// shared item...
			format sTmpFormat as "cmpt. "
		EndIf
		
		// -- set description --
		format sTmpFormat as sTmpFormat, MI_Name[i]{20}
			
		// remove decimals from amount (if any) and set it
		call removeDecimals(MI_Ttl[i], sTmpFormat2)
		format sTmpFormat as sTmpFormat, " ", sTmpFormat2{>8}

		// -- Print item --
		call printFCRNonFiscalItem(sTmpFormat)
		call checkFCRCmdResponse(giFCROK, TRUE, TRUE, FALSE)
		// workaround TM-88III's non-fiscal doc 30-line limit
		call checkFCRGCLineLimitation()

	Endfor

	// print blank line

	Call printFCRBlankLine()
	Call checkFCRCmdResponse(giFCROK, TRUE, TRUE, FALSE)
	// workaround TM-88III's non-fiscal doc 30-line limit
	Call checkFCRGCLineLimitation()

	// ---------------------------------
	// format and print Services
	// ---------------------------------

	For i = 1 to SV_Count
		
		// -- set description --
		format sTmpFormat as SV_Name[i]{26}
			
		// remove decimals from amount (if any) and set it
		call removeDecimals((SV_Ttl[i] + SV_Tax[SV_Count]), sTmpFormat2)
		format sTmpFormat as sTmpFormat, " ", sTmpFormat2{>8}

		// -- Print service --
		call printFCRNonFiscalItem(sTmpFormat)
		call checkFCRCmdResponse(giFCROK, TRUE, TRUE, FALSE)
		// workaround TM-88III's non-fiscal doc 30-line limit
		call checkFCRGCLineLimitation()

		// Accumulate Services Subtotal
		cServSubtotal = cServSubtotal + SV_Ttl[i]

	EndFor

	// Add tip charge (if tip was paid as a Tender option bit)
	// and Charged tip has been configured to be posted to 
	// check totals

	If cServSubtotal <> @SVC
		if gbliInvoiceType = 0
			gbliInvoiceType = INV_TYPE_BOLETA
		endif
		If gbliAddChargedTipToTotal[gbliInvoiceType]
			// -- set description --
			format sTmpFormat as "Excedente"{26}
				
			// remove decimals from amount (if any) and set it
			cTmpAmount = (@Svc - cServSubtotal)
			call removeDecimals(cTmpAmount, sTmpFormat2)
			format sTmpFormat as sTmpFormat, " ", sTmpFormat2{>8}

			// -- Print tip ---
			call printFCRNonFiscalItem(sTmpFormat)
			call checkFCRCmdResponse(giFCROK, TRUE, TRUE, FALSE)
			// workaround TM-88III's non-fiscal doc 30-line limit
			call checkFCRGCLineLimitation()
		Else

			// Charged tip should not be posted to the
			// guest-check total. Subtract it from 
			// accumulated total
			cTotal = cTotal - (@Svc - cServSubtotal)
		EndIf
	EndIf

	// ---------------------------------
	// format and print Discounts
	// ---------------------------------

	For i = 1 to DS_Count
		
		// -- set description --
		format sTmpFormat as DS_Name[i]{26}
			
		// remove decimals from amount (if any) and set it
		call removeDecimals(DS_Ttl[i], sTmpFormat2)
		format sTmpFormat as sTmpFormat, " ", sTmpFormat2{>8}

		// -- Print Discount --
		call printFCRNonFiscalItem(sTmpFormat)
		call checkFCRCmdResponse(giFCROK, TRUE, TRUE, FALSE)
		// workaround TM-88III's non-fiscal doc 30-line limit
		call checkFCRGCLineLimitation()

	EndFor

	// ---------------------------------
	// format and print Tenders
	// ---------------------------------

	For i = 1 to TN_Count
		
		// -- set description --
		format sTmpFormat as TN_Name[i]{26}
			
		// remove decimals from amount (if any) and set it
		call removeDecimals(TN_Ttl[i], sTmpFormat2)
		format sTmpFormat as sTmpFormat, " ", sTmpFormat2{>8}

		// -- Print tender --
		call printFCRNonFiscalItem(sTmpFormat)
		call checkFCRCmdResponse(giFCROK, TRUE, TRUE, FALSE)
		// workaround TM-88III's non-fiscal doc 30-line limit
		call checkFCRGCLineLimitation()

		// Accumulate Tenders Subtotal
		cTenderSubtotal = cTenderSubtotal + TN_Ttl[i]

	EndFor

	// ---------------------------------
	// format and print Total
	// ---------------------------------
	
	// -- set description --
	format sTmpFormat as "TOTAL"{26}
	
	// substract any tenders posted to the
	// current Check from the Total amount
	cTotal = cTotal - cTenderSubtotal

	// remove decimals from amount (if any) and set it
	call removeDecimals(cTotal, sTmpFormat2)
	format sTmpFormat as sTmpFormat, " ", sTmpFormat2{>8}

	// -- Print Total --
	call printFCRNonFiscalItem(sTmpFormat)
	call checkFCRCmdResponse(giFCROK, TRUE, TRUE, FALSE)
	// workaround TM-88III's non-fiscal doc 30-line limit
	call checkFCRGCLineLimitation()

	// print blank line
	
	call printFCRBlankLine()
	call checkFCRCmdResponse(giFCROK, TRUE, TRUE, FALSE)

	// ---------------------------------
	// format and print Trailer
	// ---------------------------------

	For i = 1 to MAX_TIL		
		// -- Print Trailer --
		if Trim(gblsTrailerInfoLines[i]) <> ""
			call printFCRNonFiscalItem(gblsTrailerInfoLines[i])
			call checkFCRCmdResponse(giFCROK, TRUE, TRUE, FALSE)
			// workaround TM-88III's non-fiscal doc 30-line limit
			call checkFCRGCLineLimitation()
		endif
	Endfor


	// ***********************************************
	// Step #5
	// Close Non-Fiscal Coupon
	// ***********************************************

	call CloseFCRNonFiscalCoupon(TRUE)
	call checkFCRCmdResponse(giFCROK, TRUE, TRUE, FALSE)

EndSub

//******************************************************************
// Procedure: removeDecimals()
// Author: Alex Vidal
// Purpose: Returns the integer portion of the passed
//			currency and returns the new value in a string
// Parameters:
//	- cAmount_ = Value where decimals should be removed
//	- sCleanAmount_= Function's return value
//******************************************************************
Sub removeDecimals( var cAmount_ : $12, ref sCleanAmount_ )

	var iTmp	: N12

	// In order to remove the decimals, all we
	// have to do is cast the currency value
	// to an integer type
	
	iTmp = cAmount_

	// Return "clean" value
	format sCleanAmount_ as iTmp{+}

EndSub

//******************************************************************
// Procedure: removeDecimalSeparator()
// Author: Alex Vidal
// Purpose: Removes the decimal separator (".") from the passed
//			currency and returns the new value in a string
// Parameters:
//	- cAmount_ = Value where decimal separator should be removed
//	- sCleanAmount_= Function's return value
//  - iLength_ = Final length to be returned. if length is less, 
//				right-pads returned number with necessary amount of
//				zeroes
//******************************************************************
Sub removeDecimalSeparator( var cAmount_ : $12, ref sCleanAmount_, \
										var iLength_ : N4 )

	var i			: N4  // for looping
	var sTmp		: A12
	var sTmp2	: A12
	var sTmp3	: A12

	// cast "amount" to string
	format sTmp as cAmount_

	// Split the current amount
	split sTmp, ".", sTmp2, sTmp3

	// return amount without the decimal separator
	format sCleanAmount_ as sTmp2, sTmp3
	
	if Len(sCleanAmount_) > iLength_
		Format sTmp as Mid(sCleanAmount_,1,iLength_)
		Format sCleanAmount_ as sTmp
	else
		// pad with right zeroes (if necessary)
		For i = Len(sCleanAmount_) to (iLength_ - 1)
			format sCleanAmount_ as sCleanAmount_, "0"
		EndFor
	endif
	
EndSub

//******************************************************************
// Procedure: CheckForReprintingIssue()
// Author: Alex Vidal
// Purpose: Checks if item being currently printed in a reprinting
//				job hasn't already been printed. If so, voids the item
//				in the printer.
// Parameters:
//	- DtlType_ = Detail type
//	- CurrCalcVal_ = Current calculated subtotal (items, Disc. and
//					 		serv.) or Pending amount (Tenders only)
//	- Param1_ = Optional parameter 1
//	- Param2_ = Optional parameter 2
//	- Param3_ = Optional parameter 3
//	- Param4_ = Optional parameter 4
//
//******************************************************************
Sub CheckForReprintingIssue( var DtlType_ : A1, var CurrCalcVal_ : $12, \
										 var Param1_ : A40, var Param2_ : A40, \
										 var Param3_ : A40, var Param4_ : A40 )

	var cTmpSubtotal		: $12
	var cTmpPendAmount  	: $12
	var sTmpDesc			: A20

	
	If DtlType_ = DT_MENU_ITEM
		// get subtotal
		call getFCRSubtotal()
		cTmpSubtotal = gsFCRFieldInfo

		If cTmpSubtotal > CurrCalcVal_
			// Item has been printed twice. Void it!
			call printFCRFiscalItemVoid(Param1_,Param2_,Param3_,Param4_)
		EndIf

	ElseIf DtlType_ = DT_SERVICE_CHARGE

		// get subtotal
		cTmpSubtotal = gsFCRFieldInfo

		If cTmpSubtotal >  CurrCalcVal_
			// Service has been printed twice. Void it! (print a disc.)
			format sTmpDesc as "X ", mid(Param1_,1,18)
			call printFCRDiscount(sTmpDesc,Param2_)
		EndIf

	ElseIf DtlType_ = DT_DISCOUNT

		// get subtotal
		cTmpSubtotal = gsFCRFieldInfo

		If cTmpSubtotal <  CurrCalcVal_
			// Discount has been printed twice. Void it! (print a serv.)
			format sTmpDesc as "X ", mid(Param1_,1,18)
			call printFCRService(sTmpDesc,Param2_)
		EndIf

	ElseIf DtlType_ = DT_TENDER

		// get pending amount
		split gsFCRFieldInfo, ETM88III_COMMAND_FIELD_SEPARATOR, cTmpPendAmount

		If cTmpPendAmount < CurrCalcVal_
			// Tender has been printed twice. Void it!
			call printFCRTenderVoid(Param1_,Param2_)
		EndIf

	EndIf

EndSub

//******************************************************************
// Procedure: checkFCRGCLineLimitation()
// Author: Alex Vidal
// Purpose: Works around the TM-88III's non-fiscal doc 30-line 
//			limit.
// Parameters:
//******************************************************************
Sub checkFCRGCLineLimitation()

	
	// update printed-line counter
	gbliFCRPrintedLines = gbliFCRPrintedLines + 1
	
	// if we are near to printing 30 lines, close current
	// non-fiscal document and open it up again
	
	If gbliFCRPrintedLines > 27
		call CloseFCRNonFiscalCoupon(FALSE)
		call OpenFCRNonFiscalCoupon()

		// reset printed-lines counter
		gbliFCRPrintedLines = 0
	EndIf

EndSub

//******************************************************************
// Procedure: setFieldInfoInFCRCmd()
// Author: Alex Vidal
// Purpose: sets specified string into the FCR Command array
// Parameters:
//		- sStr_ = Specified string
//		- iOffset_ = Current FCR Command array offset
//		- iNewOffset_ = New FCR command Offset after adding string
//******************************************************************
Sub setFieldInfoInFCRCmd(var sStr_ : A500, var iOffset_ : N9, ref iNewOffset_)
	
	var i				: N9
	var iCurrChr	: N9 = 1
	
	
	for i = (iOffset_ + 1) to (iOffset_ + Len(sStr_))
		giFCRCmd[i] = Asc(Mid(sStr_,iCurrChr,1))
		iCurrChr = iCurrChr + 1
	endfor
	
	if i > iOffset_
		iNewOffset_ = (i - 1)
	else
		iNewOffset_ = iOffset_
	endif
	
EndSub

//******************************************************************
// Procedure: ForceClosureOnFiscalDoc()
// Author: Alex Vidal
// Purpose: Tries to close a Fiscal Document in progress
// Parameters:
//******************************************************************
Sub ForceClosureOnFiscalDoc()

	var iFiscalCouponStatus	: N1
	var sSubtotal				: A12
	var sPendingAmount		: A12
	var cTmpAmount[8]			: $12
	var iCkNum					: N4
	var iFCRID					: N6
	var sTransport				: A1 = NO_TRANSPORT
	var sTmp						: A10

	// Fiscal coupon status values...
	var FCS_ITEM_EMPTY	: N1 = 1
	var FCS_SUBTOT_SENT	: N1 = 2
	var FCS_DSCSRV_SENT	: N1 = 3
	var FCS_PYMNT_SENT	: N1 = 4
	var FCS_CLOSE_DOC		: N1 = 5


	// *******************************************
	// #1 Check the status of the currently open
	// Fiscal Coupon
	// *******************************************
	
	// Get subtotal for current open Fiscal Coupon
	call getFCRSubtotal()

	If gsFCRFieldInfo <> ""
		// set subtotal
		format sSubtotal as gsFCRFieldInfo	
		// set Fiscal Status...
		iFiscalCouponStatus = FCS_SUBTOT_SENT

	Else
		// Check possible returned errors and
		// set Fiscal Coupon status accordingly

		If gsFCRCmdReturn = ETM88III_ERRCODE_NA_BEFORE_ITEM
	
			// Items haven't been sent
			iFiscalCouponStatus = FCS_ITEM_EMPTY
	
		ElseIf gsFCRCmdReturn = ETM88III_ERRCODE_NA_AFTER_DSC

			// Discounts and/or Service charges have been sent
			iFiscalCouponStatus = FCS_DSCSRV_SENT

		ElseIf gsFCRCmdReturn = ETM88III_ERRCODE_NA_AFTER_PYMNT

			// Payments have been sent
			iFiscalCouponStatus = FCS_PYMNT_SENT

		EndIf	
	EndIf

	// *******************************************
	// #2 send commands depending on Fiscal 
	// Coupon status...
	// *******************************************
	
	If iFiscalCouponStatus = FCS_ITEM_EMPTY
		// Print a generic item
		Prompt "Enviando item generico..."
		call printFCRFiscalItem("Item generico (FC)", "1", "1", gblsDefaultTaxRate )
		
		// Get subtotal for current open Fiscal Coupon
		Prompt "Obteniendo subtotal..."
		call getFCRSubtotal()

		// set subtotal
		format sSubtotal as gsFCRFieldInfo

		// update Fiscal Coupon status
		iFiscalCouponStatus = FCS_SUBTOT_SENT
	EndIf

	If iFiscalCouponStatus = FCS_SUBTOT_SENT

		// send a tender with the subtotal amount
		Prompt "Enviando pago generico..."
		call printFCRTender("1", sSubtotal)

		// Payment is done. Update Fiscal Coupon
		// status
		iFiscalCouponStatus = FCS_CLOSE_DOC
	EndIf

	If iFiscalCouponStatus = FCS_DSCSRV_SENT or \
	   iFiscalCouponStatus = FCS_PYMNT_SENT

		// send a tender with a bogus amount in order
		// to get the current Fiscal Coupon pending
		// amount
		Prompt "Enviando pago generico..."
		call printFCRTender("1", "1")

		If gsFCRCmdReturn = ETM88III_ERRCODE_PYMNT_DONE

			// All payments are already set. Update 
			// Fiscal Coupon sstatus
			iFiscalCouponStatus = FCS_CLOSE_DOC

		ElseIf gsFCRCmdReturn = ETM88III_ERRCODE_OK

			// There's still some money left to pay.
			// Get pending amount and send a tender
			// with that amount in order to end the
			// payment stage...
			split gsFCRFieldInfo, ETM88III_COMMAND_FIELD_SEPARATOR, sPendingAmount
			Prompt "Enviando pago generico..."
			call printFCRTender("1", sPendingAmount)

			// Payment is done. Update Fiscal Coupon
			// status
			iFiscalCouponStatus = FCS_CLOSE_DOC

		EndIf
	EndIf

	If iFiscalCouponStatus = FCS_CLOSE_DOC

		// get Micros last emitted check number
		call getChkNumFromFile(iCkNum) 		

		// All is set. Close Fiscal Coupon
		Prompt "Finalizando cupon fiscal..."
		call CloseFCRCoupon(iCkNum, "0")
		call checkFCRCmdResponse(giFCROK, FALSE, TRUE, FALSE)	
	EndIf
	
	// Get FCR's "Numero de Caja" value
	Prompt "Obteniendo nro. de Caja..."
	Call getFCRFiscalizationData(iFCRID)

	
	// Check status...
	If not giFCROK	
		ErrorMessage "El documento fiscal no pudo cerrarse"
		ErrorMessage "Debera cerrarlo en forma manual"
	Else
		
		// Everything OK! Post information of closed check
		// to the DB

		cTmpAmount[1] = 0.00 // Subtotal
		cTmpAmount[2] = 0.00 // Tax Subtotal
		cTmpAmount[3] = 0.00 // Burden Subtotal
		cTmpAmount[4] = 0.00 // Exempt Subtotal
		cTmpAmount[5] = 0.00 // Discount Subtotal
		cTmpAmount[6] = 0.00 // Services Subtotal
		cTmpAmount[7] = 0.00 // Roundings Subtotal
		cTmpAmount[8] = gblsFCRTotalAmount // Total

		
		Call SaveInvoiceInfoInDB(cTmpAmount[1], cTmpAmount[2], cTmpAmount[3], \
										  cTmpAmount[4], cTmpAmount[5], cTmpAmount[6], \
										  cTmpAmount[7], cTmpAmount[8], gblsInvoiceNum, cTmpAmount[8], \
									 	  sTransport, gblsInvoiceNum, gblsInvoiceNum, INV_TYPE_BOLETA, \
									 	  2, iCkNum, iFCRID)

	EndIf

EndSub

//******************************************************************
// Procedure: getFCRPaymentID()
// Author: Alex Vidal
// Purpose: Returns the matching Fiscal Printer Payment ID for the
//			passed Tender Media Object number
// Parameters:
//	- TMObj_ = Tender Media Object number
//	- FCRPaymntID_ = returned Fiscal Printer Payment ID
//******************************************************************
Sub getFCRPaymentID( var TMObj_ : N7, ref FCRPaymntID_ )

	var i					: N5  // for looping
	var iObjFound		: N1 = FALSE
	var iCurrObjNum 	: N7   
	var iCurrTmdGrp 	: N7


	// Cycle through all Tenders specified in the 
	// .cfg file

	For i = 1 to MAX_DB_TENDERS
		
		If Trim(gblsDBTender[i]) <> ""
			// get Object Number from stored strings...
			split gblsDBTender[i], "=", iCurrObjNum, iCurrTmdGrp

			If TMObj_ =  iCurrObjNum
				// We found it!.
				
				// turn on "found" flag
				iObjFound = TRUE
				// Set the FCR id
				FCRPaymntID_ = iCurrTmdGrp

				Break  // Bail out

			EndIf
		EndIf

	EndFor

	// Check for no matches...
	If Not iObjFound
		// Default Payment FCR ID is "1"
		FCRPaymntID_ = 1
	EndIf

EndSub

//******************************************************************
// Procedure: getMicrosBizDate()
// Author: Alex Vidal
// Purpose: Returns the current Business Date
// Parameters:
//		- retVal_ = Function's return value
//******************************************************************
Sub getMicrosBizDate( ref retVal_ )

	var iDBOK			: N1
	var sSQLCmd			: A1000 = ""
	var sRecordData	: A1000 = ""
	var iRecordIdx		: N9
	var iAffectedRecs	: N9
	var sQueryRetCode	: A500 = ""
	var sSQLErr			: A500 = ""
	var sTmp				: A2000 = ""


	// check connection to DB
	call MDAD_checkConnection(iDBOK)

	if Not iDBOK
		retVal_ = ""
		Return //Bail out!
	endif
	
	// Get the current Micros Business Date
	if gbliDBType = SQLSERVER
		Format sSQLCmd as "SELECT CONVERT(varchar,BusinessDate,103) FROM PERIOD_INSTANCE"
	else
		format sSQLCmd as "SELECT TO_CHAR(BusinessDate,'DD/MM/YYYY') FROM PERIOD_INSTANCE"
	endif

	call MDAD_execSQL( MDAD_DBCMD_QUERY, MDAD_DB_QRYTYPE_READ, sSQLCmd, "", \
							 MDAD_DB_RCRDSET_TYPE_LOCAL, iAffectedRecs, sQueryRetCode)
	
	If sQueryRetCode = MDAD_RET_CODE_SUCCESS

		// Try to get first record (if any).
		call MDAD_getNextRec(sRecordData, iRecordIdx)
		
		If iRecordIdx <> -1
			// We have a record match. Retrieve its data.
			Split sRecordData, DB_REC_SEPARATOR, retVal_
		Else
			Format retVal_ as ""
		EndIf
	Else
		
		// An error occurred. Warn user and log error
		Format retVal_ as ""
		ErrorMessage "Ha ocurrido un error al querer consultar la BD!"
		call logInfo(ERROR_LOG_FILE_NAME,"Error while querying DB (getMicrosBizDate)",TRUE,TRUE)
		call logInfo(ERROR_LOG_FILE_NAME,sSQLCmd,TRUE,TRUE)
		call MDAD_getLastErrDesc(sSQLErr)
		format sTmp as sQueryRetCode, " | ", sSQLErr 
		call logInfo(ERROR_LOG_FILE_NAME,sTmp,TRUE,TRUE)
	EndIf

EndSub

//******************************************************************
// Procedure: PrintZReport()
// Author: Alex Vidal
// Purpose: Prints a "Z" report for the current PCWS
// Parameters:
//******************************************************************
Sub PrintZReport()

	var sTmpFormat	 : A100
	var sFCRCmd		 : A100
	var sFCRExt		 : A100


	// -- Reset Fields --
	Format gsFCRFieldInfo as ""
	Format gsFCRCmdReturn as ""
	
	if @WSTYPE <> SAROPS
		ClearArray giFCRCmd
			
		// -- Build command --
		giFCRCmd[1] = 8
		giFCRCmd[2] = 1
		giFCRCmd[3] = ETM88III_iCOMMAND_FIELD_SEPARATOR
		giFCRCmd[4] = 0
		giFCRCmd[5] = 0
			
		Call ETM88III_GenFiscCmd( giFCRError, gsFCRMsg, gsFCRCmdReturn, gsFCRFieldInfo, \
											giFCROpenDoc, giFCRCmd[], 5, gbliTmtPZR, gsFCRFPResponse)
	
	else
		Format sFCRCmd as Chr(8), Chr(1)
		Format sFCRExt as ETM88III_FCR_NULL_CHR, ETM88III_FCR_NULL_CHR
		DLLCall gblhFCR, epson_generic_fiscal_command(ref giFCRError, ref gsDrvFCRMsg, \
														  					ref gsFCRCmdReturn, \
														  					ref sFCRCmd, \
														  					ref sFCRExt, \
														  					ref gsFCRFieldInfo, \
														  					ref gsDrvFCRFiscalStatus)
		
		Call emulateETM88IIIcheckPrinterRespFunc(giFCRError, gsDrvFCRMsg, gsDrvFCRFiscalStatus, giFCROpenDoc, \
																gsFCRMsg, gsFCRCmdReturn)
	endif

EndSub

//******************************************************************
// Procedure: PrintCashierReport()
// Author: Alex Vidal
// Purpose: Prints a Cashier report ("X" report) for the current 
//			PCWS
// Parameters:
//******************************************************************
Sub PrintCashierReport()

	var sTmpFormat	 : A100
	var sFCRCmd		 : A100
	var sFCRExt		 : A100


	// -- Reset Fields --
	Format gsFCRFieldInfo as ""
	format gsFCRCmdReturn as ""

	if @WSTYPE <> SAROPS
		ClearArray giFCRCmd

		// -- Build command --
		giFCRCmd[1] = 8
		giFCRCmd[2] = 27
		giFCRCmd[3] = 2
		giFCRCmd[4] = ETM88III_iCOMMAND_FIELD_SEPARATOR
		giFCRCmd[5] = 0
		giFCRCmd[6] = 0
			
		Call ETM88III_GenFiscCmd( giFCRError, gsFCRMsg, gsFCRCmdReturn, gsFCRFieldInfo, \
											giFCROpenDoc, giFCRCmd[], 6, gbliTmtPXR, gsFCRFPResponse)
	else
		
		Format sFCRCmd as Chr(8), Chr(27), Chr(2)
		Format sFCRExt as ETM88III_FCR_NULL_CHR, ETM88III_FCR_NULL_CHR
		DLLCall gblhFCR, epson_generic_fiscal_command(ref giFCRError, ref gsDrvFCRMsg, \
														  					ref gsFCRCmdReturn, \
														  					ref sFCRCmd, \
														  					ref sFCRExt, \
														  					ref gsFCRFieldInfo, \
														  					ref gsDrvFCRFiscalStatus)
		
		Call emulateETM88IIIcheckPrinterRespFunc(giFCRError, gsDrvFCRMsg, gsDrvFCRFiscalStatus, giFCROpenDoc, \
																gsFCRMsg, gsFCRCmdReturn)
	endif

EndSub

//******************************************************************
// Procedure: OpenFCRNonFiscalCoupon()
// Author: Alex Vidal
// Purpose: Opens a Non-Fiscal Coupon in the Fiscal Printer
// Parameters:
//******************************************************************
Sub OpenFCRNonFiscalCoupon()

	var iLen				: N9
	var sFCRCmd			: A100
	var sFCRExt		 	: A100
	
	
	// -- Reset fields --
	Format gsFCRCmdReturn as ""

	// -- Set Field Info --
	format gsFCRFieldInfo as ETM88III_COMMAND_FIELD_SEPARATOR,"0", \
							 		 ETM88III_COMMAND_FIELD_SEPARATOR,"0"

	if @WSTYPE <> SAROPS
		ClearArray giFCRCmd

		// -- Build command --
		giFCRCmd[1] = 14
		giFCRCmd[2] = 1
		giFCRCmd[3] = ETM88III_iCOMMAND_FIELD_SEPARATOR
		giFCRCmd[4] = 0
		giFCRCmd[5] = 0
		Call setFieldInfoInFCRCmd(gsFCRFieldInfo,5,iLen)
		
		Call ETM88III_GenFiscCmd( giFCRError, gsFCRMsg, gsFCRCmdReturn, gsFCRFieldInfo, \
											giFCROpenDoc, giFCRCmd[], iLen, gbliTmtONFC, gsFCRFPResponse)
	
	else

		Format sFCRCmd as Chr(14), Chr(1)
		Format sFCRExt as ETM88III_FCR_NULL_CHR, ETM88III_FCR_NULL_CHR
		DLLCall gblhFCR, epson_generic_fiscal_command(ref giFCRError, ref gsDrvFCRMsg, \
														  					ref gsFCRCmdReturn, \
														  					ref sFCRCmd, \
														  					ref sFCRExt, \
														  					ref gsFCRFieldInfo, \
														  					ref gsDrvFCRFiscalStatus)
		
		Call emulateETM88IIIcheckPrinterRespFunc(giFCRError, gsDrvFCRMsg, gsDrvFCRFiscalStatus, giFCROpenDoc, \
																gsFCRMsg, gsFCRCmdReturn)
	endif

EndSub

//******************************************************************
// Procedure: CloseFCRNonFiscalCoupon()
// Author: Al Vidal
// Purpose: Closes a previously opened Non-Fiscal Coupon in
//			the Fiscal Printer
// Parameters:
//	- cutPaper_ = if TRUE, instructs the printer to auto-cut the
//				  non-fiscal document being closed.
//
//******************************************************************
Sub CloseFCRNonFiscalCoupon( var cutPaper_ : N1)

	var iLen				: N9
	var sFCRCmd			: A100
	var sFCRExt		 	: A100
	

	// -- Reset Fields --
	Format gsFCRCmdReturn as ""

	// -- Set Field Info --
	format gsFCRFieldInfo as ETM88III_COMMAND_FIELD_SEPARATOR, "0", \
							 		 ETM88III_COMMAND_FIELD_SEPARATOR, "", \
									 ETM88III_COMMAND_FIELD_SEPARATOR, "0", \
									 ETM88III_COMMAND_FIELD_SEPARATOR, "", \
									 ETM88III_COMMAND_FIELD_SEPARATOR, "0", \
									 ETM88III_COMMAND_FIELD_SEPARATOR, ""

	if @WSTYPE <> SAROPS
		ClearArray giFCRCmd
	
		// -- Build command --
		giFCRCmd[1] = 14
		giFCRCmd[2] = 6
		giFCRCmd[3] = ETM88III_iCOMMAND_FIELD_SEPARATOR
		giFCRCmd[4] = 0
		If cutPaper_ // set auto-cut options
			giFCRCmd[5] = 1
		else
			giFCRCmd[5] = 0
		endif
		Call setFieldInfoInFCRCmd(gsFCRFieldInfo,5,iLen)
	
		Call ETM88III_GenFiscCmd( giFCRError, gsFCRMsg, gsFCRCmdReturn, gsFCRFieldInfo, \
											giFCROpenDoc, giFCRCmd[], iLen, gbliTmtCNFC, gsFCRFPResponse)
	
	else
		
		Format sFCRCmd as Chr(14), Chr(6)
		If cutPaper_ // set auto-cut options
			Format sFCRExt as ETM88III_FCR_NULL_CHR, Chr(1)
		else
			Format sFCRExt as ETM88III_FCR_NULL_CHR, ETM88III_FCR_NULL_CHR
		endif
		
		DLLCall gblhFCR, epson_generic_fiscal_command(ref giFCRError, ref gsDrvFCRMsg, \
														  					ref gsFCRCmdReturn, \
														  					ref sFCRCmd, \
														  					ref sFCRExt, \
														  					ref gsFCRFieldInfo, \
														  					ref gsDrvFCRFiscalStatus)
		
		Call emulateETM88IIIcheckPrinterRespFunc(giFCRError, gsDrvFCRMsg, gsDrvFCRFiscalStatus, giFCROpenDoc, \
																gsFCRMsg, gsFCRCmdReturn)
	endif

EndSub

//******************************************************************
// Procedure: printFCRNonFiscalItem()
// Author: Alex Vidal
// Purpose: Prints a Non-Fiscal item in a Non-Fiscal Coupon
// Parameters:
//	- Text_ = Item text to print
//******************************************************************
Sub printFCRNonFiscalItem( var Text_ : A60 )

	var iLen				: N9
	var sFCRCmd			: A100
	var sFCRExt		 	: A100
	

	// -- Reset Fields --
	Format gsFCRCmdReturn as ""
	
	// -- set Field Info --
	format gsFCRFieldInfo as ETM88III_COMMAND_FIELD_SEPARATOR, \
							 			Text_{=42}
	
	if @WSTYPE <> SAROPS
		ClearArray giFCRCmd
							 			
		// -- Build command --
		giFCRCmd[1] = 14
		giFCRCmd[2] = 27
		giFCRCmd[3] = 2
		giFCRCmd[4] = ETM88III_iCOMMAND_FIELD_SEPARATOR
		giFCRCmd[5] = 0
		giFCRCmd[6] = 0
		Call setFieldInfoInFCRCmd(gsFCRFieldInfo,6,iLen)
	
		Call ETM88III_GenFiscCmd( giFCRError, gsFCRMsg, gsFCRCmdReturn, gsFCRFieldInfo, \
											giFCROpenDoc, giFCRCmd[], iLen, gbliTmtPNFI, gsFCRFPResponse)
	else
		
		Format sFCRCmd as Chr(14), Chr(27), Chr(2)
		Format sFCRExt as ETM88III_FCR_NULL_CHR, ETM88III_FCR_NULL_CHR
		DLLCall gblhFCR, epson_generic_fiscal_command(ref giFCRError, ref gsDrvFCRMsg, \
														  					ref gsFCRCmdReturn, \
														  					ref sFCRCmd, \
														  					ref sFCRExt, \
														  					ref gsFCRFieldInfo, \
														  					ref gsDrvFCRFiscalStatus)
		
		Call emulateETM88IIIcheckPrinterRespFunc(giFCRError, gsDrvFCRMsg, gsDrvFCRFiscalStatus, giFCROpenDoc, \
																gsFCRMsg, gsFCRCmdReturn)
	endif

EndSub

//******************************************************************
// Procedure: getFCRStatus()
// Author: Alex Vidal
// Purpose: Gets the Fiscal Printer's current status
// Parameters:
//******************************************************************
Sub getFCRStatus()

	var sFCRCmd			: A100
	var sFCRExt		 	: A100


	// -- Reset fields  --
	Format gsFCRFieldInfo as ""
	format gsFCRCmdReturn as ""

	if @WSTYPE <> SAROPS
		ClearArray giFCRCmd

		// -- Build command --
		giFCRCmd[1] = 0
		giFCRCmd[2] = 1
		giFCRCmd[3] = ETM88III_iCOMMAND_FIELD_SEPARATOR
		giFCRCmd[4] = 0
		giFCRCmd[5] = 0
	
		Call ETM88III_GenFiscCmd( giFCRError, gsFCRMsg, gsFCRCmdReturn, gsFCRFieldInfo, \
											giFCROpenDoc, giFCRCmd[], 5, gbliTmtGS, gsFCRFPResponse)
	else
		
		Format sFCRCmd as ETM88III_FCR_NULL_CHR, Chr(1)
		Format sFCRExt as ETM88III_FCR_NULL_CHR, ETM88III_FCR_NULL_CHR
		DLLCall gblhFCR, epson_generic_fiscal_command(ref giFCRError, ref gsDrvFCRMsg, \
														  					ref gsFCRCmdReturn, \
														  					ref sFCRCmd, \
														  					ref sFCRExt, \
														  					ref gsFCRFieldInfo, \
														  					ref gsDrvFCRFiscalStatus)
		
		Call emulateETM88IIIcheckPrinterRespFunc(giFCRError, gsDrvFCRMsg, gsDrvFCRFiscalStatus, giFCROpenDoc, \
																gsFCRMsg, gsFCRCmdReturn)
	endif

EndSub

//******************************************************************
// Procedure: getFCRSubtotal()
// Author: Alex Vidal
// Purpose: returns the subtotal value for the current Fiscal
//			Coupon (value is set in the "gsFCRFieldInfo" global 
//			var)
//******************************************************************
Sub getFCRSubtotal()

	var sFCRCmd			: A100
	var sFCRExt		 	: A100
		

	// -- Reset Fields --
	Format gsFCRFieldInfo as ""
	format gsFCRCmdReturn as ""
	
	if @WSTYPE <> SAROPS
		ClearArray giFCRCmd
	
		// -- Build command --
		giFCRCmd[1] = 10
		giFCRCmd[2] = 27
		giFCRCmd[3] = 3
		giFCRCmd[4] = ETM88III_iCOMMAND_FIELD_SEPARATOR
		giFCRCmd[5] = 0
		giFCRCmd[6] = 1
	
		Call ETM88III_GenFiscCmd( giFCRError, gsFCRMsg, gsFCRCmdReturn, gsFCRFieldInfo, \
											giFCROpenDoc, giFCRCmd[], 6, gbliTmtGST, gsFCRFPResponse)
	
	else
		
		Format sFCRCmd as Chr(10), Chr(27), Chr(3)
		Format sFCRExt as ETM88III_FCR_NULL_CHR, Chr(1)
		DLLCall gblhFCR, epson_generic_fiscal_command(ref giFCRError, ref gsDrvFCRMsg, \
														  					ref gsFCRCmdReturn, \
														  					ref sFCRCmd, \
														  					ref sFCRExt, \
														  					ref gsFCRFieldInfo, \
														  					ref gsDrvFCRFiscalStatus)
		
		Call emulateETM88IIIcheckPrinterRespFunc(giFCRError, gsDrvFCRMsg, gsDrvFCRFiscalStatus, giFCROpenDoc, \
																gsFCRMsg, gsFCRCmdReturn)
	endif
	

EndSub

//******************************************************************
// Procedure: getFCRCouponInfo()
// Author: Alex Vidal
// Purpose: Returns current fiscal coupon state
//	- retVal_ = Function's return value
//******************************************************************
Sub getFCRCouponInfo( ref retVal_ )

	var sTmpFormat	 	: A600
	var sFCRCmd			: A100
	var sFCRExt		 	: A100


	// -- Reset Fields --
	Format gsFCRFieldInfo as ""
	format gsFCRCmdReturn as ""
	
	if @WSTYPE <> SAROPS
		ClearArray giFCRCmd

		// -- Build command --
		giFCRCmd[1] = 10
		giFCRCmd[2] = 10
		giFCRCmd[3] = ETM88III_iCOMMAND_FIELD_SEPARATOR
		giFCRCmd[4] = 0
		giFCRCmd[5] = 0
	
		Call ETM88III_GenFiscCmd( giFCRError, gsFCRMsg, gsFCRCmdReturn, gsFCRFieldInfo, \
											giFCROpenDoc, giFCRCmd[], 5, gbliTmtGCI, gsFCRFPResponse)
	
	else
		
		Format sFCRCmd as Chr(10), Chr(10)
		Format sFCRExt as ETM88III_FCR_NULL_CHR, ETM88III_FCR_NULL_CHR
		DLLCall gblhFCR, epson_generic_fiscal_command(ref giFCRError, ref gsDrvFCRMsg, \
														  					ref gsFCRCmdReturn, \
														  					ref sFCRCmd, \
														  					ref sFCRExt, \
														  					ref gsFCRFieldInfo, \
														  					ref gsDrvFCRFiscalStatus)
		
		Call emulateETM88IIIcheckPrinterRespFunc(giFCRError, gsDrvFCRMsg, gsDrvFCRFiscalStatus, giFCROpenDoc, \
																gsFCRMsg, gsFCRCmdReturn)
	endif
	
	If gsFCRCmdReturn = ETM88III_ERRCODE_OK or gsFCRCmdReturn = ETM88III_ERRCODE_PRNT_LOWPAPER
		split gsFCRFieldInfo, ETM88III_COMMAND_FIELD_SEPARATOR, ,,,,,,,,,,,,retVal_
	else							
		
		// An error ocurred!
						
		if gsFCRFieldInfo <> ""
			// we got data in spite of the error
			split gsFCRFieldInfo, ETM88III_COMMAND_FIELD_SEPARATOR, ,,,,,,,,,,,,retVal_	
		else
			retVal_ = -1 // set return value
		endif
		
		// log returned error
		Format sTmpFormat as "getFCRCouponInfo() 'gsFCRCmdReturn' var returned '", \
							 gsFCRCmdReturn, "' error. Returned FieldInfo: ", gsFCRFieldInfo
		call logInfo(ERROR_LOG_FILE_NAME,sTmpFormat,TRUE,TRUE)
	EndIf

EndSub

//******************************************************************
// Procedure: getFCRFiscalizationData()
// Author: Alex Vidal
// Purpose: Returns fiscalization data from fiscal printer
//	- iFCRID_ = Returns FCR "Numero de Caja" value
//******************************************************************
Sub getFCRFiscalizationData( ref iFCRID_ )

	var sTmpFormat	 	: A600
	var sFCRCmd			: A100
	var sFCRExt		 	: A100


	// -- Reset Fields --
	Format gsFCRFieldInfo as ""
	format gsFCRCmdReturn as ""
	
	if @WSTYPE <> SAROPS
		ClearArray giFCRCmd

		// -- Build command --
		giFCRCmd[1] = 05
		giFCRCmd[2] = 07
		giFCRCmd[3] = ETM88III_iCOMMAND_FIELD_SEPARATOR
		giFCRCmd[4] = 0
		giFCRCmd[5] = 0
	
		Call ETM88III_GenFiscCmd( giFCRError, gsFCRMsg, gsFCRCmdReturn, gsFCRFieldInfo, \
											giFCROpenDoc, giFCRCmd[], 5, gbliTmtGFD, gsFCRFPResponse)
	
	else
		
		Format sFCRCmd as Chr(05), Chr(07)
		Format sFCRExt as ETM88III_FCR_NULL_CHR, ETM88III_FCR_NULL_CHR
		DLLCall gblhFCR, epson_generic_fiscal_command(ref giFCRError, ref gsDrvFCRMsg, \
														  					ref gsFCRCmdReturn, \
														  					ref sFCRCmd, \
														  					ref sFCRExt, \
														  					ref gsFCRFieldInfo, \
														  					ref gsDrvFCRFiscalStatus)
		
		Call emulateETM88IIIcheckPrinterRespFunc(giFCRError, gsDrvFCRMsg, gsDrvFCRFiscalStatus, giFCROpenDoc, \
																gsFCRMsg, gsFCRCmdReturn)
	endif
	
	If gsFCRCmdReturn = ETM88III_ERRCODE_OK or gsFCRCmdReturn = ETM88III_ERRCODE_PRNT_LOWPAPER
		split gsFCRFieldInfo, ETM88III_COMMAND_FIELD_SEPARATOR, ,,iFCRID_
	else							
		
		// An error ocurred!
						
		if gsFCRFieldInfo <> ""
			// we got data in spite of the error
			split gsFCRFieldInfo, ETM88III_COMMAND_FIELD_SEPARATOR, ,,iFCRID_
		else
			iFCRID_ = 0
		endif
		
		// log returned error
		Format sTmpFormat as "getFCRFiscalizationData() 'gsFCRCmdReturn' var returned '", \
							 gsFCRCmdReturn, "' error. Returned FieldInfo: ", gsFCRFieldInfo
		call logInfo(ERROR_LOG_FILE_NAME,sTmpFormat,TRUE,TRUE)
	EndIf

EndSub

//******************************************************************
// Procedure: printFCRFiscalItem()
// Author: Alex Vidal
// Purpose: Prints a Fiscal item in a Fiscal Coupon
// Parameters:
//	- Desc_ = Item description
//	- Qty_ = Item quantity
//	- UnitPrice_ = Item unit price
//	- TaxRate_ = Item tax rate
//******************************************************************
Sub printFCRFiscalItem(var Desc_ : A60, var Qty_ : A12, \
					   		var UnitPrice_ : A12, var TaxRate_ : A4)

	var iLen				: N9
	var sFCRCmd			: A100
	var sFCRExt		 	: A100
	
	
	// -- Reset Fields --
	Format gsFCRCmdReturn as ""

	// -- set optional parameters --
	format gsFCRFieldInfo as ETM88III_COMMAND_FIELD_SEPARATOR,"", \
								 		ETM88III_COMMAND_FIELD_SEPARATOR,"", \
								 		ETM88III_COMMAND_FIELD_SEPARATOR,"", \
								 		ETM88III_COMMAND_FIELD_SEPARATOR,"", \
								 		ETM88III_COMMAND_FIELD_SEPARATOR,"", \
								 		ETM88III_COMMAND_FIELD_SEPARATOR

	// -- Set description --
	format gsFCRFieldInfo as gsFCRFieldInfo, Trim(Desc_){20}, \
										ETM88III_COMMAND_FIELD_SEPARATOR
	// -- Set Qty --
	format gsFCRFieldInfo as gsFCRFieldInfo, Qty_, \
										"0000", \
										ETM88III_COMMAND_FIELD_SEPARATOR
	// -- set Unit price --
	format gsFCRFieldInfo as gsFCRFieldInfo, UnitPrice_, "0000", \
							 			ETM88III_COMMAND_FIELD_SEPARATOR
	// -- set tax rate --
	format gsFCRFieldInfo as gsFCRFieldInfo, TaxRate_
		
	if @WSTYPE <> SAROPS
		ClearArray giFCRCmd
		
		// -- Build command --
		giFCRCmd[1] = 10
		giFCRCmd[2] = 27
		giFCRCmd[3] = 2
		giFCRCmd[4] = ETM88III_iCOMMAND_FIELD_SEPARATOR
		if TaxRate_ <> "0000"
			giFCRCmd[5] = 0
		else
			giFCRCmd[5] = 1 // item is tax-exempt
		endif
		giFCRCmd[6] = 0
		Call setFieldInfoInFCRCmd(gsFCRFieldInfo,6,iLen)
	
		Call ETM88III_GenFiscCmd( giFCRError, gsFCRMsg, gsFCRCmdReturn, gsFCRFieldInfo, \
											giFCROpenDoc, giFCRCmd[], iLen, gbliTmtPFI, gsFCRFPResponse)
	
	else
		
		Format sFCRCmd as Chr(10), Chr(27), Chr(2)
		if TaxRate_ <> "0000"
			Format sFCRExt as ETM88III_FCR_NULL_CHR, ETM88III_FCR_NULL_CHR
		else
			Format sFCRExt as Chr(1), ETM88III_FCR_NULL_CHR
		endif
		
		DLLCall gblhFCR, epson_generic_fiscal_command(ref giFCRError, ref gsDrvFCRMsg, \
														  					ref gsFCRCmdReturn, \
														  					ref sFCRCmd, \
														  					ref sFCRExt, \
														  					ref gsFCRFieldInfo, \
														  					ref gsDrvFCRFiscalStatus)
		
		Call emulateETM88IIIcheckPrinterRespFunc(giFCRError, gsDrvFCRMsg, gsDrvFCRFiscalStatus, giFCROpenDoc, \
																gsFCRMsg, gsFCRCmdReturn)
	endif

EndSub

//******************************************************************
// Procedure: printFCRFiscalItemReturn()
// Author: Alex Vidal
// Purpose: Prints a "return" ("Bonificación") Fiscal item in a 
//				Fiscal Coupon
// Parameters:
//	- Desc_ = Item description
//	- Qty_ = Item quantity
//	- UnitPrice_ = Item unit price
//	- TaxRate_ = Item tax rate
//
//******************************************************************
Sub printFCRFiscalItemReturn(var Desc_ : A60, var Qty_ : A12, \
					   				var UnitPrice_ : A12, var TaxRate_ : A4)

	var iLen				: N9
	var sFCRCmd			: A100
	var sFCRExt		 	: A100
	
	
	// -- Reset Fields --
	Format gsFCRCmdReturn as ""

	// -- set optional parameters --
	format gsFCRFieldInfo as ETM88III_COMMAND_FIELD_SEPARATOR,"", \
								 		ETM88III_COMMAND_FIELD_SEPARATOR,"", \
								 		ETM88III_COMMAND_FIELD_SEPARATOR,"", \
								 		ETM88III_COMMAND_FIELD_SEPARATOR,"", \
								 		ETM88III_COMMAND_FIELD_SEPARATOR,"", \
								 		ETM88III_COMMAND_FIELD_SEPARATOR

	// -- Set description --
	format gsFCRFieldInfo as gsFCRFieldInfo, Trim(Desc_){20}, \
										ETM88III_COMMAND_FIELD_SEPARATOR
	// -- Set Qty --
	format gsFCRFieldInfo as gsFCRFieldInfo, Qty_, \
										"0000", \
										ETM88III_COMMAND_FIELD_SEPARATOR
	// -- set Unit price --
	format gsFCRFieldInfo as gsFCRFieldInfo, UnitPrice_, "0000", \
							 			ETM88III_COMMAND_FIELD_SEPARATOR
	// -- set tax rate --
	format gsFCRFieldInfo as gsFCRFieldInfo, TaxRate_

	if @WSTYPE <> SAROPS
		ClearArray giFCRCmd
	
		// -- Build command --
		giFCRCmd[1] = 10
		giFCRCmd[2] = 27
		giFCRCmd[3] = 2
		giFCRCmd[4] = ETM88III_iCOMMAND_FIELD_SEPARATOR
		if TaxRate_ <> "0000"
			giFCRCmd[5] = 0
		else
			giFCRCmd[5] = 1 // item is tax-exempt
		endif
		giFCRCmd[6] = 4
		Call setFieldInfoInFCRCmd(gsFCRFieldInfo,6,iLen)
	
		Call ETM88III_GenFiscCmd( giFCRError, gsFCRMsg, gsFCRCmdReturn, gsFCRFieldInfo, \
											giFCROpenDoc, giFCRCmd[], iLen, gbliTmtPFI, gsFCRFPResponse)
	
	else
		
		Format sFCRCmd as Chr(10), Chr(27), Chr(2)
		if TaxRate_ <> "0000"
			Format sFCRExt as ETM88III_FCR_NULL_CHR, Chr(4)
		else
			Format sFCRExt as Chr(1), Chr(4)
		endif
		
		DLLCall gblhFCR, epson_generic_fiscal_command(ref giFCRError, ref gsDrvFCRMsg, \
														  					ref gsFCRCmdReturn, \
														  					ref sFCRCmd, \
														  					ref sFCRExt, \
														  					ref gsFCRFieldInfo, \
														  					ref gsDrvFCRFiscalStatus)
		
		Call emulateETM88IIIcheckPrinterRespFunc(giFCRError, gsDrvFCRMsg, gsDrvFCRFiscalStatus, giFCROpenDoc, \
																gsFCRMsg, gsFCRCmdReturn)
	endif								

EndSub


//******************************************************************
// Procedure: printFCRFiscalItemVoid()
// Author: Alex Vidal
// Purpose: Prints a voided Fiscal item in a Fiscal Coupon
// Parameters:
//	- Desc_ = Item description
//	- Qty_ = Item quantity
//	- UnitPrice_ = Item unit price
//	- TaxRate_ = Item tax rate
//******************************************************************
Sub printFCRFiscalItemVoid(var Desc_ : A60, var Qty_ : A12, \
					   			var UnitPrice_ : A12, var TaxRate_ : A4)

	var iLen				: N9
	var sFCRCmd			: A100
	var sFCRExt		 	: A100
	
	
	// -- Reset Fields --
	Format gsFCRCmdReturn as ""

	// -- set optional parameters --
	format gsFCRFieldInfo as ETM88III_COMMAND_FIELD_SEPARATOR,"", \
									 ETM88III_COMMAND_FIELD_SEPARATOR,"", \
									 ETM88III_COMMAND_FIELD_SEPARATOR,"", \
									 ETM88III_COMMAND_FIELD_SEPARATOR,"", \
									 ETM88III_COMMAND_FIELD_SEPARATOR,"", \
									 ETM88III_COMMAND_FIELD_SEPARATOR

	// -- Set description --
	format gsFCRFieldInfo as gsFCRFieldInfo, Trim(Desc_){20}, \
										ETM88III_COMMAND_FIELD_SEPARATOR
	// -- Set Qty --
	format gsFCRFieldInfo as gsFCRFieldInfo, Qty_, \
									 "0000", \
									 ETM88III_COMMAND_FIELD_SEPARATOR
	// -- set Unit price --
	format gsFCRFieldInfo as gsFCRFieldInfo, UnitPrice_, "0000", \
							 			ETM88III_COMMAND_FIELD_SEPARATOR
	// -- set tax rate --
	format gsFCRFieldInfo as gsFCRFieldInfo, TaxRate_

	if @WSTYPE <> SAROPS
		ClearArray giFCRCmd
			
		// -- Build command --
		giFCRCmd[1] = 10
		giFCRCmd[2] = 27
		giFCRCmd[3] = 2
		giFCRCmd[4] = ETM88III_iCOMMAND_FIELD_SEPARATOR
		if TaxRate_ <> "0000"
			giFCRCmd[5] = 0
		else
			giFCRCmd[5] = 1 // item is tax-exempt
		endif
		giFCRCmd[6] = 1
		Call setFieldInfoInFCRCmd(gsFCRFieldInfo,6,iLen)
		
		Call ETM88III_GenFiscCmd( giFCRError, gsFCRMsg, gsFCRCmdReturn, gsFCRFieldInfo, \
											giFCROpenDoc, giFCRCmd[], iLen, gbliTmtPFI, gsFCRFPResponse)
	else
		
		Format sFCRCmd as Chr(10), Chr(27), Chr(2)
		if TaxRate_ <> "0000"
			Format sFCRExt as ETM88III_FCR_NULL_CHR, Chr(1)
		else
			Format sFCRExt as Chr(1), Chr(1)
		endif
		
		DLLCall gblhFCR, epson_generic_fiscal_command(ref giFCRError, ref gsDrvFCRMsg, \
														  					ref gsFCRCmdReturn, \
														  					ref sFCRCmd, \
														  					ref sFCRExt, \
														  					ref gsFCRFieldInfo, \
														  					ref gsDrvFCRFiscalStatus)
		
		Call emulateETM88IIIcheckPrinterRespFunc(giFCRError, gsDrvFCRMsg, gsDrvFCRFiscalStatus, giFCROpenDoc, \
																gsFCRMsg, gsFCRCmdReturn)
	endif

EndSub

//******************************************************************
// Procedure: printFCRTender()
// Author: Alex Vidal
// Purpose: Prints a Tender in a Fiscal Coupon
// Parameters:
//	- PaymentID_ = Payment FCR ID
//	- Amount_ = Payment amount
//******************************************************************
Sub printFCRTender( var PaymentID_ : A60, var Amount_ : A12 )

	var iLen				: N9
	var sFCRCmd			: A100
	var sFCRExt		 	: A100
	
	
	// -- Reset Fields --
	Format gsFCRCmdReturn as ""

	// -- set Payment ID --
	format gsFCRFieldInfo as ETM88III_COMMAND_FIELD_SEPARATOR, \
							 			PaymentID_, \
							 			ETM88III_COMMAND_FIELD_SEPARATOR
	// -- set amount --
	format gsFCRFieldInfo as gsFCRFieldInfo, Amount_
	
	if @WSTYPE <> SAROPS
		ClearArray giFCRCmd
	
		// -- Build command --
		giFCRCmd[1] = 10
		giFCRCmd[2] = 5
		giFCRCmd[3] = ETM88III_iCOMMAND_FIELD_SEPARATOR
		giFCRCmd[4] = 0
		giFCRCmd[5] = 0
		Call setFieldInfoInFCRCmd(gsFCRFieldInfo,5,iLen)
	
		Call ETM88III_GenFiscCmd( giFCRError, gsFCRMsg, gsFCRCmdReturn, gsFCRFieldInfo, \
											giFCROpenDoc, giFCRCmd[], iLen, gbliTmtPFT, gsFCRFPResponse)
	else
		
		Format sFCRCmd as Chr(10), Chr(5)
		Format sFCRExt as ETM88III_FCR_NULL_CHR, ETM88III_FCR_NULL_CHR
		DLLCall gblhFCR, epson_generic_fiscal_command(ref giFCRError, ref gsDrvFCRMsg, \
														  					ref gsFCRCmdReturn, \
														  					ref sFCRCmd, \
														  					ref sFCRExt, \
														  					ref gsFCRFieldInfo, \
														  					ref gsDrvFCRFiscalStatus)
		
		Call emulateETM88IIIcheckPrinterRespFunc(giFCRError, gsDrvFCRMsg, gsDrvFCRFiscalStatus, giFCROpenDoc, \
																gsFCRMsg, gsFCRCmdReturn)
	endif

EndSub

//******************************************************************
// Procedure: printFCRTenderVoid()
// Author: Alex Vidal
// Purpose: Prints a voided Tender in a Fiscal Coupon
// Parameters:
//	- PaymentID_ = Payment FCR ID
//	- Amount_ = Payment amount
//******************************************************************
Sub printFCRTenderVoid( var PaymentID_ : A60, var Amount_ : A12 )

	var iLen				: N9
	var sFCRCmd			: A100
	var sFCRExt		 	: A100
	
	
	// -- Reset Fields --
	Format gsFCRCmdReturn as ""

	// -- set Payment ID --
	format gsFCRFieldInfo as ETM88III_COMMAND_FIELD_SEPARATOR, \
							 			PaymentID_, \
							 			ETM88III_COMMAND_FIELD_SEPARATOR
	// -- set amount --
	format gsFCRFieldInfo as gsFCRFieldInfo, Amount_
	
	if @WSTYPE <> SAROPS
		ClearArray giFCRCmd
	
		// -- Build command --
		giFCRCmd[1] = 10
		giFCRCmd[2] = 5
		giFCRCmd[3] = ETM88III_iCOMMAND_FIELD_SEPARATOR
		giFCRCmd[4] = 0
		giFCRCmd[5] = 1
		Call setFieldInfoInFCRCmd(gsFCRFieldInfo,5,iLen)
	
		Call ETM88III_GenFiscCmd( giFCRError, gsFCRMsg, gsFCRCmdReturn, gsFCRFieldInfo, \
											giFCROpenDoc, giFCRCmd[], iLen, gbliTmtPFT, gsFCRFPResponse)
	else
		
		Format sFCRCmd as Chr(10), Chr(5)
		Format sFCRExt as ETM88III_FCR_NULL_CHR, Chr(1)
		DLLCall gblhFCR, epson_generic_fiscal_command(ref giFCRError, ref gsDrvFCRMsg, \
														  					ref gsFCRCmdReturn, \
														  					ref sFCRCmd, \
														  					ref sFCRExt, \
														  					ref gsFCRFieldInfo, \
														  					ref gsDrvFCRFiscalStatus)
		
		Call emulateETM88IIIcheckPrinterRespFunc(giFCRError, gsDrvFCRMsg, gsDrvFCRFiscalStatus, giFCROpenDoc, \
																gsFCRMsg, gsFCRCmdReturn)
	endif

EndSub

//******************************************************************
// Procedure: CloseFCRCoupon()
// Author: Alex Vidal
// Purpose: Closes a previously opened Fiscal Coupon (invoice) in
//			the Fiscal Printer
// Parameters:
//	- iCkNum_ = Micros check number
//	- sTblNum_ = Micros table number
//******************************************************************
Sub CloseFCRCoupon( var iCkNum_ : N4, var sTblNum_ : A10  )

	var sTmpFormat	 	: A600
	var iLen				: N9
	var sFCRCmd			: A100
	var sFCRExt		 	: A100
	
	
	// -- Reset Fields --
	Format gsFCRCmdReturn as ""
	
	// set Check ID line (if any)
	If trim(@Ckid) <> ""
		Format sTmpFormat as "Chk ID: ", trim(@Ckid)
	EndIF

	// -- Set Field Info --
	format gsFCRFieldInfo as ETM88III_COMMAND_FIELD_SEPARATOR, "7", \
									 ETM88III_COMMAND_FIELD_SEPARATOR, \
									 "Chk: ", iCkNum_, "   Term.: ", @Wsid, \
									 ETM88III_COMMAND_FIELD_SEPARATOR, "8", \
									 ETM88III_COMMAND_FIELD_SEPARATOR, \
									 "Empleado: ", @Tremp, "  Mesa: ", sTblNum_, \
									 ETM88III_COMMAND_FIELD_SEPARATOR, "9", \
									 ETM88III_COMMAND_FIELD_SEPARATOR, \
									 sTmpFormat
	
	if @WSTYPE <> SAROPS
		ClearArray giFCRCmd
			
		// -- Build command --
		giFCRCmd[1] = 10
		giFCRCmd[2] = 6
		giFCRCmd[3] = ETM88III_iCOMMAND_FIELD_SEPARATOR
		giFCRCmd[4] = 0
		giFCRCmd[5] = 1
		Call setFieldInfoInFCRCmd(gsFCRFieldInfo,5,iLen)
	
		Call ETM88III_GenFiscCmd( giFCRError, gsFCRMsg, gsFCRCmdReturn, gsFCRFieldInfo, \
											giFCROpenDoc, giFCRCmd[], iLen, gbliTmtCFC, gsFCRFPResponse)
	else
		
		Format sFCRCmd as Chr(10), Chr(6)
		Format sFCRExt as ETM88III_FCR_NULL_CHR, Chr(1)
		DLLCall gblhFCR, epson_generic_fiscal_command(ref giFCRError, ref gsDrvFCRMsg, \
														  					ref gsFCRCmdReturn, \
														  					ref sFCRCmd, \
														  					ref sFCRExt, \
														  					ref gsFCRFieldInfo, \
														  					ref gsDrvFCRFiscalStatus)
		
		Call emulateETM88IIIcheckPrinterRespFunc(giFCRError, gsDrvFCRMsg, gsDrvFCRFiscalStatus, giFCROpenDoc, \
																gsFCRMsg, gsFCRCmdReturn)
	endif
	

	If gsFCRCmdReturn = ETM88III_ERRCODE_OK or gsFCRCmdReturn = ETM88III_ERRCODE_PRNT_LOWPAPER
		// Save returned data for closed coupon
		split gsFCRFieldInfo, ETM88III_COMMAND_FIELD_SEPARATOR, gblsInvoiceNum, gblsFCRTotalAmount, gblsFCRChange
	else													 
		Format sTmpFormat as "CloseFCRCoupon() 'gsFCRCmdReturn' var returned '", \
							 gsFCRCmdReturn, "' error. Returned FieldInfo: ", gsFCRFieldInfo
		call logInfo(ERROR_LOG_FILE_NAME,sTmpFormat,TRUE,TRUE)
	EndIf

EndSub

//******************************************************************
// Procedure: setFCRDateTime()
// Author: Alex Vidal
// Purpose: set a new date & time on fiscal printer
// Parameters:
//	- 
//******************************************************************
Sub setFCRDateTime()

	var sDate			: A40
	var sTime			: A40
	var iStatusOK		: N9
	var iLen				: N9
	var sFCRCmd			: A100
	var sFCRExt		 	: A100
	

	// prompt for date & time
	call valuePrompt( sDate, "Ingrese Fecha (DDMMAA)", TRUE)
	call valuePrompt( sTime, "Ingrese Hora (HHMMSS)", TRUE)
	
	if Len(sDate) <> 6 or Len(stime) <> 6
		ExitWithError "Los valores ingresados son invalidos"
	endif
	
	
	// -- Reset fields  --
	Format gsFCRFieldInfo as ""
	Format gsFCRCmdReturn as ""
	
	// set date & time
	format gsFCRFieldInfo as ETM88III_COMMAND_FIELD_SEPARATOR, \
									 sDate, \
									 ETM88III_COMMAND_FIELD_SEPARATOR, \
									 sTime

	if @WSTYPE <> SAROPS
		ClearArray giFCRCmd
			
		// -- Build command --
		giFCRCmd[1] = 5
		giFCRCmd[2] = 1
		giFCRCmd[3] = ETM88III_iCOMMAND_FIELD_SEPARATOR
		giFCRCmd[4] = 0
		giFCRCmd[5] = 0
		Call setFieldInfoInFCRCmd(gsFCRFieldInfo,5,iLen)
	
		Call ETM88III_GenFiscCmd( giFCRError, gsFCRMsg, gsFCRCmdReturn, gsFCRFieldInfo, \
											giFCROpenDoc, giFCRCmd[], iLen, gbliTmtSD, gsFCRFPResponse)
	else
		
		Format sFCRCmd as Chr(5), Chr(1)
		Format sFCRExt as ETM88III_FCR_NULL_CHR, ETM88III_FCR_NULL_CHR
		DLLCall gblhFCR, epson_generic_fiscal_command(ref giFCRError, ref gsDrvFCRMsg, \
														  					ref gsFCRCmdReturn, \
														  					ref sFCRCmd, \
														  					ref sFCRExt, \
														  					ref gsFCRFieldInfo, \
														  					ref gsDrvFCRFiscalStatus)
		
		Call emulateETM88IIIcheckPrinterRespFunc(giFCRError, gsDrvFCRMsg, gsDrvFCRFiscalStatus, giFCROpenDoc, \
																gsFCRMsg, gsFCRCmdReturn)
	endif												
												
	Call checkFCRCmdResponse(iStatusOK, TRUE, TRUE, TRUE)
	
EndSub

//******************************************************************
// Procedure: SetFCRPayments()
// Author: Alex Vidal
// Purpose: Sets the Payments for the Fiscal Printer used by the
//				current PCWS (Payments are stored in the Fiscal
//				Printer's memory). The payments are based on the
//				FCR_GROUPS defined in the .cfg file
//******************************************************************
Sub SetFCRPayments()

	var i			 		: N5  // for looping
	var sTmp		 		: A100 
	var sTmp2			: A100 
	var iLen				: N9
	var sFCRCmd			: A100
	var sFCRExt		 	: A100


	// Cycle through the payments array

	For i = 1 to MAX_FCR_TENDERS

		If gblsDBGrpTender[i] <> ""

			// Try to add current Tender to the fiscal printer memory

			// -- Reset Fields --
			format gsFCRCmdReturn as ""

			// -- set Payment ID --
			format gsFCRFieldInfo as ETM88III_COMMAND_FIELD_SEPARATOR, \
											 i, \
											 ETM88III_COMMAND_FIELD_SEPARATOR

			// -- set Payment description --
			split gblsDBGrpTender[i], "=", sTmp, sTmp2
			format gsFCRFieldInfo as gsFCRFieldInfo, Trim(sTmp2)
			
			Prompt "Dando de alta '", Trim(sTmp2), "'..."

			if @WSTYPE <> SAROPS				
				ClearArray giFCRCmd
				
				// -- Build command --
				giFCRCmd[1] = 5
				giFCRCmd[2] = 12
				giFCRCmd[3] = ETM88III_iCOMMAND_FIELD_SEPARATOR
				giFCRCmd[4] = 0
				giFCRCmd[5] = 0
				Call setFieldInfoInFCRCmd(gsFCRFieldInfo,5,iLen)
			
				Call ETM88III_GenFiscCmd( giFCRError, gsFCRMsg, gsFCRCmdReturn, gsFCRFieldInfo, \
													giFCROpenDoc, giFCRCmd[], iLen, gbliTmtSFP, gsFCRFPResponse)
			else
		
				Format sFCRCmd as Chr(5), Chr(12)
				Format sFCRExt as ETM88III_FCR_NULL_CHR, ETM88III_FCR_NULL_CHR
				DLLCall gblhFCR, epson_generic_fiscal_command(ref giFCRError, ref gsDrvFCRMsg, \
																  					ref gsFCRCmdReturn, \
																  					ref sFCRCmd, \
																  					ref sFCRExt, \
																  					ref gsFCRFieldInfo, \
																  					ref gsDrvFCRFiscalStatus)
		
				Call emulateETM88IIIcheckPrinterRespFunc(giFCRError, gsDrvFCRMsg, gsDrvFCRFiscalStatus, giFCROpenDoc, \
																		gsFCRMsg, gsFCRCmdReturn)
			endif												

			// check status...

			If giFCRError = 0
					
				If gsFCRCmdReturn = ETM88III_ERRCODE_OK or gsFCRCmdReturn = ETM88III_ERRCODE_PYMNT_EXISTS

					format sTmp as "Pago '", Trim(sTmp2), "' grabado con exito"
					InfoMessage "Carga de Tipos de Pagos", sTmp

				ElseIf gsFCRCmdReturn = ETM88III_ERRCODE_PYMNT_DEF_LIMIT
					// Maximum configurable payments limit has been 
					// reached! Warn user and exit routine

					ErrorMessage "El nro. maximo de Pagos configurables ha sido alcanzado."
					Return // bail out!
				
				ElseIf gsFCRCmdReturn <> ETM88III_ERRCODE_OK
					// an error ocurred. Log it!
					
					call checkFCRCmdResponse(giFCROK, TRUE, FALSE, FALSE)
					format sTmp as "FCR Error: ", gsFCRCmdReturn, " (Set FCR Pymnt)"
					call logInfo(ERROR_LOG_FILE_NAME,sTmp,TRUE,TRUE)

				EndIf

			Else
				// An internal FCR error ocurred! Warn user!
				ErrorMessage gsFCRMsg

				// Log error
				format sTmp as "FCR Error: ", gsFCRMsg, " (Set FCR Pymnt)"
				call logInfo(ERROR_LOG_FILE_NAME,sTmp,TRUE,TRUE)
				Return // bail out!

			EndIf

		EndIf
	
	EndFor

EndSub

//******************************************************************
// Procedure: getFCRPayments()
// Author: Alex Vidal
// Purpose: Returns the Payments currently loaded in the Fiscal 
//			Printer
// Parameters:
//******************************************************************
Sub getFCRPayments()

	var i									: N5  // for looping
	var sTmp								: A500
	var sPymnt[MAX_FCR_TENDERS]	: A100
	var iLen								: N9
	var sFCRCmd							: A100
	var sFCRExt		 					: A100


	// Cycle through the payments array

	For i = 1 to MAX_FCR_TENDERS

		// update prompt
		prompt "Obteniendo tipo de pago #", i, "/20..."

		// Get payment info for current payment (#i)

		// -- Reset Fields --
		format gsFCRCmdReturn as ""

		// -- set Payment ID --
		format gsFCRFieldInfo as ETM88III_COMMAND_FIELD_SEPARATOR, i

		if @WSTYPE <> SAROPS				
			ClearArray giFCRCmd
		
			// -- Build command --
			giFCRCmd[1] = 5
			giFCRCmd[2] = 13
			giFCRCmd[3] = ETM88III_iCOMMAND_FIELD_SEPARATOR
			giFCRCmd[4] = 0
			giFCRCmd[5] = 0
			Call setFieldInfoInFCRCmd(gsFCRFieldInfo,5,iLen)
		
			Call ETM88III_GenFiscCmd( giFCRError, gsFCRMsg, gsFCRCmdReturn, gsFCRFieldInfo, \
												giFCROpenDoc, giFCRCmd[], iLen, gbliTmtGFP, gsFCRFPResponse)
		else
			
			Format sFCRCmd as Chr(5), Chr(13)
			Format sFCRExt as ETM88III_FCR_NULL_CHR, ETM88III_FCR_NULL_CHR
			DLLCall gblhFCR, epson_generic_fiscal_command(ref giFCRError, ref gsDrvFCRMsg, \
															  					ref gsFCRCmdReturn, \
															  					ref sFCRCmd, \
															  					ref sFCRExt, \
															  					ref gsFCRFieldInfo, \
															  					ref gsDrvFCRFiscalStatus)
		
			Call emulateETM88IIIcheckPrinterRespFunc(giFCRError, gsDrvFCRMsg, gsDrvFCRFiscalStatus, giFCROpenDoc, \
																	gsFCRMsg, gsFCRCmdReturn)
		endif

		// check status...

		If giFCRError = 0
			
			If gsFCRCmdReturn <> ETM88III_ERRCODE_PYMNT_DONT_EXIST
				// save current payment info in array for later display
				format sPymnt[i] as i{02}, ": ", gsFCRFieldInfo
			Else
				format sPymnt[i] as i{02}, ": - vacio -"
			EndIf
				
		Else
			// An internal FCR error ocurred! Warn user!
			ErrorMessage gsFCRMsg

			// Log error
			format sTmp as "FCR Error: ", gsFCRMsg, " (Get FCR Pymnt)"
			call logInfo(ERROR_LOG_FILE_NAME,sTmp,TRUE,TRUE)
			Return // bail out!

		EndIf
	
	EndFor

	// Get DB default alphanumeric touchscreen
	Touchscreen @ALPHASCREEN

	// Now display info
	window 12,60, "Pagos cargados en la Impresora Fiscal:"
		// first column
		Display 1,1, sPymnt[1]
		Display 2,1, sPymnt[2]
		Display 3,1, sPymnt[3]
		Display 4,1, sPymnt[4]
		Display 5,1, sPymnt[5]
		Display 6,1, sPymnt[6]
		Display 7,1, sPymnt[7]
		Display 8,1, sPymnt[8]
		Display 9,1, sPymnt[9]
		Display 10,1, sPymnt[10]
		// second column
		Display 1,31, sPymnt[11]
		Display 2,31, sPymnt[12]
		Display 3,31, sPymnt[13]
		Display 4,31, sPymnt[14]
		Display 5,31, sPymnt[15]
		Display 6,31, sPymnt[16]
		Display 7,31, sPymnt[17]
		Display 8,31, sPymnt[18]
		Display 9,31, sPymnt[19]
		Display 10,31, sPymnt[20]
	WaitforEnter

EndSub

//******************************************************************
// Procedure: OpenFCRCoupon()
// Author: Alex Vidal
// Purpose: Opens a Fiscal Coupon (invoice) in the Fiscal Printer
// Parameters:
//******************************************************************
Sub OpenFCRCoupon()
	
	var iLen				: N9
	var sFCRCmd			: A100
	var sFCRExt		 	: A100
	
	
	// -- Reset Fields --
	Format gsFCRCmdReturn as ""

	// -- Set Field Info --
	format gsFCRFieldInfo as ETM88III_COMMAND_FIELD_SEPARATOR,"0", \
							 			ETM88III_COMMAND_FIELD_SEPARATOR,"0"
	
	if @WSTYPE <> SAROPS				
		ClearArray giFCRCmd
	
		// -- Build command --
		giFCRCmd[1] = 10
		giFCRCmd[2] = 1
		giFCRCmd[3] = ETM88III_iCOMMAND_FIELD_SEPARATOR
		giFCRCmd[4] = 0
		giFCRCmd[5] = 0
		Call setFieldInfoInFCRCmd(gsFCRFieldInfo,5,iLen)
	
		Call ETM88III_GenFiscCmd( giFCRError, gsFCRMsg, gsFCRCmdReturn, gsFCRFieldInfo, \
											giFCROpenDoc, giFCRCmd[], iLen, gbliTmtOFC, gsFCRFPResponse)
	else
		
		Format sFCRCmd as Chr(10), Chr(1)
		Format sFCRExt as ETM88III_FCR_NULL_CHR, ETM88III_FCR_NULL_CHR
		DLLCall gblhFCR, epson_generic_fiscal_command(ref giFCRError, ref gsDrvFCRMsg, \
														  					ref gsFCRCmdReturn, \
														  					ref sFCRCmd, \
														  					ref sFCRExt, \
														  					ref gsFCRFieldInfo, \
														  					ref gsDrvFCRFiscalStatus)
		
		Call emulateETM88IIIcheckPrinterRespFunc(giFCRError, gsDrvFCRMsg, gsDrvFCRFiscalStatus, giFCROpenDoc, \
																gsFCRMsg, gsFCRCmdReturn)
	endif

EndSub

//******************************************************************
// Procedure: printFCRDiscount()
// Author: Alex Vidal
// Purpose: Prints a Discount in a Fiscal Coupon
// Parameters:
//	- Desc_ = Discount description
//	- Amount_ = Discount amount
//******************************************************************
Sub printFCRDiscount( var Desc_ : A60, var Amount_ : A12 )

	var iLen				: N9
	var sFCRCmd			: A100
	var sFCRExt		 	: A100
	
	
	// -- Reset Fields --
	Format gsFCRCmdReturn as ""

	// -- set description --
	format gsFCRFieldInfo as ETM88III_COMMAND_FIELD_SEPARATOR, \
									 Trim(Desc_){20}, \
									 ETM88III_COMMAND_FIELD_SEPARATOR
	// -- set amount --
	format gsFCRFieldInfo as gsFCRFieldInfo, Amount_

	if @WSTYPE <> SAROPS				
		ClearArray giFCRCmd
	
		// -- Build command --
		giFCRCmd[1] = 10
		giFCRCmd[2] = 4
		giFCRCmd[3] = ETM88III_iCOMMAND_FIELD_SEPARATOR
		giFCRCmd[4] = 0
		giFCRCmd[5] = 0
		Call setFieldInfoInFCRCmd(gsFCRFieldInfo,5,iLen)
	
		Call ETM88III_GenFiscCmd( giFCRError, gsFCRMsg, gsFCRCmdReturn, gsFCRFieldInfo, \
											giFCROpenDoc, giFCRCmd[], iLen, gbliTmtPFDS, gsFCRFPResponse)
	else
		
		Format sFCRCmd as Chr(10), Chr(4)
		Format sFCRExt as ETM88III_FCR_NULL_CHR, ETM88III_FCR_NULL_CHR
		DLLCall gblhFCR, epson_generic_fiscal_command(ref giFCRError, ref gsDrvFCRMsg, \
														  					ref gsFCRCmdReturn, \
														  					ref sFCRCmd, \
														  					ref sFCRExt, \
														  					ref gsFCRFieldInfo, \
														  					ref gsDrvFCRFiscalStatus)
		
		Call emulateETM88IIIcheckPrinterRespFunc(giFCRError, gsDrvFCRMsg, gsDrvFCRFiscalStatus, giFCROpenDoc, \
																gsFCRMsg, gsFCRCmdReturn)
	endif
	
	// save current subtotal amount
	gblcFCRCurrSubtotal = gsFCRFieldInfo
		
EndSub

//******************************************************************
// Procedure: printFCRService()
// Author: Alex Vidal
// Purpose: Prints a Service charge in a Fiscal Coupon
// Parameters:
//	- Desc_ = Service description
//	- Amount_ = Service amount
//******************************************************************
Sub printFCRService( var Desc_ : A60, var Amount_ : A12 )

	var iLen				: N9
	var sFCRCmd			: A100
	var sFCRExt		 	: A100
	
	
	// -- Reset Fields --
	Format gsFCRCmdReturn as ""

	// -- set description --
	format gsFCRFieldInfo as ETM88III_COMMAND_FIELD_SEPARATOR, \
									 Trim(Desc_){20}, \
									 ETM88III_COMMAND_FIELD_SEPARATOR
	// -- set amount --
	format gsFCRFieldInfo as gsFCRFieldInfo, Amount_

	if @WSTYPE <> SAROPS				
		ClearArray giFCRCmd
	
		// -- Build command --
		giFCRCmd[1] = 10
		giFCRCmd[2] = 4
		giFCRCmd[3] = ETM88III_iCOMMAND_FIELD_SEPARATOR
		giFCRCmd[4] = 0
		giFCRCmd[5] = 1
		Call setFieldInfoInFCRCmd(gsFCRFieldInfo,5,iLen)
	
		Call ETM88III_GenFiscCmd( giFCRError, gsFCRMsg, gsFCRCmdReturn, gsFCRFieldInfo, \
											giFCROpenDoc, giFCRCmd[], iLen, gbliTmtPFDS, gsFCRFPResponse)
	else
		
		Format sFCRCmd as Chr(10), Chr(4)
		Format sFCRExt as ETM88III_FCR_NULL_CHR, Chr(1)
		DLLCall gblhFCR, epson_generic_fiscal_command(ref giFCRError, ref gsDrvFCRMsg, \
														  					ref gsFCRCmdReturn, \
														  					ref sFCRCmd, \
														  					ref sFCRExt, \
														  					ref gsFCRFieldInfo, \
														  					ref gsDrvFCRFiscalStatus)
		
		Call emulateETM88IIIcheckPrinterRespFunc(giFCRError, gsDrvFCRMsg, gsDrvFCRFiscalStatus, giFCROpenDoc, \
																gsFCRMsg, gsFCRCmdReturn)
	endif
	
	// save current subtotal amount
	gblcFCRCurrSubtotal = gsFCRFieldInfo
		
EndSub

//******************************************************************
// Procedure: printFCRSubtotal()
// Author: Al Vidal
// Purpose: Prints a subtotal line in a Fiscal Coupon
// Parameters:
//	-
//
//******************************************************************
Sub printFCRSubtotal()

	var sFCRCmd			: A100
	var sFCRExt		 	: A100
		

	// -- Reset Fields --
	Format gsFCRFieldInfo as ""
	Format gsFCRCmdReturn as ""
	
	if @WSTYPE <> SAROPS				
		ClearArray giFCRCmd
	
		// -- Build command --
		giFCRCmd[1] = 10
		giFCRCmd[2] = 27
		giFCRCmd[3] = 3
		giFCRCmd[4] = ETM88III_iCOMMAND_FIELD_SEPARATOR
		giFCRCmd[5] = 0
		giFCRCmd[6] = 0
	
		Call ETM88III_GenFiscCmd( giFCRError, gsFCRMsg, gsFCRCmdReturn, gsFCRFieldInfo, \
											giFCROpenDoc, giFCRCmd[], 6, gbliTmtGST, gsFCRFPResponse)
	else
		
		Format sFCRCmd as Chr(10), Chr(27), Chr(3)
		Format sFCRExt as ETM88III_FCR_NULL_CHR, ETM88III_FCR_NULL_CHR
		DLLCall gblhFCR, epson_generic_fiscal_command(ref giFCRError, ref gsDrvFCRMsg, \
														  					ref gsFCRCmdReturn, \
														  					ref sFCRCmd, \
														  					ref sFCRExt, \
														  					ref gsFCRFieldInfo, \
														  					ref gsDrvFCRFiscalStatus)
		
		Call emulateETM88IIIcheckPrinterRespFunc(giFCRError, gsDrvFCRMsg, gsDrvFCRFiscalStatus, giFCROpenDoc, \
																gsFCRMsg, gsFCRCmdReturn)
	endif
	
	// save current subtotal amount
	gblcFCRCurrSubtotal = gsFCRFieldInfo

EndSub

//******************************************************************
// Procedure: fiscalPrinterRecoveryConsole()
// Author: Al Vidal
// Purpose: runs the Fiscal Printer Recovery Console, used for
//			unlocking the printer from an erroneous state
// Parameters:
//******************************************************************
Sub fiscalPrinterRecoveryConsole()

	var iMenuSelection	: N2
	var iAnswer				: N1
	var sRCMenuOption[7]	: A40
	var sTmpVal				: A40
	var sTmpVal2			: A40


	// set menu options
	sRCMenuOption[1] = "Abrir Cupon Fiscal"
	sRCMenuOption[2] = "Imprimir Item generico"
	sRCMenuOption[3] = "Imprimir Subtotal"
	sRCMenuOption[4] = "Consultar Subtotal"
	sRCMenuOption[5] = "Imprimir Pago generico"
	sRCMenuOption[6] = "Cerrar Cupon Fiscal"
	sRCMenuOption[7] = "-- Salir --"


	While 1

		// Get DB default alphanumeric touchscreen
		Touchscreen @ALPHASCREEN

		// show RC menu
		Window 9,65, "Consola de Recuperacion FCR. Seleccione opcion."
			ListInput 2, 5, 7, sRCMenuOption, iMenuSelection, ""
		WindowClose  

		If iMenuSelection <> 7
			// Ask for status check
			call promptYesOrNo(iAnswer, "Desea realizar chequeo de status?")
		Else
			iAnswer = FALSE
		EndIf
		

		// execute selected menu option

		If iMenuSelection = 1
			// --------------------------------------
			// Open FCR Coupon
			// --------------------------------------
			
			call OpenFCRCoupon()

		ElseIf iMenuSelection = 2
			// --------------------------------------
			// Print a generic menu item
			// --------------------------------------

			// -- Ask for Qty --
			call valuePrompt( sTmpVal, "Cantidad? (nro entero)", TRUE)

			// -- Ask for Unit price --
			call valuePrompt( sTmpVal2, "Precio Unit.? (nro entero)", TRUE)

			// -- Print item --
			call printFCRFiscalItem("Item generico (CR)", sTmpVal, sTmpVal2, gblsDefaultTaxRate )

		ElseIf iMenuSelection = 3
			// --------------------------------------
			// Print a subtotal
			// --------------------------------------
			call printFCRSubtotal()

		ElseIf iMenuSelection = 4
			// --------------------------------------
			// Get subtotal value
			// --------------------------------------
			call getFCRSubtotal()

			// Show subtotal value to user
			If gsFCRFieldInfo <> ""
				InfoMessage "El Subtotal es...", gsFCRFieldInfo
			Else
				ErrorMessage "No se ha podido obtener el subtotal"
			EndIf

		ElseIf iMenuSelection = 5
			// --------------------------------------
			// Print a generic Tender
			// --------------------------------------

			// -- ask for amount --
			call valuePrompt( sTmpVal, "Monto? (nro entero)", TRUE)
			call printFCRTender("1", sTmpVal)
			

		ElseIf iMenuSelection = 6
			// --------------------------------------
			// Close FCR Coupon
			// --------------------------------------

			call CloseFCRCoupon(0, "0")

		ElseIf iMenuSelection = 7
			// --------------------------------------
			// Exit console
			// --------------------------------------

			Return  // bail out!

		EndIf

		// If user chose to check FCR status, do so.
		If iAnswer
			call checkFCRCmdResponse(giFCROK, TRUE, FALSE, TRUE)
		EndIf	

	EndWhile

EndSub

//******************************************************************
// Purpose: Sets FCR global response parameters to emulate those of
//				the ETM88III Sim library
// Parameters:
//		- sPrinterStatus_ = printer status
//		- sFiscalStatus_ = fiscal status
//		- sCmdReturn_ = Command Return (code)
//		- iDocOpen_ = TRUE if fiscal coupon in progress
//		- iErrMsg_ = returned error message (in case of error)
//******************************************************************
Sub emulateETM88IIIcheckPrinterRespFunc( var iDrvFCRStatus_ : N1, var sDrvFCRMsg_ : A100, \
														var sDrvFcrFiscalStatus_ : A100, ref iDocOpen_, \
														ref sErrMsg_, ref sCmdReturn_)

	var sErrCode	: A2
	var sErrID		: A2
	

	// Init params
	iDocOpen_ = FALSE
	
	// -------------------------------------------
	// set DLL (internal) state
	// -------------------------------------------
	If iDrvFCRStatus_ <> 0
		Format sErrMsg_ as sDrvFCRMsg_, "(", iDrvFCRStatus_, ")"
		Return
	endif
	
	// -------------------------------------------
	// set Printer state
	// -------------------------------------------
	if sCmdReturn_ = DLLFCR_ERROR_PRINTER_OFFLINE
		sCmdReturn_ = ETM88III_ERRCODE_PRNT_OFFLINE
		Format sErrMsg_ as "Impresora fuera de linea (", sCmdReturn_, ")"
		Return
	elseif sCmdReturn_ = DLLFCR_ERROR_PRINTER_ERROR
		sCmdReturn_ = ETM88III_ERRCODE_PRNT_ERROR
		Format sErrMsg_ as "Error de impresora (", sCmdReturn_, ")"
		Return
	elseif sCmdReturn_ = DLLFCR_ERROR_LID_OPEN
		sCmdReturn_ = ETM88III_ERRCODE_PRNT_OPENLID
		Format sErrMsg_ as "Tapa de impresora abierta (", sCmdReturn_, ")"
		Return
	elseif sCmdReturn_ = DLLFCR_ERROR_LOW_PAPER
		sCmdReturn_ = ETM88III_ERRCODE_PRNT_LOWPAPER
		Format sErrMsg_ as "Poco papel de impresora disponible (", sCmdReturn_, ")"
		Return
	endif
	
	// -------------------------------------------
	// set Fiscal state
	// -------------------------------------------
	if sDrvFcrFiscalStatus_ = DLLFCR_ERROR_FISCAL_DOC_OPEN
		iDocOpen_ = TRUE
		Format sErrMsg_ as "Documento abierto en impresora (", sDrvFcrFiscalStatus_, ")"
	endif
	
	
	// -------------------------------------------
	// Check Command return code
	// -------------------------------------------
	If sCmdReturn_ = ETM88III_ERRCODE_OK
		Return // All is well.
	ElseIf sCmdReturn_ = ETM88III_ERRCODE_BASIC_INTERR
		Format sErrMsg_ as "Error interno en impresora (", sCmdReturn_, ")"
		Return
	ElseIf sCmdReturn_ = ETM88III_ERRCODE_BASIC_INITERR
		Format sErrMsg_ as "Error de inicializacion de impresora (", sCmdReturn_, ")"
		Return
	ElseIf sCmdReturn_ = ETM88III_ERRCODE_BASIC_INTRNLPROC
		Format sErrMsg_ as "Error en proceso interno de impresora (", sCmdReturn_, ")"
		Return
	endif
	
	// Get error Code and error ID
	format sErrCode as mid(sCmdReturn_,1,2)
	format sErrID as mid(sCmdReturn_,3,2)
	
	If sErrCode = ETM88III_ERRCODE_GENERIC_CMDS
		
		If sErrID = ETM88III_01ERRID_01
			Format sErrMsg_ as "Comando invalido en impresora para estado actual (", sCmdReturn_, ")"
		else
			Format sErrMsg_ as "Error en comando de impresora (", sCmdReturn_, ")"
		endif
	
	elseif sErrCode = ETM88III_ERRCODE_PROTOCOL_FIELDS
		
		Format sErrMsg_ as "Error en campo de protocolo de impresora (", sCmdReturn_, ")"
		
	elseif sErrCode = ETM88III_ERRCODE_HARDWARE
		
		If sErrID = ETM88III_03ERRID_01
			Format sErrMsg_ as "Error de hardware en impresora (", sCmdReturn_, ")"
		ElseIf sErrID = ETM88III_03ERRID_02
			Format sErrMsg_as "Impresora fuera de linea (", sCmdReturn_, ")"
		ElseIf sErrID = ETM88III_03ERRID_03
			Format sErrMsg_ as "Error de Impresion (", sCmdReturn_, ")"
		ElseIf sErrID = ETM88III_03ERRID_04
			Format sErrMsg_ as "Sin papel en impresora (", sCmdReturn_, ")"
		ElseIf sErrID = ETM88III_03ERRID_05
			Format sErrMsg_ as "Poco papel disponible en impresora (", sCmdReturn_, ")"
		Else
			format sErrMsg_ as "Problema de hardware en impresora (", sCmdReturn_, ")"
		EndIf
	
	elseif sErrCode = ETM88III_ERRCODE_INIT
	
		Format sErrMsg_ as "Error de inicializacion en impresora (", sCmdReturn_, ")"
	
	elseif sErrCode = ETM88III_ERRCODE_CFG
	
		Format sErrMsg_ as "Error de configuracion en impresora (", sCmdReturn_, ")"
	
	elseif sErrCode = ETM88III_ERRCODE_TRANS_MEMORY
	
		If sErrID = ETM88III_06ERRID_01
			format sErrMsg_ as "Memoria de transacciones llena en impresora (", sCmdReturn_, ")"
		Else
			format sErrMsg_ as "Error de memoria de transacciones en impresora (", sCmdReturn_, ")"
		EndIf
	
	elseif sErrCode = ETM88III_ERRCODE_FISCAL_DAY
	
		If sErrID = ETM88III_08ERRID_03
			format sErrMsg_ as "Memoria fiscal llena en impresora (", sCmdReturn_, ")"
		ElseIf sErrID = ETM88III_08ERRID_04
			format sErrMsg_ as "Se requiere cierre Z en impresora (", sCmdReturn_, ")"
		ElseIf sErrID = ETM88III_08ERRID_05
			format sErrMsg_ as "Pagos no definidos en impresora (", sCmdReturn_, ")"
		Else
			format sErrMsg_ as "Error en jornada fiscal en impresora (", sCmdReturn_, ")"
		EndIf
	
	elseif sErrCode = ETM88III_ERRCODE_GENERIC_TRANS
	
		Format sErrMsg_ as "Error en transaccion generica de impresora (", sCmdReturn_, ")"
	
	elseif sErrCode = ETM88III_ERRCODE_FISCAL_COUPON
	
		Format sErrMsg_ as "Error en cupon fiscal de impresora (", sCmdReturn_, ")"
		
	elseif sErrCode = ETM88III_ERRCODE_NON_FISCAL_COUPON
	
		If sErrID = ETM88III_0EERRID_01
			format sErrMsg_ as "Se llego al limite de 30 lineas en impresora (", sCmdReturn_, ")"
		Else
			format sErrMsg_ as "Error en cupon no fiscal de impresora (", sCmdReturn_, ")"
		EndIf
	
	elseif sErrCode = ETM88III_ERRCODE_OTHER
	
		If sErrID = ETM88III_FFERRID_FF
			format sErrMsg_ as "Error desconocido en impresora (", sCmdReturn_, ")"
		EndIf
	
	else
		
		// Return code for other error types
		Format sErrMsg_ as "Estado erroneo en impresora (", sCmdReturn_, ")"
		
	endif
	
EndSub

//******************************************************************
// Procedure: getExemptSubtotal()
// Author: Al Vidal
// Purpose: Returns the current check's Exempt subtotal
// Parameters:
//	 - retVal_ = Function's return value
//  - MI_Ttl_[] = Array containing grouped Menu Item totals
//	 - MI_Tax_[] = Array containing grouped Menu Item Tax Totals
//  - MI_Count_ = Total number of grouped Menu Items
//******************************************************************
Sub getExemptSubtotal( ref retVal_, ref MI_Ttl_[], ref MI_Tax_[], var MI_Count_ : N5)

	var cAcumSub	: $12
	var i				: N4  // for looping

	// Cycle through the MI arrays and accumulate
	// the Exempt subtotal value
	
	For i = 1 to MI_Count_

		// Only accumulate values from MIs
		// that are 'tax exempt' (in spanish: 'no gravados')

		If MI_Tax_[i] = 0.00
			cAcumSub = cAcumSub + MI_Ttl_[i]
		EndIf

	EndFor

	// return Burden subtotal value
	retVal_ = cAcumSub

EndSub

//EDI Functions
//******************************************************************
// Procedure: OpenEDICoupon()
// Author: C Sepulveda
// Purpose: Opens a EDI Coupon (invoice) in the Serial Printer
// Parameters:
//******************************************************************
Sub OpenEDICoupon()
	
	var iLen							: N9
	var sTmpLine					: A50
	var sTmp1							: A50
	var sTmp2							: A50
	var iESCPPrinterResp	: N9
	
	
	DLLCall gblhESCPOS, InitializePrinterToDefault(Ref iESCPPrinterResp)
	
	For i = 1 to MAX_HIL		
		// -- Print Header --
		if Trim(gblsHeaderInfoLines[i]) <> ""
			format sTmpLine as gblsHeaderInfoLines[i]{=42}
			DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
		endif
	Endfor
	
	//Blank line separator
	format sTmpLine as ""{=42}
	DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
	
	//Print Date and Time
	format sTmp1 as "FECHA: ",  @Day{02}, "/", @Month{02}, "/", (@YEAR + 1900){04}
	format sTmp2 as "HORA: ", @Hour{02}, ":", @Minute{02}, ":", @Second{02}  

	format sTmpLine as  sTmp1{<21}, sTmp2{>21}
	DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
	
	//Print Transaction info
	format sTmpLine as "Chk: ", @CKNUM{04}, "   TERMINAL: ", @WSID{>4}, "   EMP: ", @CKEMP{08}
	DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
	
	//Blank line separator
	format sTmpLine as ""{=42}
	DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
	
	//Print EDI info
	if gbliInvoiceType = INV_TYPE_BOLETA
		format sTmp1 as "BOLETA ELECTRONICA NRO: ", gblsInvoiceNumEDI{012}
	elseif gbliInvoiceType = INV_TYPE_FACTURA
		format sTmp1 as "FACTURA ELECTRONICA NRO: ", gblsInvoiceNumEDI{012}
	elseif gbliInvoiceType = INV_TYPE_CREDITO
		format sTmp1 as "NOTA CREDITO ELECTRONICA NRO: ", gblsInvoiceNumEDI{012}
	endif
	
	format sTmpLine as sTmp1{=42}
	DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
	
	if gbliInvoiceType = INV_TYPE_CREDITO
		format sTmpLine as "------------------------------------------"
		DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
		
		if gblsNCReferenceInvType = "1"
			Format sTmpLine As "TIPO DOC. ORIGINAL  : BOLETA"
			DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
		else
			Format sTmpLine As "TIPO DOC. ORIGINAL  : FACTURA"
			DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
		endif
		
		Format sTmpLine As "DOC. ORIGINAL       : ", gblsNCReferenceInvNumber
		DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)

		//Print Separator
		format sTmpLine as "------------------------------------------"
		DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
	endif
	
	//Blank line separator
	format sTmpLine as ""{=42}
	DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
	
	if gbliInvoiceType = INV_TYPE_FACTURA or gbliInvoiceType = INV_TYPE_CREDITO
		//Print Separator
		format sTmpLine as "------------------------------------------"
		DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
		
		//Print Product HEader
		format sTmpLine as "               DATOS CLIENTE"
		DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
		
		//Print Separator
		format sTmpLine as "------------------------------------------"
		DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
		
		//Print Product HEader
		format sTmpLine as "RUT         :", mid(gblsIDNumber, 1,len(gblsIDNumber)-1), "-", mid(gblsIDNumber, len(gblsIDNumber), 1)
		DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
		
		//Print Product HEader
		format sTmpLine as "NOMBRE      :", gblsName
		DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
		
		//Print Product HEader
		format sTmpLine as "DIRECCION   :", gblsAddress1
		DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
		
		//Print Product HEader
		format sTmpLine as "             ", gblsAddress2
		DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
		
		//Print Product HEader
		format sTmpLine as "GIRO        :", gblsExtra1
		DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
		
		//Print Separator
		format sTmpLine as "------------------------------------------"
		DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
	Endif
		
	//Print Separator
	format sTmpLine as "------------------------------------------"
	DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
	
	if gbliInvoiceType <> INV_TYPE_BOLETA
		//Print Product HEader
		format sTmpLine as "CANT.  PRODUCTO          P.UNIT      TOTAL"
		DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
	else
		//Print Product HEader
		format sTmpLine as "CANT.  PRODUCTO                      TOTAL"
		DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
	endif
		
	//Print Separator
	format sTmpLine as "------------------------------------------"
	DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
EndSub

//******************************************************************
// Procedure: printEDIFiscalItem()
// Author: C Sepulveda
// Purpose: Print Items at serial printer for EDI interfase
// Parameters:
//******************************************************************
Sub printEDIFiscalItem(ref sItemName_, ref sQty_, ref sTotalPrice_, ref sTaxAmount_, ref sUnitPrice_)
	
	var iLen							: N9
	var sTmpLine					: A50
	var sTmp1							: A50
	var sTmp2							: A50
	var iESCPPrinterResp	: N9
	
	format sTmp1 as "(", trim(sUnitPrice_), ")"
	
	format sTmp2 as sTmp1{>8}
	
	if gbliInvoiceType <> INV_TYPE_BOLETA
		format sTmpLine as sQty_{>4}, "  ", trim(sItemName_){<16}, " ",  sTmp2, " $ ", sTotalPrice_{>8}
	else
		format sTmpLine as sQty_{>4}, "  ", trim(sItemName_){<25}, " $ ", sTotalPrice_{>8}
	endif
	
	DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
EndSub



//******************************************************************
// Procedure: printEDISubtotal()
// Author: C Sepulveda
// Purpose: Print Items at serial printer for EDI interfase
// Parameters:
//******************************************************************
Sub printEDISubtotal(ref cTmpAmount_)
	
	var iLen							: N9
	var sTmpLine					: A50
	var sTmp1							: A50
	var sTmp2							: A50
	var iESCPPrinterResp	: N9
	
	//Print Separator
	format sTmpLine as "------------------------------------------"
	DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
	
	if gbliInvoiceType = INV_TYPE_BOLETA
		format sTmp1 as "SUBTOTAL $ "{>34}
	else
		format sTmp1 as "SUBTOTAL NETO $ "{>34}
	endif
	
	format sTmp2 as Abs(cTmpAmount_){>8}
	
	format sTmpLine as sTmp1, sTmp2 
	DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
	
EndSub

//******************************************************************
// Procedure: printEDIService()
// Author: C Sepulveda
// Purpose: Print Items at serial printer for EDI interfase
// Parameters:
//******************************************************************
Sub printEDIService(ref sSrvcName_, ref sSrvcAmount_)
	
	var iLen							: N9
	var sTmpLine					: A50
	var sTmp1							: A50
	var sTmp2							: A50
	var iESCPPrinterResp	: N9
	
	//Print Separator
	format sTmpLine as "------------------------------------------"
	DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
	
	format sTmp1 as trim(sSrvcName_)
	format sTmp2 as sSrvcAmount_{>8}
	
	format sTmpLine as sTmp1{>34}, sTmp2 
	DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
EndSub

//PrintEDItotal

//******************************************************************
// Procedure: PrintEDItotal()
// Author: C Sepulveda
// Purpose: Print total at serial printer for EDI interfase
// Parameters:
//******************************************************************
Sub PrintEDItotal(ref cTmpAmount_, ref cNetAmount_, ref cTaxAmount_)
	
	var iLen							: N9
	var sTmpLine					: A50
	var sTmp1							: A50
	var sTmp2							: A50
	var iESCPPrinterResp	: N9
	
	//Print Separator
	format sTmpLine as "------------------------------------------"
	DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
	
	if gbliInvoiceType = INV_TYPE_FACTURA or \
		 gbliInvoiceType = INV_TYPE_GUIA or \
		 gbliInvoiceType = INV_TYPE_CREDITO
		 
		format sTmp1 as "NETO $ "{>34}
		format sTmp2 as Abs(cNetAmount_){>8}
		
		format sTmpLine as sTmp1, sTmp2 
		DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
		
		format sTmp1 as "IVA $ "{>34}
		format sTmp2 as Abs(cTaxAmount_){>8}
		
		format sTmpLine as sTmp1, sTmp2 
		DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
	endif
	 
	format sTmp1 as "TOTAL $ "{>34}
	format sTmp2 as Abs(cTmpAmount_){>8}
	
	format sTmpLine as sTmp1, sTmp2 
	DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
	
	//Print Separator
	format sTmpLine as "------------------------------------------"
	DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
	
	//Print 
	format sTmpLine as "MEDIOS DE PAGO"{=42}
	DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
	
		//Print Separator
	format sTmpLine as "------------------------------------------"
	DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
	
EndSub

//******************************************************************
// Procedure: printEDITenders()
// Author: C Sepulveda
// Purpose: Print Items at serial printer for EDI interfase
// Parameters:
//******************************************************************
Sub printEDITenders(ref sTndrName_, ref sTndrAmount_)
	
	var iLen							: N9
	var sTmpLine					: A50
	var sTmp1							: A50
	var sTmp2							: A50
	var iESCPPrinterResp	: N9
		
	format sTmp1 as trim(sTndrName_)
	format sTmp2 as sTndrAmount_{>8}
	
	format sTmpLine as sTmp1{<32},"$ ", sTmp2 
	DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
EndSub

//******************************************************************
// Procedure: CloseEDICoupon()
// Author: C Sepulveda
// Purpose: Print PDF 417, trailer lines and cuts the document
// Parameters:
//******************************************************************
Sub CloseEDICoupon()
	
	var iLen							: N9
	var sTmpLine					: A50
	var sTmp1							: A50
	var sTmp2							: A50
	var iESCPPrinterResp	: N9
	Var sLineInfo					:A800
	Var sLineInfo1				:A800
		
	//Print Separator
	format sTmpLine as "------------------------------------------"
	DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
	
	format sTmpLine as ""{42}
	DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
	
	if gbliInvoiceType <> INV_TYPE_BOLETA
		format sTmpLine as "NOMBRE:___________________________________"
		DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
		
		format sTmpLine as "RUT:________________FIRMA:________________"
		DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
		
		format sTmpLine as "FECHA:____________RECINTO:________________"
		DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
		
		format sTmpLine as "------------------------------------------"
		DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
		
		format sTmpLine as "El acuse de recibo que se declara en este "
		DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
		
		format sTmpLine as "acto, de acuerdo a lo dispuesto en la     "
		DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
		
		format sTmpLine as "letra b) del Art. 4°, y la letra c) del   "
		DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
		
		format sTmpLine as "Art. 5° de la ley 19.983, acredita que la "
		DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
		
		format sTmpLine as "entrega de mercaderias o servicio(s),     "
		DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
		
		format sTmpLine as "prestado(s) ha(n) sido recibido(s).       "
		DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
		
		format sTmpLine as ""{42}
		DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
	endif
	
	format sLineInfo as mid(gblsEDICode,1,729)
  
  format sLineInfo1 as mid(gblsEDICode,730, 294)

	DLLCall gblhESCPOS, PrintPDF417(sLineInfo, sLineInfo1, Ref iESCPPrinterResp)
	
  DLLCall gblhESCPOS, InitializePrinterToDefault(Ref iESCPPrinterResp)
	
	if gbliInvoiceType = INV_TYPE_BOLETA
		For i = 1 to MAX_TIL		
			// -- Print Header --
			if Trim(gblsTrailerInfoLines[i]) <> ""
				format sTmpLine as gblsTrailerInfoLines[i]{=42}
				DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
			endif
		Endfor
	else
		For i = 1 to MAX_TIL		
			// -- Print Header --
			if Trim(gblsSpecialTrailerInfoLines[i]) <> ""
				format sTmpLine as gblsSpecialTrailerInfoLines[i]{=42}
				DLLCall gblhESCPOS, PrintLine(sTmpLine, Ref iESCPPrinterResp)
			endif
		Endfor
	endif

	DLLCall gblhESCPOS, CutPaper(Ref iESCPPrinterResp)
	
EndSub 