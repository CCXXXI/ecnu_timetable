import 'package:dio/dio.dart';
import 'package:ecnu_timetable/toolbox/calendar/calendar_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart' hide Response;

class FakeDio extends Fake implements Dio {
  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));

    return Response(
      requestOptions: RequestOptions(path: path),
      data: fakeData as T,
    );
  }
}

class FakeErrorDio extends Fake implements Dio {
  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));

    throw DioError(
      requestOptions: RequestOptions(path: path),
    );
  }
}

void main() {
  runApp(const GetMaterialApp());

  test('fake calendar', () async {
    final logic = Get.put(CalendarLogic(dio: FakeDio()));

    expect(logic.imgUrl.value, isEmpty);

    await Future.delayed(const Duration(milliseconds: 200));
    expect(logic.imgUrl.value, fakeImgUrl);

    Get.delete<CalendarLogic>();
  });

  test('error calendar', () async {
    final logic = Get.put(CalendarLogic(dio: FakeErrorDio()));

    expect(logic.imgUrl.value, isEmpty);

    await Future.delayed(const Duration(milliseconds: 200));
    expect(logic.imgUrl.value, isEmpty);

    Get.delete<CalendarLogic>();
  });

  test('real calendar', () async {
    final logic = Get.put(CalendarLogic());

    expect(logic.imgUrl.value, isEmpty);

    await Future.delayed(const Duration(seconds: 10));
    expect(logic.imgUrl.value, isNotEmpty);

    Get.delete<CalendarLogic>();
  }, skip: 'network');
}

