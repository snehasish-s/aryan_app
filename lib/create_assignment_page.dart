import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'assignment_model.dart';

class CreateAssignmentPage extends StatefulWidget {
  const CreateAssignmentPage({super.key});

  @override
  State<CreateAssignmentPage> createState() => _CreateAssignmentPageState();
}

class _CreateAssignmentPageState extends State<CreateAssignmentPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _maxMarksController = TextEditingController(text: '10');

  String _selectedBranch = EngineeringBranches.branches[0];
  String _selectedSection =
      EngineeringBranches.sections['Computer Science Engineering']![0];
  String _selectedYear = EngineeringBranches.years[0];
  String _selectedSemester = EngineeringBranches.semesters[0];
  String _selectedSubject = EngineeringBranches.subjects[0];
  DateTime _dueDate = DateTime.now().add(const Duration(days: 7));
  bool _isLoading = false;

  String _facultyName = '';
  String _facultyId = '';

  @override
  void initState() {
    super.initState();
    _loadFacultyData();
  }

  Future<void> _loadFacultyData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('faculty')
            .doc(user.uid)
            .get();
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          setState(() {
            _facultyName = data['name'] ?? '';
            _facultyId = user.uid;
          });
        }
      }
    } catch (e) {
      print('Error loading faculty data: $e');
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _maxMarksController.dispose();
    super.dispose();
  }

  Future<void> _selectDueDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _dueDate) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  Future<void> _createAssignment() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      String assignmentId = FirebaseFirestore.instance
          .collection('assignments')
          .doc()
          .id;

      Map<String, dynamic> assignmentData = {
        'id': assignmentId,
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'facultyName': _facultyName,
        'facultyId': _facultyId,
        'branch': _selectedBranch,
        'section': _selectedSection,
        'semester': _selectedSemester,
        'year': _selectedYear,
        'subject': _selectedSubject,
        'maxMarks': int.parse(_maxMarksController.text),
        'dueDate': _dueDate.toIso8601String(),
        'createdAt': DateTime.now().toIso8601String(),
        'status': 'active',
      };

      await FirebaseFirestore.instance
          .collection('assignments')
          .doc(assignmentId)
          .set(assignmentData);

      // Also create a branch-specific collection for easier querying
      await FirebaseFirestore.instance
          .collection('branch_assignments')
          .doc('${_selectedBranch}_${_selectedYear}')
          .collection('assignments')
          .doc(assignmentId)
          .set(assignmentData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Assignment created successfully for $_selectedBranch - $_selectedSection',
            ),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error creating assignment: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Create Assignment'),
        backgroundColor: Colors.blue[700],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.blue[700],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.assignment,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Post New Assignment',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Create assignment for your students',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Form
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Assignment Title
                    _buildSectionTitle('Assignment Details'),
                    const SizedBox(height: 12),
                    _buildTextField(
                      controller: _titleController,
                      label: 'Assignment Title',
                      hint: 'Enter assignment title',
                      icon: Icons.title,
                      validator: (v) =>
                          v!.isEmpty ? 'Please enter title' : null,
                    ),
                    const SizedBox(height: 16),

                    // Description
                    _buildTextField(
                      controller: _descriptionController,
                      label: 'Description',
                      hint: 'Enter assignment description',
                      icon: Icons.description,
                      maxLines: 4,
                      validator: (v) =>
                          v!.isEmpty ? 'Please enter description' : null,
                    ),
                    const SizedBox(height: 16),

                    // Subject & Max Marks
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: DropdownButtonFormField<String>(
                            value: _selectedSubject,
                            decoration: InputDecoration(
                              labelText: 'Subject',
                              prefixIcon: const Icon(Icons.book),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            items: EngineeringBranches.subjects.map((subject) {
                              return DropdownMenuItem(
                                value: subject,
                                child: Text(
                                  subject,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                            onChanged: (v) {
                              setState(() => _selectedSubject = v!);
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _maxMarksController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Max Marks',
                              prefixIcon: const Icon(Icons.grade),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (v) {
                              if (v!.isEmpty) return 'Required';
                              if (int.tryParse(v) == null) return 'Invalid';
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Target Audience
                    _buildSectionTitle('Target Audience'),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Branch
                          DropdownButtonFormField<String>(
                            value: _selectedBranch,
                            decoration: InputDecoration(
                              labelText: 'Branch',
                              prefixIcon: const Icon(Icons.school),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            items: EngineeringBranches.branches.map((branch) {
                              return DropdownMenuItem(
                                value: branch,
                                child: Text(
                                  branch,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              );
                            }).toList(),
                            onChanged: (v) {
                              setState(() {
                                _selectedBranch = v!;
                                _selectedSection =
                                    EngineeringBranches.sections[v]![0];
                              });
                            },
                          ),
                          const SizedBox(height: 16),

                          // Section & Year
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: _selectedSection,
                                  decoration: InputDecoration(
                                    labelText: 'Section',
                                    prefixIcon: const Icon(Icons.group),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  items:
                                      (EngineeringBranches
                                                  .sections[_selectedBranch] ??
                                              ['A'])
                                          .map((section) {
                                            return DropdownMenuItem(
                                              value: section,
                                              child: Text(section),
                                            );
                                          })
                                          .toList(),
                                  onChanged: (v) {
                                    setState(() => _selectedSection = v!);
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: _selectedYear,
                                  decoration: InputDecoration(
                                    labelText: 'Year',
                                    prefixIcon: const Icon(
                                      Icons.calendar_today,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  items: EngineeringBranches.years.map((year) {
                                    return DropdownMenuItem(
                                      value: year,
                                      child: Text(year),
                                    );
                                  }).toList(),
                                  onChanged: (v) {
                                    setState(() => _selectedYear = v!);
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Semester
                          DropdownButtonFormField<String>(
                            value: _selectedSemester,
                            decoration: InputDecoration(
                              labelText: 'Semester',
                              prefixIcon: const Icon(Icons.date_range),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            items: EngineeringBranches.semesters.map((sem) {
                              return DropdownMenuItem(
                                value: sem,
                                child: Text(sem),
                              );
                            }).toList(),
                            onChanged: (v) {
                              setState(() => _selectedSemester = v!);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Due Date
                    _buildSectionTitle('Due Date'),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: _selectDueDate,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.calendar_month,
                                color: Colors.blue[700],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Submission Deadline',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    DateFormat(
                                      'EEEE, MMMM dd, yyyy',
                                    ).format(_dueDate),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.grey[400],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _createAssignment,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.upload_file, size: 24),
                                  SizedBox(width: 8),
                                  Text(
                                    'Post Assignment',
                                    style: TextStyle(
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
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
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
          borderSide: BorderSide(color: Colors.blue[700]!, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      validator: validator,
    );
  }
}
