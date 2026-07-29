import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:public_emergency_app/Common%20Widgets/constants.dart';

class DoctorListPage extends StatelessWidget {
  const DoctorListPage({Key? key}) : super(key: key);

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define the variables
    final double appBarHeight = Get.height * 0.12 + kToolbarHeight;
    final double iconHeight = Get.height * 0.09;
    final double buttonSize = 44;

    // Doctor referral / booking platforms
    // Names are proper nouns/brand names and stay untranslated;
    // descriptions are pulled from the translation table.
    final List<Map<String, dynamic>> referralSites = [
      {
        "name": "Oladoc",
        "desc": 'referral_oladoc_desc'.tr,
        "url": "https://oladoc.com/",
        "color": const Color(0xFF00A99D),
        "icon": Icons.local_hospital_rounded,
      },
      {
        "name": "Marham",
        "desc": 'referral_marham_desc'.tr,
        "url": "https://www.marham.pk/",
        "color": const Color(0xFF2E7D32),
        "icon": Icons.medical_services_rounded,
      },
      {
        "name": "Dawaai.pk",
        "desc": 'referral_dawaai_desc'.tr,
        "url": "https://dawaai.pk/doctors-online",
        "color": const Color(0xFF1565C0),
        "icon": Icons.health_and_safety_rounded,
      },
      {
        "name": "Ddoctor.pk",
        "desc": 'referral_ddoctor_desc'.tr,
        "url": "https://www.ddoctor.pk/doctors",
        "color": const Color(0xFF6A1B9A),
        "icon": Icons.person_search_rounded,
      },
      {
        "name": "Healthwire.pk",
        "desc": 'referral_healthwire_desc'.tr,
        "url": "https://www.healthwire.pk/",
        "color": const Color(0xFFEF6C00),
        "icon": Icons.favorite_rounded,
      },
      {
        "name": "Sehat Kahani",
        "desc": 'referral_sehatkahani_desc'.tr,
        "url": "https://sehatkahani.com/",
        "color": const Color(0xFFC62828),
        "icon": Icons.video_call_rounded,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0F4C5C),
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
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
                    'doctor_referrals_title'.tr,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Back button - aligned with app icon (same as DoctorListPage)
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
                      colors: [
                        Colors.white,
                        Colors.white,
                      ],
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
                      color: Color(0xFF0F4C5C),
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
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
        children: [
          Text(
            'book_free_consultation_title'.tr,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'trusted_platforms_subtitle'.tr,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 16),
          ...referralSites.map((site) => _buildReferralCard(site)).toList(),
        ],
      ),
    );
  }

  Widget _buildReferralCard(Map<String, dynamic> site) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => _launchURL(site["url"]),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: (site["color"] as Color).withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    site["icon"] as IconData,
                    color: site["color"] as Color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        site["name"],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        site["desc"],
                        style: TextStyle(
                          fontSize: 12.5,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: site["color"] as Color,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    'book_label'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}