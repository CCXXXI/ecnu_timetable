package com.github.ccxxxi.ecnutimetable.html

import android.util.Log
import com.github.ccxxxi.ecnutimetable.ecnudb.Error
import com.github.ccxxxi.ecnutimetable.ecnudb.LoginResult
import com.github.ccxxxi.ecnutimetable.ecnudb.Success
import org.jsoup.Jsoup

object Parser {
    fun parseLoginResult(html: String): LoginResult {
        val doc = Jsoup.parse(html)!!
        doc.select("#errormsg")?.first()?.text()?.let { return Error(it) }
        doc.select("[title=查看登录记录]")?.first()?.text()?.let { return Success(it) }

        Log.wtf("Parser", "分析不出登录结果:\n$doc")
        return Error("分析不出登录结果")
    }
}
