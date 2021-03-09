import 'package:flutter/material.dart';
import 'package:roylen/ui/theming/const_values.dart';

class ErrorMessage extends StatelessWidget {
  final String _msg;
  ErrorMessage(this._msg);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ConstValues.appPadding),
      margin: const EdgeInsets.symmetric(vertical: ConstValues.divPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ConstValues.appColor,
      ),
      child: Text(
        _msg,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(color: ConstValues.errorColor, height: 1.5),
      ),
    );
  }
}
