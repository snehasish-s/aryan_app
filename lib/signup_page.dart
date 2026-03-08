import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'student_dashboard.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final regdController = TextEditingController();
  final phoneController = TextEditingController();

  String branch = "Computer Science Engineering";
  String year = "1st Year";
  String semester = "1";

  bool loading = false;

  Future<void> signup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => loading = true);

    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      await FirebaseFirestore.instance
          .collection("students")
          .doc(user.user!.uid)
          .set({
            "name": nameController.text,
            "email": emailController.text,
            "regdNo": regdController.text,
            "phone": phoneController.text,
            "branch": branch,
            "year": year,
            "semester": semester,
            "createdAt": Timestamp.now(),
          });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Signup Successful")));

      // Navigate to StudentDashboard with replacement
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const StudentDashboard()),
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = "Signup Failed";

      if (e.code == 'weak-password') {
        message = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        message = "An account already exists for that email.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Signup"),
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Full Name"),
                validator: (v) => v!.isEmpty ? "Enter name" : null,
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (v) => v!.contains("@") ? null : "Invalid email",
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
                validator: (v) => v!.length < 6 ? "Min 6 characters" : null,
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: regdController,
                decoration: const InputDecoration(labelText: "Registration No"),
                validator: (v) => v!.isEmpty ? "Enter Regd No" : null,
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: "Phone Number"),
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField(
                value: branch,
                decoration: const InputDecoration(labelText: "Branch"),
                items: const [
                  DropdownMenuItem(
                    value: "Computer Science Engineering",
                    child: Text("Computer Science Engineering"),
                  ),

                  DropdownMenuItem(
                    value: "Mechanical Engineering",
                    child: Text("Mechanical Engineering"),
                  ),

                  DropdownMenuItem(
                    value: "Electrical Engineering",
                    child: Text("Electrical Engineering"),
                  ),

                  DropdownMenuItem(
                    value: "Civil Engineering",
                    child: Text("Civil Engineering"),
                  ),
                ],
                onChanged: (v) {
                  setState(() {
                    branch = v!;
                  });
                },
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField(
                value: year,
                decoration: const InputDecoration(labelText: "Year"),
                items: const [
                  DropdownMenuItem(value: "1st Year", child: Text("1st Year")),
                  DropdownMenuItem(value: "2nd Year", child: Text("2nd Year")),
                  DropdownMenuItem(value: "3rd Year", child: Text("3rd Year")),
                  DropdownMenuItem(value: "4th Year", child: Text("4th Year")),
                ],
                onChanged: (v) {
                  setState(() {
                    year = v!;
                  });
                },
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField(
                value: semester,
                decoration: const InputDecoration(labelText: "Semester"),
                items: const [
                  DropdownMenuItem(value: "1", child: Text("Semester 1")),
                  DropdownMenuItem(value: "2", child: Text("Semester 2")),
                  DropdownMenuItem(value: "3", child: Text("Semester 3")),
                  DropdownMenuItem(value: "4", child: Text("Semester 4")),
                  DropdownMenuItem(value: "5", child: Text("Semester 5")),
                  DropdownMenuItem(value: "6", child: Text("Semester 6")),
                  DropdownMenuItem(value: "7", child: Text("Semester 7")),
                  DropdownMenuItem(value: "8", child: Text("Semester 8")),
                ],
                onChanged: (v) {
                  setState(() {
                    semester = v!;
                  });
                },
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: loading ? null : signup,
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
