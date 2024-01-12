import 'package:flutter/material.dart';

class ProfileTable extends StatelessWidget {
  final Map<String, String> data;
  final double padding;
  const ProfileTable({super.key, required this.data, this.padding = 15.0});

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(),
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
                  padding: EdgeInsets.symmetric(
                      horizontal: padding, vertical: padding),
                  child: Text(e.key),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: padding, vertical: padding),
                  child: Text(
                    e.value,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.grey[400]),
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
