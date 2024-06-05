Class IOP.Jokes.Messages.OperatingResponse Extends Ens.Response
{

Property ReceivedJokeList As %Library.DynamicObject;

Method %OnNew(rawHTTPResponse As %Net.HttpResponse) As %Status
{
    write !!, "Hello this is an operating response lol wip", !!
    zwrite rawHTTPResponse

    return $$$OK
}

Storage Default
{
<Data name="ReceivedJokeList">
<Attribute>ReceivedJokeList</Attribute>
<Structure>node</Structure>
<Subscript>"IOP.Jokes.Messages.OperatingResponse.ReceivedJokeList"</Subscript>
</Data>
<Type>%Storage.Persistent</Type>
}

}
