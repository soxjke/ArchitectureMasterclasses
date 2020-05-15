package com.soxjke.android_mvp

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.fragment.app.Fragment
import androidx.navigation.findNavController

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    private lateinit var loginPresenter: LoginPresenter
    fun onFragmentAttach(fragment: Fragment) {
        when (fragment) {
            is LoginFragment -> loginPresenter = LoginPresenter(fragment)
        }
    }
}
