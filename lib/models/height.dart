class Height {
  final int heightFoot;
  final int heightInch;
  bool isSelected = false;
  String get displayableHeight => '$heightFoot ft $heightInch in';

  Height({this.heightFoot, this.heightInch});
}
