package com.github.ccxxxi.ecnutimetable.ecnudb

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import androidx.lifecycle.*
import com.github.ccxxxi.ecnutimetable.R
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

                // 验证码图片
                // 直接用InputStream格式的图片会出错，ByteArray就没问题，magic
                val arr = session.captchaImg
                val img = BitmapFactory.decodeByteArray(arr, 0, arr.size)
                    ?: TODO("拿不到验证码图片")
                _captchaImg.postValue(img)
            }
        }
    }

    private val _loginForm = MutableLiveData<LoginFormState>()
    val formState: LiveData<LoginFormState> = _loginForm

    private val _loginResult = MutableLiveData<LoginResult>()
    val loginResult: LiveData<LoginResult> = _loginResult

    fun getTimetable(username: String, password: String, captcha: String) = viewModelScope.launch {
        // todo: disable input until login finish
        withContext(Dispatchers.IO) {
            val loginResult1 = session.login(username, password, captcha)
            _loginResult.postValue(loginResult1)

            session.getTimetable()
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

sealed class LoginResult
data class Error(val errorMessage: String) : LoginResult()
data class Success(val realName: String) : LoginResult()
