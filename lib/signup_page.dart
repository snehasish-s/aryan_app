import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'student_dashboard.dart';
import 'faculty_dashboard.dart';
import 'staff_dashboard.dart';
import 'authority_dashboard.dart';

// Stream/Program List
class StreamPrograms {
  static const List<String> streams = [
    'B.Tech',
    'M.Tech',
    'MCA',
    'BCA',
    'MBA',
    'BBA',
    'Diploma',
    'Polytechnic',
    'B.Pharm',
    'M.Pharm',
    'B.Sc',
    'M.Sc',
    'Ph.D',
  ];

  static const Map<String, List<String>> branchesByStream = {
    'B.Tech': [
      'Computer Science Engineering',
      'Information Technology',
      'Electronics & Communication Engineering',
      'Electrical Engineering',
      'Mechanical Engineering',
      'Civil Engineering',
      'Chemical Engineering',
      'Biotechnology',
      'Aerospace Engineering',
      'Automobile Engineering',
      'Mining Engineering',
      'Petroleum Engineering',
      'Food Technology',
      'Artificial Intelligence & Data Science',
    ],
    'M.Tech': [
      'Computer Science & Engineering',
      'Structural Engineering',
      'Thermal Engineering',
      'VLSI Design',
      'Power Electronics',
      'Communication Systems',
    ],
    'MCA': ['Master of Computer Applications'],
    'BCA': ['Bachelor of Computer Applications'],
    'MBA': [
      'Finance',
      'Marketing',
      'Human Resources',
      'Operations',
      'Business Analytics',
      'Digital Marketing',
    ],
    'BBA': ['Bachelor of Business Administration'],
    'Diploma': [
      'Computer Science',
      'Mechanical Engineering',
      'Civil Engineering',
      'Electrical Engineering',
      'Electronics & Communication',
    ],
    'Polytechnic': [
      'Computer Science',
      'Mechanical Engineering',
      'Civil Engineering',
      'Electrical Engineering',
    ],
    'B.Pharm': ['Bachelor of Pharmacy'],
    'M.Pharm': ['Pharmaceutics', 'Pharmacology', 'Quality Assurance'],
    'B.Sc': [
      'Computer Science',
      'Physics',
      'Chemistry',
      'Mathematics',
      'Biotechnology',
    ],
    'M.Sc': [
      'Computer Science',
      'Physics',
      'Chemistry',
      'Mathematics',
      'Biotechnology',
    ],
    'Ph.D': ['Computer Science', 'Engineering', 'Sciences', 'Management'],
  };

  static const List<String> years = [
    '1st Year',
    '2nd Year',
    '3rd Year',
    '4th Year',
    '5th Year',
  ];

  static const List<String> semesters = [
    '1st Semester',
    '2nd Semester',
    '3rd Semester',
    '4th Semester',
    '5th Semester',
    '6th Semester',
    '7th Semester',
    '8th Semester',
  ];
}

class SignupPage extends StatefulWidget {
  final String? userRole;

  const SignupPage({super.key, this.userRole});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  // Common fields
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  // Student specific
  final regdController = TextEditingController();
  String selectedStream = StreamPrograms.streams[0];
  String selectedBranch = StreamPrograms.branchesByStream['B.Tech']![0];
  String year = StreamPrograms.years[0];
  String semester = StreamPrograms.semesters[0];

  // Faculty specific
  final employeeIdController = TextEditingController();
  String facultyDepartment = "Computer Science";
  String designation = "Assistant Professor";

  // Staff specific
  String staffDepartment = "Administrative";
  String position = "Office Assistant";

  // Authority specific
  String authorityPosition = "Director";
  String authorityDepartment = "Administration";

