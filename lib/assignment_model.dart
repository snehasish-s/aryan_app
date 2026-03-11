class Assignment {
  final String id;
  final String title;
  final String description;
  final String facultyName;
  final String facultyId;
  final String branch;
  final String semester;
  final String year;
  final DateTime dueDate;
  final DateTime createdAt;
  final String subject;
  final int maxMarks;
  final List<String> attachments;

  Assignment({
    required this.id,
    required this.title,
    required this.description,
    required this.facultyName,
    required this.facultyId,
    required this.branch,
    required this.semester,
    required this.year,
    required this.dueDate,
    required this.createdAt,
    required this.subject,
    required this.maxMarks,
    this.attachments = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'facultyName': facultyName,
      'facultyId': facultyId,
      'branch': branch,
      'semester': semester,
      'year': year,
      'dueDate': dueDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'subject': subject,
      'maxMarks': maxMarks,
      'attachments': attachments,
    };
  }

  factory Assignment.fromMap(Map<String, dynamic> map) {
    return Assignment(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      facultyName: map['facultyName'] ?? '',
      facultyId: map['facultyId'] ?? '',
      branch: map['branch'] ?? '',
      semester: map['semester'] ?? '',
      year: map['year'] ?? '',
      dueDate: DateTime.parse(map['dueDate']),
      createdAt: DateTime.parse(map['createdAt']),
      subject: map['subject'] ?? '',
      maxMarks: map['maxMarks'] ?? 0,
      attachments: List<String>.from(map['attachments'] ?? []),
    );
  }
}

// Engineering Branches
class EngineeringBranches {
  static const List<String> branches = [
    'Computer Science Engineering',
    'Artificial Intelligence & Data Science',
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
  ];

  static const Map<String, List<String>> sections = {
    'Computer Science Engineering': ['CSE-A', 'CSE-B', 'CSE-C', 'CSE-D'],
    'Artificial Intelligence & Data Science': ['AI-A', 'AI-B'],
    'Information Technology': ['IT-A', 'IT-B', 'IT-C'],
    'Electronics & Communication Engineering': ['ECE-A', 'ECE-B', 'ECE-C'],
    'Electrical Engineering': ['EE-A', 'EE-B'],
    'Mechanical Engineering': ['ME-A', 'ME-B', 'ME-C'],
    'Civil Engineering': ['CE-A', 'CE-B'],
    'Chemical Engineering': ['CHE-A'],
    'Biotechnology': ['BT-A'],
    'Aerospace Engineering': ['AE-A'],
    'Automobile Engineering': ['AU-A'],
    'Mining Engineering': ['ME-A'],
    'Petroleum Engineering': ['PE-A'],
    'Food Technology': ['FT-A'],
  };

  static const List<String> years = [
    '1st Year',
    '2nd Year',
    '3rd Year',
    '4th Year',
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

  static const List<String> subjects = [
    'Mathematics',
    'Physics',
    'Chemistry',
    'Computer Fundamentals',
    'Data Structures',
    'Algorithms',
    'Database Management',
    'Operating Systems',
    'Computer Networks',
    'Machine Learning',
    'Artificial Intelligence',
    'Web Development',
    'Mobile App Development',
    'Software Engineering',
    'Digital Electronics',
    'Circuit Theory',
    'Signal Processing',
    'Thermodynamics',
    'Fluid Mechanics',
    'Structural Analysis',
  ];
}
