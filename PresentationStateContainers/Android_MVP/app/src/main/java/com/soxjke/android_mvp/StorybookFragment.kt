package com.soxjke.android_mvp

import android.content.Context
import android.os.Bundle
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup

/**
 * A fragment representing a list of Items.
 * Activities containing this fragment MUST implement the
 * [StorybookFragment.OnListFragmentInteractionListener] interface.
 */
class StorybookFragment : Fragment() {

    // TODO: Customize parameters
    private var columnCount = 1
    private val mValues = listOf<String>(
        "default state",
        "login error1",
        "login error2",
        "login error3",
        "password error1",
        "password error2"
    )

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val view = inflater.inflate(R.layout.fragment_storybook_list, container, false)

        // Set the adapter
        if (view is RecyclerView) {
            with(view) {
                layoutManager = when {
                    columnCount <= 1 -> LinearLayoutManager(context)
                    else -> GridLayoutManager(context, columnCount)
                }
                adapter = StorybookFragmentRecyclerViewAdapter(mValues) {
                    val fragment = LoginFragment()
                    when (it) {
                        0 -> {
                            fragment.render(LoginFragment.Props(
                                ValidatableField<LoginValidator.Error>(),
                                ValidatableField<PasswordValidator.Error>(),
                                true,
                                {}
                            ))
                        }
                        1 -> {
                            fragment.render(LoginFragment.Props(
                                ValidatableField<LoginValidator.Error>(LoginValidator.Error.LoginTooShort, "ab"),
                                ValidatableField<PasswordValidator.Error>(null, "123456"),
                                false,
                                {}
                            ))
                        }
                        2 -> {
                            fragment.render(LoginFragment.Props(
                                ValidatableField<LoginValidator.Error>(LoginValidator.Error.LoginTooLong, "abcdefabcdefabcdefabcdef"),
                                ValidatableField<PasswordValidator.Error>(null, "123456"),
                                false,
                                {}
                            ))
                        }
                        3 -> {
                            fragment.render(LoginFragment.Props(
                                ValidatableField<LoginValidator.Error>(LoginValidator.Error.LoginNonAscii, "вітаю"),
                                ValidatableField<PasswordValidator.Error>(null, "123456"),
                                true,
                                {}
                            ))
                        }
                        4 -> {
                            fragment.render(LoginFragment.Props(
                                ValidatableField<LoginValidator.Error>(null, "login"),
                                ValidatableField<PasswordValidator.Error>(PasswordValidator.Error.PasswordTooShort, "12"),
                                true,
                                {}
                            ))
                        }
                        5 -> {
                            fragment.render(LoginFragment.Props(
                                ValidatableField<LoginValidator.Error>(null, "login"),
                                ValidatableField<PasswordValidator.Error>(PasswordValidator.Error.PasswordShouldContainSpecialCharactes, "123456"),
                                true,
                                {}
                            ))
                        }
                    }
                    requireActivity().supportFragmentManager
                        .beginTransaction()
                        .replace(R.id.nav_host_placeholder, fragment)
                        .addToBackStack(null)
                        .commit()
                }
            }
        }
        return view
    }

    override fun onDetach() {
        super.onDetach()
    }
}
