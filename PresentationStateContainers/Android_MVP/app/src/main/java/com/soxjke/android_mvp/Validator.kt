package com.soxjke.android_mvp

interface Validator<ErrorType: Throwable> {
    fun validate(string: String): ErrorType?
}