// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/tektoncd/pipeline/pkg/apis/pipeline/v1beta1

package v1beta1

#ParamsPrefix: "params"

// ParamSpec defines arbitrary parameters needed beyond typed inputs (such as
// resources). Parameter values are provided by users as inputs on a TaskRun
// or PipelineRun.
#ParamSpec: {
	// Name declares the name by which a parameter is referenced.
	name: string @go(Name)

	// Type is the user-specified type of the parameter. The possible types
	// are currently "string", "array" and "object", and "string" is the default.
	// +optional
	type?: #ParamType @go(Type)

	// Description is a user-facing description of the parameter that may be
	// used to populate a UI.
	// +optional
	description?: string @go(Description)

	// Properties is the JSON Schema properties to support key-value pairs parameter.
	// +optional
	properties?: {[string]: #PropertySpec} @go(Properties,map[string]PropertySpec)

	// Default is the value a parameter takes if no input value is supplied. If
	// default is set, a Task may be executed without a supplied value for the
	// parameter.
	// +optional
	default?: null | #ParamValue @go(Default,*ParamValue)
}

// ParamSpecs is a list of ParamSpec
#ParamSpecs: [...#ParamSpec]

// PropertySpec defines the struct for object keys
#PropertySpec: {
	type?: #ParamType @go(Type)
}

// Param declares an ParamValues to use for the parameter called name.
#Param: {
	name:  string      @go(Name)
	value: #ParamValue @go(Value)
}

// Params is a list of Param
#Params: [...#Param]

// ParamType indicates the type of an input parameter;
// Used to distinguish between a single string and an array of strings.
#ParamType: string // #enumParamType

#enumParamType:
	#ParamTypeString |
	#ParamTypeArray |
	#ParamTypeObject

#ParamTypeString: #ParamType & "string"
#ParamTypeArray:  #ParamType & "array"
#ParamTypeObject: #ParamType & "object"

// ParamValue is a type that can hold a single string or string array.
// Used in JSON unmarshalling so that a single JSON field can accept
// either an individual string or an array of strings.
#ParamValue: _

// ArrayOrString is deprecated, this is to keep backward compatibility
//
// Deprecated: Use ParamValue instead.
#ArrayOrString: _
