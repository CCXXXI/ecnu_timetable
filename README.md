# ECNU Timetable

[![GitHub](https://img.shields.io/github/license/CCXXXI/ecnu-timetable)](LICENSE)
[![GitHub last commit](https://img.shields.io/github/last-commit/CCXXXI/ecnu-timetable)](../../commits)
[![Kotlin](https://img.shields.io/badge/Kotlin-1.5.10-D022B6?logo=kotlin&logoColor=D022B6)](https://kotlinlang.org)
[![Android](https://img.shields.io/badge/Android-8.0%2B-3DDC84?logo=android&logoColor=3DDC84)](https://www.android.com)
[![Total alerts](https://img.shields.io/lgtm/alerts/g/CCXXXI/ecnu-timetable.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/CCXXXI/ecnu-timetable/alerts/)
[![Language grade: Python](https://img.shields.io/lgtm/grade/python/g/CCXXXI/ecnu-timetable.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/CCXXXI/ecnu-timetable/context:python)

更美观更智能的ECNU课程表。

## 当前状态

拆分自某个预计会咕掉的课程项目，正在继续开发。

## 鸣谢

* 登入公共数据库并获取课表数据的流程参考了 [BillChen2K/ECNU-class2ics](https://github.com/BillChen2K/ECNU-class2ics)

  * > ics 是最流行的日历文件之一，受到几乎所有日历软件的支持。这个程序能根据指定的提醒策略，将高校的课程表信息生成一个可以导入到各个日历软件的 ics 文件。

* 识别验证码使用了 [adaptech-cz/Tesseract4Android](https://github.com/adaptech-cz/Tesseract4Android)

  * 这东西扔进`build.gradle`不工作，所以直接copy了一份，并导致项目中占比最大的语言成了c

* DES加密参考了 [冰河的专栏-CSDN博客](https://blog.csdn.net/l1028386804/article/details/50196061)

  * 我再也不黑CSDN了

* 使用了 [OkHttp](https://square.github.io/okhttp/) 以避免安全缺陷症、冗余代码症、重新发明轮子症、啃文档症、抑郁、头疼等问题

  * 也尝试过 [khttp](https://github.com/ascclemens/khttp) 和 [Fuel](https://github.com/kittinunf/fuel)，都比较坑

* 使用了 [riversun/okhttp3-cookie-helper](https://github.com/riversun/okhttp3-cookie-helper) 来处理cookie

  * 最后更新于2017年但仍然能跑起来，感谢okhttp的开发者在升级到4.x时确保了兼容性

* 使用了 [jsoup](https://jsoup.org/) 进行HTML解析

  * 但没有尝试它看上去就很简陋的HTTP请求有关功能

* [JetBrains](https://www.jetbrains.com/) nb! [Kotlin](https://kotlinlang.org/) nb!
