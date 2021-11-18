package com.example.login.model.repository.data.response

data class LoginResponse(
    var onboardingStatus: Int,
    var deviceRegistrationStatus: Int,
    var name: String,
    var nickname: String,
    var agency: String,
    var accountNumber: String,
    var accountDigit: String,
    var branch: String
) {
    fun onboardingStatusDescription(): String {
        return when (onboardingStatus) {
            0 -> "ONBOARDING_ENABLE"
            1 -> "UNDER_ANALYSIS"
            2 -> "REJECTED"
            3 -> "PENDING_DOCUMENT_COMPLIANCE"
            4 -> "APPROVED_NOT_FINALIZED"
            5 -> "APPROVED_FINALIZED"
            6 -> "IN_SUBMISSION"
            7 -> "TEMPEST"
            10 -> "PENDING_REJECTION"
            else -> "UNKOWN"
        }
    }

    fun deviceRegistrationDescription(): String {
        return when (deviceRegistrationStatus) {
            1 -> "ACTIVE"
            2 -> "BLOCKED"
            3 -> "SUSPENDED"
            4 -> "UNREGISTERED_BY_SYSTEM"
            5 -> "UNREGISTERED_BY_USER"
            6 -> "PENDING_VALIDATION"
            7 -> "VALIDATED"
            8 -> "PENDING_VALID_ACCESS_CODE"
            else -> "UNKOWN"
        }
    }

    val isOnBoardingEnable: Boolean = onboardingStatus == 0
    val isOnBoardingUnderAnalysis: Boolean = onboardingStatus == 1
    val isOnBoardingRejected: Boolean = onboardingStatus == 2
    val isOnBoardingPendingDocumentCompliance: Boolean = onboardingStatus == 3
    val isOnBoardingApprovedNotFinalized: Boolean = onboardingStatus == 4
    val isOnBoardingApprovedFinalized: Boolean = onboardingStatus == 5
    val isOnBoardingInSubmission: Boolean = onboardingStatus == 6

    val isDeviceActive: Boolean = deviceRegistrationStatus == 1
    val isDeviceBlocked: Boolean = deviceRegistrationStatus == 2
    val isDeviceSuspended: Boolean = deviceRegistrationStatus == 3
    val isDeviceUnregisteredBySystem: Boolean = deviceRegistrationStatus == 4
    val isDeviceUnregisteredByUser: Boolean = deviceRegistrationStatus == 5
    val isDevicePendingValidation: Boolean = deviceRegistrationStatus == 6
    val isDeviceValidated: Boolean = deviceRegistrationStatus == 7
    val isDevicePendingValidAccessCode: Boolean = deviceRegistrationStatus == 8

}