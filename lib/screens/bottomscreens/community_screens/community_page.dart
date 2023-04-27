import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riderapp/screens/bottomscreens/community_screens/user_confessions_screen.dart';

import '../../../components/widgets/community_page_grid.dart';
import '../../../providers/community_provider.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit = true) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Confessions>(context).fetchAndSetConfessions();
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Page'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.edit),
              onPressed: (() {
                Navigator.of(context)
                    .pushReplacementNamed(UserConfessionsScreen.routeName);
              })),
        ],
      ),
      // drawer: AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : const CommunityPageGrid(),
    );
  }
}
