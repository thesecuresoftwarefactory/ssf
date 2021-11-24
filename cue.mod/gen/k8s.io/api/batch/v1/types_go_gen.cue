// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go k8s.io/api/batch/v1

package v1

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/api/core/v1"
)

#JobCompletionIndexAnnotationAlpha: "batch.kubernetes.io/job-completion-index"

// Job represents the configuration of a single job.
#Job: {
	metav1.#TypeMeta

	// Standard object's metadata.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	// +optional
	metadata?: metav1.#ObjectMeta @go(ObjectMeta) @protobuf(1,bytes,opt)

	// Specification of the desired behavior of a job.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
	// +optional
	spec?: #JobSpec @go(Spec) @protobuf(2,bytes,opt)

	// Current status of a job.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
	// +optional
	status?: #JobStatus @go(Status) @protobuf(3,bytes,opt)
}

// JobList is a collection of jobs.
#JobList: {
	metav1.#TypeMeta

	// Standard list metadata.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	// +optional
	metadata?: metav1.#ListMeta @go(ListMeta) @protobuf(1,bytes,opt)

	// items is the list of Jobs.
	items: [...#Job] @go(Items,[]Job) @protobuf(2,bytes,rep)
}

// CompletionMode specifies how Pod completions of a Job are tracked.
#CompletionMode: string // #enumCompletionMode

#enumCompletionMode:
	#NonIndexedCompletion |
	#IndexedCompletion

// NonIndexedCompletion is a Job completion mode. In this mode, the Job is
// considered complete when there have been .spec.completions
// successfully completed Pods. Pod completions are homologous to each other.
#NonIndexedCompletion: #CompletionMode & "NonIndexed"

// IndexedCompletion is a Job completion mode. In this mode, the Pods of a
// Job get an associated completion index from 0 to (.spec.completions - 1).
// The Job is  considered complete when a Pod completes for each completion
// index.
#IndexedCompletion: #CompletionMode & "Indexed"

