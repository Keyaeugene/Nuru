import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages/home_page.dart';

void main() {
  final supabaseClient = SupabaseClient(
    'https://thcutchnxqzqdaqvhpzs.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRoY3V0Y2hueHF6cWRhcXZocHpzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTk0OTk2NTIsImV4cCI6MjAzNTA3NTY1Mn0.ElE53quPMezzkjB6xg3wUXxZVI71XvpotO1BGy8p92s',
  );
  runApp(MyApp(supabaseClient: supabaseClient));
}

class MyApp extends StatelessWidget {
  final SupabaseClient supabaseClient;
  const MyApp({super.key, required this.supabaseClient});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nuru',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(supabaseClient: supabaseClient),
    );
  }
}
