import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ajay Kumar | Flutter Developer & UI/UX Designer',
      theme: ThemeData.dark(),
      home: const PortfolioWebsite(),
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
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            NavBar(onSectionSelect: scrollToSection),
            HomeSection(),
            AboutSection(),
            SkillsSection(),
            ProjectsSection(),
            ContactSection(),
          ],
        ),
      ),
    );
  }
}

// Navbar Widget
class NavBar extends StatelessWidget {
  final Function(double) onSectionSelect;
  const NavBar({required this.onSectionSelect, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      color: Colors.black87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Ajay Kumar',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              _navButton('Home', 0),
              _navButton('About', 600),
              _navButton('Skills', 1200),
              _navButton('Projects', 1800),
              _navButton('Contact', 2400),
            ],
          )
        ],
      ),
    );
  }

  Widget _navButton(String title, double offset) {
    return TextButton(
      onPressed: () => onSectionSelect(offset),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}


class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  _HomeSectionState createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    // Animation Controller for Background Effect
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
    
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Animation
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Container(
              height: 700,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blueAccent.withOpacity(0.2 + _animationController.value * 0.3),
                    Colors.purpleAccent.withOpacity(0.3 + _animationController.value * 0.2),
                  ],
                ),
                image: const DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.cover,
                  opacity: 0.2,
                ),
              ),
            );
          },
        ),

        // Content with Glassmorphism Effect
        Center(
          child: Container(
            height: 600,
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile Image with Fade In Effect
                FadeTransition(
                  opacity: _fadeInAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage('assets/images/profile_image.jpg'),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 50),

                // Intro Section
                SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hello, I'm",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          color: Colors.white60,
                        ),
                      ),
                      Text(
                        "Ajay Kumar",
                        style: GoogleFonts.poppins(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Flutter Developer & UI/UX Designer",
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Social Media Icons with Hover Effect
                      Row(
                        children: [
                          _buildSocialIcon(FontAwesomeIcons.linkedin, 'https://linkedin.com/in/ajay-kumar-02b9b525b'),
                          _buildSocialIcon(FontAwesomeIcons.github, 'https://github.com/ajayrana78767'),
                          _buildSocialIcon(FontAwesomeIcons.twitter, 'https://x.com/AjayRana78767'),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Action Buttons with Hover Effect
                      Row(
                        children: [
                          _buildHoverButton(
                            text: "Hire Me",
                            color: Colors.blueAccent,
                            onPressed: () async {
                              final Uri whatsappUri = Uri.parse(
                                'https://wa.me/917876740036?text=Hello%20Ajay,%20I%20am%20interested%20in%20hiring%20you.',
                              );
                              if (!await launchUrl(whatsappUri, mode: LaunchMode.externalApplication)) {
                                throw 'Could not launch $whatsappUri';
                              }
                            },
                          ),
                          const SizedBox(width: 20),
                          _buildHoverButton(
                            text: "Download Resume",
                            color: Colors.transparent,
                            borderColor: Colors.blueAccent,
                            textColor: Colors.white,
                            onPressed: () async {
                              final url = Uri.parse(
                                  'https://drive.google.com/uc?export=download&id=1DQbRzcs9uNJJ5wTJK4dIt38uVxpayDdL');
                              if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                                throw 'Could not launch $url';
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Function to build social media icons
  Widget _buildSocialIcon(IconData icon, String url) {
    return IconButton(
      icon: FaIcon(icon, color: Colors.white),
      onPressed: () async {
        if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
          throw 'Could not launch $url';
        }
      },
      hoverColor: Colors.blueAccent.withOpacity(0.2),
    );
  }

  // Function to build modern hover buttons
  Widget _buildHoverButton({
    required String text,
    required Color color,
    Color borderColor = Colors.transparent,
    Color textColor = Colors.white,
    required VoidCallback onPressed,
  }) {
    return MouseRegion(
      onEnter: (event) => setState(() {}),
      onExit: (event) => setState(() {}),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          side: BorderSide(color: borderColor),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 18, color: textColor),
        ),
      ),
    );
  }
}

// class HomeSection extends StatelessWidget {
//   const HomeSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 700,
//       padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
//       color: Colors.black,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Profile Image
//           CircleAvatar(
//             radius: 100,
//             backgroundImage: AssetImage('assets/images/profile_image.jpg'),
//           ),
//           const SizedBox(width: 50),

//           // Intro Section
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Hello, I'm",
//                 style: GoogleFonts.poppins(
//                   fontSize: 24,
//                   color: Colors.white60,
//                 ),
//               ),
//               Text(
//                 "Ajay Kumar",
//                 style: GoogleFonts.poppins(
//                   fontSize: 48,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               Text(
//                 "Flutter Developer & UI/UX Designer",
//                 style: GoogleFonts.poppins(
//                   fontSize: 22,
//                   color: Colors.blueAccent,
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Social Media Icons
//               Row(
//                 children: [
//                   IconButton(
//                     icon: const FaIcon(FontAwesomeIcons.linkedin),
//                     color: Colors.white,
//                     onPressed: () async {
//                       await launchUrl(Uri.parse(
//                           'www.linkedin.com/in/ajay-kumar-02b9b525b'));
//                     },
//                   ),
//                   IconButton(
//                     icon: const FaIcon(FontAwesomeIcons.github),
//                     color: Colors.white,
//                     onPressed: () async {
//                       await launchUrl(
//                           Uri.parse('https://github.com/ajayrana78767'));
//                     },
//                   ),
//                   IconButton(
//                     icon: const FaIcon(FontAwesomeIcons.twitter),
//                     color: Colors.white,
//                     onPressed: () async {
//                       await launchUrl(Uri.parse('https://x.com/AjayRana78767'));
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),

//               // Action Buttons
//               Row(
//                 children: [
//                   ElevatedButton(
//                     onPressed: () async {
//                       final Uri whatsappUri = Uri.parse(
//                           'https://wa.me/917876740036?text=Hello%20Ajay,%20I%20am%20interested%20in%20hiring%20you.');

//                       if (!await launchUrl(whatsappUri,
//                           mode: LaunchMode.externalApplication)) {
//                         throw 'Could not launch $whatsappUri';
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blueAccent,
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 30, vertical: 15),
//                     ),
//                     child: const Text(
//                       "Hire Me",
//                       style: TextStyle(fontSize: 18),
//                     ),
//                   ),
//                   const SizedBox(width: 20),
//                   OutlinedButton(
//                     onPressed: () async {
//                       final url = Uri.parse(
//                           'https://drive.google.com/uc?export=download&id=1DQbRzcs9uNJJ5wTJK4dIt38uVxpayDdL');

//                       if (!await launchUrl(url,
//                           mode: LaunchMode.externalApplication)) {
//                         throw 'Could not launch $url';
//                       }
//                     },
//                     style: OutlinedButton.styleFrom(
//                       side: const BorderSide(color: Colors.blueAccent),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 30, vertical: 15),
//                     ),
//                     child: const Text(
//                       "Download Resume",
//                       style: TextStyle(fontSize: 18, color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      color: Colors.teal,
      child: Center(
        child: Text(
          'About Me',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
      color: Colors.purple,
      child: Center(
        child: Text(
          'My Skills',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
      color: Colors.orange,
      child: Center(
        child: Text(
          'Projects Showcase',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
      color: Colors.red,
      child: Center(
        child: Text(
          'Contact Me',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
