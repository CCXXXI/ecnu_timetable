package com.github.ccxxxi.ecnutimetable.ecnudb

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import androidx.lifecycle.*
import com.github.ccxxxi.ecnutimetable.R
import com.github.ccxxxi.ecnutimetable.Session
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class EcnudbViewModel : ViewModel() {
    private lateinit var session: Session

    private val _captchaImg = MutableLiveData<Bitmap>()
    val captchaImg: LiveData<Bitmap> = _captchaImg

    init {
        viewModelScope.launch {
            withContext(Dispatchers.IO) {
                session = Session()
                _captchaImg.postValue(BitmapFactory.decodeFile(session.captchaImg.path))
            }
        }
    }

    private val _loginForm = MutableLiveData<LoginFormState>()
    val formState: LiveData<LoginFormState> = _loginForm

    fun getTimetable(username: String, password: String, captcha: String) = viewModelScope.launch {
        // todo: disable input until login finish
        withContext(Dispatchers.IO) {
            session.login(username, password, captcha)
            // todo: get timetable
        }
    }

    fun loginDataChanged(username: String, password: String, captcha: String) = when {
        username.length != 11 -> {
            _loginForm.value = LoginFormState(usernameError = R.string.invalid_username)
        }
        password.isBlank() -> {
            _loginForm.value = LoginFormState(passwordError = R.string.invalid_password)
        }
        captcha.length != 4 -> {
            _loginForm.value = LoginFormState(captchaError = R.string.invalid_captcha)
        }
        else -> {
            _loginForm.value = LoginFormState(isDataValid = true)
        }
    }
}

data class LoginFormState(
    val usernameError: Int? = null,
    val passwordError: Int? = null,
    val captchaError: Int? = null,
    val isDataValid: Boolean = false,
)

class LoginViewModelFactory : ViewModelProvider.Factory {
    @Suppress("UNCHECKED_CAST")
    override fun <T : ViewModel> create(modelClass: Class<T>): T = EcnudbViewModel() as T
}
