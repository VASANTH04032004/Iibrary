import 'package:flutter/material.dart';
import 'account_screen.dart';
import 'borrowed_books_screen.dart';
import 'catalog_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    // Focus management code
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Library System',
          textAlign: TextAlign.center,
        ),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(text: 'Catalog'),
            Tab(text: 'Borrowed Books'),
            Tab(text: 'Account'),
          ],
          indicatorColor: Colors.white,
          labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 14.0),
          onTap: (index) {
            _handleTabSelection();
          },
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          CatalogScreen(),
          BorrowedBooksScreen(),
          AccountScreen(),
        ],
      ),
    );
  }
}
