import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nucleusv2/constants.dart';
import 'package:nucleusv2/src/core/app/session_provider.dart';
import 'package:nucleusv2/src/core/app/singletons.dart';
import 'package:nucleusv2/src/core/app_router.dart';
import 'package:nucleusv2/src/core/app_router.gr.dart';
import 'package:nucleusv2/src/core/base_component.dart';
import 'package:web/web.dart' as web;

class AuthButton extends BaseComponent {
  const AuthButton({super.key});

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    final sessionProvider = ref.watch(sessionStateNotifierProvider);

    final isAuthenticated =
        sessionProvider.isAuthenticated && sessionProvider.user != null;
    var username = ref.read(sessionStateNotifierProvider).user!.name;
    return  Row(
      children: [
        username == logSPUserName ?     ElevatedButton(onPressed: (){
           _showPersistentDialog(context);
            }, child: Text('Show SP')) : Container(),
        TextButton(
          onPressed: () {
            if (isAuthenticated) {
              singleton<AppRouter>().push(const SettingsRoute());
            } else {
              singleton<AppRouter>().push(const LoginRoute());
            }
          },
          child:   Text(
            isAuthenticated
                ?  username
                : "Login",
          ),
        ),
      ],
    );
  }
}



  void _showPersistentDialog(BuildContext context) {
           final items = getSortedSessionStorageItems();     
    showDialog(
      context: context,
      barrierDismissible: false, // This makes the dialog persistent
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('SP List'),
          content:  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.8,
            child: ListView.builder(
              
              itemCount: items.length,
              itemBuilder:   (context, index) { 

              String? todisplay = items[index]['params'] == null ?  'No Params': items[index]['params'].toString();

            //  return Text(todisplay);
              return SizedBox(
                child: ListTile(     
                  
                  title: SelectableText('${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(items[index]['timestamp']))} ${items[index]['sp'] ?? 'No SP Name'} '),
                  subtitle: SelectableText(todisplay),
           // subtitle: Text('${items[index]['sp'] ?? 'No SP Name'} ${todisplay}'),
                ),
              );
            }),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                 final web.Storage storage = web.window.sessionStorage;
                storage.clear();
                Navigator.of(context).pop(); 
                _showPersistentDialog(context);
              },
              child: const Text('Clear'),
            ),
              TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // You need to explicitly close it
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  List<Map<String, dynamic>> getSortedSessionStorageItems() {
  final web.Storage storage = web.window.sessionStorage;
  List<Map<String, dynamic>> items = [];

  // Iterate over all keys in session storage
  for (int i = 0; i < storage.length; i++) {
    final String? key = storage.key(i);
    if (key != null) {
      final String? value = storage.getItem(key);
      if (value != null) {
        try {
          // Decode the JSON string value into a Dart map
          final Map<String, dynamic> item = json.decode(value);
          // Assuming the item has a 'timestamp' field (unix timestamp in milliseconds)
          if (item.containsKey('timestamp')) {
            items.add(item);
          }
        } catch (e) {
          // Handle potential JSON parsing errors
        }
      }
    }
  }

  // Sort the list of items by the 'timestamp' field (descending order)
  items.sort((a, b) {
    // Convert the unix timestamp (e.g., int/double) to a DateTime object for comparison
    final DateTime dateA = DateTime.parse(a['timestamp']);
    final DateTime dateB = DateTime.parse(b['timestamp']);
    return dateB.compareTo(dateA);
  });

  return items;
}
