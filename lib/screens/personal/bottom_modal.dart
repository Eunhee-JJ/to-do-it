import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as modal_bottom_sheet;

Future<T?> showAvatarModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? backgroundColor,
  double? elevation,
  ShapeBorder? shape,
  Clip? clipBehavior,
  Color barrierColor = Colors.black87,
  bool bounce = true,
  bool expand = false,
  AnimationController? secondAnimation,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  Duration? duration,
  SystemUiOverlayStyle? overlayStyle,
}) async {
  assert(debugCheckHasMediaQuery(context));
  assert(debugCheckHasMaterialLocalizations(context));
  final result = await Navigator.of(context, rootNavigator: useRootNavigator)
      .push(modal_bottom_sheet.ModalSheetRoute<T>(
    builder: builder,
    containerBuilder: (_, animation, child) => Container(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                      ),
                      Icon(
                        CupertinoIcons.chevron_up,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        '전체 할 일 목록()',
                        style: TextStyle(
                          fontSize: 20,
                          color: CupertinoColors.activeBlue,
                        ),
                      ),
                    ],
                  ),
                  height: 90,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 248, 248, 248),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          offset: Offset(0, -1),
                          blurRadius: 10,
                        )
                      ])),
    ),
    bounce: bounce,
    secondAnimationController: secondAnimation,
    expanded: expand,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    isDismissible: isDismissible,
    modalBarrierColor: barrierColor,
    enableDrag: enableDrag,
    duration: duration,
  ));
  return result;
}