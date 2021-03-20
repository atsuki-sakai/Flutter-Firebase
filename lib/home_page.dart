import 'package:flutter/material.dart';
import 'package:flutter_firebase/service/auth.dart';
import 'package:flutter_firebase/conponets_widgets/show_alert_dialog.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'Logout',
      content: 'Are you sure that you want to logout.',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    );
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  void _signOut(context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
      Navigator.of(context).popAndPushNamed('/');
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('HomePage'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _confirmSignOut(context),
          ),
        ],
      ),
      body: Container(
        child: Text('Home Page'),
      ),
    );
  }
}
