Class IOP.Jokes.Operations.Simpsons Extends EnsLib.REST.Operation
{

Parameter INVOCATION = "Queue";

Method GetJoke(operatingRequest As IOP.Jokes.Messages.OperatingRequest, Output response As IOP.Jokes.Messages.OperatingResponse) As %Status
{
	#dim status as %Status = $$$OK

	$$$TRACE("(request received by operator: ((family: """_operatingRequest.ValidatedFamily_""")(amount: "_operatingRequest.ValidatedAmount_")))")
	
	try
	{
		set request=##class(%Net.HttpRequest).%New()
		set request.Server=operatingRequest.TargetServer
		set request.Https=operatingRequest.UseHTTPS
		// is SSLConfiguration required?
		//set request.SSLConfiguration="TEST" 
		set status=request.Get(operatingRequest.TargetEndpoint)
		if $$$ISERR(status) {
			#dim details as %String = "HTTP Request Error in Simpsons Operator"
			#dim error = ##class(IOP.Jokes.Error).Create(details)
        	$$$LOGERROR(error.ExportToJson())
 		} else {
        	set rawResponse=request.HttpResponse

			write !!, "SIMPSONS RAW RESPONSE", !!
			zwrite rawResponse
			write !!

			set jokeResponse = ##class(IOP.Jokes.Messages.OperatingResponse).%New(rawResponse)
 		}

	} catch (e) {
		$$$TRACE("Simpsons operator exception: "_ e)
		set status = $$$SystemError
	}
	
	return status
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="IOP.Jokes.Messages.OperatingRequest">
    <Method>GetJoke</Method>
  </MapItem>
</MapItems>
}

}
