Class IOP.Jokes.Messages.OperatingResponse Extends Ens.Response
{

Property ReceivedJokesObject As %Library.DynamicObject;

Method %OnNew(rawAPIResponse As %Library.DynamicObject) As %Status
{

    set ..ReceivedJokesObject = rawAPIResponse

    return $$$OK
}

Storage Default
{
<Data name="OperatingResponseDefaultData">
<Subscript>"OperatingResponse"</Subscript>
</Data>
<Data name="ReceivedJokesObject">
<Attribute>ReceivedJokesObject</Attribute>
<Structure>node</Structure>
<Subscript>"IOP.Jokes.Messages.OperatingResponse.ReceivedJokesObject"</Subscript>
</Data>
<DefaultData>OperatingResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
