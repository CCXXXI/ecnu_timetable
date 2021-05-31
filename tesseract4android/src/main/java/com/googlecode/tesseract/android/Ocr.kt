package com.googlecode.tesseract.android

import android.content.Context
import android.graphics.Bitmap
import cz.adaptech.android.tesseract4android.R
import java.io.File
import java.nio.file.Files

class Ocr(context: Context) {
    private val basePath = context.filesDir.path
    private val dataFolder = File("$basePath/tessdata")
    private val file = File("$dataFolder/eng.traineddata")

    init {
        if (!file.exists()) {
            dataFolder.mkdirs()
            Files.copy(context.resources.openRawResource(R.raw.eng), file.toPath())
        }
    }

    private val api = TessBaseAPI().apply { init(basePath, "eng") }

    /**
     * 识别验证码
     * @param bmp 待识别图片
     * @return 识别结果
     */
    fun rec(bmp: Bitmap): String = api.run {
        setImage(bmp)
        utF8Text
    }
}
