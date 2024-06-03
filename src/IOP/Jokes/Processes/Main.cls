Class IOP.Jokes.Processes.Main Extends Ens.BusinessProcess [ ClassType = persistent ]
{

Method OnRequest(pRequest As IOP.Jokes.Messages.ProcessingRequest, Output pResponse As IOP.Jokes.Messages.ProcessingResponse) As %Status
{
	$$$TRACE("(pRequest ((family """_pRequest.Family_""")(amount "_pRequest.Amount_")))")

	#dim status as %Status = $$$OK

	write "", !!!!
	write "hello from processes onRequest()", !

	// validate input using validateFamily() and validateAmount() methods
	set familyValidStatus = ..validateFamily(pRequest.Family)
	set amountValidStatus = ..validateAmount(pRequest.Amount)

	if (familyValidStatus '= 1){
		set familyError = ##class(IOP.Jokes.Error).CreateFromStatus(familyValidStatus)
		set pResponse = ##class(IOP.Jokes.Messages.ProcessingResponse).%New("", familyError)
		set status = $$$ERROR(familyError)
	}
	if (amountValidStatus '= 1){
		set amountError = ##class(IOP.Jokes.Error).CreateFromStatus(amountValidStatus)
		set pResponse = ##class(IOP.Jokes.Messages.ProcessingResponse).%New("", amountError)
		set status = $$$ERROR(amountError)
	}

	write !!, "ok now here", !!
	








	// convert pRequest to OperatingRequest
	//set oRequest = ##class(IOP.Jokes.Messages.OperatingRequest).%New(pRequest)

	//set pResponse = ##class(IOP.Jokes.Messages.ProcessingResponse).%New("This is a joke. Ha ha.")

	return status
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
