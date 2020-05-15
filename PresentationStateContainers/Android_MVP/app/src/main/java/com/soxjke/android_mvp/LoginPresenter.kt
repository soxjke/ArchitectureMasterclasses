package com.soxjke.android_mvp

import android.util.Log

class LoginPresenter(private val fragment: LoginFragment) {
    private var login = ValidatableField<LoginValidator.Error>()
    private var loginValidator = LoginValidator()
    private var password = ValidatableField<PasswordValidator.Error>()
    private var passwordValidator = PasswordValidator()

    init {
        present()
    }

    fun present() {
        fragment.render(makeProps())
    }

    private fun makeProps(): LoginFragment.Props {
        return LoginFragment.Props(
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
        present()
    }

    private fun loginEditingChanged(text: String) {
        login.text = text
        present()
    }

    private fun loginEndEditing(text: String) {
        login.error = loginValidator.validate(text);
        present()
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
        present()
    }

    private fun passwordEditingChanged(text: String) {
        password.text = text
        present()
    }

    private fun passwordEndEditing(text: String) {
        password.error = passwordValidator.validate(text);
        present()
    }

    private fun loginAction() {
        // Call login method
        Log.d("","LoginPresenter now will call login with:\n${login.text}\n${password.text}")
    }
}