// JobSpec describes how the job execution will look like.
#JobSpec: {
	// Specifies the maximum desired number of pods the job should
	// run at any given time. The actual number of pods running in steady state will
	// be less than this number when ((.spec.completions - .status.successful) < .spec.parallelism),
	// i.e. when the work left to do is less than max parallelism.
	// More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/
	// +optional
	parallelism?: null | int32 @go(Parallelism,*int32) @protobuf(1,varint,opt)

	// Specifies the desired number of successfully finished pods the
	// job should be run with.  Setting to nil means that the success of any
	// pod signals the success of all pods, and allows parallelism to have any positive
	// value.  Setting to 1 means that parallelism is limited to 1 and the success of that
	// pod signals the success of the job.
	// More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/
	// +optional
	completions?: null | int32 @go(Completions,*int32) @protobuf(2,varint,opt)

	// Specifies the duration in seconds relative to the startTime that the job
	// may be continuously active before the system tries to terminate it; value
	// must be positive integer. If a Job is suspended (at creation or through an
	// update), this timer will effectively be stopped and reset when the Job is
	// resumed again.
	// +optional
	activeDeadlineSeconds?: null | int64 @go(ActiveDeadlineSeconds,*int64) @protobuf(3,varint,opt)

	// Specifies the number of retries before marking this job failed.
	// Defaults to 6
	// +optional
	backoffLimit?: null | int32 @go(BackoffLimit,*int32) @protobuf(7,varint,opt)

	// A label query over pods that should match the pod count.
	// Normally, the system sets this field for you.
	// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors
	// +optional
	selector?: null | metav1.#LabelSelector @go(Selector,*metav1.LabelSelector) @protobuf(4,bytes,opt)

	// manualSelector controls generation of pod labels and pod selectors.
	// Leave `manualSelector` unset unless you are certain what you are doing.
	// When false or unset, the system pick labels unique to this job
	// and appends those labels to the pod template.  When true,
	// the user is responsible for picking unique labels and specifying
	// the selector.  Failure to pick a unique label may cause this
	// and other jobs to not function correctly.  However, You may see
	// `manualSelector=true` in jobs that were created with the old `extensions/v1beta1`
	// API.
	// More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/#specifying-your-own-pod-selector
	// +optional
	manualSelector?: null | bool @go(ManualSelector,*bool) @protobuf(5,varint,opt)

	// Describes the pod that will be created when executing a job.
	// More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/
	template: v1.#PodTemplateSpec @go(Template) @protobuf(6,bytes,opt)

	// ttlSecondsAfterFinished limits the lifetime of a Job that has finished
	// execution (either Complete or Failed). If this field is set,
	// ttlSecondsAfterFinished after the Job finishes, it is eligible to be
	// automatically deleted. When the Job is being deleted, its lifecycle
	// guarantees (e.g. finalizers) will be honored. If this field is unset,
	// the Job won't be automatically deleted. If this field is set to zero,
	// the Job becomes eligible to be deleted immediately after it finishes.
	// This field is alpha-level and is only honored by servers that enable the
	// TTLAfterFinished feature.
	// +optional
	ttlSecondsAfterFinished?: null | int32 @go(TTLSecondsAfterFinished,*int32) @protobuf(8,varint,opt)

	// CompletionMode specifies how Pod completions are tracked. It can be
	// `NonIndexed` (default) or `Indexed`.
	//
	// `NonIndexed` means that the Job is considered complete when there have
	// been .spec.completions successfully completed Pods. Each Pod completion is
	// homologous to each other.
	//
	// `Indexed` means that the Pods of a
	// Job get an associated completion index from 0 to (.spec.completions - 1),
	// available in the annotation batch.kubernetes.io/job-completion-index.
	// The Job is considered complete when there is one successfully completed Pod
	// for each index.
	// When value is `Indexed`, .spec.completions must be specified and
	// `.spec.parallelism` must be less than or equal to 10^5.
	//
	// This field is alpha-level and is only honored by servers that enable the
	// IndexedJob feature gate. More completion modes can be added in the future.
	// If the Job controller observes a mode that it doesn't recognize, the
	// controller skips updates for the Job.
	// +optional
	completionMode?: null | #CompletionMode @go(CompletionMode,*CompletionMode) @protobuf(9,bytes,opt,casttype=CompletionMode)

	// Suspend specifies whether the Job controller should create Pods or not. If
	// a Job is created with suspend set to true, no Pods are created by the Job
	// controller. If a Job is suspended after creation (i.e. the flag goes from
	// false to true), the Job controller will delete all active Pods associated
	// with this Job. Users must design their workload to gracefully handle this.
	// Suspending a Job will reset the StartTime field of the Job, effectively
	// resetting the ActiveDeadlineSeconds timer too. This is an alpha field and
	// requires the SuspendJob feature gate to be enabled; otherwise this field
	// may not be set to true. Defaults to false.
	// +optional
	suspend?: null | bool @go(Suspend,*bool) @protobuf(10,varint,opt)
}

