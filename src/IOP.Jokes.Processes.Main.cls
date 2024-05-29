Class IOP.Jokes.Processes.Main Extends Ens.BusinessProcess
{

// how to add business process to iris production via code?

Method OnRequest(request As %Library.Persistent, Output response As %Library.Persistent) As %Status
{
    set requestStatus=$$$OK
    write "YOOO from process OnRequest...:"
    zwrite request
    set operatingRequest = ##class(IOP.Jokes.Messages.OperatingRequest).%New(request)


    return requestStatus
}

Method OnResponse(request As %Library.Persistent, ByRef response As %Library.Persistent, callrequest As %Library.Persistent, callresponse As %Library.Persistent, pCompletionKey As %String) As %Status
{
    write "not implemented"
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
