import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class StudentAssignmentsPage extends StatefulWidget {
  const StudentAssignmentsPage({super.key});

  @override
  State<StudentAssignmentsPage> createState() => _StudentAssignmentsPageState();
}

class _StudentAssignmentsPageState extends State<StudentAssignmentsPage> {
  String _userBranch = '';
  String _userSection = '';
  String _userSemester = '';
  String _userYear = '';
  bool _isLoading = true;
  List<Map<String, dynamic>> _assignments = [];

  @override
  void initState() {
    super.initState();
    _loadUserDataAndAssignments();
  }

  Future<void> _loadUserDataAndAssignments() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Load student data
        DocumentSnapshot studentDoc = await FirebaseFirestore.instance
            .collection('students')
            .doc(user.uid)
            .get();

        if (studentDoc.exists) {
          Map<String, dynamic> studentData =
              studentDoc.data() as Map<String, dynamic>;
          setState(() {
            _userBranch = studentData['branch'] ?? '';
            _userSection = studentData['section'] ?? '';
            _userSemester = studentData['semester'] ?? '';
            _userYear = studentData['year'] ?? '';
          });

          // Load assignments for this branch and semester
          await _loadAssignments();
        }
      }
    } catch (e) {
      print('Error loading data: $e');
    }

    setState(() => _isLoading = false);
  }

  Future<void> _loadAssignments() async {
    try {
      // Query assignments for the student's branch and section
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('assignments')
          .where('branch', isEqualTo: _userBranch)
          .orderBy('createdAt', descending: true)
          .get();

      List<Map<String, dynamic>> assignments = [];

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        // Filter by section if needed
        if (data['section'] == _userSection || data['section'] == null) {
          assignments.add(data);
        }
      }

      setState(() {
        _assignments = assignments;
      });
    } catch (e) {
      print('Error loading assignments: $e');
    }
  }

  String _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'orange';
      case 'submitted':
        return 'blue';
      case 'graded':
        return 'green';
      case 'overdue':
        return 'red';
      default:
        return 'grey';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('My Assignments'),
        backgroundColor: Colors.green[700],
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadUserDataAndAssignments,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Student Info Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green[700],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.school,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _userBranch,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '$_userSection • $_userYear • $_userSemester',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Assignments List
                Expanded(
                  child: _assignments.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _assignments.length,
                          itemBuilder: (context, index) {
                            return _buildAssignmentCard(_assignments[index]);
                          },
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No Assignments Yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your faculty haven\'t posted any assignments\nfor your branch yet.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[500], fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentCard(Map<String, dynamic> assignment) {
    DateTime dueDate = DateTime.parse(assignment['dueDate']);
    DateTime createdAt = DateTime.parse(assignment['createdAt']);
    bool isOverdue = dueDate.isBefore(DateTime.now());
    bool isDueSoon = dueDate.difference(DateTime.now()).inDays <= 2;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isOverdue
                  ? Colors.red[50]
                  : isDueSoon
                  ? Colors.orange[50]
                  : Colors.green[50],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isOverdue
                        ? Colors.red
                        : isDueSoon
                        ? Colors.orange
                        : Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.assignment,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        assignment['subject'] ?? 'Subject',
                        style: TextStyle(
                          color: isOverdue
                              ? Colors.red[700]
                              : isDueSoon
                              ? Colors.orange[700]
                              : Colors.green[700],
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        assignment['title'] ?? 'Assignment',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isOverdue ? Colors.red : Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isOverdue ? 'Overdue' : 'Active',
                    style: TextStyle(
                      color: isOverdue ? Colors.white : Colors.grey[700],
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  assignment['description'] ?? 'No description',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),

                // Details
                Row(
                  children: [
                    _buildInfoChip(
                      Icons.person,
                      assignment['facultyName'] ?? 'Faculty',
                    ),
                    const SizedBox(width: 12),
                    _buildInfoChip(
                      Icons.grade,
                      '${assignment['maxMarks']} marks',
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Dates
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Posted: ${DateFormat('MMM dd, yyyy').format(createdAt)}',
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.event,
                      size: 16,
                      color: isOverdue ? Colors.red : Colors.grey[500],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Due: ${DateFormat('MMM dd, yyyy').format(dueDate)}',
                      style: TextStyle(
                        color: isOverdue ? Colors.red : Colors.grey[500],
                        fontSize: 12,
                        fontWeight: isOverdue
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Action Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isOverdue
                        ? null
                        : () {
                            // TODO: Implement assignment submission
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Assignment submission coming soon!',
                                ),
                              ),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isOverdue
                          ? Colors.grey
                          : Colors.green[700],
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isOverdue ? Icons.lock : Icons.upload_file,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isOverdue ? 'Submission Closed' : 'Submit Assignment',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey[600]),
          const SizedBox(width: 6),
          Text(text, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        ],
      ),
    );
  }
}
