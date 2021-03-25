import 'package:flutter/material.dart';
import 'package:flutter_firebase/home/jobs/job_list_tile.dart';
import 'package:flutter_firebase/home/models/job.dart';
import 'package:flutter_firebase/service/auth.dart';
import 'package:flutter_firebase/conponets_widgets/show_alert_dialog.dart';
import 'package:flutter_firebase/service/database.dart';
import 'package:provider/provider.dart';

import 'edit_job_page.dart';

class JobsPage extends StatelessWidget {
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
        title: Text('Jobs'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
            ),
            onPressed: () => _confirmSignOut(context),
          ),
        ],
      ),
      body: _buildContent(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => EditJobPage.show(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final database = Provider.of<Database>(context);
    // ! StreamBuilderではsteamに渡す値でキャストする。 =>  StreamBuilder<streamに渡した型>
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          final jobs = snapShot.data;
          final children = jobs
              .map((job) => JobListTile(
                    job: job,
                    onTap: () => EditJobPage.show(context, job: job),
                  ))
              .toList();
          return ListView(
            children: children,
          );
        }
        if (snapShot.hasError) {
          print(snapShot.error);
          return Center(
            child: Text('some error occurred.'),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
