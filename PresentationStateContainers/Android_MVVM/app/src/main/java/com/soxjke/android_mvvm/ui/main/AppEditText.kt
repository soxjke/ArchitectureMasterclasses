package com.soxjke.android_mvvm.ui.main

import android.content.Context
import android.text.Editable
import android.text.TextWatcher
import android.util.AttributeSet
import com.google.android.material.textfield.TextInputEditText

class AppEditText(context: Context, aset: AttributeSet): TextInputEditText(context, aset) {
    class Watcher(val afterTextChanged: (String) -> Unit): TextWatcher {
        var shouldInvoke: Boolean = true
        override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
        }

        override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {
        }

        override fun afterTextChanged(editable: Editable?) {
            if (shouldInvoke) { afterTextChanged.invoke(editable.toString()) }
        }
    }
    private var watcher: Watcher? = null
    fun afterTextChanged(afterTextChanged: (String) -> Unit) {
        watcher?.let { this.removeTextChangedListener(it) }
        this.watcher = Watcher(afterTextChanged)
        this.addTextChangedListener(watcher)
    }
    fun appSetText(text: String) {
        watcher?.shouldInvoke = false
        this.setText(text)
        watcher?.shouldInvoke = true
    }
}