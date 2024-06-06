Class IOP.Jokes.Services.Main Extends Ens.BusinessService
{

Method OnProcessInput(pInput As IOP.Jokes.Messages.ProcessingRequest, Output pOutput As IOP.Jokes.Messages.ProcessingResponse) As %Status
{

	#dim status as %Status = $$$OK

	// send request sync to our process
	set tPC = ..SendRequestSync("Jokes.Processes.Main", pInput, .pResponse, 10)

	// if error, set to status, else set to output
	if ('pResponse){
		set status = $$$ERROR(pResponse)
	} else {
		set pOutput = pResponse
	}

	return status
}

}
