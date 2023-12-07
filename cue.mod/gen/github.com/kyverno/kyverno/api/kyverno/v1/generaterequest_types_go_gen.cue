// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/kyverno/kyverno/api/kyverno/v1

package v1

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	admissionv1 "k8s.io/api/admission/v1"
	authenticationv1 "k8s.io/api/authentication/v1"
)

// GenerateRequest is a request to process generate rule.
// +genclient
// +k8s:deepcopy-gen:interfaces=k8s.io/apimachinery/pkg/runtime.Object
// +kubebuilder:object:root=true
// +kubebuilder:subresource:status
// +kubebuilder:printcolumn:name="Policy",type="string",JSONPath=".spec.policy"
// +kubebuilder:printcolumn:name="ResourceKind",type="string",JSONPath=".spec.resource.kind"
// +kubebuilder:printcolumn:name="ResourceName",type="string",JSONPath=".spec.resource.name"
// +kubebuilder:printcolumn:name="ResourceNamespace",type="string",JSONPath=".spec.resource.namespace"
// +kubebuilder:printcolumn:name="status",type="string",JSONPath=".status.state"
// +kubebuilder:printcolumn:name="Age",type="date",JSONPath=".metadata.creationTimestamp"
// +kubebuilder:resource:shortName=gr
#GenerateRequest: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta @go(ObjectMeta)

	// Spec is the information to identify the generate request.
	spec: #GenerateRequestSpec @go(Spec)

	// Status contains statistics related to generate request.
	// +optional
	status?: #GenerateRequestStatus @go(Status)
}

// GenerateRequestSpec stores the request specification.
#GenerateRequestSpec: {
	// Specifies the name of the policy.
	policy: string @go(Policy)

	// ResourceSpec is the information to identify the generate request.
	resource: #ResourceSpec @go(Resource)

	// Context ...
	context: #GenerateRequestContext @go(Context)
}

// GenerateRequestContext stores the context to be shared.
#GenerateRequestContext: {
	// +optional
	userInfo?: #RequestInfo @go(UserRequestInfo)

	// +optional
	admissionRequestInfo?: #AdmissionRequestInfoObject @go(AdmissionRequestInfo)
}

// AdmissionRequestInfoObject stores the admission request and operation details
#AdmissionRequestInfoObject: {
	// +optional
	admissionRequest?: string @go(AdmissionRequest)

	// +optional
	operation?: admissionv1.#Operation @go(Operation)
}

// RequestInfo contains permission info carried in an admission request.
#RequestInfo: {
	// Roles is a list of possible role send the request.
	// +nullable
	// +optional
	roles?: [...string] @go(Roles,[]string)

	// ClusterRoles is a list of possible clusterRoles send the request.
	// +nullable
	// +optional
	clusterRoles?: [...string] @go(ClusterRoles,[]string)

	// UserInfo is the userInfo carried in the admission request.
	// +optional
	userInfo?: authenticationv1.#UserInfo @go(AdmissionUserInfo)
}

// GenerateRequestStatus stores the status of generated request.
#GenerateRequestStatus: {
	// State represents state of the generate request.
	state: #GenerateRequestState @go(State)

	// Specifies request status message.
	// +optional
	message?: string @go(Message)

	// This will track the resources that are generated by the generate Policy.
	// Will be used during clean up resources.
	generatedResources?: [...#ResourceSpec] @go(GeneratedResources,[]ResourceSpec)
}

// GenerateRequestState defines the state of request.
#GenerateRequestState: string // #enumGenerateRequestState

#enumGenerateRequestState:
	#Pending |
	#Failed |
	#Completed |
	#Skip

// Pending - the Request is yet to be processed or resource has not been created.
#Pending: #GenerateRequestState & "Pending"

// Failed - the Generate Request Controller failed to process the rules.
#Failed: #GenerateRequestState & "Failed"

// Completed - the Generate Request Controller created resources defined in the policy.
#Completed: #GenerateRequestState & "Completed"

// Skip - the Generate Request Controller skips to generate the resource.
#Skip: #GenerateRequestState & "Skip"

// GenerateRequestList stores the list of generate requests.
#GenerateRequestList: {
	metav1.#TypeMeta
	metadata: metav1.#ListMeta @go(ListMeta)
	items: [...#GenerateRequest] @go(Items,[]GenerateRequest)
}
