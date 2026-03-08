import 'package:flutter/material.dart';
import 'semester_page.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  final List<Map<String, String>> courses = const [
    {"title": "Computer Science Engineering", "duration": "4 Years"},
    {"title": "Mechanical Engineering", "duration": "4 Years"},
    {"title": "Electrical Engineering", "duration": "4 Years"},
    {"title": "Civil Engineering", "duration": "4 Years"},
    {"title": "Electronics & Communication", "duration": "4 Years"},
    {"title": "Artificial Intelligence", "duration": "4 Years"},
    {"title": "Data Science Engineering", "duration": "4 Years"},
    {"title": "Robotics Engineering", "duration": "4 Years"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Engineering Courses"),
        backgroundColor: Colors.green.shade700,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];

          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green.shade100,
                child: Icon(Icons.engineering, color: Colors.green.shade800),
              ),
              title: Text(
                course["title"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(course["duration"]!),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SemesterPage(courseName: course["title"]!),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
