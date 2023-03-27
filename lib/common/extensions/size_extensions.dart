import '../screenutil/screenutil.dart';

extension SizeExtension on double {
  double get w => screenutil().setWidth(this);

  double get h => screenutil().setHeight(this);

  double get sp => screenutil().setSp(this);
}
