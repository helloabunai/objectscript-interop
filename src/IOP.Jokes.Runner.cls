Class IOP.Jokes.Runner
{

ClassMethod Run(family As %String, amount As %Integer = 1) As %Status
{
    // Feedback display of input arguments
    write ">_ Hello, joke enthusiast", !
    write ">_ You requested: " _ family, !
    write ">_ Joke amount: " _ amount, !

    // Create a processing request from iris terminal arguments
    set userProcessingRequest = ##class(IOP.Jokes.Messages.ProcessingRequest).%New(family, amount)
    zwrite userProcessingRequest

    // Create our business service on IRIS
    do ##class(IOP.Jokes.Services.Main).CreateBusinessService()
    // Process our input (processing request), receive output
    set mainService = ##class(IOP.Jokes.Services.Main).%New()
    do mainService.ProcessInput(userProcessingRequest, .processingResponse)
    zwrite processingResponse

    return $$$OK
}

}
