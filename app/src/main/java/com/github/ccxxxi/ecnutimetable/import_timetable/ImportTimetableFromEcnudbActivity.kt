package cn.edu.ecnu.timetable.ui.import_timetable

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.View
import android.widget.EditText
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.ViewModelProvider
import cn.edu.ecnu.timetable.databinding.ActivityImportTimetableFromEcnudbBinding
import com.googlecode.tesseract.android.Ocr

class ImportTimetableFromEcnudbActivity : AppCompatActivity() {
    private lateinit var ecnudbViewModel: EcnudbViewModel
    private lateinit var binding: ActivityImportTimetableFromEcnudbBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityImportTimetableFromEcnudbBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val username = binding.username
        val password = binding.password
        val captchaVal = binding.captchaVal
        val captchaImg = binding.captchaImg
        val getTimetable = binding.getTimetable
        val loading = binding.loading

        ecnudbViewModel = ViewModelProvider(this, LoginViewModelFactory())
            .get(EcnudbViewModel::class.java)

        ecnudbViewModel.captchaImg.observe(this@ImportTimetableFromEcnudbActivity, {
            val img = it!!

            // show captcha image
            captchaImg.setImageBitmap(img)

            // recognize the captcha automatically
            val v = Ocr(this).rec(it)
            captchaVal.setText(v)
        })

        ecnudbViewModel.formState.observe(this@ImportTimetableFromEcnudbActivity, {
            val state = it!!

            // button is enabled iff data is valid
            getTimetable.isEnabled = state.isDataValid

            // show error message if any
            username.error = state.usernameError?.let(::getString)
            password.error = state.passwordError?.let(::getString)
            captchaVal.error = state.captchaError?.let(::getString)
        })

        fun loginDataChanged() = ecnudbViewModel.loginDataChanged(
            username.text.toString(),
            password.text.toString(),
            captchaVal.text.toString(),
        )
        username.afterTextChanged(::loginDataChanged)
        password.afterTextChanged(::loginDataChanged)
        captchaVal.afterTextChanged(::loginDataChanged)

        fun getTimetable() {
            if (!getTimetable.isEnabled) return

            loading.visibility = View.VISIBLE

            ecnudbViewModel.getTimetable(
                username.text.toString(),
                password.text.toString(),
                captchaVal.text.toString(),
            )
        }
        // todo: more listener; 验证码已自动识别，不需要把焦点挪过去
        captchaVal.setOnEditorActionListener { _, _, _ ->
            getTimetable()
            true
        }
        getTimetable.setOnClickListener { getTimetable() }
    }
}

/**
 * Extension function to simplify setting an afterTextChanged action to EditText components.
 */
fun EditText.afterTextChanged(afterTextChanged: () -> Unit) {
    this.addTextChangedListener(object : TextWatcher {
        override fun afterTextChanged(editable: Editable?) = afterTextChanged.invoke()
        override fun beforeTextChanged(s: CharSequence, start: Int, count: Int, after: Int) = Unit
        override fun onTextChanged(s: CharSequence, start: Int, before: Int, count: Int) = Unit
    })
}
