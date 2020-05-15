package com.soxjke.android_mvvm.ui.main

import android.util.Log
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class LoginViewModel : ViewModel() {
    data class Props(
        val login: ValidatableField<LoginValidator.Error>,
        val password: ValidatableField<PasswordValidator.Error>,
        val loginEnabled: Boolean,
        val loginAction: () -> Unit
    )
    var props: MutableLiveData<Props> = MutableLiveData(Props(
        ValidatableField<LoginValidator.Error>(),
        ValidatableField<PasswordValidator.Error>(),
        false,
        {}
    ))
    private var login = ValidatableField<LoginValidator.Error>()
    private var loginValidator = LoginValidator()
    private var password = ValidatableField<PasswordValidator.Error>()
    private var passwordValidator = PasswordValidator()

    init {
        update()
    }

    fun update() {
        props.value = makeProps()
    }

    private fun makeProps(): Props {
        return Props(
            makeLoginField(),
            makePasswordField(),
            loginValidator.validate(login.text) == null && passwordValidator.validate(password.text) == null,
            this::loginAction
        )
    }

    private fun makeLoginField(): ValidatableField<LoginValidator.Error> {
        return ValidatableField<LoginValidator.Error>(
            login.error,
            login.text,
            this::loginStartEditing,
            this::loginEditingChanged,
            this::loginEndEditing
        )
    }

    private fun loginStartEditing(text: String) {
        login.error = null
        update()
    }

    private fun loginEditingChanged(text: String) {
        login.text = text
        update()
    }

    private fun loginEndEditing(text: String) {
        login.error = loginValidator.validate(text);
        update()
    }

    private fun makePasswordField(): ValidatableField<PasswordValidator.Error> {
        return ValidatableField<PasswordValidator.Error>(
            password.error,
            password.text,
            this::passwordStartEditing,
            this::passwordEditingChanged,
            this::passwordEndEditing
        )
    }

    private fun passwordStartEditing(text: String) {
        password.error = null
        update()
    }

    private fun passwordEditingChanged(text: String) {
        password.text = text
        update()
    }

    private fun passwordEndEditing(text: String) {
        password.error = passwordValidator.validate(text);
        update()
    }

    private fun loginAction() {
        // Call login method
        Log.d("","LoginViewModel now will call login with:\n${login.text}\n${password.text}")
    }
}
