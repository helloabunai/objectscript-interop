Class IOP.Jokes.Messages.OperatingResponse Extends Ens.Response
{

Property ReceivedJokeList As %Library.DynamicObject;

Property HTTPError As %String;

Property TempHTTPDump As %String(MAXLEN = 5000);

Method %OnNew(rawHTTPResponse As %Net.HttpResponse) As %Status
{

    set ..TempHTTPDump = rawHTTPResponse.Data.Read()

    return $$$OK
}

Storage Default
{
<Data name="OperatingResponseDefaultData">
<Subscript>"OperatingResponse"</Subscript>
<Value name="1">
<Value>HTTPError</Value>
</Value>
<Value name="2">
<Value>TempHTTPDump</Value>
</Value>
</Data>
<Data name="ReceivedJokeList">
<Attribute>ReceivedJokeList</Attribute>
<Structure>node</Structure>
<Subscript>"IOP.Jokes.Messages.OperatingResponse.ReceivedJokeList"</Subscript>
</Data>
<DefaultData>OperatingResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
