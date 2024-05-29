Class IOP.Jokes.Messages.ProcessingRequest Extends %RegisteredObject
{

Property Family As %String(MAXLEN = 25);

Property Amount As %Integer;

Method %OnNew(family As %String, amount As %Integer) As %Status
{
    write ">_ Creating Processing request with provided args...", !
    set ..Family = family
    set ..Amount = amount
    return $$$OK
}

}
