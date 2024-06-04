Class IOP.Jokes.Messages.OperatingRequest Extends Ens.Request
{

Property ValidatedFamily As %String(MAXLEN = 25);

Property ValidatedAmount As %Integer;

Method %OnNew(family As %String, amount As %Integer) As %Status
{
    set ..ValidatedFamily = family
    set ..ValidatedAmount = amount
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
</Data>
<DefaultData>OperatingRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
