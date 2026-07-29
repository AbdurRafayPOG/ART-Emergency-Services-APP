import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

// ---------------------------------------------------------------------
// Color theme - matches the Fire Fighter / Police screens so the app
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

class PharmacyOptions extends StatefulWidget {
  const PharmacyOptions({super.key});

  @override
  State<PharmacyOptions> createState() => _PharmacyOptionsState();
}

class _PharmacyOptionsState extends State<PharmacyOptions> {
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
  // Trusted Online Pharmacies & Health Platforms
  // These are getters (not a `static final` list) so the descriptions
  // re-read the current locale's strings every time the widget rebuilds
  // after a language switch. Names/URLs are proper nouns and are not
  // translated.
  // ---------------------------------------------------------------------

  List<Map<String, dynamic>> get pharmacyWebsites => [
        {
          "name": "Dawaai.pk",
          "icon": Icons.local_pharmacy,
          "url": "https://www.dawaai.pk/",
          "description": 'pharmacy_dawaai_desc'.tr,
        },
        {
          "name": "DVAGO",
          "icon": Icons.medication_liquid,
          "url": "https://www.dvago.pk/",
          "description": 'pharmacy_dvago_desc'.tr,
        },
        {
          "name": "Servaid Pharmacy",
          "icon": Icons.storefront,
          "url": "https://www.servaid.com.pk/",
          "description": 'pharmacy_servaid_desc'.tr,
        },
        {
          "name": "Instacare",
          "icon": Icons.shopping_cart,
          "url": "https://instacare.pk/",
          "description": 'pharmacy_instacare_desc'.tr,
        },
        {
          "name": "Sehat Kahani",
          "icon": Icons.health_and_safety,
          "url": "https://www.sehatkahani.com/",
          "description": 'pharmacy_sehatkahani_desc'.tr,
        },
      ];

  // ---------------------------------------------------------------------
  // Modal: Trusted Online Pharmacies
  // ---------------------------------------------------------------------

  void _showPharmacyWebsites() {
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
                      'trusted_online_pharmacies'.tr,
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
                      itemCount: pharmacyWebsites.length,
                      itemBuilder: (context, index) {
                        final item = pharmacyWebsites[index];
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
  // Getter (not `static final`) so it re-reads the current locale's
  // strings every time the widget rebuilds after a language switch.
  // ---------------------------------------------------------------------

  List<Map<String, dynamic>> get _services => [
        {
          "title": 'service_nearby_pharmacy_title'.tr,
          "subtitle": 'service_nearby_pharmacy_subtitle'.tr,
          "icon": Icons.local_pharmacy,
          "onTap": () => _openNearbySearch('pharmacy'),
        },
        {
          "title": 'service_24hr_pharmacy_title'.tr,
          "subtitle": 'service_24hr_pharmacy_subtitle'.tr,
          "icon": Icons.access_time,
          "onTap": () => _openNearbySearch('24 hour pharmacy'),
        },
        {
          "title": 'trusted_online_pharmacies'.tr,
          "subtitle": 'browse_verified_pharmacy_platforms'.tr,
          "icon": Icons.shopping_bag,
          "onTap": _showPharmacyWebsites,
        },
      ];

  // ---------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = Get.height * 0.12 + kToolbarHeight;
    final double iconHeight = Get.height * 0.09;
    final double buttonSize = 44;

    return Scaffold(
      backgroundColor: kPageBackground,

      // App bar style matches the Fire Fighter / Police screens: Deep
      // Teal, rounded bottom corners, logo + title, circular back button.
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
                      'pharmacy_services'.tr,
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
                  const Icon(Icons.local_pharmacy, color: Colors.white, size: 32),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'pharmacy_page_banner'.tr,
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

            _SectionHeader(title: 'pharmacy_services'.tr),
            const SizedBox(height: 6),
            Text(
              'pharmacy_services_subtitle'.tr,
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