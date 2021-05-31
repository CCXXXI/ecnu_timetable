package cn.edu.ecnu.timetable

import android.util.Log
import com.github.kittinunf.fuel.Fuel
import com.github.kittinunf.fuel.core.FuelManager
import com.github.kittinunf.fuel.core.Headers
import com.github.kittinunf.fuel.core.Response
import com.github.kittinunf.fuel.core.requests.download
import java.io.File
import kotlin.properties.Delegates

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

    private lateinit var cookie: String

    private fun updateCookie(response: Response) {
        // 2017年就提了的issue竟然还没解决
        // https://github.com/kittinunf/fuel/issues/263
        // todo: 最好换个对cookie支持更完善的库
        // OkHttp看起来不错
        // https://square.github.io/okhttp/

        val s = response.headers["Set-Cookie"].toString()
            .also { Log.d(TAG, "Set-Cookie: $it") }

        Regex("""[a-z_]*=[a-z_0-9!\-]*;""", RegexOption.IGNORE_CASE).findAll(s).forEach {
            val c = it.value
            Log.d(TAG, c)
            cookie += c // todo: 去重
        }

        // todo: JSESSIONID无法从Set-Cookie里拿到，疑为Fuel的bug
        Regex("(?<=jsessionid%3D).*", RegexOption.IGNORE_CASE).find(response.url.toString())
            ?.value?.also { cookie = "JSESSIONID=$it;" }

        FuelManager.instance.baseHeaders = mapOf(
            Headers.COOKIE to cookie,
            Headers.USER_AGENT to
                    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) " +
                    "AppleWebKit/537.36 (KHTML, like Gecko) " +
                    "Chrome/90.0.4430.93 " +
                    "Safari/537.36 " +
                    "Edg/90.0.818.56"
        )
    }

    /**
     * Init cookie.
     */
    fun newSession() {
        cookie = ""
        Fuel.get(URL.PORTAL).response()
            .also { Log.d(TAG, it.toString()) }
            .second
            .also { updateCookie(it) }
    }

    fun getCaptchaImg(): File {
        val file = File.createTempFile("CAPTCHA", ".png")
            .also { Log.d(TAG, "Temp file created: $it") }
        Fuel.get(URL.CAPTCHA).download().fileDestination { _, _ -> file }.response()
            .also { Log.d(TAG, it.toString()) }
            .second.also { updateCookie(it) }
        return file
    }

    private fun getRsa(username: String, password: String) =
        Des().strEnc(username + password, "1", "2", "3")

    fun login(username: String, password: String, captcha: String) {
        val data = listOf(
            "code" to captcha,
            "rsa" to getRsa(username, password),
            "ul" to username.length,
            "pl" to password.length,
            "lt" to "LT-211100-OG7kcGcBAxSpyGub3FC9LU6BtINhGg-cas",
            "execution" to "e1s1",
            "_eventId" to "submit",
        ).also { Log.d(TAG, it.toString()) }
        Fuel.post(URL.PORTAL, data).responseString()
            .also { Log.d(TAG, it.toString()) }
            .also { updateCookie(it.second) }
            .also {
                when (Parser.parseLoginResult(it.third.get())) {
                    is Success -> TODO("登陆成功处理")
                    is Error -> TODO("登陆失败处理")
                }
            }
    }
}

class Session {
    init {
        EcnuDB.newSession()
    }

    val captchaImg = EcnuDB.getCaptchaImg()

    private var ids by Delegates.notNull<Int>()

    fun login(username: String, password: String, captcha: String) =
        EcnuDB.login(username, password, captcha)
    // todo
}
