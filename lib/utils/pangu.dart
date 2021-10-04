/// https://gist.github.com/CCXXXI/434ff6bc0d63261011c5be26bfd6057c
final _cjkQuote = RegExp(
    '([\u2e80-\u2eff\u2f00-\u2fdf\u3040-\u309f\u30a0-\u30ff\u3100-\u312f\u3200-\u32ff\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff])(["])');
final _quoteCJK = RegExp(
    '(["])([\u2e80-\u2eff\u2f00-\u2fdf\u3040-\u309f\u30a0-\u30ff\u3100-\u312f\u3200-\u32ff\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff])');
final _fixQuote = RegExp("([\"']+)(s*)(.+?)(s*)([\"']+)");
final _fixSingleQuote = RegExp(
    "([\u2e80-\u2eff\u2f00-\u2fdf\u3040-\u309f\u30a0-\u30ff\u3100-\u312f\u3200-\u32ff\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff])( )(')([A-Za-z])");
final _hashANSCJKhash = RegExp(
    '([\u2e80-\u2eff\u2f00-\u2fdf\u3040-\u309f\u30a0-\u30ff\u3100-\u312f\u3200-\u32ff\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff])(#)([A-Za-z0-9\u2e80-\u2eff\u2f00-\u2fdf\u3040-\u309f\u30a0-\u30ff\u3100-\u312f\u3200-\u32ff\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff]+)(#)([\u2e80-\u2eff\u2f00-\u2fdf\u3040-\u309f\u30a0-\u30ff\u3100-\u312f\u3200-\u32ff\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff])');
final _cjkHash = RegExp(
    '([\u2e80-\u2eff\u2f00-\u2fdf\u3040-\u309f\u30a0-\u30ff\u3100-\u312f\u3200-\u32ff\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff])(#([^ ]))');
final _hashCJK = RegExp(
    '(([^ ])#)([\u2e80-\u2eff\u2f00-\u2fdf\u3040-\u309f\u30a0-\u30ff\u3100-\u312f\u3200-\u32ff\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff])');
final _cjkOperatorANS = RegExp(
    r'([\u2e80-\u2eff\u2f00-\u2fdf\u3040-\u309f\u30a0-\u30ff\u3100-\u312f\u3200-\u32ff\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff])([\+\-\*\/=&\\|<>])([A-Za-z0-9])');
final _ansOperatorCJK = RegExp(
    r'([A-Za-z0-9])([\+\-\*\/=&\\|<>])([\u2e80-\u2eff\u2f00-\u2fdf\u3040-\u309f\u30a0-\u30ff\u3100-\u312f\u3200-\u32ff\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff])');
final _cjkBracketCJK = RegExp(
    '([\u2e80-\u2eff\u2f00-\u2fdf\u3040-\u309f\u30a0-\u30ff\u3100-\u312f\u3200-\u32ff\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff])([([{<\u201c]+(.*?)[)]}>\u201d]+)([\u2e80-\u2eff\u2f00-\u2fdf\u3040-\u309f\u30a0-\u30ff\u3100-\u312f\u3200-\u32ff\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff])');
final _cjkBracket = RegExp(
    '([\u2e80-\u2eff\u2f00-\u2fdf\u3040-\u309f\u30a0-\u30ff\u3100-\u312f\u3200-\u32ff\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff])([([{<\u201c>])');
final _bracketCJK = RegExp(
    '([)]}>\u201d<])([\u2e80-\u2eff\u2f00-\u2fdf\u3040-\u309f\u30a0-\u30ff\u3100-\u312f\u3200-\u32ff\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff])');
final _fixBracket = RegExp('([([{<\u201c]+)(s*)(.+?)(s*)([)]}>\u201d]+)');
final _fixSymbol = RegExp(
    '([\u2e80-\u2eff\u2f00-\u2fdf\u3040-\u309f\u30a0-\u30ff\u3100-\u312f\u3200-\u32ff\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff])([~!;:,.?\u2026])([A-Za-z0-9])');
final _cjkANS = RegExp(
    '([\u2e80-\u2eff\u2f00-\u2fdf\u3040-\u309f\u30a0-\u30ff\u3100-\u312f\u3200-\u32ff\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff])([A-Za-z0-9`\$%^&*-=+\\|/@\u00a1-\u00ff\u2022\u2027\u2150-\u218f])');
final _ansCJK = RegExp(
    '([A-Za-z0-9`~\$%^&*-=+\\|/!;:,.?\u00a1-\u00ff\u2022\u2026\u2027\u2150-\u218f])([\u2e80-\u2eff\u2f00-\u2fdf\u3040-\u309f\u30a0-\u30ff\u3100-\u312f\u3200-\u32ff\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff])');

String spacingText(String text) {
  var r = text;
  r = r.replaceAllMapped(_cjkQuote, (m) => '${m[1]} ${m[2]}');
  r = r.replaceAllMapped(_quoteCJK, (m) => '${m[1]} ${m[2]}');
  r = r.replaceAllMapped(_fixQuote, (m) => '${m[1]}${m[3]}${m[5]}');
  r = r.replaceAllMapped(_fixSingleQuote, (m) => '${m[1]}${m[3]}${m[4]}');
  r = r.replaceAllMapped(
      _hashANSCJKhash, (m) => '${m[1]} ${m[2]}${m[3]}${m[4]} ${m[5]}');
  r = r.replaceAllMapped(_cjkHash, (m) => '${m[1]} ${m[2]}');
  r = r.replaceAllMapped(_hashCJK, (m) => '${m[1]} ${m[3]}');
  r = r.replaceAllMapped(_cjkOperatorANS, (m) => '${m[1]} ${m[2]} ${m[3]}');
  r = r.replaceAllMapped(_ansOperatorCJK, (m) => '${m[1]} ${m[2]} ${m[3]}');
  final t = r;
  r = r.replaceAllMapped(_cjkBracketCJK, (m) => '${m[1]} ${m[2]} ${m[4]}');
  if (r == t) {
    r = r.replaceAllMapped(_cjkBracket, (m) => '${m[1]} ${m[2]}');
    r = r.replaceAllMapped(_bracketCJK, (m) => '${m[1]} ${m[2]}');
  }
  r = r.replaceFirstMapped(_fixBracket, (m) => '${m[1]}${m[3]}${m[5]}');
  r = r.replaceAllMapped(_fixSymbol, (m) => '${m[1]}${m[2]} ${m[3]}');
  r = r.replaceAllMapped(_cjkANS, (m) => '${m[1]} ${m[2]}');
  r = r.replaceAllMapped(_ansCJK, (m) => '${m[1]} ${m[2]}');
  return r;
}

// extension PanGu on String {
//   String get s => spacingText(this);
// }
