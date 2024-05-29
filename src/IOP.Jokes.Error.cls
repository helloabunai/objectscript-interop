Class IOP.Jokes.Error Extends %Exception.AbstractException
{

Property Description As %String(MAXLEN = 30) [ Private ];

Property Detail As %String(MAXLEN = 30) [ Private ];

Property Time As %String(MAXLEN = 50) [ Private ];

Method %OnNew(inputDescription As %String, inputDetail As %String, errorTime As %String) As %Status
{
    set ..Description=inputDescription
    set ..Detail=inputDetail
    set ..Time=errorTime

    Return $$$ERROR($$$GeneralError)
}

}
