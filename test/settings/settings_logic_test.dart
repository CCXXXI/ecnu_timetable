import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecnu_timetable/settings/settings_logic.dart';
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

  test('fake version', () async {
    final logic = Get.put(SettingsLogic(dio: FakeDio()));

    expect(logic.latestVer.value, isNull);
    expect(logic.updateAvailable, isFalse);

    await Future.delayed(const Duration(milliseconds: 200));
    expect(logic.latestVer.value, '1024.2048.4096');
    expect(logic.updateAvailable, isTrue);

    Get.delete<SettingsLogic>();
  });

  test('error version', () async {
    final logic = Get.put(SettingsLogic(dio: FakeErrorDio()));

    expect(logic.latestVer.value, isNull);
    expect(logic.updateAvailable, isFalse);

    await Future.delayed(const Duration(milliseconds: 200));
    expect(logic.latestVer.value, isEmpty);
    expect(logic.updateAvailable, isFalse);

    Get.delete<SettingsLogic>();
  });

  test('real version', () async {
    final logic = Get.put(SettingsLogic());

    expect(logic.latestVer.value, isNull);
    expect(logic.updateAvailable, isFalse);

    await Future.delayed(const Duration(seconds: 1));
    expect(logic.latestVer.value, isNotEmpty);

    Get.delete<SettingsLogic>();
  });
}

