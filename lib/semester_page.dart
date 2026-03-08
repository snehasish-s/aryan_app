import 'package:flutter/material.dart';
import 'pdf_viewer_page.dart';

class SemesterPage extends StatelessWidget {
  final String courseName;

  const SemesterPage({super.key, required this.courseName});

  @override
  Widget build(BuildContext context) {
    List<String> semesters = [
      "Semester 1",
      "Semester 2",
      "Semester 3",
      "Semester 4",
      "Semester 5",
      "Semester 6",
      "Semester 7",
      "Semester 8",
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(courseName),
        backgroundColor: Colors.green.shade700,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: semesters.length,
        itemBuilder: (context, index) {
          final semester = semesters[index];

          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green.shade100,
                child: Text("${index + 1}"),
              ),
              title: Text(
                semester,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.picture_as_pdf),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfViewerPage(
                      title: semester,
                      pdfPath: "assets/pdfs/sem6.pdf",
                    ),
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
