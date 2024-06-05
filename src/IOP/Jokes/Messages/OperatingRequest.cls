Class IOP.Jokes.Messages.OperatingRequest Extends Ens.Request
{

Property ValidatedFamily As %String(MAXLEN = 25);

Property ValidatedAmount As %Integer;

Property TargetServer As %String(MAXLEN = 100);

Property UseHTTPS As %Boolean;

Property TargetEndpoint As %String(MAXLEN = 100);

Method %OnNew(family As %String, amount As %Integer) As %Status
{
    set ..ValidatedFamily = family
    set ..ValidatedAmount = amount
    if (..ValidatedFamily = "simpsons"){
        set ..TargetServer = "thesimspsonsquoteapi.glitch.me"
        set ..UseHTTPS = 1
        // is there a better mechanism to do this eg. "/quotes?count={}".format(ValidatedAmount)
        set ..TargetEndpoint = "/quotes?count="_ ..ValidatedAmount
    }
    if (..ValidatedFamily = "chucknorris"){
        set ..TargetServer = "api.chucknorris.io"
        set ..UseHTTPS = 1
        set ..TargetEndpoint = "/jokes/random"
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
<Value>UseHTTPS</Value>
</Value>
<Value name="5">
<Value>TargetEndpoint</Value>
</Value>
</Data>
<DefaultData>OperatingRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
