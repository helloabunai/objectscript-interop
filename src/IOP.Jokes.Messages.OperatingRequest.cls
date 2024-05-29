Class IOP.Jokes.Messages.OperatingRequest Extends %RegisteredObject
{

Property ValidatedFamily As %String(MAXLEN = 25) [ Private ];

Property ValidatedAmount As %Integer [ Private ];

Method %OnNew(incomingRequest As %RegisteredObject) As %Status
{
    write (">_ Creating OperatingRequest")
    set requestedFamily = incomingRequest.Family
    set requestedAmount = incomingRequest.Amount
    if ..ValidateFamily(requestedFamily){
        set ..ValidatedFamily=requestedFamily
    } else {
        throw ##class(IOP.Jokes.Error).%New(
            "Invalid family: "_requestedFamily,
            "Valid families: baconipsum; chucknorris; simpsons",
            "time_goes_here")
    }
    if ..ValidateAmount(requestedAmount){
        set ..ValidatedAmount=requestedAmount
    } else {
        throw ##class(IOP.Jokes.Error).%New(
            "Invalid amount: "_requestedAmount,
            "Valid amounts > 0",
            "time_goes_here")
    }

    return $$$OK
}

Method ValidateFamily(requestFamily As %String) As %Boolean
{
    // implement validation check
    write requestFamily
    return 1
}

Method ValidateAmount(requestAmount As %Integer) As %Boolean
{
    // implement validation check
    write requestAmount
    return 1
}

}
