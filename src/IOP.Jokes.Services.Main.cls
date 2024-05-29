Class IOP.Jokes.Services.Main Extends Ens.BusinessService
{

ClassMethod CreateBusinessService(productionName As %Dictionary.CacheClassname = "INTEROPuEXERCISEPKG.FoundationProduction", name As %String = "JokesBusinessService", class As %Dictionary.CacheClassname = "IOP.Jokes.Services.Main") As %Status
{
    // Set our production
    set production = ##class(Ens.Config.Production).%OpenId(productionName)
    
    // Create new item/business host
    set item = ##class(Ens.Config.Item).%New()
    set item.PoolSize = 1
    set item.Name = name
    set item.ClassName = class
    set item.Enabled = $$$YES

    // Add our new item/business host to the IRIS production
    set sc = production.Items.Insert(item)
    if ($$$ISERR(sc)){
        return $SYSTEM.Status.Error($$$GeneralError,">_ Error adding item to production object.")
    }

    // Sync changes to IRIS server/this production
    set sc = ##class(EnsPortal.Template.prodConfigSCPage).CallProductionUpdateAndSaveToClass(production,"","SaveProduction")
    if ($$$ISERR(sc)){
        return $SYSTEM.Status.Error($$$GeneralError,">_ Error syncing production to IRIS server.")
    }

    write ">_ Added business service to IRIS production", !
    return $$$OK
}

Method %OnNew() As %Status
{
    return $$$OK
}

Method ProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{

    write ">_ Processing input..."
    set jokeProcess = ##class(IOP.Jokes.Processes.Main).%New()
    do jokeProcess.OnRequest(pInput)

    return $$$OK
}

}
