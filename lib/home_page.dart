import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController floatingController;
  late AnimationController pulseController;
  late AnimationController shimmerController;
  late AnimationController parallaxController;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;
  late Animation<double> scaleAnimation;
  late Animation<double> rotationAnimation;
  late Animation<double> pulseAnimation;
  late Animation<double> shimmerAnimation;
  late Animation<Offset> parallaxAnimation;

  final List<Map<String, dynamic>> noticeBoard = [
    {
      'date': 'February 09, 2026',
      'title': 'On Campus drive by Bhojsoft solutions',
      'icon': Icons.business_center,
      'color': Colors.blue,
      'priority': 'High',
      'description':
          'Bhojsoft solutions is conducting an on-campus drive for final year students. Eligibility: 60% and above in academics.',
    },
    {
      'date': 'January 10, 2026',
      'title': "Notice for name registration for an 'ITI'-'Poly' fest 2025-26",
      'icon': Icons.festival,
      'color': Colors.orange,
      'priority': 'Medium',
      'description':
          'Registration open for the annual ITI-Poly fest. Last date: January 15, 2026.',
    },
    {
      'date': 'January 09, 2026',
      'title': 'Notice for Timely Entry to Examination Halls',
      'icon': Icons.access_time,
      'color': Colors.red,
      'priority': 'Urgent',
      'description':
          'Students must arrive 15 minutes before exam start time. Late entries will not be permitted.',
    },
    {
      'date': 'January 08, 2026',
      'title': 'Library Timings Extended During Exams',
      'icon': Icons.library_books,
      'color': Colors.purple,
      'priority': 'Medium',
      'description':
          'Library will remain open from 7 AM to 10 PM during examination period.',
    },
    {
      'date': 'January 07, 2026',
      'title': 'Scholarship Application Deadline Extended',
      'icon': Icons.school,
      'color': Colors.teal,
      'priority': 'High',
      'description':
          'Last date for scholarship applications extended to January 20, 2026.',
    },
  ];

  final List<String> academicCourses = [
    'Diploma',
    'BTech',
    'MBA',
    'MCA',
    'MTech',
    'Placement Database',
    'E-Magazine',
    'Certification of Accreditation',
    'PhD Programs',
    'Certificate Courses',
    'Online Learning',
    'Research Programs',
  ];

  final List<Map<String, dynamic>> placementCompanies = [
    {'name': 'Infosys', 'logo': Icons.apartment, 'color': Colors.blue},
    {'name': 'Amazon', 'logo': Icons.shopping_cart, 'color': Colors.orange},
    {'name': 'IBM', 'logo': Icons.computer, 'color': Colors.indigo},
    {'name': 'HCL', 'logo': Icons.devices, 'color': Colors.green},
    {'name': 'Google Maps', 'logo': Icons.map, 'color': Colors.red},
    {
      'name': 'HSBC Bank',
      'logo': Icons.account_balance,
      'color': Colors.purple,
    },
    {
      'name': 'ICICI Bank',
      'logo': Icons.account_balance_wallet,
      'color': Colors.teal,
    },
    {'name': 'Microsoft', 'logo': Icons.window, 'color': Colors.blueGrey},
    {'name': 'TCS', 'logo': Icons.laptop, 'color': Colors.deepOrange},
    {'name': 'Wipro', 'logo': Icons.cloud, 'color': Colors.cyan},
  ];

  final List<Map<String, dynamic>> events = [
    {
      'title': 'Tech Fest 2024',
      'date': 'March 15-17, 2024',
      'time': '10:00 AM',
      'venue': 'Main Auditorium',
      'attendees': 500,
      'color': Colors.blue,
      'organizer': 'Computer Science Dept',
      'description':
          'Annual technical festival with coding competitions, workshops, and guest lectures.',
    },
    {
      'title': 'Sports Meet',
      'date': 'March 20-25, 2024',
      'time': '9:00 AM',
      'venue': 'Sports Complex',
      'attendees': 300,
      'color': Colors.green,
      'organizer': 'Physical Education Dept',
      'description':
          'Inter-department sports competition including cricket, football, and athletics.',
    },
    {
      'title': 'Alumni Meet',
      'date': 'April 5, 2024',
      'time': '6:00 PM',
      'venue': 'Conference Hall',
      'attendees': 200,
      'color': Colors.purple,
      'organizer': 'Alumni Association',
      'description':
          'Annual gathering of alumni from various batches. Networking and cultural events.',
    },
    {
      'title': 'Hackathon 2024',
      'date': 'April 12-14, 2024',
      'time': '9:00 AM',
      'venue': 'Innovation Lab',
      'attendees': 150,
      'color': Colors.orange,
      'organizer': 'Innovation Cell',
      'description':
          '48-hour hackathon to solve real-world problems. Exciting prizes for winners.',
    },
    {
      'title': 'Career Fair',
      'date': 'April 20, 2024',
      'time': '10:00 AM',
      'venue': 'Main Ground',
      'attendees': 1000,
      'color': Colors.red,
      'organizer': 'Training & Placement Cell',
      'description':
          'Meet recruiters from top companies. On-the-spot interviews and job offers.',
    },
  ];

  final List<Map<String, dynamic>> testimonials = [
    {
      'name': 'Rahul Sharma',
      'batch': '2023',
      'company': 'Google',
      'position': 'Software Engineer',
      'message':
          'AIET provided me with the perfect platform to launch my career. The faculty and infrastructure are world-class. The coding culture and placement training helped me crack Google.',
      'rating': 5,
      'image': 'https://i.pravatar.cc/150?img=1',
    },
    {
      'name': 'Priya Patel',
      'batch': '2022',
      'company': 'Microsoft',
      'position': 'Product Manager',
      'message':
          'The placement training and industry exposure at AIET is unmatched. Grateful for my time here. The mentorship program helped me grow both personally and professionally.',
      'rating': 5,
      'image': 'https://i.pravatar.cc/150?img=2',
    },
    {
      'name': 'Amit Kumar',
      'batch': '2023',
      'company': 'Amazon',
      'position': 'SDE',
      'message':
          'Excellent faculty and great learning environment. The entrepreneurship cell helped me start my journey. AIET gave me the confidence to pursue my dreams.',
      'rating': 5,
      'image': 'https://i.pravatar.cc/150?img=3',
    },
    {
      'name': 'Sneha Reddy',
      'batch': '2021',
      'company': 'Goldman Sachs',
      'position': 'Analyst',
      'message':
          'The rigorous curriculum and industry-oriented projects prepared me well for the corporate world. Thank you AIET!',
      'rating': 5,
      'image': 'https://i.pravatar.cc/150?img=4',
    },
  ];

  final List<Map<String, dynamic>> facultyMembers = [
    {
      'name': 'Dr. S. Patnaik',
      'department': 'Computer Science',
      'experience': '15 years',
      'specialization': 'AI & ML',
      'color': Colors.blue,
    },
    {
      'name': 'Prof. M. Das',
      'department': 'Electronics',
      'experience': '12 years',
      'specialization': 'VLSI Design',
      'color': Colors.green,
    },
    {
      'name': 'Dr. R. Mohanty',
      'department': 'Mechanical',
      'experience': '18 years',
      'specialization': 'Thermal Engineering',
      'color': Colors.orange,
    },
    {
      'name': 'Prof. S. Behera',
      'department': 'Civil',
      'experience': '10 years',
      'specialization': 'Structural Engineering',
      'color': Colors.purple,
    },
  ];

  final List<Map<String, dynamic>> achievements = [
    {
      'title': 'Best Engineering College',
      'year': '2023',
      'award': 'Education Excellence Award',
      'icon': Icons.emoji_events,
      'color': Colors.amber,
    },
    {
      'title': 'Top Placement Record',
      'year': '2023',
      'award': 'Highest Placement in Odisha',
      'icon': Icons.work,
      'color': Colors.green,
    },
    {
      'title': 'Research Excellence',
      'year': '2023',
      'award': '50+ Research Papers Published',
      'icon': Icons.science,
      'color': Colors.blue,
    },
    {
      'title': 'Sports Champions',
      'year': '2023',
      'award': 'Inter-College Sports Trophy',
      'icon': Icons.sports,
      'color': Colors.red,
    },
  ];

  final List<Map<String, dynamic>> clubsAndSocieties = [
    {
      'name': 'Coding Club',
      'members': 200,
      'activities': 'Hackathons, Workshops',
      'icon': Icons.code,
      'color': Colors.blue,
    },
    {
      'name': 'Robotics Club',
      'members': 150,
      'activities': 'Robot Building, Competitions',
      'icon': Icons.smart_toy,
      'color': Colors.green,
    },
    {
      'name': 'Drama Society',
      'members': 100,
      'activities': 'Theatre, Street Plays',
      'icon': Icons.theater_comedy,
      'color': Colors.orange,
    },
    {
      'name': 'Music Club',
      'members': 120,
      'activities': 'Band, Choir, Instruments',
      'icon': Icons.music_note,
      'color': Colors.purple,
    },
    {
      'name': 'Photography Club',
      'members': 80,
      'activities': 'Photo Walks, Exhibitions',
      'icon': Icons.camera,
      'color': Colors.red,
    },
    {
      'name': 'Entrepreneurship Cell',
      'members': 90,
      'activities': 'Startup Incubation',
      'icon': Icons.business,
      'color': Colors.teal,
    },
  ];

  final List<Map<String, dynamic>> researchProjects = [
    {
      'title': 'AI-based Healthcare System',
      'lead': 'Dr. S. Patnaik',
      'students': 5,
      'status': 'Ongoing',
      'color': Colors.blue,
    },
    {
      'title': 'Renewable Energy Integration',
      'lead': 'Dr. R. Mohanty',
      'students': 4,
      'status': 'Completed',
      'color': Colors.green,
    },
    {
      'title': 'Smart Traffic Management',
      'lead': 'Prof. M. Das',
      'students': 6,
      'status': 'Ongoing',
      'color': Colors.orange,
    },
    {
      'title': 'Water Purification System',
      'lead': 'Prof. S. Behera',
      'students': 3,
      'status': 'Prototype',
      'color': Colors.purple,
    },
  ];

  final List<Map<String, dynamic>> upcomingWorkshops = [
    {
      'title': 'Machine Learning Workshop',
      'date': 'Feb 15-16',
      'trainer': 'Industry Expert',
      'seats': 50,
      'color': Colors.blue,
    },
    {
      'title': 'Web Development Bootcamp',
      'date': 'Feb 20-22',
      'trainer': 'Senior Developer',
      'seats': 40,
      'color': Colors.green,
    },
    {
      'title': 'Digital Marketing Masterclass',
      'date': 'Feb 25',
      'trainer': 'Marketing Guru',
      'seats': 30,
      'color': Colors.orange,
    },
    {
      'title': 'Cloud Computing Workshop',
      'date': 'Mar 1-2',
      'trainer': 'AWS Certified',
      'seats': 45,
      'color': Colors.purple,
    },
  ];

  final List<Map<String, dynamic>> scholarships = [
    {
      'name': 'Merit Scholarship',
      'amount': '50% Tuition',
      'eligibility': '90%+ in 12th',
      'deadline': 'Mar 31',
      'color': Colors.blue,
    },
    {
      'name': 'Sports Quota',
      'amount': '25% Tuition',
      'eligibility': 'State Level',
      'deadline': 'Apr 15',
      'color': Colors.green,
    },
    {
      'name': 'Need-based Aid',
      'amount': 'Variable',
      'eligibility': 'Family Income < 5L',
      'deadline': 'Apr 30',
      'color': Colors.orange,
    },
    {
      'name': 'Research Fellowship',
      'amount': '₹15,000/month',
      'eligibility': 'PG Students',
      'deadline': 'May 15',
      'color': Colors.purple,
    },
  ];

  int _selectedBottomNavIndex = 0;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showFab = true;
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    floatingController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    shimmerController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: false);

    parallaxController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat(reverse: true);

    fadeAnimation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    scaleAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.elasticOut,
    );

    rotationAnimation = Tween<double>(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(parent: floatingController, curve: Curves.easeInOut),
    );

    pulseAnimation = Tween<double>(begin: 1, end: 1.1).animate(
      CurvedAnimation(parent: pulseController, curve: Curves.easeInOut),
    );

    shimmerAnimation = Tween<double>(
      begin: -1,
      end: 2,
    ).animate(CurvedAnimation(parent: shimmerController, curve: Curves.linear));

    parallaxAnimation =
        Tween<Offset>(
          begin: const Offset(0, -0.1),
          end: const Offset(0, 0.1),
        ).animate(
          CurvedAnimation(parent: parallaxController, curve: Curves.linear),
        );

    _scrollController.addListener(_onScroll);
    controller.forward();
  }

  void _onScroll() {
    if (_scrollController.offset > 100 && _showFab) {
      setState(() => _showFab = false);
    } else if (_scrollController.offset <= 100 && !_showFab) {
      setState(() => _showFab = true);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    floatingController.dispose();
    pulseController.dispose();
    shimmerController.dispose();
    parallaxController.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: fadeAnimation,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            _buildSliverAppBar(),
            SliverToBoxAdapter(child: _buildWelcomeBanner()),
            SliverToBoxAdapter(child: _buildQuickStats()),
            SliverToBoxAdapter(child: _buildSearchBar()),
            SliverToBoxAdapter(child: _buildFilterChips()),
            SliverToBoxAdapter(child: _buildRankingSection()),
            SliverToBoxAdapter(child: _buildNoticeBoard()),
            SliverToBoxAdapter(child: _buildEventsCarousel()),
            SliverToBoxAdapter(child: _buildAchievementsSection()),
            SliverToBoxAdapter(child: _buildAboutSection()),
            SliverToBoxAdapter(child: _buildAcademicsSection()),
            SliverToBoxAdapter(child: _buildFacultySection()),
            SliverToBoxAdapter(child: _buildResearchProjects()),
            SliverToBoxAdapter(child: _buildClubsSection()),
            SliverToBoxAdapter(child: _buildUpcomingWorkshops()),
            SliverToBoxAdapter(child: _buildScholarshipSection()),
            SliverToBoxAdapter(child: _buildFocusSection()),
            SliverToBoxAdapter(child: _buildPlacementSection()),
            SliverToBoxAdapter(child: _buildPlacementStats()),
            SliverToBoxAdapter(child: _buildTestimonials()),
            SliverToBoxAdapter(child: _buildLifeSkillsSection()),
            SliverToBoxAdapter(child: _buildEntrepreneurshipSection()),
            SliverToBoxAdapter(child: _buildGallerySection()),
            SliverToBoxAdapter(child: _buildSocialSection()),
            SliverToBoxAdapter(child: _buildNewsletterSection()),
            SliverToBoxAdapter(child: _buildFAQSection()),
            SliverToBoxAdapter(child: _buildContactSection()),
            SliverToBoxAdapter(child: _buildFooter()),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
      floatingActionButton: _showFab
          ? AnimatedBuilder(
              animation: floatingController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: rotationAnimation.value,
                  child: ScaleTransition(
                    scale: pulseAnimation,
                    child: FloatingActionButton.extended(
                      onPressed: _showQuickActions,
                      label: const Text('Quick Actions'),
                      icon: const Icon(Icons.menu),
                      backgroundColor: Colors.green.shade700,
                    ),
                  ),
                );
              },
            )
          : null,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildFilterChips() {
    final filters = ['All', 'Events', 'Notices', 'Placements', 'Academics'];
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(filter),
              selected: _selectedFilter == filter,
              onSelected: (selected) {
                setState(() => _selectedFilter = filter);
                _showSnackBar('Filtered by: $filter');
              },
              backgroundColor: Colors.grey.shade100,
              selectedColor: Colors.green.shade100,
              checkmarkColor: Colors.green.shade700,
              labelStyle: TextStyle(
                color: _selectedFilter == filter
                    ? Colors.green.shade700
                    : Colors.grey.shade700,
                fontWeight: _selectedFilter == filter
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
              avatar: _selectedFilter == filter
                  ? const Icon(Icons.check, size: 16)
                  : null,
            ),
          );
        },
      ),
    );
  }

  Widget _buildAchievementsSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 15),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.emoji_events,
                    color: Colors.amber,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  "🏆 Our Achievements",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: achievements.length,
            itemBuilder: (context, index) {
              return _buildAchievementCard(achievements[index], index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementCard(Map<String, dynamic> achievement, int index) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 500 + (index * 100).toInt()),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  achievement['color'].withOpacity(0.1),
                  achievement['color'].withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: achievement['color'].withOpacity(0.3)),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -10,
                  bottom: -10,
                  child: Icon(
                    achievement['icon'],
                    size: 60,
                    color: achievement['color'].withOpacity(0.1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        achievement['icon'],
                        color: achievement['color'],
                        size: 24,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        achievement['title'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        achievement['award'],
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: achievement['color'].withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          achievement['year'],
                          style: TextStyle(
                            fontSize: 10,
                            color: achievement['color'],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFacultySection() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 15),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.people,
                    color: Colors.indigo,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  "👨‍🏫 Our Faculty",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: facultyMembers.length,
              itemBuilder: (context, index) {
                return _buildFacultyCard(facultyMembers[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFacultyCard(Map<String, dynamic> faculty) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 15),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
          onTap: () => _showFacultyDetails(faculty),
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  faculty['color'].withOpacity(0.1),
                  faculty['color'].withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: faculty['color'].withOpacity(0.2),
                      child: Text(
                        faculty['name'].split(' ').last[0],
                        style: TextStyle(
                          color: faculty['color'],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        faculty['name'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  faculty['department'],
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
                const SizedBox(height: 5),
                Text(
                  faculty['specialization'],
                  style: TextStyle(
                    fontSize: 11,
                    color: faculty['color'],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.timeline, size: 12, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text(
                      faculty['experience'],
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFacultyDetails(Map<String, dynamic> faculty) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: faculty['color'].withOpacity(0.2),
                  child: Text(
                    faculty['name'].split(' ').last[0],
                    style: TextStyle(
                      fontSize: 30,
                      color: faculty['color'],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  faculty['name'],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: faculty['color'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    faculty['department'],
                    style: TextStyle(color: faculty['color']),
                  ),
                ),
                const SizedBox(height: 15),
                _buildDetailRow('Specialization', faculty['specialization']),
                _buildDetailRow('Experience', faculty['experience']),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      label: const Text('Close'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        foregroundColor: Colors.black,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _showSnackBar('Contacting faculty');
                      },
                      icon: const Icon(Icons.email),
                      label: const Text('Contact'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildResearchProjects() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 15),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.cyan.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.science,
                    color: Colors.cyan,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  "🔬 Research Projects",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ...researchProjects
              .map((project) => _buildResearchCard(project))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildResearchCard(Map<String, dynamic> project) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: project['color'].withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: project['color'].withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.biotech, color: project['color']),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project['title'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Lead: ${project['lead']} • ${project['students']} Students',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(
                              project['status'],
                            ).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            project['status'],
                            style: TextStyle(
                              fontSize: 10,
                              color: _getStatusColor(project['status']),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, size: 16),
                    onPressed: () => _showSnackBar('Viewing project details'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Ongoing':
        return Colors.green;
      case 'Completed':
        return Colors.blue;
      case 'Prototype':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Widget _buildClubsSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink.shade50, Colors.purple.shade50],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.pink.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.groups, color: Colors.pink, size: 24),
              ),
              const SizedBox(width: 10),
              const Text(
                "Clubs & Societies",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 15),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: clubsAndSocieties.length,
            itemBuilder: (context, index) {
              return _buildClubCard(clubsAndSocieties[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildClubCard(Map<String, dynamic> club) {
    return GestureDetector(
      onTap: () => _showSnackBar('Viewing ${club['name']}'),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: club['color'].withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(club['icon'], color: club['color'], size: 30),
            const SizedBox(height: 8),
            Text(
              club['name'],
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              '${club['members']} members',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: club['color'].withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                club['activities'].split(',')[0],
                style: TextStyle(fontSize: 9, color: club['color']),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingWorkshops() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 15),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.event_available,
                    color: Colors.deepPurple,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  "📚 Upcoming Workshops",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: upcomingWorkshops.length,
              itemBuilder: (context, index) {
                return _buildWorkshopCard(upcomingWorkshops[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkshopCard(Map<String, dynamic> workshop) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 15),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                workshop['color'].withOpacity(0.1),
                workshop['color'].withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: workshop['color'].withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.workspace_premium,
                      color: workshop['color'],
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      workshop['title'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildWorkshopDetail(Icons.calendar_today, workshop['date']),
              const SizedBox(height: 6),
              _buildWorkshopDetail(Icons.person, workshop['trainer']),
              const SizedBox(height: 6),
              _buildWorkshopDetail(
                Icons.people,
                '${workshop['seats']} seats left',
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => _showSnackBar('Registering for workshop'),
                    style: TextButton.styleFrom(
                      backgroundColor: workshop['color'],
                      foregroundColor: Colors.white,
                      minimumSize: const Size(80, 30),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 0,
                      ),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWorkshopDetail(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 12, color: Colors.grey.shade600),
        const SizedBox(width: 6),
        Text(text, style: TextStyle(fontSize: 11, color: Colors.grey.shade700)),
      ],
    );
  }

  Widget _buildScholarshipSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber.shade50, Colors.orange.shade50],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.school, color: Colors.amber, size: 24),
              ),
              const SizedBox(width: 10),
              const Text(
                "🎓 Scholarships Available",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ...scholarships
              .map((scholarship) => _buildScholarshipCard(scholarship))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildScholarshipCard(Map<String, dynamic> scholarship) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: scholarship['color'].withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.card_giftcard,
              color: scholarship['color'],
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scholarship['name'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Amount: ${scholarship['amount']}',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
                ),
                Text(
                  'Eligibility: ${scholarship['eligibility']}',
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Deadline: ${scholarship['deadline']}',
                    style: TextStyle(fontSize: 9, color: Colors.red.shade700),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => _showSnackBar('Viewing scholarship details'),
          ),
        ],
      ),
    );
  }

  Widget _buildPlacementStats() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1a237e), Color(0xFF283593)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            'Placement Statistics 2023',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                '92%',
                'Placement Rate',
                Icons.percent,
                Colors.greenAccent,
              ),
              _buildStatItem(
                '₹12.5L',
                'Highest Package',
                Icons.money,
                Colors.amber,
              ),
              _buildStatItem(
                '₹6.2L',
                'Average Package',
                Icons.trending_up,
                Colors.blueAccent,
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                '150+',
                'Recruiters',
                Icons.business,
                Colors.orangeAccent,
              ),
              _buildStatItem('450+', 'Offers', Icons.work, Colors.purpleAccent),
              _buildStatItem(
                '35+',
                'Dream Offers',
                Icons.star,
                Colors.pinkAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 11),
        ),
      ],
    );
  }

  Widget _buildNewsletterSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade50, Colors.cyan.shade50],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Icon(Icons.email, size: 40, color: Colors.teal),
          const SizedBox(height: 10),
          const Text(
            'Subscribe to Newsletter',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            'Get latest updates about events and announcements',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => _showSnackBar('Subscribed to newsletter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                ),
                child: const Text('Subscribe'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFAQSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 15),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.help, color: Colors.indigo, size: 24),
                ),
                const SizedBox(width: 10),
                const Text(
                  "❓ Frequently Asked Questions",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          _buildFAQItem(
            'How can I apply for admission?',
            'Visit our admissions portal at admissions.aryan.edu.in or contact our admission office.',
          ),
          _buildFAQItem(
            'What are the eligibility criteria?',
            'Minimum 60% in 10+2 with Physics, Chemistry, Mathematics for B.Tech programs.',
          ),
          _buildFAQItem(
            'Is hostel facility available?',
            'Yes, separate hostels for boys and girls with all modern amenities.',
          ),
          _buildFAQItem(
            'What is the placement record?',
            '92% placement record with top companies visiting campus every year.',
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              answer,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.grey.shade900,
      child: Column(
        children: [
          const Text(
            'Aryan Institute of Engineering & Technology',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Established 2009 | AICTE Approved | Affiliated to BPUT',
            style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFooterIcon(Icons.facebook, Colors.blue),
              const SizedBox(width: 15),
              _buildFooterIcon(Icons.message, Colors.green),
              const SizedBox(width: 15),
              _buildFooterIcon(Icons.email, Colors.red),
              const SizedBox(width: 15),
              _buildFooterIcon(Icons.link, Colors.purple),
            ],
          ),
          const SizedBox(height: 15),
          const Divider(color: Colors.white24),
          const SizedBox(height: 10),
          Text(
            '© 2024 Aryan Institute. All rights reserved.',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterIcon(IconData icon, Color color) {
    return GestureDetector(
      onTap: () => _showSnackBar('Opening social media'),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 18),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedBottomNavIndex,
        onTap: (index) {
          setState(() {
            _selectedBottomNavIndex = index;
          });
          _showSnackBar('Navigated to ${_getNavTitle(index)}');
        },
        selectedItemColor: Colors.green.shade700,
        unselectedItemColor: Colors.grey.shade600,
        items: [
          _buildNavItem(Icons.home, 'Home', 0),
          _buildNavItem(Icons.calendar_today, 'Events', 1),
          _buildNavItem(Icons.notifications, 'Notices', 2),
          _buildNavItem(Icons.person, 'Profile', 3),
          _buildNavItem(Icons.more_horiz, 'More', 4),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    IconData icon,
    String label,
    int index,
  ) {
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(_selectedBottomNavIndex == index ? 8 : 0),
        decoration: BoxDecoration(
          color: _selectedBottomNavIndex == index
              ? Colors.green.shade50
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(icon),
      ),
      label: label,
    );
  }

  String _getNavTitle(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Events';
      case 2:
        return 'Notices';
      case 3:
        return 'Profile';
      case 4:
        return 'More';
      default:
        return '';
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 800),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        action: SnackBarAction(label: 'OK', onPressed: () {}),
      ),
    );
  }

  void _showQuickActions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Quick Actions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  _buildQuickActionItem(
                    Icons.school,
                    'Admissions',
                    Colors.blue,
                  ),
                  _buildQuickActionItem(Icons.book, 'Academics', Colors.green),
                  _buildQuickActionItem(
                    Icons.work,
                    'Placements',
                    Colors.orange,
                  ),
                  _buildQuickActionItem(Icons.event, 'Events', Colors.purple),
                  _buildQuickActionItem(
                    Icons.contact_mail,
                    'Contact',
                    Colors.red,
                  ),
                  _buildQuickActionItem(Icons.map, 'Campus Map', Colors.teal),
                  _buildQuickActionItem(
                    Icons.library_books,
                    'Library',
                    Colors.brown,
                  ),
                  _buildQuickActionItem(
                    Icons.fitness_center,
                    'Sports',
                    Colors.pink,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuickActionItem(IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        _showSnackBar('Opening $label');
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildWelcomeBanner() {
    return SlideTransition(
      position: slideAnimation,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade400, Colors.green.shade600],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Aryan Institute of Engineering & Technology',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Est. 2009',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedBuilder(
              animation: pulseController,
              builder: (context, child) {
                return Transform.scale(
                  scale: pulseAnimation.value,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.school,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: _isSearching ? 60 : 50,
        child: TextField(
          controller: _searchController,
          onTap: () {
            setState(() {
              _isSearching = true;
            });
          },
          onSubmitted: (value) {
            setState(() {
              _isSearching = false;
            });
            if (value.isNotEmpty) {
              _showSnackBar('Searching for: $value');
            }
          },
          decoration: InputDecoration(
            hintText: 'Search courses, events, notices...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _isSearching
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _isSearching = false;
                      });
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _buildAnimatedStatCard(
              '16+',
              'Years',
              Icons.timeline,
              Colors.blue,
            ),
          ),
          Expanded(
            child: _buildAnimatedStatCard(
              '92%',
              'Placement',
              Icons.work,
              Colors.green,
            ),
          ),
          Expanded(
            child: _buildAnimatedStatCard(
              '5000+',
              'Students',
              Icons.people,
              Colors.orange,
            ),
          ),
          Expanded(
            child: _buildAnimatedStatCard(
              '150+',
              'Faculty',
              Icons.person,
              Colors.purple,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedStatCard(
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(seconds: 1),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(height: 3),
                Text(
                  value.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(fontSize: 9, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEventsCarousel() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.event,
                        color: Colors.blue,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      '📅 Upcoming Events',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                TextButton.icon(
                  onPressed: () => _showSnackBar('Viewing all events'),
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text("View All"),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: events.length,
              itemBuilder: (context, index) {
                return _buildEventCard(events[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> event, int index) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 500 + (index * 100).toInt()),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(50 * (1 - value), 0),
          child: Opacity(
            opacity: value,
            child: Container(
              width: 280,
              margin: const EdgeInsets.only(right: 15),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  onTap: () => _showEventDetails(event),
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          event['color'].withOpacity(0.1),
                          event['color'].withOpacity(0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: event['color'].withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.event,
                                color: event['color'],
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                event['title'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildEventDetailRow(
                          Icons.calendar_today,
                          event['date'],
                        ),
                        const SizedBox(height: 6),
                        _buildEventDetailRow(Icons.access_time, event['time']),
                        const SizedBox(height: 6),
                        _buildEventDetailRow(Icons.location_on, event['venue']),
                        const SizedBox(height: 6),
                        _buildEventDetailRow(
                          Icons.people,
                          '${event['attendees']} Attendees',
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: event['color'].withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            event['organizer'],
                            style: TextStyle(
                              fontSize: 10,
                              color: event['color'],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEventDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey.shade600),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ),
      ],
    );
  }

  void _showEventDetails(Map<String, dynamic> event) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: event['color'].withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.event, color: event['color'], size: 40),
                ),
                const SizedBox(height: 15),
                Text(
                  event['title'],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                _buildDetailRow('Date', event['date']),
                _buildDetailRow('Time', event['time']),
                _buildDetailRow('Venue', event['venue']),
                _buildDetailRow('Organizer', event['organizer']),
                _buildDetailRow('Expected Attendees', '${event['attendees']}'),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    event['description'],
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      label: const Text('Close'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        foregroundColor: Colors.black,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _showSnackBar('Added to calendar');
                      },
                      icon: const Icon(Icons.calendar_today),
                      label: const Text('Remind Me'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(color: Colors.grey.shade700)),
        ],
      ),
    );
  }

  Widget _buildTestimonials() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      '⭐ Student Testimonials',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                TextButton.icon(
                  onPressed: () => _showSnackBar('Viewing all testimonials'),
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text("View All"),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: testimonials.length,
              itemBuilder: (context, index) {
                return _buildTestimonialCard(testimonials[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(Map<String, dynamic> testimonial) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 15),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(testimonial['image']),
                    onBackgroundImageError: (_, __) {},
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          testimonial['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Batch of ${testimonial['batch']}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: List.generate(
                  testimonial['rating'],
                  (index) =>
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '"${testimonial['message']}"',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  fontStyle: FontStyle.italic,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      testimonial['company'],
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    testimonial['position'],
                    style: TextStyle(fontSize: 9, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRankingSection() {
    return SlideTransition(
      position: slideAnimation,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amber.shade50, Colors.orange.shade50],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.emoji_events,
                    color: Colors.orange,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Ranking & Recognitions",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: _buildAnimatedRankingCard(
                    "2nd",
                    "Best BTech College in Odisha",
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildAnimatedRankingCard(
                    "39th",
                    "Top Private Engineering College in India",
                    Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedRankingCard(String rank, String title, Color color) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 800),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Text(
                  rank,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNoticeBoard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.campaign,
                      color: Colors.red.shade700,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Latest Notice Board",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: () => _showSnackBar('Viewing all notices'),
                icon: const Icon(Icons.arrow_forward),
                label: const Text("More"),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ...noticeBoard.asMap().entries.map(
            (entry) => _buildAnimatedNoticeItem(entry.value, entry.key),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedNoticeItem(Map<String, dynamic> notice, int index) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 500 + (index * 100)),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(50 * (1 - value), 0),
          child: Opacity(opacity: value, child: _buildNoticeItem(notice)),
        );
      },
    );
  }

  Widget _buildNoticeItem(Map<String, dynamic> notice) {
    return GestureDetector(
      onTap: () => _showNoticeDetails(notice),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: notice['color'].withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(notice['icon'], size: 20, color: notice['color']),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        notice['date'],
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getPriorityColor(
                            notice['priority'],
                          ).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          notice['priority'],
                          style: TextStyle(
                            fontSize: 9,
                            color: _getPriorityColor(notice['priority']),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notice['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.blue;
      case 'Medium':
        return Colors.orange;
      case 'Urgent':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showNoticeDetails(Map<String, dynamic> notice) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(notice['icon'], color: notice['color']),
              const SizedBox(width: 10),
              Expanded(child: const Text('Notice Details')),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Date: ${notice['date']}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(notice['title']),
              const SizedBox(height: 10),
              Text(notice['description'] ?? 'No description available'),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getPriorityColor(notice['priority']).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Priority: ${notice['priority']}',
                  style: TextStyle(
                    color: _getPriorityColor(notice['priority']),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showSnackBar('Marked as read');
              },
              child: const Text('Mark as Read'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAboutSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade50, Colors.blue.shade50],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.school, color: Colors.green, size: 24),
              ),
              const SizedBox(width: 10),
              const Text(
                "About Aryan",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "Aryan Institute of Engineering and Technology (AIET), the top engineering college in Odisha and one of the best Btech college in Bhubaneswar. Established in the year 2009, approved by AICTE, New Delhi and affiliated to BPUT, RKN, Odisha.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () => _showSnackBar('Reading more about Aryan'),
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Read More'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAcademicsSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.menu_book,
                  color: Colors.purple,
                  size: 24,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "Academics Courses",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: academicCourses
                .map(
                  (course) => GestureDetector(
                    onTap: () => _showSnackBar('Viewing $course details'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Text(
                        course,
                        style: TextStyle(
                          color: Colors.green.shade800,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFocusSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 15),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.track_changes,
                    color: Colors.orange,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Our Focus",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.1,
            children: [
              _buildFocusCard(
                "Best Engineering College",
                "Top 10 in Odisha",
                Icons.school,
                Colors.blue,
              ),
              _buildFocusCard(
                "Highly Qualified Faculty",
                "Expert Trainers",
                Icons.person,
                Colors.green,
              ),
              _buildFocusCard(
                "Green Campus",
                "Eco-friendly",
                Icons.nature,
                Colors.green,
              ),
              _buildFocusCard(
                "Modern Infrastructure",
                "World-class",
                Icons.business,
                Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFocusCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return GestureDetector(
      onTap: () => _showSnackBar('Viewing $title'),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlacementSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade50, Colors.pink.shade50],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.work, color: Colors.purple, size: 24),
              ),
              const SizedBox(width: 10),
              const Text(
                "Placement",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "AIET has an excellent placement track record with MNCs like Infosys, Amazon, IBM, HCL, Google Maps, HSBC Bank, ICICI Bank.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: placementCompanies.length,
              itemBuilder: (context, index) {
                return _buildCompanyChip(placementCompanies[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyChip(Map<String, dynamic> company) {
    return GestureDetector(
      onTap: () =>
          _showSnackBar('Viewing ${company['name']} placement details'),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: company['color'].withOpacity(0.1),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: company['color'].withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(company['logo'], size: 16, color: company['color']),
            const SizedBox(width: 8),
            Text(
              company['name'],
              style: TextStyle(
                color: company['color'],
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLifeSkillsSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.psychology,
                  color: Colors.teal,
                  size: 24,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "Life Skills & SDL",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "Imparting skills through Experiential Learning & Activity Based Learning methodologies to help students deal with day-to-day challenges.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: _buildSkillButton(
                  "Life Skills",
                  Icons.psychology,
                  Colors.teal,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildSkillButton(
                  "SDL",
                  Icons.auto_stories,
                  Colors.indigo,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillButton(String label, IconData icon, Color color) {
    return ElevatedButton.icon(
      onPressed: () => _showSnackBar('Viewing $label'),
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.1),
        foregroundColor: color,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildEntrepreneurshipSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade50, Colors.amber.shade50],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lightbulb,
                  color: Colors.orange,
                  size: 24,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "Entrepreneurship Development Cell",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "Established in 2011 with vision 'Turn around Job seekers into Job Creators'. AICTE Sponsored IIPC and ED Cells with 1450 Sft space.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () => _showSnackBar('Viewing EDC details'),
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Learn More'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGallerySection() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.pink.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.photo_library,
                        color: Colors.pink,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Our Gallery",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                TextButton.icon(
                  onPressed: () => _showSnackBar('Viewing all photos'),
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text("View All"),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: (context, index) {
                return _buildGalleryItem(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryItem(int index) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
    ];
    return GestureDetector(
      onTap: () => _showGalleryFullScreen(index),
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: Duration(milliseconds: 500 + (index * 50)),
        builder: (context, double value, child) {
          return Transform.scale(
            scale: value,
            child: Container(
              width: 200,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colors[index % colors.length].shade300,
                    colors[index % colors.length].shade600,
                  ],
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: colors[index % colors.length].withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      'https://picsum.photos/200/150?image=${index + 10}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: colors[index % colors.length].shade100,
                          child: Center(
                            child: Icon(
                              Icons.image,
                              size: 50,
                              color: colors[index % colors.length].shade700,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black54, Colors.transparent],
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Text(
                        'Campus View ${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showGalleryFullScreen(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(20),
          child: Container(
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(
                  'https://picsum.photos/400/300?image=${index + 10}',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Aryan Institute Campus',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSocialSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          AnimatedBuilder(
            animation: pulseController,
            builder: (context, child) {
              return Transform.scale(
                scale: pulseAnimation.value,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.facebook,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Aryan Institute of Engineering...",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "22,612 followers",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => _showSnackBar('Following page'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text("Follow"),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.shade700,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.contact_phone,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "Contact Information",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          _buildContactItem(Icons.phone, "+91-9437481251 / 9437481252"),
          _buildContactItem(Icons.phone, "+91-9437475534 (Outside Odisha)"),
          _buildContactItem(Icons.phone, "+91-9437156212"),
          _buildContactItem(Icons.email, "admission@aryan.ac.in"),
          const Divider(color: Colors.white24, height: 30),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.shade700,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "Campus",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "Aryan Institute Of Engineering & Technology, Arya Vihar, Bhubaneswar-752050",
            style: TextStyle(color: Colors.grey.shade400, height: 1.5),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.shade700,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.link, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 10),
              const Text(
                "Important Links",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children:
                [
                      'Blogs',
                      'Grievance Cell',
                      'Notice Board',
                      'Student\'s Feedback',
                      'Parent\'s Feedback',
                      'Faculty Self Appraisal',
                      'E-Magazine',
                      'Email Login',
                    ]
                    .map(
                      (link) => GestureDetector(
                        onTap: () => _showSnackBar('Opening $link'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            link,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSocialIcon(Icons.facebook, Colors.blue),
              _buildSocialIcon(Icons.message, Colors.green),
              _buildSocialIcon(Icons.email, Colors.red),
              _buildSocialIcon(Icons.link, Colors.purple),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color) {
    return GestureDetector(
      onTap: () => _showSnackBar('Opening social media'),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.green.shade300, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: () => _showSnackBar('Copying contact info'),
              child: Text(text, style: const TextStyle(color: Colors.white70)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      backgroundColor: Colors.green.shade800,
      flexibleSpace: FlexibleSpaceBar(
        title: AnimatedBuilder(
          animation: shimmerController,
          builder: (context, child) {
            return ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  begin: Alignment(shimmerAnimation.value, 0),
                  end: Alignment(shimmerAnimation.value + 0.5, 0),
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(0.5),
                    Colors.white,
                  ],
                ).createShader(bounds);
              },
              child: const Text("ARYAN Institute"),
            );
          },
        ),
        background: AnimatedBuilder(
          animation: parallaxController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, parallaxAnimation.value.dy * 50),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.green.shade600,
                      Colors.green.shade800,
                      Colors.green.shade900,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: const Duration(seconds: 1),
                        builder: (context, double value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.school,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "ARYAN Institute of Engineering & Technology",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