final fakeData = json.decode(r'''
[
  {
    "url": "https://api.github.com/repos/CCXXXI/ecnu_timetable/releases/51086607",
    "assets_url": "https://api.github.com/repos/CCXXXI/ecnu_timetable/releases/51086607/assets",
    "upload_url": "https://uploads.github.com/repos/CCXXXI/ecnu_timetable/releases/51086607/assets{?name,label}",
    "html_url": "https://github.com/CCXXXI/ecnu_timetable/releases/tag/v1024.2048.4096",
    "id": 51086607,
    "author": {
      "login": "github-actions[bot]",
      "id": 41898282,
      "node_id": "MDM6Qm90NDE4OTgyODI=",
      "avatar_url": "https://avatars.githubusercontent.com/in/15368?v=4",
      "gravatar_id": "",
      "url": "https://api.github.com/users/github-actions%5Bbot%5D",
      "html_url": "https://github.com/apps/github-actions",
      "followers_url": "https://api.github.com/users/github-actions%5Bbot%5D/followers",
      "following_url": "https://api.github.com/users/github-actions%5Bbot%5D/following{/other_user}",
      "gists_url": "https://api.github.com/users/github-actions%5Bbot%5D/gists{/gist_id}",
      "starred_url": "https://api.github.com/users/github-actions%5Bbot%5D/starred{/owner}{/repo}",
      "subscriptions_url": "https://api.github.com/users/github-actions%5Bbot%5D/subscriptions",
      "organizations_url": "https://api.github.com/users/github-actions%5Bbot%5D/orgs",
      "repos_url": "https://api.github.com/users/github-actions%5Bbot%5D/repos",
      "events_url": "https://api.github.com/users/github-actions%5Bbot%5D/events{/privacy}",
      "received_events_url": "https://api.github.com/users/github-actions%5Bbot%5D/received_events",
      "type": "Bot",
      "site_admin": false
    },
    "node_id": "RE_kwDOFjHll84DC4UP",
    "tag_name": "v1024.2048.4096",
    "target_commitish": "main",
    "name": "v1024.2048.4096",
    "draft": false,
    "prerelease": false,
    "created_at": "2021-10-09T21:15:35Z",
    "published_at": "2021-10-09T21:22:53Z",
    "assets": [
      {
        "url": "https://api.github.com/repos/CCXXXI/ecnu_timetable/releases/assets/46611305",
        "id": 46611305,
        "node_id": "RA_kwDOFjHll84Cxztp",
        "name": "app-arm64-v8a-release.apk",
        "label": "",
        "uploader": {
          "login": "github-actions[bot]",
          "id": 41898282,
          "node_id": "MDM6Qm90NDE4OTgyODI=",
          "avatar_url": "https://avatars.githubusercontent.com/in/15368?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/github-actions%5Bbot%5D",
          "html_url": "https://github.com/apps/github-actions",
          "followers_url": "https://api.github.com/users/github-actions%5Bbot%5D/followers",
          "following_url": "https://api.github.com/users/github-actions%5Bbot%5D/following{/other_user}",
          "gists_url": "https://api.github.com/users/github-actions%5Bbot%5D/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/github-actions%5Bbot%5D/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/github-actions%5Bbot%5D/subscriptions",
          "organizations_url": "https://api.github.com/users/github-actions%5Bbot%5D/orgs",
          "repos_url": "https://api.github.com/users/github-actions%5Bbot%5D/repos",
          "events_url": "https://api.github.com/users/github-actions%5Bbot%5D/events{/privacy}",
          "received_events_url": "https://api.github.com/users/github-actions%5Bbot%5D/received_events",
          "type": "Bot",
          "site_admin": false
        },
        "content_type": "application/vnd.android.package-archive",
        "state": "uploaded",
        "size": 25932872,
        "download_count": 0,
        "created_at": "2021-10-09T21:22:53Z",
        "updated_at": "2021-10-09T21:22:54Z",
        "browser_download_url": "https://github.com/CCXXXI/ecnu_timetable/releases/download/v1024.2048.4096/app-arm64-v8a-release.apk"
      },
      {
        "url": "https://api.github.com/repos/CCXXXI/ecnu_timetable/releases/assets/46611307",
        "id": 46611307,
        "node_id": "RA_kwDOFjHll84Cxztr",
        "name": "app-armeabi-v7a-release.apk",
        "label": "",
        "uploader": {
          "login": "github-actions[bot]",
          "id": 41898282,
          "node_id": "MDM6Qm90NDE4OTgyODI=",
          "avatar_url": "https://avatars.githubusercontent.com/in/15368?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/github-actions%5Bbot%5D",
          "html_url": "https://github.com/apps/github-actions",
          "followers_url": "https://api.github.com/users/github-actions%5Bbot%5D/followers",
          "following_url": "https://api.github.com/users/github-actions%5Bbot%5D/following{/other_user}",
          "gists_url": "https://api.github.com/users/github-actions%5Bbot%5D/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/github-actions%5Bbot%5D/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/github-actions%5Bbot%5D/subscriptions",
          "organizations_url": "https://api.github.com/users/github-actions%5Bbot%5D/orgs",
          "repos_url": "https://api.github.com/users/github-actions%5Bbot%5D/repos",
          "events_url": "https://api.github.com/users/github-actions%5Bbot%5D/events{/privacy}",
          "received_events_url": "https://api.github.com/users/github-actions%5Bbot%5D/received_events",
          "type": "Bot",
          "site_admin": false
        },
        "content_type": "application/vnd.android.package-archive",
        "state": "uploaded",
        "size": 25679147,
        "download_count": 0,
        "created_at": "2021-10-09T21:22:54Z",
        "updated_at": "2021-10-09T21:22:55Z",
        "browser_download_url": "https://github.com/CCXXXI/ecnu_timetable/releases/download/v1024.2048.4096/app-armeabi-v7a-release.apk"
      },
      {
        "url": "https://api.github.com/repos/CCXXXI/ecnu_timetable/releases/assets/46611310",
        "id": 46611310,
        "node_id": "RA_kwDOFjHll84Cxztu",
        "name": "app-x86_64-release.apk",
        "label": "",
        "uploader": {
          "login": "github-actions[bot]",
          "id": 41898282,
          "node_id": "MDM6Qm90NDE4OTgyODI=",
          "avatar_url": "https://avatars.githubusercontent.com/in/15368?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/github-actions%5Bbot%5D",
          "html_url": "https://github.com/apps/github-actions",
          "followers_url": "https://api.github.com/users/github-actions%5Bbot%5D/followers",
          "following_url": "https://api.github.com/users/github-actions%5Bbot%5D/following{/other_user}",
          "gists_url": "https://api.github.com/users/github-actions%5Bbot%5D/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/github-actions%5Bbot%5D/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/github-actions%5Bbot%5D/subscriptions",
          "organizations_url": "https://api.github.com/users/github-actions%5Bbot%5D/orgs",
          "repos_url": "https://api.github.com/users/github-actions%5Bbot%5D/repos",
          "events_url": "https://api.github.com/users/github-actions%5Bbot%5D/events{/privacy}",
          "received_events_url": "https://api.github.com/users/github-actions%5Bbot%5D/received_events",
          "type": "Bot",
          "site_admin": false
        },
        "content_type": "application/vnd.android.package-archive",
        "state": "uploaded",
        "size": 26159376,
        "download_count": 0,
        "created_at": "2021-10-09T21:22:55Z",
        "updated_at": "2021-10-09T21:22:56Z",
        "browser_download_url": "https://github.com/CCXXXI/ecnu_timetable/releases/download/v1024.2048.4096/app-x86_64-release.apk"
      },
      {
        "url": "https://api.github.com/repos/CCXXXI/ecnu_timetable/releases/assets/46611312",
        "id": 46611312,
        "node_id": "RA_kwDOFjHll84Cxztw",
        "name": "ecnu_timetable_windows.zip",
        "label": "",
        "uploader": {
          "login": "github-actions[bot]",
          "id": 41898282,
          "node_id": "MDM6Qm90NDE4OTgyODI=",
          "avatar_url": "https://avatars.githubusercontent.com/in/15368?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/github-actions%5Bbot%5D",
          "html_url": "https://github.com/apps/github-actions",
          "followers_url": "https://api.github.com/users/github-actions%5Bbot%5D/followers",
          "following_url": "https://api.github.com/users/github-actions%5Bbot%5D/following{/other_user}",
          "gists_url": "https://api.github.com/users/github-actions%5Bbot%5D/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/github-actions%5Bbot%5D/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/github-actions%5Bbot%5D/subscriptions",
          "organizations_url": "https://api.github.com/users/github-actions%5Bbot%5D/orgs",
          "repos_url": "https://api.github.com/users/github-actions%5Bbot%5D/repos",
          "events_url": "https://api.github.com/users/github-actions%5Bbot%5D/events{/privacy}",
          "received_events_url": "https://api.github.com/users/github-actions%5Bbot%5D/received_events",
          "type": "Bot",
          "site_admin": false
        },
        "content_type": "application/octet-stream",
        "state": "uploaded",
        "size": 28032749,
        "download_count": 1,
        "created_at": "2021-10-09T21:22:56Z",
        "updated_at": "2021-10-09T21:22:57Z",
        "browser_download_url": "https://github.com/CCXXXI/ecnu_timetable/releases/download/v1024.2048.4096/ecnu_timetable_windows.zip"
      }
    ],
    "tarball_url": "https://api.github.com/repos/CCXXXI/ecnu_timetable/tarball/v1024.2048.4096",
    "zipball_url": "https://api.github.com/repos/CCXXXI/ecnu_timetable/zipball/v1024.2048.4096",
    "body": "## Features\n- **timetable**: update menu [#112](https://github.com/CCXXXI/ecnu_timetable/pull/112) ([CCXXXI](https://github.com/CCXXXI/ecnu_timetable/commit/200d6a05cce708b0bba86d995152e9a5a5935fd4))\n- **utils**: set responseLevel of dio to debug [#112](https://github.com/CCXXXI/ecnu_timetable/pull/112) ([CCXXXI](https://github.com/CCXXXI/ecnu_timetable/commit/71f8585b9e6414588a6db26eebc0362928480712))\n- **toolbox**: show academic calendar as image [#112](https://github.com/CCXXXI/ecnu_timetable/pull/112) ([CCXXXI](https://github.com/CCXXXI/ecnu_timetable/commit/441a5ca4530d80e4f45fc571e581e738eab88134))\n- **toolbox**: InteractiveViewer for calendar [#112](https://github.com/CCXXXI/ecnu_timetable/pull/112) ([CCXXXI](https://github.com/CCXXXI/ecnu_timetable/commit/bef4367c09f4e006acc3e44793729d24dfa79aeb))\n- **toolbox**: set maxScale of InteractiveViewer to infinity [#112](https://github.com/CCXXXI/ecnu_timetable/pull/112) ([CCXXXI](https://github.com/CCXXXI/ecnu_timetable/commit/47d4fe2162d42d78877ce01a8f545534d74da271))\n- **toolbox**: basic idc [#112](https://github.com/CCXXXI/ecnu_timetable/pull/112) ([CCXXXI](https://github.com/CCXXXI/ecnu_timetable/commit/284fe9fda4564cab3a3794d9498286b121080d49))\n\n## Bug Fixes\n- **toolbox**: disable academic calendar image on web [#112](https://github.com/CCXXXI/ecnu_timetable/pull/112) ([CCXXXI](https://github.com/CCXXXI/ecnu_timetable/commit/ae5f0a78754407bd19a78ef26dcf1fb71fba2811))\n\n## Builds\n- use mirror by https://pub.flutter-io.cn [#112](https://github.com/CCXXXI/ecnu_timetable/pull/112) ([CCXXXI](https://github.com/CCXXXI/ecnu_timetable/commit/bea470f673c00f5443bdf2f16e4d4eef43651073))\n\n## Chores\n- **deps**: universal_html [#112](https://github.com/CCXXXI/ecnu_timetable/pull/112) ([CCXXXI](https://github.com/CCXXXI/ecnu_timetable/commit/982959ee859dd676fdce9f6465f4e451b2b605ca))\n- **deps**: cached_network_image [#112](https://github.com/CCXXXI/ecnu_timetable/pull/112) ([CCXXXI](https://github.com/CCXXXI/ecnu_timetable/commit/cfd0932118051ab58ecc9b13ece48b871d5b9902))\n- 1024.2048.4096+14 [#112](https://github.com/CCXXXI/ecnu_timetable/pull/112) ([CCXXXI](https://github.com/CCXXXI/ecnu_timetable/commit/82c7c2289d3ec7872b936fb2561b76698d588e22))"
  }
]
''');