// JobStatus represents the current state of a Job.
#JobStatus: {
	// The latest available observations of an object's current state. When a Job
	// fails, one of the conditions will have type "Failed" and status true. When
	// a Job is suspended, one of the conditions will have type "Suspended" and
	// status true; when the Job is resumed, the status of this condition will
	// become false. When a Job is completed, one of the conditions will have
	// type "Complete" and status true.
	// More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/
	// +optional
	// +patchMergeKey=type
	// +patchStrategy=merge
	// +listType=atomic
	conditions?: [...#JobCondition] @go(Conditions,[]JobCondition) @protobuf(1,bytes,rep)

	// Represents time when the job controller started processing a job. When a
	// Job is created in the suspended state, this field is not set until the
	// first time it is resumed. This field is reset every time a Job is resumed
	// from suspension. It is represented in RFC3339 form and is in UTC.
	// +optional
	startTime?: null | metav1.#Time @go(StartTime,*metav1.Time) @protobuf(2,bytes,opt)

	// Represents time when the job was completed. It is not guaranteed to
	// be set in happens-before order across separate operations.
	// It is represented in RFC3339 form and is in UTC.
	// The completion time is only set when the job finishes successfully.
	// +optional
	completionTime?: null | metav1.#Time @go(CompletionTime,*metav1.Time) @protobuf(3,bytes,opt)

	// The number of actively running pods.
	// +optional
	active?: int32 @go(Active) @protobuf(4,varint,opt)

	// The number of pods which reached phase Succeeded.
	// +optional
	succeeded?: int32 @go(Succeeded) @protobuf(5,varint,opt)

	// The number of pods which reached phase Failed.
	// +optional
	failed?: int32 @go(Failed) @protobuf(6,varint,opt)

	// CompletedIndexes holds the completed indexes when .spec.completionMode =
	// "Indexed" in a text format. The indexes are represented as decimal integers
	// separated by commas. The numbers are listed in increasing order. Three or
	// more consecutive numbers are compressed and represented by the first and
	// last element of the series, separated by a hyphen.
	// For example, if the completed indexes are 1, 3, 4, 5 and 7, they are
	// represented as "1,3-5,7".
	// +optional
	completedIndexes?: string @go(CompletedIndexes) @protobuf(7,bytes,opt)
}

#JobConditionType: string // #enumJobConditionType

#enumJobConditionType:
	#JobSuspended |
	#JobComplete |
	#JobFailed

// JobSuspended means the job has been suspended.
#JobSuspended: #JobConditionType & "Suspended"

// JobComplete means the job has completed its execution.
#JobComplete: #JobConditionType & "Complete"

// JobFailed means the job has failed its execution.
#JobFailed: #JobConditionType & "Failed"

// JobCondition describes current state of a job.
#JobCondition: {
	// Type of job condition, Complete or Failed.
	type: #JobConditionType @go(Type) @protobuf(1,bytes,opt,casttype=JobConditionType)

	// Status of the condition, one of True, False, Unknown.
	status: v1.#ConditionStatus @go(Status) @protobuf(2,bytes,opt,casttype=k8s.io/api/core/v1.ConditionStatus)

	// Last time the condition was checked.
	// +optional
	lastProbeTime?: metav1.#Time @go(LastProbeTime) @protobuf(3,bytes,opt)

	// Last time the condition transit from one status to another.
	// +optional
	lastTransitionTime?: metav1.#Time @go(LastTransitionTime) @protobuf(4,bytes,opt)

	// (brief) reason for the condition's last transition.
	// +optional
	reason?: string @go(Reason) @protobuf(5,bytes,opt)

	// Human readable message indicating details about last transition.
	// +optional
	message?: string @go(Message) @protobuf(6,bytes,opt)
}

// JobTemplateSpec describes the data a Job should have when created from a template
#JobTemplateSpec: {
	// Standard object's metadata of the jobs created from this template.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	// +optional
	metadata?: metav1.#ObjectMeta @go(ObjectMeta) @protobuf(1,bytes,opt)

	// Specification of the desired behavior of the job.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
	// +optional
	spec?: #JobSpec @go(Spec) @protobuf(2,bytes,opt)
}

// CronJob represents the configuration of a single cron job.
#CronJob: {
	metav1.#TypeMeta

	// Standard object's metadata.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	// +optional
	metadata?: metav1.#ObjectMeta @go(ObjectMeta) @protobuf(1,bytes,opt)

	// Specification of the desired behavior of a cron job, including the schedule.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
	// +optional
	spec?: #CronJobSpec @go(Spec) @protobuf(2,bytes,opt)

	// Current status of a cron job.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
	// +optional
	status?: #CronJobStatus @go(Status) @protobuf(3,bytes,opt)
}

