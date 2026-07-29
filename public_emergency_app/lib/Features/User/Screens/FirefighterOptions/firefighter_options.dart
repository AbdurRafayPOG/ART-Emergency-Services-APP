import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

// ---------------------------------------------------------------------
// Color theme
// ---------------------------------------------------------------------
// App bar keeps the original Deep Teal look.
const Color kPrimary = Color(0xFF0F4C5C); // Deep Teal (app bar only)
const Color kPrimaryLight = Color(0xFF16697A);
const Color kPageBackground = Color(0xFFF5F7F8);

// Cards use a warmer, more varied accent palette so they read as
// distinct from the app bar instead of repeating the same teal everywhere.
const Color kCardAccent = Color(0xFFE07A5F); // Terracotta - default card accent
const List<Color> kCardPalette = [
  Color(0xFFE07A5F), // Terracotta
  Color(0xFFE9C46A), // Amber
  Color(0xFF2A9D8F), // Jade
  Color(0xFF457B9D), // Slate blue
];

class FireFighterOptions extends StatefulWidget {
  const FireFighterOptions({super.key});

  @override
  State<FireFighterOptions> createState() => _FireFighterOptionsState();
}

class _FireFighterOptionsState extends State<FireFighterOptions> {
  // ---------------------------------------------------------------------
  // Core actions
  // ---------------------------------------------------------------------

