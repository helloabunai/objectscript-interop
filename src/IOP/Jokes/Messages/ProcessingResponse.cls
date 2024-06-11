Class IOP.Jokes.Messages.ProcessingResponse Extends Ens.Response
{

Property Family As %String(MAXLEN = 200);

Property Joke As %String(MAXLEN = 1000);

Property FamilyError As %String(MAXLEN = 200);

Property AmountError As %String(MAXLEN = 200);

Method %OnNew(family As %String = "", inputJoke As %String = "", inputFamilyError As %String = "", inputAmountError As %String = "") As %Status
{
    if (family'="")
    {
        set ..Family=family
    }
    if (inputJoke'="")
    {
        set ..Joke=inputJoke
    }

    if (inputFamilyError'="")
    {
        set ..FamilyError=inputFamilyError
    }

    if (inputAmountError'="")
    {
        set ..AmountError=inputAmountError
    }

    return $$$OK
}

Storage Default
{
<Data name="ProcessingResponseDefaultData">
<Subscript>"ProcessingResponse"</Subscript>
<Value name="1">
<Value>Family</Value>
</Value>
<Value name="2">
<Value>Joke</Value>
</Value>
<Value name="3">
<Value>FamilyError</Value>
</Value>
<Value name="4">
<Value>AmountError</Value>
</Value>
</Data>
<DefaultData>ProcessingResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
