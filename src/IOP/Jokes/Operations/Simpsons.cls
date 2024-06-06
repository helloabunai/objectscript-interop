Class IOP.Jokes.Operations.Simpsons Extends EnsLib.REST.Operation
{

Parameter INVOCATION = "Queue";

Method GetJoke(operatingRequest As IOP.Jokes.Messages.OperatingRequest, Output jokeResponse As IOP.Jokes.Messages.OperatingResponse) As %Status
{
	
	#dim status as %Status = $$$OK

	$$$TRACE("(request received by operator: ((family: """_operatingRequest.ValidatedFamily_""")(amount: "_operatingRequest.ValidatedAmount_")))")
	
	try
	{
		set request=##class(%Net.HttpRequest).%New()
		set request.Server=operatingRequest.TargetServer
		set request.Port=operatingRequest.TargetPort
		set request.Https=operatingRequest.UseHTTPS
		// IRIS SSL Configs are stored in the web portal under
		// "System Administration" --> "Security" --> "SSL/TLS configuration"
		// Required for real API access, not for wiremock localhost
		//set request.SSLConfiguration="ISC.FeatureTracker.SSL.Config"
		set status=request.Get(operatingRequest.TargetEndpoint)
		if $$$ISERR(status) {
			#dim details as %String = "HTTP Request Error in Simpsons Operator"
			#dim error = ##class(IOP.Jokes.Error).Create(details)
        	$$$LOGERROR(error.ExportToJson())
 		} else {
        	set rawResponse=request.HttpResponse
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
