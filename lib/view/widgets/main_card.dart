import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
    final double valueOfPadding;
    final Widget? title;
    final Widget? leading;
    final Widget? trailing;
    final Widget? subTitle;
  const MainCard({
    super.key,
    required this.valueOfPadding,
    this.title,
    this.leading,
    this.trailing, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0 , right: 8.0),
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: ListTile(
          contentPadding: EdgeInsets.all(valueOfPadding),
          subtitle: subTitle,
          title: title,
          leading: leading,
          trailing: trailing,
        ),
      ),
    );
  }
}
