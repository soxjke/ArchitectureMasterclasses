package com.soxjke.android_mvvm.ui.main

interface Validator<ErrorType: Throwable> {
    fun validate(string: String): ErrorType?
}