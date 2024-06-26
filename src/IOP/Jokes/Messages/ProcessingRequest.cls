Class IOP.Jokes.Messages.ProcessingRequest Extends Ens.Request
{

Property Family As %String(MAXLEN = 25);

Property Amount As %Integer;

Method %OnNew(family As %String, amount As %Integer) As %Status
{
    set ..Family = family
    set ..Amount = amount
    return $$$OK
}

Storage Default
{
<Data name="ProcessingRequestDefaultData">
<Subscript>"ProcessingRequest"</Subscript>
<Value name="1">
<Value>Family</Value>
</Value>
<Value name="2">
<Value>Amount</Value>
</Value>
</Data>
<DefaultData>ProcessingRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
