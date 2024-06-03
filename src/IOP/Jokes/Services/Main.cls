Class IOP.Jokes.Services.Main Extends Ens.BusinessService
{

Method OnProcessInput(pInput As IOP.Jokes.Messages.ProcessingRequest, Output pOutput As IOP.Jokes.Messages.ProcessingResponse) As %Status
{

	#dim status as %Status = $$$OK

	write "Hello from IOP.Jokes.Services.Main OnProcessInput()", !

	// why don't write commands within OnRequest work when sending SendRequestSync?
	//set tPC = ..SendRequestSync("Jokes.Processes.Main", pInput, .pResponse, 10)

	// write commands work via calling an object. use during development i guess
	set inDev = ##class("IOP.Jokes.Processes.Main").%New()
	set pResponse = inDev.OnRequest(pInput)

	write "", !!!
	write "this is after the sendRequestSync", !
	write "the response was: ", !
	zwrite pResponse

	if (pResponse '= 1){
		set status = $$$ERROR(pResponse)
	}

	return status
}

}
