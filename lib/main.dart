import 'package:flutter/material.dart';
import 'package:flutter_ui_ux_portfolio/Utils/app_routes.dart';
import 'package:flutter_ui_ux_portfolio/pages/home_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: AppRoutes.router.routerDelegate,
      routeInformationParser: AppRoutes.router.routeInformationParser,
      routeInformationProvider: AppRoutes.router.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      title: 'Ajay Kumar | Flutter Developer & UI/UX Designer',
      theme: ThemeData(
        textTheme: GoogleFonts.spaceGroteskTextTheme(),
      ),
      //   theme: ThemeData.light(),
      // home: HomePage(),
    );
  }
}

class PortfolioWebsite extends StatefulWidget {
  const PortfolioWebsite({super.key});

  @override
  State<PortfolioWebsite> createState() => _PortfolioWebsiteState();
}

class _PortfolioWebsiteState extends State<PortfolioWebsite> {
  final ScrollController _scrollController = ScrollController();
  bool isNavExpanded = false; // Track navbar expansion

  void scrollToSection(double offset) {
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        // Use Row to align navbar and content properly
        children: [
          MouseRegion(
            onEnter: (_) => setState(() => isNavExpanded = true),
            onExit: (_) => setState(() => isNavExpanded = false),
            child: SizedBox(
              width: isNavExpanded ? 200 : 70, // Adjust width dynamically
              child: SideNavBar(onSectionSelect: scrollToSection),
            ),
          ),
          Expanded(
            // Ensures the main content takes remaining space
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    HomePage(),
                    SizedBox(height: 20),
                    AboutSection(),
                    SizedBox(
                      height: 20,
                    ),
                    SkillsSection(),
                    SizedBox(
                      height: 20,
                    ),
                    ProjectsSection(),
                    SizedBox(
                      height: 20,
                    ),
                    ContactSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Navbar Widget

class SideNavBar extends StatefulWidget {
  final Function(double) onSectionSelect;
  const SideNavBar({required this.onSectionSelect, super.key});

  @override
  _SideNavBarState createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
  bool isExpanded = false;
  int selectedIndex = 0;

  final List<Map<String, dynamic>> navItems = [
    {'icon': FontAwesomeIcons.house, 'label': 'Home', 'offset': 0},
    {'icon': FontAwesomeIcons.user, 'label': 'About', 'offset': 600},
    {'icon': FontAwesomeIcons.code, 'label': 'Skills', 'offset': 1200},
    {'icon': FontAwesomeIcons.briefcase, 'label': 'Projects', 'offset': 1800},
    {'icon': FontAwesomeIcons.envelope, 'label': 'Contact', 'offset': 2400},
  ];

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isExpanded = true),
      onExit: (_) => setState(() => isExpanded = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: isExpanded ? 200 : 70,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: isExpanded
                  ? Text(
                      'Ajay Kumar',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  : Icon(Icons.person, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 30),
            Column(
              children: List.generate(navItems.length, (index) {
                return _navButton(
                  navItems[index]['icon'],
                  navItems[index]['label'],
                  navItems[index]['offset'],
                  index,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navButton(IconData icon, String label, double offset, int index) {
    return GestureDetector(
      onTap: () {
        widget.onSectionSelect(offset);
        setState(() => selectedIndex = index);
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => selectedIndex = index),
        onExit: (_) => setState(() => selectedIndex = -1),
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            width: isExpanded ? 180 : 50,
            decoration: BoxDecoration(
              color: selectedIndex == index
                  ? Colors.blueAccent.withOpacity(0.3)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Icon(icon, color: Colors.white, size: 24),
                  if (isExpanded)
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        label,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            )),
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade900, Colors.teal.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: GlassContainer(
          title: "About Me",
          description:
              "I'm a passionate Flutter Developer & UI/UX Designer with experience in building modern, high-performance mobile and web applications. Let's create something amazing together!",
          icon: Icons.person,
        ),
      ),
    );
  }
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade900, Colors.purple.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: GlassContainer(
          title: "My Skills",
          description:
              "⚡ Flutter & Dart  🚀 UI/UX Design 🎨 REST APIs 📡 Firebase 🔥 State Management (Provider, Riverpod)",
          icon: Icons.code,
        ),
      ),
    );
  }
}

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade900, Colors.orange.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: GlassContainer(
          title: "Projects Showcase",
          description:
              "Check out my latest projects, including mobile apps, websites, and innovative UI/UX designs. I love building high-quality, user-friendly applications!",
          icon: Icons.brush,
        ),
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade900, Colors.red.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: GlassContainer(
          title: "Contact Me",
          description:
              "📩 Email: ajayrana@synergysoftindia.com\n📱 LinkedIn: linkedin.com/in/ajaykumar\n🌍 Portfolio: www.ajaykumar.dev",
          icon: Icons.email,
        ),
      ),
    );
  }
}

class GlassContainer extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const GlassContainer({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(seconds: 2),
      opacity: 1.0,
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 50, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