const fakeData = '''
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="keyword" contents="华东师范大学">
<title>校历</title>

<link type="text/css" href="/_css/_system/system.css" rel="stylesheet"/>
<link type="text/css" href="/_upload/site/1/style/87/87.css" rel="stylesheet"/>
<link type="text/css" href="/_upload/site/01/1d/285/style/561/561.css" rel="stylesheet"/>
<link type="text/css" href="/_js/_portletPlugs/simpleNews/css/simplenews.css" rel="stylesheet" />

<script language="javascript" src="/_js/jquery.min.js" sudy-wp-context="" sudy-wp-siteId="285"></script>
<script language="javascript" src="/_js/jquery.sudy.wp.visitcount.js"></script>
<link href="/_upload/tpl/07/01/1793/template1793/css/css.css" rel="stylesheet" type="text/css" />
</head>




<body>


<table width="100%" border="0" cellspacing="0" cellpadding="0" id="fullCont">
    <tbody>
        <tr>
            <td>
                <table width="940" height="300" border="0" align="center" cellpadding="28" cellspacing="1" bgcolor="#E2E2E2">
                    <tbody>
                        <tr>
                            <td valign="top" bgcolor="#FFFFFF">
                                <table width="882" border="0" cellpadding="0" cellspacing="0">
                                    <tbody>
                                        <tr>
                                            <td width="882">
                                                <div frag="面板1" style="width:882px;height:100%;">
                                                    <div frag="窗口1">
                                                        <div id="wp_news_w1">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="wp_article_list_table">
<tr>
<td>

                                                            <!--[InfoCycleBegin]--><a class="focus_img i1" href="/_upload/article/images/4f/e8/1a1c59344523a4be4cf6a90081c6/b1de9633-5f49-4511-b63d-236f44b327d5.jpg" target="_blank"> <img width="882" height="" src="/_upload/article/images/4f/e8/1a1c59344523a4be4cf6a90081c6/701c09f0-42a3-442f-b02c-f3308c62f4c6.jpg"/></a>
                                                        </td>
</tr>
</table></div>
<!--[InfoCycleEnd]-->
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tbody>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                <div frag="面板2" class="cont">
                                                    <div frag="窗口2">
                                                        <div id="wp_news_w2">


                                                            <div class="xlxz">
                                                                <a href='/_upload/article/files/03/15/d3c06d5a46e6a593f0b89f26fbf1/caf89983-b3a8-4ca1-88ad-b06d3d885145.rar' target='_blank' title='2021-2022学年校历[教师+学生版]'>2021-2022学年校历[教师+学生版]</a>
                                                            </div>
                                                            <div class="xlxz">
                                                                <a href='/_upload/article/files/42/10/82a810a34de1bb5d93e54d7992cf/c18dd106-d24b-405d-a550-b4f4f583698c.rar' target='_blank' title='2020-2021学年校历[教师+学生版]'>2020-2021学年校历[教师+学生版]</a>
                                                            </div>
                                                            <div class="xlxz">
                                                                <a href='/_upload/article/files/86/7e/a73a2b1f404d9c9495f426ace4f0/35a1dfd0-d653-4464-af84-c841ed6bb94e.pdf' target='_blank' title='2019-2020学年校历[新]'>2019-2020学年校历[新]</a>
                                                            </div>
                                                            <div class="xlxz">
                                                                <a href='/_upload/article/images/51/8c/e24e20e94b1689bddfa4c19d2bf7/152f7972-fc1e-4561-bfc1-265e59afc5f1.jpg' target='_blank' title='2018-2019学年校历'>2018-2019学年校历</a>
                                                            </div>
                                                            <div class="xlxz">
                                                                <a href='/_upload/article/files/63/3b/c11a91d94bacb0a4ca90c3969a35/3c98a9dd-1e7b-401a-9dd0-74bd78533ccb.rar' target='_blank' title='2017-2018学年校历[教师+学生版]'>2017-2018学年校历[教师+学生版]</a>
                                                            </div>
                                                            <div class="xlxz">
                                                                <a href='/_upload/article/images/b9/b6/1bf8d72d42199ac2d4ab23693bda/3e63e5d2-a50e-499b-b081-f70b410c753a.jpg' target='_blank' title='2016-2017学年校历'>2016-2017学年校历</a>
                                                            </div>
                                                            <div class="xlxz">
                                                                <a href='/_upload/article/images/b6/cc/c1b7c49845e9ac38ff258695cd3a/f2dd80f9-daf3-45a6-9eec-6dca10d5e6ef.jpg' target='_blank' title='2015-2016学年校历'>2015-2016学年校历</a>
                                                            </div>
                                                            <div class="xlxz">
                                                                <a href='/_upload/article/files/19/96/454ce85f4f6198ad5ea816a52350/749a9377-20e1-4cc9-b866-2eeac98da48e.rar' target='_blank' title='2014-2015学年校历[教师+学生版]'>2014-2015学年校历[教师+学生版]</a>
                                                            </div>
                                                            <div class="xlxz">
                                                                <a href='/_upload/article/images/61/19/3f08f121419382d9dea02191054b/dffac477-d2f4-4757-9efc-8950c3351028.jpg' target='_blank' title='2013-2014学年校历'>2013-2014学年校历</a>
                                                            </div>
                                                            <div class="xlxz">
                                                                <a href='/_upload/article/images/b2/8e/f75167d14fbda67c5c91359d4bc3/be0a3c07-f7f0-4a4d-bc0f-4041105dde48.jpg' target='_blank' title='2012-2013学年校历'>2012-2013学年校历</a>
                                                            </div>
                                                            <div class="xlxz">
                                                                <a href='/_upload/article/images/be/d0/a388ba694a7a9727cfbf327770e5/9d1b8b71-0a3c-47cc-84cc-c91da660c06b.jpg' target='_blank' title='2011-2012学年校历'>2011-2012学年校历</a>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <table width="940" border="0" align="center" cellpadding="20" cellspacing="0" id="copyright">
                    <tbody>
                        <tr>
                            <td align="right">
                                © Copyright 2012 版权所有 华东师范大学
                            </td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
    </tbody>
</table>


</body>
</html>
 <img src="/_visitcount?siteId=285&type=1&columnId=10066" style="display:none" width="0" height="0"></image>''';
const fakeImgUrl =
    'http://www.u-office.ecnu.edu.cn/_upload/article/images/4f/e8/1a1c59344523a4be4cf6a90081c6/b1de9633-5f49-4511-b63d-236f44b327d5.jpg';
