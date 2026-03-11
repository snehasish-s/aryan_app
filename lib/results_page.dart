import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({Key? key}) : super(key: key);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _userName = '';
  bool _isLoading = true;

  List<Map<String, dynamic>> _semesterResults = [];
  double _gpa = 0.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('students')
            .doc(user.uid)
            .get();
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          setState(() => _userName = data['name'] ?? 'Student');
        }
      }
    } catch (e) {
      print('Error: $e');
    }

    _semesterResults = [
      {
        'semester': 'Semester 1',
        'sgpa': 8.2,
        'subjects': [
          {'name': 'Mathematics I', 'grade': 'A', 'marks': 85, 'credits': 4},
          {'name': 'Physics', 'grade': 'A-', 'marks': 82, 'credits': 4},
          {'name': 'Chemistry', 'grade': 'B+', 'marks': 78, 'credits': 4},
          {'name': 'English', 'grade': 'A', 'marks': 88, 'credits': 2},
          {'name': 'Basic Electrical', 'grade': 'B', 'marks': 75, 'credits': 3},
        ],
      },
      {
        'semester': 'Semester 2',
        'sgpa': 8.8,
        'subjects': [
          {'name': 'Mathematics II', 'grade': 'A', 'marks': 87, 'credits': 4},
          {'name': 'C Programming', 'grade': 'A', 'marks': 90, 'credits': 4},
          {
            'name': 'Engineering Mechanics',
            'grade': 'B+',
            'marks': 79,
            'credits': 4,
          },
          {
            'name': 'Environmental Studies',
            'grade': 'A-',
            'marks': 83,
            'credits': 2,
          },
          {'name': 'Workshop', 'grade': 'A', 'marks': 85, 'credits': 3},
        ],
      },
      {
        'semester': 'Semester 3',
        'sgpa': 9.1,
        'subjects': [
          {'name': 'Data Structures', 'grade': 'A+', 'marks': 92, 'credits': 4},
          {
            'name': 'Digital Electronics',
            'grade': 'A',
            'marks': 88,
            'credits': 4,
          },
          {
            'name': 'Object Oriented Programming',
            'grade': 'A',
            'marks': 90,
            'credits': 4,
          },
          {
            'name': 'Discrete Mathematics',
            'grade': 'A-',
            'marks': 84,
            'credits': 3,
          },
          {
            'name': 'Technical Communication',
            'grade': 'A',
            'marks': 86,
            'credits': 2,
          },
        ],
      },
    ];

    double totalPoints = 0;
    int totalCredits = 0;
    for (var sem in _semesterResults) {
      for (var sub in sem['subjects']) {
        totalPoints += _getGradePoints(sub['grade']) * (sub['credits'] as int);
        totalCredits += (sub['credits'] as int);
      }
    }
    _gpa = totalPoints / totalCredits;
    setState(() => _isLoading = false);
  }

  double _getGradePoints(String grade) {
    switch (grade) {
      case 'A+':
        return 10;
      case 'A':
        return 9;
      case 'A-':
        return 8.5;
      case 'B+':
        return 8;
      case 'B':
        return 7;
      default:
        return 0;
    }
  }

  Color _getGradeColor(String grade) {
    if (grade.startsWith('A')) return Colors.green;
    if (grade.startsWith('B')) return Colors.blue;
    return Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Results & Grades'),
        backgroundColor: Colors.green.shade700,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Overview', icon: Icon(Icons.dashboard)),
            Tab(text: 'Subjects', icon: Icon(Icons.list)),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [_buildOverviewTab(), _buildSubjectsTab()],
            ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade400, Colors.green.shade700],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Text(
                  'Cumulative GPA',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  _gpa.toStringAsFixed(2),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _getGradeDescription(_gpa),
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Semester Performance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(
            _semesterResults.length,
            (index) => _buildSemesterCard(_semesterResults[index], index),
          ),
        ],
      ),
    );
  }

  Widget _buildSemesterCard(Map<String, dynamic> sem, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sem['semester'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${sem['subjects'].length} Subjects',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                sem['sgpa'].toString(),
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                'SGPA',
                style: TextStyle(color: Colors.grey[500], fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getGradeDescription(double gpa) {
    if (gpa >= 9) return 'Excellent - First Class with Distinction';
    if (gpa >= 8) return 'Very Good - First Class';
    if (gpa >= 7) return 'Good - Second Class';
    return 'Need Improvement';
  }

  Widget _buildSubjectsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _semesterResults.length,
      itemBuilder: (context, index) {
        final sem = _semesterResults[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                sem['semester'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...List.generate(
              (sem['subjects'] as List).length,
              (subIndex) => _buildSubjectCard(sem['subjects'][subIndex]),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Widget _buildSubjectCard(Map<String, dynamic> subject) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: _getGradeColor(subject['grade']).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                subject['grade'],
                style: TextStyle(
                  color: _getGradeColor(subject['grade']),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Text(
                  '${subject['credits']} Credits',
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            '${subject['marks']}',
            style: TextStyle(
              color: _getGradeColor(subject['grade']),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
