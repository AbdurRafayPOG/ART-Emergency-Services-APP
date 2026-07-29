import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:public_emergency_app/Common%20Widgets/constants.dart';
import 'package:url_launcher/url_launcher.dart';

// Color theme matched to the User Dashboard page
const Color kPrimary = Color(0xFF0F4C5C);
const Color kPrimaryLight = Color(0xFF16697A);
const Color kPageBackground = Color(0xFFF5F7F8);

class PoliceOptions extends StatefulWidget {
  const PoliceOptions({Key? key}) : super(key: key);

  @override
  State<PoliceOptions> createState() => _PoliceOptionsState();
}

class _PoliceOptionsState extends State<PoliceOptions> {
  // Track which action is currently loading so we can show
  // a spinner on that specific card without blocking the whole page.
  bool _isLocating = false;
  bool _isCalling = false;

  // ---------------------------------------------------------------------
  // Core emergency actions (unchanged behaviour, just wrapped with
  // loading/error handling as before)
  // ---------------------------------------------------------------------

  Future<void> _openPoliceStationMap({String? query}) async {
    final searchQuery = query ?? 'police_station_query'.tr;
    if (_isLocating) return;
    setState(() => _isLocating = true);

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showSnack('msg_enable_location'.tr);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showSnack('msg_location_permission_required'.tr);
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        _showSnack('msg_location_permanently_denied'.tr);
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      double lat = position.latitude;
      double long = position.longitude;
      String url = '';
      String urlAppleMaps = '';
      final encodedQuery = Uri.encodeComponent(searchQuery);

      if (Platform.isAndroid) {
        url =
            "https://www.google.com/maps/search/$encodedQuery/@$lat,$long,12.5z";
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else {
          _showSnack('msg_could_not_open_map'.tr);
        }
      } else {
        urlAppleMaps = 'https://maps.apple.com/?q=$searchQuery&near=$lat,$long';
        url = 'comgooglemaps://?q=$encodedQuery&center=$lat,$long';
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else if (await canLaunchUrl(Uri.parse(urlAppleMaps))) {
          await launchUrl(Uri.parse(urlAppleMaps));
        } else {
          _showSnack('msg_could_not_open_map'.tr);
        }
      }
    } catch (e) {
      _showSnack('msg_map_error'.tr);
    } finally {
      if (mounted) setState(() => _isLocating = false);
    }
  }

  Future<void> _callNumber(String number) async {
    if (_isCalling) return;
    setState(() => _isCalling = true);

    try {
      if (await Permission.phone.request().isGranted) {
        var url = Uri.parse("tel:$number");
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          _showSnack('msg_could_not_start_call'.tr);
        }
      } else {
        _showSnack('msg_phone_permission_required'.tr);
      }
    } catch (e) {
      _showSnack('msg_call_error'.tr);
    } finally {
      if (mounted) setState(() => _isCalling = false);
    }
  }

  void _showSnack(String message) {
    Get.snackbar(
      'notice_label'.tr,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: kPrimary,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 12,
      icon: const Icon(Icons.info_outline, color: Colors.white),
    );
  }

  // ---------------------------------------------------------------------
  // Bottom sheets: specialised wing details & info/rights content
  // ---------------------------------------------------------------------

  void _showWingDetails(_PoliceWing wing) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.55,
          minChildSize: 0.35,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.all(20),
                children: [
                  Center(
                    child: Container(
                      height: 4,
                      width: 44,
                      margin: const EdgeInsets.only(bottom: 18),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 54,
                        width: 54,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: wing.colors),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(wing.icon, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              wing.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1B1B1B),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${'helpline_label'.tr}: ${wing.helpline}',
                              style: TextStyle(
                                color: wing.colors.first,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    wing.description,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...wing.details.map(
                    (point) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.circle, size: 7, color: wing.colors.first),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              point,
                              style: const TextStyle(
                                fontSize: 13.5,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            _callNumber(wing.helpline);
                          },
                          icon: const Icon(Icons.call, color: Colors.white),
                          label: Text('call_now'.tr),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: wing.colors.first,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            _openPoliceStationMap(query: wing.mapQuery);
                          },
                          icon: Icon(
                            Icons.map_outlined,
                            color: wing.colors.first,
                          ),
                          label: Text('find_nearest'.tr),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: wing.colors.first,
                            side: BorderSide(color: wing.colors.first),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showInfoDetails(_InfoTopic topic) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.35,
          maxChildSize: 0.92,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.all(20),
                children: [
                  Center(
                    child: Container(
                      height: 4,
                      width: 44,
                      margin: const EdgeInsets.only(bottom: 18),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: topic.color.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(topic.icon, color: topic.color, size: 24),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          topic.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B1B1B),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  if (!topic.isFaq)
                    ...topic.points.map(
                      (point) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                color: topic.color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                point,
                                style: const TextStyle(
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ...topic.points.map((qa) {
                      final parts = qa.split('|');
                      final question = parts[0];
                      final answer = parts.length > 1 ? parts[1] : '';
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              question,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: topic.color,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              answer,
                              style: const TextStyle(
                                fontSize: 13.5,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  const SizedBox(height: 8),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // ---------------------------------------------------------------------
  // Localized data
  // These are now getters (not `static final`) so they re-read the
  // current locale's strings every time the widget rebuilds after a
  // language switch — same pattern as the Fire Brigade page.
  // Helplines, map queries, icons and colors are NOT translated
  // (they aren't language-dependent).
  // ---------------------------------------------------------------------

  List<_PoliceWing> get _wings => [
        _PoliceWing(
          title: 'wing_women_title'.tr,
          subtitle: 'wing_women_subtitle'.tr,
          icon: Icons.woman_rounded,
          colors: const [Color(0xFFAD1457), Color(0xFFEC407A)],
          helpline: '(021)99226042',
          mapQuery: 'women police station',
          description: 'wing_women_desc'.tr,
          details: [
            'wing_women_detail1'.tr,
            'wing_women_detail2'.tr,
            'wing_women_detail3'.tr,
          ],
        ),
        _PoliceWing(
          title: 'wing_child_title'.tr,
          subtitle: 'wing_child_subtitle'.tr,
          icon: Icons.child_care_rounded,
          colors: const [Color(0xFFEF6C00), Color(0xFFFFA726)],
          helpline: '1121',
          mapQuery: 'child protection police station',
          description: 'wing_child_desc'.tr,
          details: [
            'wing_child_detail1'.tr,
            'wing_child_detail2'.tr,
            'wing_child_detail3'.tr,
          ],
        ),
        _PoliceWing(
          title: 'wing_traffic_title'.tr,
          subtitle: 'wing_traffic_subtitle'.tr,
          icon: Icons.traffic_rounded,
          colors: const [Color(0xFFFF8F00), Color(0xFFFFC107)],
          helpline: '1915',
          mapQuery: 'traffic police station',
          description: 'wing_traffic_desc'.tr,
          details: [
            'wing_traffic_detail1'.tr,
            'wing_traffic_detail2'.tr,
            'wing_traffic_detail3'.tr,
          ],
        ),
        _PoliceWing(
          title: 'wing_bomb_title'.tr,
          subtitle: 'wing_bomb_subtitle'.tr,
          icon: Icons.dangerous_rounded,
          colors: const [Color(0xFFB71C1C), Color(0xFFE53935)],
          helpline: '021-99212674',
          mapQuery: 'bomb disposal unit',
          description: 'wing_bomb_desc'.tr,
          details: [
            'wing_bomb_detail1'.tr,
            'wing_bomb_detail2'.tr,
            'wing_bomb_detail3'.tr,
          ],
        ),
        _PoliceWing(
          title: 'wing_rescue_title'.tr,
          subtitle: 'wing_rescue_subtitle'.tr,
          icon: Icons.local_hospital_rounded,
          colors: const [Color(0xFF2E7D32), Color(0xFF66BB6A)],
          helpline: '1122',
          mapQuery: 'rescue 1122 station',
          description: 'wing_rescue_desc'.tr,
          details: [
            'wing_rescue_detail1'.tr,
            'wing_rescue_detail2'.tr,
            'wing_rescue_detail3'.tr,
          ],
        ),
        _PoliceWing(
          title: 'wing_cyber_title'.tr,
          subtitle: 'wing_cyber_subtitle'.tr,
          icon: Icons.security_rounded,
          colors: const [Color(0xFF283593), Color(0xFF5C6BC0)],
          helpline: '1991',
          mapQuery: 'FIA cyber crime wing office',
          description: 'wing_cyber_desc'.tr,
          details: [
            'wing_cyber_detail1'.tr,
            'wing_cyber_detail2'.tr,
            'wing_cyber_detail3'.tr,
          ],
        ),
      ];

  List<_InfoTopic> get _infoTopics => [
        _InfoTopic(
          title: 'info_fir_title'.tr,
          icon: Icons.description_rounded,
          color: kPrimary,
          points: [
            'fir_point1'.tr,
            'fir_point2'.tr,
            'fir_point3'.tr,
            'fir_point4'.tr,
            'fir_point5'.tr,
          ],
        ),
        _InfoTopic(
          title: 'info_rights_title'.tr,
          icon: Icons.gavel_rounded,
          color: const Color(0xFF6A1B9A),
          points: [
            'rights_point1'.tr,
            'rights_point2'.tr,
            'rights_point3'.tr,
            'rights_point4'.tr,
            'rights_point5'.tr,
          ],
        ),
        _InfoTopic(
          title: 'info_safety_title'.tr,
          icon: Icons.health_and_safety_rounded,
          color: const Color(0xFF00838F),
          points: [
            'safety_point1'.tr,
            'safety_point2'.tr,
            'safety_point3'.tr,
            'safety_point4'.tr,
            'safety_point5'.tr,
          ],
        ),
        _InfoTopic(
          title: 'info_faq_title'.tr,
          icon: Icons.help_rounded,
          color: const Color(0xFF455A64),
          isFaq: true,
          points: [
            '${'faq_q1'.tr}|${'faq_a1'.tr}',
            '${'faq_q2'.tr}|${'faq_a2'.tr}',
            '${'faq_q3'.tr}|${'faq_a3'.tr}',
            '${'faq_q4'.tr}|${'faq_a4'.tr}',
            '${'faq_q5'.tr}|${'faq_a5'.tr}',
          ],
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double appBarHeight = Get.height * 0.12 + kToolbarHeight;
    final double iconHeight = Get.height * 0.09;
    final double buttonSize = 44;

    return Scaffold(
      backgroundColor: kPageBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight),
        child: Container(
          decoration: const BoxDecoration(
            color: kPrimary,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logos/emergencyAppLogo.png",
                      height: iconHeight,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'police_options_title'.tr,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 12,
                top: (appBarHeight / 2) - (buttonSize / 2),
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    width: buttonSize,
                    height: buttonSize,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.white, Colors.white],
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.6),
                        width: 1.5,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: kPrimary,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Small info banner explaining the section
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [kPrimary, kPrimaryLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: kPrimary.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.shield, color: Colors.white, size: 32),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'police_page_banner'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Police Station Map
            _AdvancedActionCard(
              icon: Icons.map_rounded,
              title: 'police_station_map_title'.tr,
              subtitle: 'police_station_map_subtitle'.tr,
              isLoading: _isLocating,
              onTap: () => _openPoliceStationMap(),
            ),
            const SizedBox(height: 14),

            // Call Police Helpline
            _AdvancedActionCard(
              icon: Icons.call_rounded,
              title: 'call_police_helpline_title'.tr,
              subtitle: 'call_police_helpline_subtitle'.tr,
              isLoading: _isCalling,
              onTap: () => _callNumber('15'),
            ),

            const SizedBox(height: 26),
            _SectionHeader(title: 'specialised_police_wings'.tr),
            const SizedBox(height: 12),

            GridView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: _wings.length,
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    childAspectRatio: 1.2, // Reduced grid height
  ),
  itemBuilder: (context, index) {
    final wing = _wings[index];
    return _WingCard(
      wing: wing,
      onTap: () => _showWingDetails(wing),
    );
  },
),
            const SizedBox(height: 26),
            _SectionHeader(title: 'know_your_rights_safety'.tr),
            const SizedBox(height: 12),

            ..._infoTopics.map(
              (topic) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _InfoCard(
                  topic: topic,
                  onTap: () => _showInfoDetails(topic),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Data models
// ---------------------------------------------------------------------

class _PoliceWing {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> colors;
  final String helpline;
  final String mapQuery;
  final String description;
  final List<String> details;

  _PoliceWing({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.colors,
    required this.helpline,
    required this.mapQuery,
    required this.description,
    required this.details,
  });
}

class _InfoTopic {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> points;
  final bool isFaq;

  _InfoTopic({
    required this.title,
    required this.icon,
    required this.color,
    required this.points,
    this.isFaq = false,
  });
}

// ---------------------------------------------------------------------
// Reusable widgets
// ---------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 4,
          decoration: BoxDecoration(
            color: kPrimary,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1B1B1B),
          ),
        ),
      ],
    );
  }
}

/// A reusable, polished action card used for the primary emergency options.
class _AdvancedActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isLoading;
  final VoidCallback onTap;

  const _AdvancedActionCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    final isLargeScreen = screenWidth > 600;

    return Material(
      elevation: 6,
      shadowColor: kPrimary.withOpacity(0.3),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: kPrimary.withOpacity(0.1),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenWidth * 0.035,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: kPrimary.withOpacity(0.08), width: 1),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(screenWidth * 0.025),
                decoration: BoxDecoration(
                  color: kPrimary.withOpacity(0.08),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: kPrimary.withOpacity(0.15),
                    width: 1,
                  ),
                ),
                child: Icon(icon, color: kPrimary, size: screenWidth * 0.065),
              ),
              SizedBox(width: screenWidth * 0.035),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: isSmallScreen
                            ? screenWidth * 0.035
                            : isLargeScreen
                            ? screenWidth * 0.025
                            : screenWidth * 0.04,
                        fontWeight: FontWeight.w700,
                        color: kPrimary,
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.008),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: isSmallScreen
                            ? screenWidth * 0.025
                            : isLargeScreen
                            ? screenWidth * 0.018
                            : screenWidth * 0.03,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(screenWidth * 0.02),
                decoration: BoxDecoration(
                  color: kPrimary.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: isLoading
                    ? SizedBox(
                        height: screenWidth * 0.045,
                        width: screenWidth * 0.045,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          color: kPrimary,
                        ),
                      )
                    : Icon(
                        Icons.arrow_forward_ios,
                        color: kPrimary,
                        size: isSmallScreen
                            ? screenWidth * 0.03
                            : isLargeScreen
                            ? screenWidth * 0.025
                            : screenWidth * 0.035,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WingCard extends StatelessWidget {
  final _PoliceWing wing;
  final VoidCallback onTap;

  const _WingCard({required this.wing, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shadowColor: wing.colors.first.withOpacity(0.4),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: wing.colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Icon(wing.icon, color: Colors.white, size: 18),
              ),
              const SizedBox(height: 6),
              Text(
                wing.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13.5,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                wing.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 10.5,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.call, color: Colors.white, size: 11),
                  const SizedBox(width: 3),
                  Text(
                    wing.helpline,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
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
}

/// A row-style card for the informational section (FIR guide, rights,
/// safety tips, FAQs) that opens a bottom sheet with the full content.
class _InfoCard extends StatelessWidget {
  final _InfoTopic topic;
  final VoidCallback onTap;

  const _InfoCard({required this.topic, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shadowColor: topic.color.withOpacity(0.2),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: topic.color.withOpacity(0.1)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: topic.color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(topic.icon, color: topic.color, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  topic.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14.5,
                    color: Color(0xFF1B1B1B),
                  ),
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: topic.color),
            ],
          ),
        ),
      ),
    );
  }
}