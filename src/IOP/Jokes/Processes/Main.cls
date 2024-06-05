Class IOP.Jokes.Processes.Main Extends Ens.BusinessProcess [ ClassType = persistent ]
{

Method OnRequest(pRequest As IOP.Jokes.Messages.ProcessingRequest, Output pResponse As IOP.Jokes.Messages.ProcessingResponse) As %Status
{
	$$$TRACE("(pRequest ((family """_pRequest.Family_""")(amount "_pRequest.Amount_")))")

	#dim status as %Status = $$$OK

	// validate input using validateFamily() and validateAmount() methods
	set familyValidStatus = ..validateFamily(pRequest.Family)
	set amountValidStatus = ..validateAmount(pRequest.Amount)

	if ('familyValidStatus){
		set familyError = ##class(IOP.Jokes.Error).CreateFromStatus(familyValidStatus).ExportToJson()
		set pResponse = ##class(IOP.Jokes.Messages.ProcessingResponse).%New("", familyError, "")
	}
	if ('amountValidStatus){
		set amountError = ##class(IOP.Jokes.Error).CreateFromStatus(amountValidStatus).ExportToJson()
		set pResponse = ##class(IOP.Jokes.Messages.ProcessingResponse).%New("", "", amountError)
	}
	if ('familyValidStatus && 'amountValidStatus)
	{
		set familyError = ##class(IOP.Jokes.Error).CreateFromStatus(familyValidStatus).ExportToJson()
		set amountError = ##class(IOP.Jokes.Error).CreateFromStatus(amountValidStatus).ExportToJson()
		set pResponse = ##class(IOP.Jokes.Messages.ProcessingResponse).%New("", familyError, amountError)
	}

	// convert validated processingRequest to OperatingRequest
	set operatingRequest = ##class(IOP.Jokes.Messages.OperatingRequest).%New(pRequest.Family, pRequest.Amount)

	// send request sync to our operator
	if (operatingRequest.ValidatedFamily = "simpsons"){

		$$$TRACE("sending request to simpsons, maybe...")
		set tPC = ..SendRequestSync("Jokes.Operations.Simpsons", operatingRequest, .operationResponse, 10)
		$$$TRACE("simpsons response: "_ operationResponse)

		zwrite operationResponse

		set pResponse = ##class(IOP.Jokes.Messages.ProcessingResponse).%New("response goes here", "", "")
	}
	if (operatingRequest.ValidatedFamily = "chucknorris"){
		//set tPC = ..SendRequestSync("Jokes.Operations.ChuckNorris", operatingRequest, .opResponse, 10)
		write "WIP"
	}



























	// success, set response with joke (no error)
	// this is placeholder and will be removed when family endpoints work
	if (familyValidStatus && amountValidStatus){
		#dim placeholderJoke = "{jokes:[{family: " _ pRequest.Family _ ", text: This is a placeholder joke. ha ha ha.}]}"
		set pResponse = ##class(IOP.Jokes.Messages.ProcessingResponse).%New(placeholderJoke, "", "")
	}
	
	return $$$OK
}

Method validateAmount(amount As %Integer) As %Status [ Private ]
{
	if (amount < 1) {
		#dim details as %String = "Invalid amount: "_amount_". Valid amount > 0."
		#dim error = ##class(IOP.Jokes.Error).Create(details)
		$$$LOGERROR(error.ExportToJson())
		return error.ExportToStatus()
	}
	
	return $$$OK
}

Method validateFamily(family As %String) As %Status [ Private ]
{
	if ((family '= "baconipsum") && (family '= "chucknorris") && (family '= "simpsons")) {
		#dim details as %String = "Invalid family: "_family_". Valid families: ""baconipsum"", ""chucknorris"", ""simpsons""."
		#dim error = ##class(IOP.Jokes.Error).Create(details)
		$$$LOGERROR(error.ExportToJson())
		return error.ExportToStatus()
	}
	if (family = "baconipsum"){
		#dim baconDetails as %String = "Not implemented yet. Family: "_family
		#dim baconError = ##class(IOP.Jokes.Error).Create(baconDetails)
		$$$LOGERROR(baconError.ExportToJson())
		return baconError.ExportToStatus()
	}
	
	return $$$OK
}

Method %OnNew() As %Status
{
	return $$$OK
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
