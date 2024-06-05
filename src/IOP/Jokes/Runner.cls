Class IOP.Jokes.Runner Extends %RegisteredObject
{

ClassMethod Run(family As %String = "simpsons", amount As %Integer = 1) As %Status
{
	#dim status as %Status = $$$OK

	// check production so you don't need to manually start it upon laptop reboot
    if '##class(Ens.Director).IsProductionRunning(.productionStatus) {
        set sc = ##class(Ens.Director).StartProduction("IOP.Jokes.Production")
        if $$$ISERR(sc)
		{
			set status = $$$ERROR(83, "IOP.Jokes.Error", "Failed to start production.")
        }
    }

	// create our request (processingRequest type)
	set userProcessingRequest = ##class(IOP.Jokes.Messages.ProcessingRequest).%New(family, amount)
    zwrite userProcessingRequest

	// create an instance of our business service, send request
	set tSC = ##class(Ens.Director).CreateBusinessService("Jokes.Services.Main", .bService)
	set tSC = bService.OnProcessInput(userProcessingRequest, .pResponse)

	// check for errors in business service response
	if (pResponse.FamilyError '= "") || (pResponse.AmountError '= ""){
		do ##class(IOP.Jokes.Error).CombineErrorEntities(pResponse.FamilyError, pResponse.AmountError, .errorDetails)
		
		// TODO this only shows a timestamp if using errorDetails within status
		// TODO using pResponse.individualErrorHere shows correct info. for one error type.
		write !!, errorDetails
		set status = $$$ERROR(83, "IOP.Jokes.Error", errorDetails)
	}

	#dim statusDetails // md
	do $system.Status.DecomposeStatus(status, .statusDetails)
	
	if ($system.Status.IsOK(status)) {
		write pResponse.Joke
	} else { // error
		if (##class(IOP.Jokes.Error).IsStatusContainsError(status)) {
			write !,"IOP.Jokes.Error:",!
			#dim errorStatus = ##class(IOP.Jokes.Error).UnwrapStatusError(status)
			
			write ##class(IOP.Jokes.Error).CreateFromStatus(errorStatus).ExportToJson()
		} else {
			write !,"Other error:",!
			write $system.Status.GetErrorCodes(status),!
			write $system.Status.GetErrorText(status)
		}
	}
	
	return status
}

}
