package com.github.ccxxxi.ecnutimetable

import org.jsoup.Jsoup

object Parser {
    fun parseLoginResult(html: String): Result {
        val doc = Jsoup.parse(html)!!
        val error = doc.getElementById("errormsg")?.text()
        return error?.let { Error(it) } ?: Success()
    }
}

sealed class Result
data class Error(val msg: String? = null) : Result()
data class Success(val msg: String? = null) : Result()
