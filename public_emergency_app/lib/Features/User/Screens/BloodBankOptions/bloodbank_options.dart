import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

// ---------------------------------------------------------------------
// Color theme - matches the Pharmacy / Fire Fighter screens so the app
// feels consistent across sections.
// ---------------------------------------------------------------------
const Color kPrimary = Color(0xFF0F4C5C); // Deep Teal (app bar only)
const Color kPrimaryLight = Color(0xFF16697A);
const Color kPageBackground = Color(0xFFF5F7F8);

const Color kCardAccent = Color(0xFF2A9D8F); // Jade - default card accent
const List<Color> kCardPalette = [
  Color(0xFF2A9D8F), // Jade
  Color(0xFF457B9D), // Slate blue
  Color(0xFFE07A5F), // Terracotta
  Color(0xFFE9C46A), // Amber
];

class BloodBankOptions extends StatefulWidget {
  const BloodBankOptions({super.key});

  @override
  State<BloodBankOptions> createState() => _BloodBankOptionsState();
}

class _BloodBankOptionsState extends State<BloodBankOptions> {
  // ---------------------------------------------------------------------
  // Core actions
  // ---------------------------------------------------------------------

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched) {
        _showSnack('msg_could_not_open_link'.tr);
      }
    } catch (_) {
      _showSnack('msg_could_not_open_link'.tr);
    }
  }

  void _showSnack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: kPrimary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(12),
      ),
    );
  }

  Future<void> _callNumber(String number) async {
    final Uri url = Uri.parse("tel:$number");
    try {
      final launched = await launchUrl(url);
      if (!launched) {
        _showSnack('msg_could_not_place_call'.tr);
      }
    } catch (_) {
      _showSnack('msg_could_not_place_call'.tr);
    }
  }

  Future<void> _openNearbySearch(String query) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      double lat = position.latitude;
      double long = position.longitude;
      final encodedQuery = Uri.encodeComponent(query);

      if (Platform.isAndroid) {
        await _launchURL(
          "https://www.google.com/maps/search/$encodedQuery/@$lat,$long,14z",
        );
      } else if (Platform.isIOS) {
        final googleUrl = 'comgooglemaps://?q=$encodedQuery&center=$lat,$long';
        final appleUrl = 'https://maps.apple.com/?q=$encodedQuery&sll=$lat,$long';
        if (await canLaunchUrl(Uri.parse(googleUrl))) {
          await launchUrl(Uri.parse(googleUrl));
        } else {
          await _launchURL(appleUrl);
        }
      } else {
        _showSnack('msg_platform_not_supported'.tr);
      }
    } catch (e) {
      _showSnack('msg_unable_to_get_location'.tr);
      final encodedQuery = Uri.encodeComponent(query);
      await _launchURL("https://www.google.com/maps/search/$encodedQuery");
    }
  }

  // ---------------------------------------------------------------------
  // Blood Donation Websites (verified sources)
  // Org names are proper nouns and stay untranslated; only the
  // descriptions are localized.
  // ---------------------------------------------------------------------

  List<Map<String, dynamic>> get donationWebsites => [
        {
          "name": "SBTA - Locate a Blood Bank",
          "icon": Icons.bloodtype,
          "url": "https://sbta.gos.pk/locate-a-blood-bank-near-you/",
          "description": 'donation_sbta_desc'.tr,
        },
        {
          "name": "Fatimid Foundation",
          "icon": Icons.favorite,
          "url": "https://fatimid.org/",
          "description": 'donation_fatimid_desc'.tr,
        },
        {
          "name": "Indus Hospital Blood Bank",
          "icon": Icons.local_hospital,
          "url": "https://indushealthnetwork.org/",
          "description": 'donation_indus_desc'.tr,
        },
        {
          "name": "Pakistan Red Crescent",
          "icon": Icons.volunteer_activism,
          "url": "https://prcs.org.pk/",
          "description": 'donation_redcrescent_desc'.tr,
        },
      ];

  // ---------------------------------------------------------------------
  // Modal: Blood Donation Websites
  // ---------------------------------------------------------------------

  void _showDonationWebsites() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: 4,
                      width: 44,
                      margin: const EdgeInsets.only(top: 12, bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'blood_donation_availability'.tr,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B1B1B),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: donationWebsites.length,
                      itemBuilder: (context, index) {
                        final item = donationWebsites[index];
                        final accent = kCardPalette[index % kCardPalette.length];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 2,
                          child: ListTile(
                            leading: Icon(item["icon"], color: accent),
                            title: Text(
                              item["name"],
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              item["description"],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                            ),
                            trailing: Icon(Icons.open_in_new, color: accent),
                            onTap: () {
                              Navigator.pop(context);
                              _launchURL(item["url"]);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // ---------------------------------------------------------------------
  // Service list data (drives the professional ListTile cards below)
  // ---------------------------------------------------------------------

  List<Map<String, dynamic>> get _services => [
        {
          "title": 'service_nearby_blood_bank_title'.tr,
          "subtitle": 'service_nearby_blood_bank_subtitle'.tr,
          "icon": Icons.bloodtype,
          "onTap": () => _openNearbySearch('blood bank'),
        },
        {
          "title": 'emergency_helpline'.tr,
          "subtitle": 'service_emergency_helpline_subtitle'.tr,
          "icon": Icons.call,
          "onTap": () => _callNumber('02135650411'),
        },
        {
          "title": 'service_24hr_blood_bank_title'.tr,
          "subtitle": 'service_24hr_blood_bank_subtitle'.tr,
          "icon": Icons.access_time,
          "onTap": () => _openNearbySearch('24 hour blood bank'),
        },
        {
          "title": 'service_realtime_availability_title'.tr,
          "subtitle": 'service_realtime_availability_subtitle'.tr,
          "icon": Icons.favorite,
          "onTap": _showDonationWebsites,
        },
      ];

  // ---------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = MediaQuery.of(context).size.height * 0.12 + kToolbarHeight;
    final double iconHeight = MediaQuery.of(context).size.height * 0.09;
    final double buttonSize = 44;

    return Scaffold(
      backgroundColor: kPageBackground,

      // App bar style matches the Pharmacy / Fire Fighter screens: Deep
      // Teal, rounded bottom corners, logo + title, and a circular back
      // button.
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
                      'blood_bank_services'.tr,
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
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: buttonSize,
                    height: buttonSize,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
          padding: const EdgeInsets.all(14),
          children: [
            // HEADER BANNER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 18),
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
                  const Icon(Icons.bloodtype, color: Colors.white, size: 32),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'blood_bank_page_banner'.tr,
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

            _SectionHeader(title: 'blood_bank_services'.tr),
            const SizedBox(height: 6),
            Text(
              'blood_bank_services_subtitle'.tr,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12.5),
            ),
            const SizedBox(height: 12),

            // Professional list-style cards, one accent color per card so
            // the list stays easy to scan.
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _services.length,
              itemBuilder: (context, index) {
                final service = _services[index];
                final accent = kCardPalette[index % kCardPalette.length];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  color: Colors.white,
                  elevation: 1.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: BorderSide(color: accent.withOpacity(0.12)),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: accent.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(service["icon"], color: accent, size: 22),
                    ),
                    title: Text(
                      service["title"],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.5,
                        color: Color(0xFF1B1B1B),
                      ),
                    ),
                    subtitle: Text(
                      service["subtitle"],
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 15, color: accent),
                    onTap: service["onTap"],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
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
            color: kCardAccent,
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