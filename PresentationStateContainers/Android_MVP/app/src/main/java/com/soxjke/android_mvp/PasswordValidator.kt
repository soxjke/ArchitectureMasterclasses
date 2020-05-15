package com.soxjke.android_mvp

import java.util.regex.Pattern

class PasswordValidator: Validator<PasswordValidator.Error> {
    sealed class Error: Throwable() {
        object PasswordTooShort: Error()
        object PasswordShouldContainSpecialCharactes: Error()
    }
    override fun validate(string: String): Error? {
        if (string.length < 6) { return Error.PasswordTooShort }
        val p: Pattern = Pattern.compile("[^a-zA-Z0-9]")
        val hasNonAlphanumerics: Boolean = p.matcher(string).find()
        if (!hasNonAlphanumerics) { return Error.PasswordShouldContainSpecialCharactes }
        return null
    }
}