import 'package:flutter/material.dart';
import 'package:ja_travel/provider/settings_provider.dart';
import 'package:ja_travel/provider/user_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Configuración",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(16),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.lock),
                  title: Text("Cambiar contraseña"),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () => Navigator.pushNamed(context, '/edit_password'),
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Cerrar sesión"),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () => context.read<UserProvider>().logout().then(
                      (value) => Navigator.pushNamedAndRemoveUntil(
                          context, '/login', (route) => false)),
                ),
                SwitchListTile(
                  value: context.watch<SettingsProvider>().mode,
                  onChanged: (value) async => await context
                      .read<SettingsProvider>()
                      .changeMode(value: value),
                  title: Text(context.watch<SettingsProvider>().mode
                      ? "Modo claro"
                      : "Modo oscuro"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
