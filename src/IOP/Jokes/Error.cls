Class IOP.Jokes.Error Extends (%RegisteredObject, %JSON.Adaptor)
{

Property Description As %String(MAXLEN = "");

/// utc
Property Time As %DateTime [ InitialExpression = {$zdatetime($ztimestamp,3)} ];

ClassMethod Create(description As %String) As Error [ Final ]
{
	#dim ex = ##class(Error).%New()
	set ex.Description = description
	return ex
}

ClassMethod CreateFromJson(json As %String) As Error [ Final ]
{
	#dim ex = ##class(Error).%New()
	do ex.%JSONImport(json)
	return ex
}

ClassMethod CreateFromStatus(status As %Status) As Error [ Final ]
{
	#dim statusDetails // md
	do $system.Status.DecomposeStatus(status, .statusDetails)
	return ..CreateFromJson(statusDetails(1,"param",2))
}

/// Does %Status contains this Error object, possibly embedded, or not
ClassMethod IsStatusContainsError(status As %Status) As %Boolean [ Final ]
{
	#dim statusDetails // md
	do $system.Status.DecomposeStatus(status, .statusDetails)
	if (($get(statusDetails(1,"code")) = 83) && ($get(statusDetails(1,"param",1)) = ..%ClassName(1))) {
		return 1
	}

	#dim embeddedStatus as %Status = $get(statusDetails(1,"embeddedstatus"))
	if (embeddedStatus '= "") {
		return ..IsStatusContainsError(embeddedStatus)
	}
	
	return 0
}

/// Unwraps embedded statuses and returns the first %Status that encapsulates Error.
/// IRIS IOP wraps the error %Status.
ClassMethod UnwrapStatusError(status As %Status) As %Status [ Final ]
{
	#dim statusDetails // md
	do $system.Status.DecomposeStatus(status, .statusDetails)
	if (($get(statusDetails(1,"code")) = 83) && ($get(statusDetails(1,"param",1)) = ..%ClassName(1))) {
		return status
	}

	#dim embeddedStatus as %Status = $get(statusDetails(1,"embeddedstatus"))
	if (embeddedStatus '= "") {
		return ..UnwrapStatusError(embeddedStatus)
	}
	
	return 1
}

/// Helper function to combine errors for pretty printing
ClassMethod CombineErrorEntities(inputFamilyError As %String, inputAmountError As %String, Output serialisedError As %String) As %Status [ Final ]
{
	set combinedError = ##class(%DynamicObject).%New()
	set combinedError.FamilyError = inputFamilyError
	set combinedError.AmountError = inputAmountError
	set serialisedError = combinedError.%ToJSON()

	return $$$OK
}

Method DisplayString(pLevel As %Integer = 0) As %String
{
	return ..ExportToJson()
}

Method ExportToStatus() As %Status [ Final ]
{
	// 83 is InterSystems magic number for custom error message
	// https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=RERR_gen
	return $$$ERROR(83,..%ClassName(1),..ExportToJson())
}

Method ExportToJson() As %String [ Final ]
{
	#dim asJson as %String
	do ..%JSONExportToString(.asJson)
	return asJson
}

}
