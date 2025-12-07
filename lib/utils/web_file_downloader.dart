import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

void downloadExcelWeb(List<int> bytes, String fileName) {
  final base64 = base64Encode(bytes);
  final anchor = html.AnchorElement(
      href: 'data:application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;base64,$base64')
    ..setAttribute('download', fileName)
    ..click();
}
