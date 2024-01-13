import 'package:flutter/material.dart';

class SpaAlertDialog extends StatefulWidget {
  const SpaAlertDialog({
    super.key,
    required this.title,
    required this.text,
    this.data,
    this.extraChildren = const [],
    this.firstBtnText = "Cancel",
    this.firstBtnTap,
    this.secondBtnText = "Confirm",
    this.secondBtnTap,
  });

  final String title;
  final String text;
  final Map<String, String>? data;
  final List<Widget> extraChildren;
  final String firstBtnText;
  final void Function()? firstBtnTap;
  final String secondBtnText;
  final void Function()? secondBtnTap;

  static Widget makeText(context, text) {
    ThemeData theme = Theme.of(context);
    TextTheme txtTheme = theme.textTheme;
    return Text(
      text,
      style: txtTheme.bodyLarge,
    );
  }

  @override
  State<SpaAlertDialog> createState() => _SpaAlertDialogState();
}

class _SpaAlertDialogState extends State<SpaAlertDialog> {
  @override
  Widget build(BuildContext context) {
    Widget makeTable(Map<String, String> data) {
      double padding = 5.0;
      return Table(
        columnWidths: const {
          0: IntrinsicColumnWidth(),
          1: IntrinsicColumnWidth(),
          2: FlexColumnWidth(),
        },
        border: TableBorder(
          top: BorderSide(
            color: Colors.white.withOpacity(0.1),
          ),
          horizontalInside: BorderSide(
            color: Colors.white.withOpacity(0.1),
          ),
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.1),
          ),
        ),
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        children: data.entries
            .map(
              (e) => TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: padding),
                    child: Text(e.key),
                  ),
                  Padding(
                    padding: EdgeInsets.all(padding),
                    child: const Text("  :  "),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: padding),
                    child: Text(e.value),
                  ),
                ],
              ),
            )
            .toList(),
      );
    }

    return AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SpaAlertDialog.makeText(context, widget.text),
            widget.data != null ? makeTable(widget.data!) : const SizedBox(),
            const SizedBox(height: 10.0),
            ...widget.extraChildren,
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: widget.firstBtnTap ?? () => Navigator.pop(context),
          child: Text(widget.firstBtnText),
        ),
        TextButton(
          onPressed: widget.secondBtnTap ?? () => Navigator.pop(context),
          child: Text(widget.secondBtnText),
        ),
      ],
    );
  }
}
