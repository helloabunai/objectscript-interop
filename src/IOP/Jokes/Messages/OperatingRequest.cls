Class IOP.Jokes.Messages.OperatingRequest Extends Ens.Request
{

Property ValidatedFamily As %String(MAXLEN = 25);

Property ValidatedAmount As %Integer;

Property TargetServer As %String(MAXLEN = 100);

Property TargetPort As %Integer;

Property UseHTTPS As %Boolean;

Property TargetEndpoint As %String(MAXLEN = 100);

/// 
/// Note about API calls
/// We are using wiremock in order to emulate endpoints for this exercise
/// We are not calling actual HTTP APIs over the internet
/// 
/// Also, as IRIS is running within docker, and wiremock on host-mac/pc
/// Use host.docker.internal instead of localhost
/// 
/// From the repo folder, run:
/// wiremock --verbose --port=PORT --disable-gzip --global-response-templating --root-dir ./wiremock/`
Method %OnNew(family As %String, amount As %Integer) As %Status
{
    set ..ValidatedFamily = family
    set ..ValidatedAmount = amount
    if (..ValidatedFamily = "simpsons"){
        //set ..TargetServer = "thesimpsonsquoteapi.glitch.me"
        // is there a better mechanism to do this eg. "/quotes?count={}".format(ValidatedAmount)
        //set ..TargetEndpoint = "/quotes?count=3"
        //set ..UseHTTPS = 1
        
        set ..TargetServer = "host.docker.internal"
        set ..TargetPort = 9999
        set ..UseHTTPS = 0
        set ..TargetEndpoint = "/simpsons/random" //wip
    }
    if (..ValidatedFamily = "chucknorris"){
        //set ..TargetServer = "api.chucknorris.io"
        //set ..TargetEndpoint = "/jokes/random"
        //set ..UseHTTPS = 1

        set ..TargetServer = "host.docker.internal"
        set ..TargetPort = 9999
        set ..UseHTTPS = 0
        set ..TargetEndpoint = "/chucknorris/random" //wip
    }
    #; if (..ValidatedFamily = "baconipsum"){
    #;     $$$TRACE("OperatingRequest for baconipsum not implemented.")
    #; }
 
    return $$$OK
}

Storage Default
{
<Data name="OperatingRequestDefaultData">
<Subscript>"OperatingRequest"</Subscript>
<Value name="1">
<Value>ValidatedFamily</Value>
</Value>
<Value name="2">
<Value>ValidatedAmount</Value>
</Value>
<Value name="3">
<Value>TargetServer</Value>
</Value>
<Value name="4">
<Value>TargetPort</Value>
</Value>
<Value name="5">
<Value>UseHTTPS</Value>
</Value>
<Value name="6">
<Value>TargetEndpoint</Value>
</Value>
</Data>
<DefaultData>OperatingRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
