import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_ux_portfolio/Utils/colors_utils.dart';
import 'package:flutter_ui_ux_portfolio/Utils/spacing_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomeSectionState createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomePage> with TickerProviderStateMixin {
  // late AnimationController _animationController;
  // late Animation<double> _fadeInAnimation;
  // late Animation<Offset> _slideAnimation;
  int _hoverIndex = -1; // Track hovered index
  @override
  void initState() {
    super.initState();

    // // Animation Controller for Background Effect
    // _animationController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(seconds: 5),
    // )..repeat(reverse: true);

    // _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    //   CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    // );

    // _slideAnimation =
    //     Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
    //   CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    // );
  }

  // Sample Project List
  final List<Map<String, String>> projects = [
    {
      'title': 'MOHVAX',
      'description': 'A child vaccination mobile app.',
      'image': 'assets/images/project1.jpg'
    },
    {
      'title': 'Book Ladder',
      'description': 'A selling and donating books app.',
      'image': 'assets/images/project2.jpg'
    },
    {
      'title': 'Labour Assessment APP',
      'description': 'A reduce heavy work load app.',
      'image': 'assets/images/project3.jpg'
    },
    {
      'title': 'Pizza Deck',
      'description': 'App that offers a pizza as a product ',
      'image': 'assets/images/project4.jpg'
    },
  ];
  int _currentIndex = 0;

  // @override
  // void dispose() {
  //   _animationController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Text(
                    'Ajay Kumar',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                    ),
                  ),
                  SpacingUtils.wspace30,
                  Spacer(),
                  Text(
                    'Work',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SpacingUtils.wspace30,
                  Text(
                    'About',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SpacingUtils.wspace30,
                  Text(
                    'My CV',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SpacingUtils.wspace30,
                  Text(
                    'Contact',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 550,
                    width: double.infinity,
                    child: CarouselSlider.builder(
                      itemCount: projects.length,
                      itemBuilder: (context, index, realIndex) =>
                          _buildProjectCard(projects[index], index),
                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index; // Update the current index
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                      height: 16.0), // Space between carousel and dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      projects.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        height: _currentIndex == index ? 12.0 : 8.0,
                        width: _currentIndex == index ? 12.0 : 8.0,
                        decoration: BoxDecoration(
                          color: _currentIndex == index
                              ? Colors.teal
                              : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SpacingUtils.space40,
            Stack(
              children: [
                // Blurred Background Image
                Positioned.fill(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(
                        sigmaX: 5, sigmaY: 5), // Blur intensity
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/6.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),

                // Foreground Content
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 150.0,
                        ),
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: '"',
                                style: TextStyle(
                                  fontSize: 70,
                                  color: ColorsUtils
                                      .primaryColor, // Replace with ColorsUtils.primaryColor
                                ),
                              ),
                              TextSpan(
                                text:
                                    'I’m a Flutter Developer and UI/UX Designer at Synergy Soft India with 1+ years of experience. Skilled in Dart, Flutter, GetX, Provider, and REST APIs, I specialize in creating seamless mobile experiences. Proficient in Figma and Adobe Photoshop, I excel at prototyping, wireframing, and crafting user-centered designs.\n\nI transitioned from business administration to tech, combining design expertise with development skills. Passionate about continuous learning and delivering innovative solutions.',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  height: 1.5,
                                ),
                              ),
                              TextSpan(
                                text: '"',
                                style: TextStyle(
                                  fontSize: 70,
                                  color: ColorsUtils.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/images/my_image.png',
                      width: 730,
                      height: 730,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ],
            ),

            // Contact Us Section
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Row(
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contact Us',
                          style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.black,
                            decorationThickness: 1.0,
                          ),
                        ),
                        SpacingUtils.space20,
                        // Social Media Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _buildSocialIcon(FontAwesomeIcons.linkedin,
                                'https://linkedin.com/in/ajay-kumar-02b9b525b'),
                            _buildSocialIcon(FontAwesomeIcons.github,
                                'https://github.com/ajayrana78767'),
                            _buildSocialIcon(FontAwesomeIcons.twitter,
                                'https://x.com/AjayRana78767'),
                          ],
                        ),
                        SpacingUtils.space20,
                        // Back to Top Button
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                // Add Back to Top action here
                                // Use ScrollController to scroll to top
                              },
                              icon: Icon(FontAwesomeIcons.circleUp),
                            ),
                            Text('Back to Top'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Subscribe to Updates Section
                        Text('Subscribe to Updates',
                            style: TextStyle(fontSize: 16)),
                        SpacingUtils.space10, // Text('Email Address'),
                        // SizedBox(height: 5),
                        Container(
                          width: 490,
                          color: Colors.white,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter your email',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(.15),
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(.15),
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 10),
                        // _buildHoverButton(
                        //     color: Colors.white,
                        //     text: '',
                        //     onPressed: () {}),
                        SizedBox(
                          width: 490,
                          child: ElevatedButton(
                            onPressed: () {
                              // Add subscribe action
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black87,
                              backgroundColor: ColorsUtils.primaryColor,
                              elevation: 0.0,
                              shadowColor: Colors.white,
                              minimumSize: Size(490, 56),
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      16), // Match padding with TextField
                            ).copyWith(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                            child: Text('Subscribe Now'),
                          ),
                        ),
                        SpacingUtils.space20,
                        // Copyright Text
                        Text(
                          '© 2025 Ajay Kumar. All Rights Reserved.',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // Stack(
    //   children: [
    //     // Background Animation
    //     // AnimatedBuilder(
    //     //   animation: _animationController,
    //     //   builder: (context, child) {
    //     //     return SizedBox(
    //     //       height: 700,
    //     //       width: double.infinity,
    //     //       // decoration: BoxDecoration(
    //     //       //   gradient: LinearGradient(
    //     //       //     begin: Alignment.topLeft,
    //     //       //     end: Alignment.bottomRight,
    //     //       //     colors: [
    //     //       //       Colors.blueAccent
    //     //       //           .withOpacity(0.2 + _animationController.value * 0.3),
    //     //       //       Colors.purpleAccent
    //     //       //           .withOpacity(0.3 + _animationController.value * 0.2),
    //     //       //     ],
    //     //       //   ),
    //     //       //   // image: const DecorationImage(
    //     //       //   //   image: AssetImage('assets/images/background.jpg'),
    //     //       //   //   fit: BoxFit.cover,
    //     //       //   //   opacity: 0.2,
    //     //       //   // ),
    //     //       // ),
    //     //     );
    //     //   },
    //     // ),

    //     // Content with Glassmorphism Effect
    //     Center(
    //       child: Container(
    //         height: 650,
    //         width: MediaQuery.of(context).size.width * 0.9,
    //         padding: const EdgeInsets.all(40),
    //         decoration: BoxDecoration(
    //           color: Colors.black,
    //           borderRadius: BorderRadius.circular(20),
    //           border: Border.all(color: Colors.white.withOpacity(0.2)),
    //           // boxShadow: [
    //           //   BoxShadow(
    //           //     color: Colors.black.withOpacity(0.5),
    //           //     blurRadius: 20,
    //           //     spreadRadius: 5,
    //           //   ),
    //           // ],
    //         ),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             // Profile Image with Fade In Effect
    //             FadeTransition(
    //               opacity: _fadeInAnimation,
    //               child: SlideTransition(
    //                 position: _slideAnimation,
    //                 child: CircleAvatar(
    //                   radius: 100,
    //                   backgroundImage:
    //                       AssetImage('assets/images/profile_image.jpg'),
    //                   backgroundColor: Colors.white,
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(width: 50),

    //             // Intro Section
    //             SlideTransition(
    //               position: _slideAnimation,
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Text(
    //                     "Hello, I'm",
    //                     style: GoogleFonts.poppins(
    //                       fontSize: 24,
    //                       color: Colors.white60,
    //                     ),
    //                   ),
    //                   Text(
    //                     "Ajay Kumar",
    //                     style: GoogleFonts.poppins(
    //                       fontSize: 48,
    //                       fontWeight: FontWeight.bold,
    //                       color: Colors.white,
    //                     ),
    //                   ),
    //                   Text(
    //                     "Flutter Developer & UI/UX Designer",
    //                     style: GoogleFonts.poppins(
    //                       fontSize: 22,
    //                       color: Colors.blueAccent,
    //                     ),
    //                   ),
    // SpacingUtils.space20,
    //                   // Social Media Icons with Hover Effect
    //                   Row(
    //                     children: [
    //
    //                     ],
    //                   ),
    // SpacingUtils.space20,
    //                   // Action Buttons with Hover Effect
    //                   Row(
    //                     children: [
    //                       _buildHoverButton(
    //                         text: "Hire Me",
    //                         color: Colors.blueAccent,
    //                         onPressed: () async {
    //                           final Uri whatsappUri = Uri.parse(
    //                             'https://wa.me/917876740036?text=Hello%20Ajay,%20I%20am%20interested%20in%20hiring%20you.',
    //                           );
    //                           if (!await launchUrl(whatsappUri,
    //                               mode: LaunchMode.externalApplication)) {
    //                             throw 'Could not launch $whatsappUri';
    //                           }
    //                         },
    //                       ),
    //                       const SizedBox(width: 20),
    //                       _buildHoverButton(
    //                         text: "Download Resume",
    //                         color: Colors.transparent,
    //                         borderColor: Colors.blueAccent,
    //                         textColor: Colors.white,
    //                         onPressed: () async {
    //                           final url = Uri.parse(
    //                               'https://drive.google.com/uc?export=download&id=1DQbRzcs9uNJJ5wTJK4dIt38uVxpayDdL');
    //                           if (!await launchUrl(url,
    //                               mode: LaunchMode.externalApplication)) {
    //                             throw 'Could not launch $url';
    //                           }
    //                         },
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }

  // // Project Card Widget
  // Widget _buildProjectCard(String title, String description) {
  //   return Card(
  //     elevation: 5,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(16),
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.all(20),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Text(
  //             title,
  //             style: GoogleFonts.montserrat(
  //               fontSize: 22,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           const SizedBox(height: 10),
  //           Text(
  //             description,
  //             style: GoogleFonts.inter(fontSize: 16),
  //             textAlign: TextAlign.center,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget _buildProjectCard(Map<String, String> project, int index) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _hoverIndex = index; // Track the hovered card
        });
      },
      onExit: (_) {
        setState(() {
          _hoverIndex = -1; // Reset when cursor leaves
        });
      },
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                image: DecorationImage(
                  image: AssetImage(project['image']!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Blur Effect on Hover
          if (_hoverIndex == index)
            Positioned.fill(
              child: AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 300),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(color: Colors.transparent),
                  ),
                ),
              ),
            ),

          // Content on Hover
          Positioned.fill(
            child: Center(
              child: AnimatedOpacity(
                opacity: _hoverIndex == index ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      project['title']!,
                      style: const TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      project['description']!,
                      style: const TextStyle(color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //   Widget buildProjectCard(Map<String, String> project) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 8.0),
  //     padding: const EdgeInsets.all(16.0),
  //     decoration: BoxDecoration(
  //       color: Colors.tealAccent.shade100,
  //       borderRadius: BorderRadius.circular(16.0),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black26,
  //           blurRadius: 8.0,
  //           offset: const Offset(4, 4),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           project['title']!,
  //           style: const TextStyle(
  //             fontSize: 18.0,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         const SizedBox(height: 8.0),
  //         Text(project['description']!),
  //       ],
  //     ),
  //   );
  // }

  // Function to build social media icons
  Widget _buildSocialIcon(IconData icon, String url) {
    return IconButton(
      icon: FaIcon(icon, color: Colors.black),
      onPressed: () async {
        if (!await launchUrl(Uri.parse(url),
            mode: LaunchMode.externalApplication)) {
          throw 'Could not launch $url';
        }
      },
      //  hoverColor: ColorsUtils.primaryColor.withOpacity(.2),
    );
  }

//   // Function to build modern hover buttons
//   Widget _buildHoverButton({
//     required String text,
//     required Color color,
//     Color borderColor = Colors.transparent,
//     Color textColor = Colors.white,
//     required VoidCallback onPressed,
//   }) {
//     return MouseRegion(
//       onEnter: (event) => setState(() {}),
//       onExit: (event) => setState(() {}),
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: color,
//           side: BorderSide(color: borderColor),
//           padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(fontSize: 18, color: textColor),
//         ),
//       ),
//     );
//   }
// }
}