// CronJobList is a collection of cron jobs.
#CronJobList: {
	metav1.#TypeMeta

	// Standard list metadata.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	// +optional
	metadata?: metav1.#ListMeta @go(ListMeta) @protobuf(1,bytes,opt)

	// items is the list of CronJobs.
	items: [...#CronJob] @go(Items,[]CronJob) @protobuf(2,bytes,rep)
}

// CronJobSpec describes how the job execution will look like and when it will actually run.
#CronJobSpec: {
	// The schedule in Cron format, see https://en.wikipedia.org/wiki/Cron.
	schedule: string @go(Schedule) @protobuf(1,bytes,opt)

	// Optional deadline in seconds for starting the job if it misses scheduled
	// time for any reason.  Missed jobs executions will be counted as failed ones.
	// +optional
	startingDeadlineSeconds?: null | int64 @go(StartingDeadlineSeconds,*int64) @protobuf(2,varint,opt)

	// Specifies how to treat concurrent executions of a Job.
	// Valid values are:
	// - "Allow" (default): allows CronJobs to run concurrently;
	// - "Forbid": forbids concurrent runs, skipping next run if previous run hasn't finished yet;
	// - "Replace": cancels currently running job and replaces it with a new one
	// +optional
	concurrencyPolicy?: #ConcurrencyPolicy @go(ConcurrencyPolicy) @protobuf(3,bytes,opt,casttype=ConcurrencyPolicy)

	// This flag tells the controller to suspend subsequent executions, it does
	// not apply to already started executions.  Defaults to false.
	// +optional
	suspend?: null | bool @go(Suspend,*bool) @protobuf(4,varint,opt)

	// Specifies the job that will be created when executing a CronJob.
	jobTemplate: #JobTemplateSpec @go(JobTemplate) @protobuf(5,bytes,opt)

	// The number of successful finished jobs to retain. Value must be non-negative integer.
	// Defaults to 3.
	// +optional
	successfulJobsHistoryLimit?: null | int32 @go(SuccessfulJobsHistoryLimit,*int32) @protobuf(6,varint,opt)

	// The number of failed finished jobs to retain. Value must be non-negative integer.
	// Defaults to 1.
	// +optional
	failedJobsHistoryLimit?: null | int32 @go(FailedJobsHistoryLimit,*int32) @protobuf(7,varint,opt)
}

// ConcurrencyPolicy describes how the job will be handled.
// Only one of the following concurrent policies may be specified.
// If none of the following policies is specified, the default one
// is AllowConcurrent.
#ConcurrencyPolicy: string // #enumConcurrencyPolicy

#enumConcurrencyPolicy:
	#AllowConcurrent |
	#ForbidConcurrent |
	#ReplaceConcurrent

// AllowConcurrent allows CronJobs to run concurrently.
#AllowConcurrent: #ConcurrencyPolicy & "Allow"

// ForbidConcurrent forbids concurrent runs, skipping next run if previous
// hasn't finished yet.
#ForbidConcurrent: #ConcurrencyPolicy & "Forbid"

// ReplaceConcurrent cancels currently running job and replaces it with a new one.
#ReplaceConcurrent: #ConcurrencyPolicy & "Replace"

// CronJobStatus represents the current state of a cron job.
#CronJobStatus: {
	// A list of pointers to currently running jobs.
	// +optional
	// +listType=atomic
	active?: [...v1.#ObjectReference] @go(Active,[]v1.ObjectReference) @protobuf(1,bytes,rep)

	// Information when was the last time the job was successfully scheduled.
	// +optional
	lastScheduleTime?: null | metav1.#Time @go(LastScheduleTime,*metav1.Time) @protobuf(4,bytes,opt)

	// Information when was the last time the job successfully completed.
	// +optional
	lastSuccessfulTime?: null | metav1.#Time @go(LastSuccessfulTime,*metav1.Time) @protobuf(5,bytes,opt)
}
