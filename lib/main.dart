import 'package:drift/src/runtime/executor/executor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart'; 
import 'package:atts_jewels/common/database/app_database.dart'; // Import your database
import 'package:atts_jewels/features/home/presentation/pages/home_page.dart';

// Initialize GetIt and register the AppDatabase
void setup() async {
  // Register AppDatabase with GetIt using registerSingletonAsync for async initialization
 GetIt.I.registerSingleton(AppDatabase()); // Pass the synchronous openConnection() function
}

void main() {
  setup(); // Call the setup function to register dependencies
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
