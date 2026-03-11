import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_page.dart';
import 'student_dashboard.dart';
import 'faculty_dashboard.dart';
import 'staff_dashboard.dart';
import 'authority_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // Set Firestore settings for better reliability
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> _getHomeWidget(User user) async {
    try {
      // Check students collection
      DocumentSnapshot studentDoc = await FirebaseFirestore.instance
          .collection('students')
          .doc(user.uid)
          .get();
      if (studentDoc.exists) {
        return const StudentDashboard();
      }

      // Check faculty collection
      DocumentSnapshot facultyDoc = await FirebaseFirestore.instance
          .collection('faculty')
          .doc(user.uid)
          .get();
      if (facultyDoc.exists) {
        return const FacultyDashboard();
      }

      // Check staff collection
      DocumentSnapshot staffDoc = await FirebaseFirestore.instance
          .collection('staff')
          .doc(user.uid)
          .get();
      if (staffDoc.exists) {
        return const StaffDashboard();
      }

      // Check authority collection
      DocumentSnapshot authorityDoc = await FirebaseFirestore.instance
          .collection('authority')
          .doc(user.uid)
          .get();
      if (authorityDoc.exists) {
        return const AuthorityDashboard();
      }

      // If no collection found, return to home
      return const HomePage();
    } catch (e) {
      print('Error checking user role: $e');
      return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aryan App',
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.hasData && snapshot.data != null) {
            // User is logged in - check role and route accordingly
            return FutureBuilder<Widget>(
              future: _getHomeWidget(snapshot.data!),
              builder: (context, homeSnapshot) {
                if (homeSnapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }

                if (homeSnapshot.hasData) {
                  return homeSnapshot.data!;
                } else {
                  return const HomePage();
                }
              },
            );
          } else {
            // User is not logged in - show home page
            return const HomePage();
          }
        },
      ),
    );
  }
}
