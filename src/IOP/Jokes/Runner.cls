Class IOP.Jokes.Runner Extends %RegisteredObject
{

ClassMethod Run(family As %String = "simpsons", amount As %Integer = 1) As %Status
{
	#dim status as %Status = $$$OK

	// create our request (processingRequest type)
	set userProcessingRequest = ##class(IOP.Jokes.Messages.ProcessingRequest).%New(family, amount)
    zwrite userProcessingRequest

	// create an instance of our business service, send request
	set tSC = ##class(Ens.Director).CreateBusinessService("Jokes.Services.Main", .bService)
	set response = bService.OnProcessInput(userProcessingRequest)

	write "Hello from Runner; after response!!", !
	if (response '= 1){
		set status = $$$ERROR(response)
	}

	#dim statusDetails // md
	do $system.Status.DecomposeStatus(status, .statusDetails)
	
	if ($system.Status.IsOK(status)) {
		//write response.Joke
		write ">__ yea response goes here", !
	} else { // error
		write ">_ ERROR"
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
