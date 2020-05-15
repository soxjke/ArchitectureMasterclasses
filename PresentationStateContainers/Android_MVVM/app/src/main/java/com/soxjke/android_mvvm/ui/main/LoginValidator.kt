package com.soxjke.android_mvvm.ui.main

import java.util.regex.Pattern

class LoginValidator: Validator<LoginValidator.Error> {
    sealed class Error: Throwable() {
        object LoginTooShort: Error()
        object LoginTooLong: Error()
        object LoginNonAscii: Error()
    }
    override fun validate(string: String): Error? {
        if (string.length < 3) { return Error.LoginTooShort }
        if (string.length >= 20) { return Error.LoginTooLong }
        val p: Pattern = Pattern.compile("[^a-zA-Z0-9]")
        val hasNonAlphanumerics: Boolean = p.matcher(string).find()
        if (hasNonAlphanumerics) { return Error.LoginNonAscii }
        return null
    }
}