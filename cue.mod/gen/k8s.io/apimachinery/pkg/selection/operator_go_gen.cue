// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go k8s.io/apimachinery/pkg/selection

package selection

// Operator represents a key/field's relationship to value(s).
// See labels.Requirement and fields.Requirement for more details.
#Operator: string // #enumOperator

#enumOperator:
	#DoesNotExist |
	#Equals |
	#DoubleEquals |
	#In |
	#NotEquals |
	#NotIn |
	#Exists |
	#GreaterThan |
	#LessThan

#DoesNotExist: #Operator & "!"
#Equals:       #Operator & "="
#DoubleEquals: #Operator & "=="
#In:           #Operator & "in"
#NotEquals:    #Operator & "!="
#NotIn:        #Operator & "notin"
#Exists:       #Operator & "exists"
#GreaterThan:  #Operator & "gt"
#LessThan:     #Operator & "lt"
