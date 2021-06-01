package com.github.ccxxxi.ecnutimetable.html

import org.jsoup.Jsoup

object Parser {
    fun parseLoginResult(html: String): Result {
        val doc = Jsoup.parse(html)!!
        doc.getElementById("errormsg")?.text()?.let { return Error(it) }
        TODO()
    }
}

sealed class Result
data class Error(val msg: String) : Result()
data class Success(val msg: String) : Result()
