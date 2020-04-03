import 'package:flutter/material.dart';
import 'package:newsapp/state/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeDialog extends StatefulWidget {
  @override
  _ThemeDialogState createState() => _ThemeDialogState();
}

class _ThemeDialogState extends State<ThemeDialog> {
  bool _darkModeSelected;

  @override
  void initState() {
    _darkModeSelected =
        Provider.of<ThemeState>(context, listen: false).isDarkModeOn;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Escolha um tema'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RadioListTile(
            title: Text("Claro"),
            groupValue: _darkModeSelected,
            value: false,
            onChanged: (value) {
              setState(() => _darkModeSelected = value);
            },
          ),
          RadioListTile(
            title: Text("Escuro"),
            groupValue: _darkModeSelected,
            value: true,
            onChanged: (value) {
              setState(() => _darkModeSelected = value);
            },
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancelar',
              style: TextStyle(color: Theme.of(context).primaryColor)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text('Ok',
              style: TextStyle(color: Theme.of(context).primaryColor)),
          onPressed: () {
            Provider.of<ThemeState>(context, listen: false)
                .updateTheme(_darkModeSelected);
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