  Future<void> callNumber(String number) async {
    final Uri url = Uri.parse("tel:$number");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      _showSnack('msg_could_not_start_call'.tr);
    }
  }

  Future<void> openWebsite(String website) async {
    if (website.isEmpty) {
      _showSnack('msg_no_website_listed'.tr);
      return;
    }

    String finalUrl = website;
    if (!finalUrl.startsWith('http://') && !finalUrl.startsWith('https://')) {
      finalUrl = 'https://$finalUrl';
    }

    final Uri url = Uri.parse(finalUrl);
    try {
      final launched = await launchUrl(url, mode: LaunchMode.externalApplication);
      if (!launched) {
        _showSnack('msg_could_not_open_website'.tr);
      }
    } catch (_) {
      _showSnack('msg_could_not_open_website'.tr);
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

  // ---------------------------------------------------------------------
  // Safety Guides Data
  // (getter, not a final field, so it re-reads the current locale's
  // strings every time the widget rebuilds after a language switch)
  // ---------------------------------------------------------------------

  List<Map<String, dynamic>> get safetyGuides => [
        {
          "title": 'guide_fire_title'.tr,
          "icon": Icons.fire_extinguisher,
          "steps": [
            'guide_fire_step1'.tr,
            'guide_fire_step2'.tr,
            'guide_fire_step3'.tr,
            'guide_fire_step4'.tr,
            'guide_fire_step5'.tr,
            'guide_fire_step6'.tr,
            'guide_fire_step7'.tr,
            'guide_fire_step8'.tr,
            'guide_fire_step9'.tr,
          ]
        },
        {
          "title": 'guide_extinguisher_title'.tr,
          "icon": Icons.emergency,
          "steps": [
            'guide_extinguisher_step1'.tr,
            'guide_extinguisher_step2'.tr,
            'guide_extinguisher_step3'.tr,
            'guide_extinguisher_step4'.tr,
            'guide_extinguisher_step5'.tr,
            'guide_extinguisher_step6'.tr,
            'guide_extinguisher_step7'.tr,
            'guide_extinguisher_step8'.tr,
          ]
        },
        {
          "title": 'guide_burn_title'.tr,
          "icon": Icons.medical_services,
          "steps": [
            'guide_burn_step1'.tr,
            'guide_burn_step2'.tr,
            'guide_burn_step3'.tr,
            'guide_burn_step4'.tr,
            'guide_burn_step5'.tr,
            'guide_burn_step6'.tr,
            'guide_burn_step7'.tr,
            'guide_burn_step8'.tr,
            'guide_burn_step9'.tr,
          ]
        },
        {
          "title": 'guide_evacuation_title'.tr,
          "icon": Icons.exit_to_app,
          "steps": [
            'guide_evacuation_step1'.tr,
            'guide_evacuation_step2'.tr,
            'guide_evacuation_step3'.tr,
            'guide_evacuation_step4'.tr,
            'guide_evacuation_step5'.tr,
            'guide_evacuation_step6'.tr,
            'guide_evacuation_step7'.tr,
            'guide_evacuation_step8'.tr,
            'guide_evacuation_step9'.tr,
          ]
        },
        {
          "title": 'guide_gas_leak_title'.tr,
          "icon": Icons.gas_meter,
          "steps": [
            'guide_gas_leak_step1'.tr,
            'guide_gas_leak_step2'.tr,
            'guide_gas_leak_step3'.tr,
            'guide_gas_leak_step4'.tr,
            'guide_gas_leak_step5'.tr,
            'guide_gas_leak_step6'.tr,
            'guide_gas_leak_step7'.tr,
            'guide_gas_leak_step8'.tr,
            'guide_gas_leak_step9'.tr,
          ]
        },
      ];

  // ---------------------------------------------------------------------
  // Fire Safety Products - Websites
  // Real, working search URLs so "Buy Equipment" always lands somewhere valid.
  // Brand names (Daraz.pk, Amazon, Alibaba, eBay) are left untranslated;
  // only the descriptions are localized.
  // ---------------------------------------------------------------------

  List<Map<String, dynamic>> get productWebsites => [
        {
          "name": "Daraz.pk",
          "icon": Icons.shopping_bag,
          "url": "https://www.daraz.pk/catalog/?q=fire+safety+equipment",
          "description": 'product_daraz_desc'.tr,
        },
        {
          "name": "Amazon",
          "icon": Icons.shopping_cart,
          "url": "https://www.amazon.com/s?k=fire+safety+equipment",
          "description": 'product_amazon_desc'.tr,
        },
        {
          "name": "Alibaba",
          "icon": Icons.factory,
          "url": "https://www.alibaba.com/trade/search?SearchText=fire+safety+equipment",
          "description": 'product_alibaba_desc'.tr,
        },
        {
          "name": "eBay",
          "icon": Icons.storefront,
          "url": "https://www.ebay.com/sch/i.html?_nkw=fire+safety+equipment",
          "description": 'product_ebay_desc'.tr,
        },
      ];

  // ---------------------------------------------------------------------
  // Fire Safety Tips
  // (getter still holds the tip data - rendered as a horizontal
  // scrollable card row on the page)
  // ---------------------------------------------------------------------

  List<Map<String, dynamic>> get safetyTips => [
        {
          "title": 'tip_smoke_detectors_title'.tr,
          "icon": Icons.sensors,
          "tip": 'tip_smoke_detectors_desc'.tr,
        },
        {
          "title": 'tip_fire_extinguisher_title'.tr,
          "icon": Icons.fire_extinguisher,
          "tip": 'tip_fire_extinguisher_desc'.tr,
        },
        {
          "title": 'tip_escape_routes_title'.tr,
          "icon": Icons.route,
          "tip": 'tip_escape_routes_desc'.tr,
        },
        {
          "title": 'tip_electrical_wiring_title'.tr,
          "icon": Icons.electric_bolt,
          "tip": 'tip_electrical_wiring_desc'.tr,
        },
        {
          "title": 'tip_flammables_title'.tr,
          "icon": Icons.dangerous,
          "tip": 'tip_flammables_desc'.tr,
        },
        {
          "title": 'tip_kitchen_safety_title'.tr,
          "icon": Icons.kitchen,
          "tip": 'tip_kitchen_safety_desc'.tr,
        },
      ];

  // ---------------------------------------------------------------------
  // Show Safety Guide Details
  // ---------------------------------------------------------------------

  void _showSafetyGuideDetails(Map<String, dynamic> guide) {
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Icon(guide["icon"], color: kCardAccent, size: 30),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            guide["title"],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1B1B1B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 24, thickness: 1),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: (guide["steps"] as List).length,
                      itemBuilder: (context, index) {
                        final step = (guide["steps"] as List)[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: kCardAccent.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                      color: kCardAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  step,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
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
  // Show Website Options (used for buying products)
  // ---------------------------------------------------------------------

  void _showWebsiteOptions(String title, List<Map<String, dynamic>> websites) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
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
                      title,
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
                      itemCount: websites.length,
                      itemBuilder: (context, index) {
                        final item = websites[index];
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
                              item["name"] ?? item["title"] ?? "",
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              item["description"] ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                            ),
                            trailing: Icon(Icons.open_in_new, color: accent),
                            onTap: () {
                              Navigator.pop(context);
                              openWebsite(item["url"]);
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
  // Location-based map search (shared by Find Fire Station / Fire Hydrants)
  // ---------------------------------------------------------------------

  Future<void> _openNearbySearch(String query) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
      );
      double lat = position.latitude;
      double long = position.longitude;

      String url = '';
      String urlAppleMaps = '';
      final encodedQuery = Uri.encodeComponent(query);

      if (Platform.isAndroid) {
        url = "https://www.google.com/maps/search/$encodedQuery/@$lat,$long,14z";
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else {
          _showSnack('msg_could_not_open_maps'.tr);
        }
      } else if (Platform.isIOS) {
        urlAppleMaps = 'https://maps.apple.com/?q=$encodedQuery&sll=$lat,$long';
        url = 'comgooglemaps://?q=$encodedQuery&center=$lat,$long';
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else if (await canLaunchUrl(Uri.parse(urlAppleMaps))) {
          await launchUrl(Uri.parse(urlAppleMaps));
        } else {
          _showSnack('msg_could_not_open_maps'.tr);
        }
      } else {
        _showSnack('msg_platform_not_supported'.tr);
      }
    } catch (e) {
      _showSnack('msg_unable_to_get_location'.tr);
      final encodedQuery = Uri.encodeComponent(query);
      String defaultUrl = "https://www.google.com/maps/search/$encodedQuery";
      if (await canLaunchUrl(Uri.parse(defaultUrl))) {
        await launchUrl(Uri.parse(defaultUrl));
      }
    }
  }

  void _findFireStation() => _openNearbySearch('fire brigade');

  void _findFireHydrants() => _openNearbySearch('fire hydrant');

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

      // App bar left untouched (still Deep Teal).
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
                      'fire_brigade'.tr,
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
                  const Icon(Icons.fire_extinguisher, color: Colors.white, size: 32),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'fire_page_banner'.tr,
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

            // 🔥 Emergency Contacts dial list removed.
            // "Call Fire Brigade" now lives directly inside Quick Actions below.

            // Quick Actions - fire-brigade related features live here
            _SectionHeader(title: 'quick_actions'.tr),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.3,
              children: [
                // 🔥 Call Fire Brigade replaces the old separate
                // Emergency Contacts dial list - number 16 lives here now.
                _QuickActionCard(
                  title: 'fire_department'.tr,
                  icon: Icons.local_fire_department,
                  color: kCardPalette[0],
                  onTap: () => callNumber('16'),
                ),
                _QuickActionCard(
                  title: 'find_fire_station'.tr,
                  icon: Icons.location_on,
                  color: kCardPalette[3],
                  onTap: _findFireStation,
                ),
                _QuickActionCard(
                  title: 'nearby_fire_hydrants'.tr,
                  icon: Icons.water_drop,
                  color: kCardPalette[2],
                  onTap: _findFireHydrants,
                ),
                _QuickActionCard(
                  title: 'buy_equipment'.tr,
                  icon: Icons.shopping_bag,
                  color: kCardPalette[1],
                  onTap: () => _showWebsiteOptions(
                    'fire_safety_products'.tr,
                    productWebsites
                  ),
                ),
              ],
            ),

            // 🔥 Safety Tips - horizontal scrollable card row
            // 🔥 Safety Tips - horizontal scrollable card row
const SizedBox(height: 24),
_SectionHeader(title: 'safety_tips'.tr),
const SizedBox(height: 10),
SizedBox(
  height: 190,  // ✅ INCREASED from 150 to 190
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: safetyTips.length,
    itemBuilder: (context, index) {
      final tip = safetyTips[index];
      final accent = kCardPalette[index % kCardPalette.length];
      return Container(
        width: 200,  // ✅ Slightly wider too
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(16),  // ✅ More padding
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: accent.withOpacity(0.25),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: accent.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(tip["icon"], color: accent, size: 20),
            ),
            const SizedBox(height: 10),
            Text(
              tip["title"],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Text(
                tip["tip"],
                maxLines: 5,  // ✅ Increased from 4 to 5 lines
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      );
    },
  ),
),

            // Safety Guides
            const SizedBox(height: 24),
            _SectionHeader(title: 'safety_guides'.tr),
            const SizedBox(height: 6),
            Text(
              'safety_guides_subtitle'.tr,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12.5),
            ),
            const SizedBox(height: 12),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: safetyGuides.length,
              itemBuilder: (context, index) {
                final guide = safetyGuides[index];
                final accent = kCardPalette[index % kCardPalette.length];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: accent.withOpacity(0.12),
                      child: Icon(guide["icon"], color: accent),
                    ),
                    title: Text(
                      guide["title"],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => _showSafetyGuideDetails(guide),
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

class _QuickActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}