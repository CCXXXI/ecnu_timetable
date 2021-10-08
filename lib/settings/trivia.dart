import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../utils/messages.dart';

final _triviaStr = [
  'GitHub的仓库名通常使用分隔符`ecnu-timetable`，但为了让Dart开心，本仓库使用了下划线`ecnu_timetable`。'.s,
  '此项目最初是受ECNU-class2ics启发的。'.s,
  '长按校徽可以打开开发者选项。',
  '师大各院系标志色涵盖了红、绿、蓝、橙、青，但没有院系使用品红。',
  '尽管检测到的出错会自动上报到sentry.io，遇到问题去GitHub手动开个issue总是会更可靠。'.s,
  '师大校徽的标准颜色是`#a41f35`。'.s,
  '全半角字符之间的空格被称为「盘古之白」。',
  '横竖屏状态下有不同的布局方式。',
  '由于某人不喜欢苹果严格的审核机制，此应用没有macOS或iOS版本。'.s,
  '由于构建过程比较痛苦，此应用没有Linux版本。'.s,
  '虽然一些字体会在用到时从Google Fonts下载，但考虑到部分用户的网络环境，常用字体文件直接打包进了应用。'.s,
  r'Windows的配置文件位于`%AppData%\io.github.ccxxxi\ecnu_timetable`。'.s,
  '竖屏状态下，上方校训的字体固定为思源宋体，不会受字体设置影响。',
  '最新版本信息需要从GitHub获取，在某些网络环境下可能会失败。'.s,
  '此应用为开源项目，使用MIT许可协议。'.s,
  '你的数据只会保存在本地。高情商：确保数据安全；低情商：没有云同步功能。',
  '不上传数据的原因：如果被怀疑盗用，无法自证清白；没有把握保证服务器不被入侵。',
  '左上角校徽图标的长宽为42逻辑像素。'.s,
  '点击许可协议后出现的应用图标的长宽为42逻辑像素。'.s,
  '工具箱中卡片的长宽比为$pi...'.s,
  '舔狗语录刷新后会关闭是有意为之，以此避免连点导致API请求过于频繁。'.s,
  'cheater语录刷新后会关闭是因为复用了舔狗语录的代码。'.s,
  '由于跨域资源共享（CORS）问题，部分功能在Web端不可用。'.s,
];

final trivia =
    _triviaStr.map((e) => MarkdownBody(data: e)).toList(growable: false);

final _r = Random();

Widget get randomTrivia => trivia[_r.nextInt(_triviaStr.length)];