  bool loading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  Future<void> signup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => loading = true);

    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      final role = widget.userRole ?? 'unknown';
      final coll = FirebaseFirestore.instance.collection(role);
      final docRef = coll.doc(user.user!.uid);

      Map<String, dynamic> data;
      switch (role) {
        case 'student':
          data = {
            "name": nameController.text,
            "email": emailController.text,
            "regdNo": regdController.text,
            "phone": phoneController.text,
            "stream": selectedStream,
            "branch": selectedBranch,
            "year": year,
            "semester": semester,
            "createdAt": Timestamp.now(),
            "profileComplete": true,
          };
          break;
        case 'faculty':
          data = {
            "name": nameController.text,
            "email": emailController.text,
            "phone": phoneController.text,
            "employeeId": employeeIdController.text,
            "department": facultyDepartment,
            "designation": designation,
            "createdAt": Timestamp.now(),
          };
          break;
        case 'staff':
          data = {
            "name": nameController.text,
            "email": emailController.text,
            "phone": phoneController.text,
            "department": staffDepartment,
            "position": position,
            "createdAt": Timestamp.now(),
          };
          break;
        case 'authority':
          data = {
            "name": nameController.text,
            "email": emailController.text,
            "phone": phoneController.text,
            "position": authorityPosition,
            "department": authorityDepartment,
            "createdAt": Timestamp.now(),
          };
          break;
        default:
          data = {
            "name": nameController.text,
            "email": emailController.text,
            "phone": phoneController.text,
            "createdAt": Timestamp.now(),
          };
      }

      await docRef.set(data);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${_getRoleName()} signup successful!"),
          backgroundColor: _getColorForRole(),
        ),
      );

      if (mounted) {
        switch (role) {
          case 'student':
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (c) => const StudentDashboard()),
              (route) => false,
            );
            break;
          case 'faculty':
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (c) => const FacultyDashboard()),
              (route) => false,
            );
            break;
          case 'staff':
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (c) => const StaffDashboard()),
              (route) => false,
            );
            break;
          case 'authority':
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (c) => const AuthorityDashboard()),
              (route) => false,
            );
            break;
          default:
            break;
        }
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

  String _getRoleName() {
    switch (widget.userRole) {
      case 'student':
        return 'Student';
      case 'faculty':
        return 'Faculty';
      case 'staff':
        return 'Staff';
      case 'authority':
        return 'Authority';
      default:
        return 'User';
    }
  }

  Color _getColorForRole() {
    switch (widget.userRole) {
      case 'student':
        return Colors.green;
      case 'faculty':
        return Colors.blue;
      case 'staff':
        return Colors.orange;
      case 'authority':
        return Colors.purple;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with gradient
          SliverAppBar(
            expandedHeight: 180,
            floating: false,
            pinned: true,
            backgroundColor: _getColorForRole(),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _getColorForRole(),
                      _getColorForRole().withOpacity(0.7),
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _getRoleIcon(),
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${_getRoleName()} Registration',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // Form
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Common Fields
                    _buildSectionTitle('Personal Information'),
                    const SizedBox(height: 16),

                    // Name field
                    _buildTextField(
                      controller: nameController,
                      label: "Full Name",
                      hint: "Enter your full name",
                      icon: Icons.person,
                      validator: (v) =>
                          v!.isEmpty ? "Please enter your name" : null,
                    ),
                    const SizedBox(height: 16),

                    // Email field
                    _buildTextField(
                      controller: emailController,
                      label: "Email Address",
                      hint: "Enter your email",
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        if (v == null || v.isEmpty) return "Please enter email";
                        if (!v.contains("@")) return "Invalid email format";
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Password field
                    TextFormField(
                      controller: passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Enter password (min 6 characters)",
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(
                              () => _isPasswordVisible = !_isPasswordVisible,
                            );
                          },
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty)
                          return "Please enter password";
                        if (v.length < 6)
                          return "Password must be at least 6 characters";
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Confirm Password field
                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: !_isConfirmPasswordVisible,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        hintText: "Re-enter password",
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(
                              () => _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible,
                            );
                          },
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty)
                          return "Please confirm password";
                        if (v != passwordController.text)
                          return "Passwords do not match";
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Phone field
                    _buildTextField(
                      controller: phoneController,
                      label: "Phone Number",
                      hint: "Enter phone number",
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                      validator: (v) {
                        if (v == null || v.isEmpty) return "Please enter phone";
                        if (v.length < 7) return "Invalid phone number";
                        return null;
                      },
                    ),

                    const SizedBox(height: 24),

                    // Student specific fields
                    if (widget.userRole == 'student') ...[
                      _buildSectionTitle('Academic Information'),
                      const SizedBox(height: 16),

                      // Registration Number
                      _buildTextField(
                        controller: regdController,
                        label: "Registration Number",
                        hint: "Enter your university registration number",
                        icon: Icons.badge,
                        validator: (v) {
                          if (v == null || v.isEmpty)
                            return "Please enter registration number";
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Stream/Program dropdown
                      _buildDropdownField(
                        label: "Stream/Program",
                        icon: Icons.school,
                        value: selectedStream,
                        items: StreamPrograms.streams,
                        onChanged: (v) {
                          setState(() {
                            selectedStream = v!;
                            selectedBranch =
                                StreamPrograms.branchesByStream[v]?[0] ?? '';
                          });
                        },
                      ),
                      const SizedBox(height: 16),

                      // Branch dropdown
                      _buildDropdownField(
                        label: "Branch",
                        icon: Icons.engineering,
                        value: selectedBranch,
                        items:
                            StreamPrograms.branchesByStream[selectedStream] ??
                            [],
                        onChanged: (v) {
                          setState(() => selectedBranch = v!);
                        },
                      ),
                      const SizedBox(height: 16),

                      // Year & Semester
                      Row(
                        children: [
                          Expanded(
                            child: _buildDropdownField(
                              label: "Year",
                              icon: Icons.calendar_today,
                              value: year,
                              items: StreamPrograms.years,
                              onChanged: (v) => setState(() => year = v!),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildDropdownField(
                              label: "Semester",
                              icon: Icons.date_range,
                              value: semester,
                              items: StreamPrograms.semesters,
                              onChanged: (v) => setState(() => semester = v!),
                            ),
                          ),
                        ],
                      ),
                    ],

                    // Faculty specific fields
                    if (widget.userRole == 'faculty') ...[
                      _buildSectionTitle('Employment Details'),
                      const SizedBox(height: 16),

                      _buildTextField(
                        controller: employeeIdController,
                        label: "Employee ID",
                        hint: "Enter your employee ID",
                        icon: Icons.badge,
                        validator: (v) =>
                            v!.isEmpty ? "Please enter employee ID" : null,
                      ),
                      const SizedBox(height: 16),

                      _buildDropdownField(
                        label: "Department",
                        icon: Icons.business,
                        value: facultyDepartment,
                        items: const [
                          "Computer Science",
                          "Information Technology",
                          "Electronics & Communication",
                          "Electrical Engineering",
                          "Mechanical Engineering",
                          "Civil Engineering",
                          "Chemistry",
                          "Physics",
                          "Mathematics",
                          "English",
                        ],
                        onChanged: (v) =>
                            setState(() => facultyDepartment = v!),
                      ),
                      const SizedBox(height: 16),

                      _buildDropdownField(
                        label: "Designation",
                        icon: Icons.work,
                        value: designation,
                        items: const [
                          "Professor",
                          "Associate Professor",
                          "Assistant Professor",
                          "Lecturer",
                          "Teaching Assistant",
                        ],
                        onChanged: (v) => setState(() => designation = v!),
                      ),
                    ],

                    // Staff specific fields
                    if (widget.userRole == 'staff') ...[
                      _buildSectionTitle('Work Details'),
                      const SizedBox(height: 16),

                      _buildDropdownField(
                        label: "Department",
                        icon: Icons.business,
                        value: staffDepartment,
                        items: const [
                          "Administrative",
                          "Finance",
                          "Library",
                          "Maintenance",
                          "Transport",
                          "Hostel",
                          "Sports",
                          "IT Support",
                        ],
                        onChanged: (v) => setState(() => staffDepartment = v!),
                      ),
                      const SizedBox(height: 16),

                      _buildDropdownField(
                        label: "Position",
                        icon: Icons.work,
                        value: position,
                        items: const [
                          "Office Assistant",
                          "Accountant",
                          "Librarian",
                          "Library Assistant",
                          "Maintenance Staff",
                          "Driver",
                          "Security",
                          "Wardens",
                        ],
                        onChanged: (v) => setState(() => position = v!),
                      ),
                    ],

                    // Authority specific fields
                    if (widget.userRole == 'authority') ...[
                      _buildSectionTitle('Authority Details'),
                      const SizedBox(height: 16),

                      _buildDropdownField(
                        label: "Position",
                        icon: Icons.admin_panel_settings,
                        value: authorityPosition,
                        items: const [
                          "Director",
                          "Principal",
                          "Deputy Director",
                          "Dean",
                          "Head of Department",
                          "Registrar",
                        ],
                        onChanged: (v) =>
                            setState(() => authorityPosition = v!),
                      ),
                      const SizedBox(height: 16),

                      _buildDropdownField(
                        label: "Department",
                        icon: Icons.business,
                        value: authorityDepartment,
                        items: const [
                          "Administration",
                          "Academic Affairs",
                          "Student Affairs",
                          "Finance",
                          "Research",
                          "Placements",
                        ],
                        onChanged: (v) =>
                            setState(() => authorityDepartment = v!),
                      ),
                    ],

                    const SizedBox(height: 32),

                    // Sign up button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: loading ? null : signup,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _getColorForRole(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                        ),
                        child: loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.app_registration, size: 24),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Register as ${_getRoleName()}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: _getColorForRole(),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _getColorForRole(), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildDropdownField({
    required String label,
    required IconData icon,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item, style: const TextStyle(fontSize: 14)),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  IconData _getRoleIcon() {
    switch (widget.userRole) {
      case 'student':
        return Icons.school;
      case 'faculty':
        return Icons.person;
      case 'staff':
        return Icons.business_center;
      case 'authority':
        return Icons.admin_panel_settings;
      default:
        return Icons.person;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    regdController.dispose();
    employeeIdController.dispose();
    super.dispose();
  }
}
