package com.github.ccxxxi.ecnutimetable.ecnudb

import android.util.Log
import com.github.ccxxxi.ecnutimetable.html.Parser
import okhttp3.FormBody
import okhttp3.OkHttpClient
import okhttp3.Request
import org.riversun.okhttp3.OkHttp3CookieHelper
import java.io.IOException

// todo: 连不上公共数据库时的处理
private object EcnuDB {
    private const val TAG = "EcnuDB"

    private object URL {
        private const val CAS = "https://portal1.ecnu.edu.cn/cas"
        private const val JW = "https://applicationnewjw.ecnu.edu.cn"

        const val PORTAL = "$CAS/login?service=$JW/eams/home.action"
        const val CAPTCHA = "$CAS/code"
        const val IDS = "$JW/eams/courseTableForStd!index.action"
        const val TABLE = "$JW/eams/courseTableForStd!courseTable.action"
    }

    /**
     * Set cookie.
     *
     * 这是必要的，否则之后登录时会直接返回登录页面，并且没有任何报错信息。
     */
    fun initSession(client: OkHttpClient) {
        val request = Request.Builder().url(URL.PORTAL).build()

        client.newCall(request).execute().use {
            // IOException
            if (!it.isSuccessful) throw IOException("Unexpected code $it")

            // log
            for ((name, value) in it.headers) {
                Log.d(TAG, "$name: $value")
            }
            Log.d(TAG, it.body!!.string())
        }
    }

    fun getCaptchaImg(client: OkHttpClient): ByteArray {
        val request = Request.Builder().url(URL.CAPTCHA).build()

        client.newCall(request).execute().use {
            return it.body!!.bytes()
        }
    }

    private fun getRsa(username: String, password: String) =
        Des().strEnc(username + password, "1", "2", "3")

    fun login(
        client: OkHttpClient,
        username: String,
        password: String,
        captcha: String
    ): LoginResult {
        val body = FormBody.Builder()
            .add("code", captcha)
            .add("rsa", getRsa(username, password))
            .add("ul", username.length.toString())
            .add("pl", password.length.toString())
            .add("lt", "LT-211100-OG7kcGcBAxSpyGub3FC9LU6BtINhGg-cas")
            .add("execution", "e1s1")
            .add("_eventId", "submit")
            .build()

        val request = Request.Builder().url(URL.PORTAL).post(body).build()

        client.newCall(request).execute().use {
            return Parser.parseLoginResult(it.body!!.string())
        }
    }

    fun getIds(client: OkHttpClient): String {
        val request = Request.Builder().url(URL.IDS).build()

        client.newCall(request).execute().use {
            return Parser.parseIds(it.body!!.string())
        }
    }
}


class Session {
    private val cookieJar = OkHttp3CookieHelper().cookieJar()
    private val client = OkHttpClient.Builder().cookieJar(cookieJar).build()

    init {
        EcnuDB.initSession(client)
    }

    val captchaImg = EcnuDB.getCaptchaImg(client)

    private lateinit var ids: String

    fun login(username: String, password: String, captcha: String) =
        EcnuDB.login(client, username, password, captcha)

    fun getTimetable() {
        ids = EcnuDB.getIds(client)
        TODO()
    }
}
