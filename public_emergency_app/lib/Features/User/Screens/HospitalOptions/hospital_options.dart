import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

// ---------------------------------------------------------------------
// Color theme - matches the Blood Bank / Pharmacy / Fire Fighter screens
// so the app feels consistent across sections. (Same as Blood Bank code -
// not changed.)
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

class HospitalOptions extends StatefulWidget {
  const HospitalOptions({super.key});

  @override
  State<HospitalOptions> createState() => _HospitalOptionsState();
}

class _HospitalOptionsState extends State<HospitalOptions> {
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
  // Specialized care data - Kidney / Cancer / Heart / Other
  // Each hospital appears only once per list (no repeats within a list).
  // Note: query .tr getters below so language switches update live.
  // ---------------------------------------------------------------------

  Map<String, List<Map<String, dynamic>>> get specialtyHospitals => {
        "Kidney Care": [
          {
            "name": "SIUT - Sindh Institute of Urology & Transplantation",
            "icon": Icons.water_drop,
            "url": "https://siut.org/",
            "phone": "0219215752",
            "description": 'hosp_siut_desc'.tr,
          },
          {
            "name": "The Kidney Centre (TKC)",
            "icon": Icons.water_drop,
            "url": "https://kidneycentre.com/",
            "phone": "02135661000",
            "description": 'hosp_tkc_desc'.tr,
          },
          {
            "name": "Clifton Kidney & General Hospital (CKGH)",
            "icon": Icons.water_drop,
            "url": "https://ckgh.com.pk/",
            "phone": "02135837965",
            "description": 'hosp_ckgh_desc'.tr,
          },
          {
            "name": "MMI Hospital - Nephrology Department",
            "icon": Icons.water_drop,
            "url": "https://mmi.edu.pk/",
            "phone": null,
            "description": 'hosp_mmi_desc'.tr,
          },
          {
            "name": "The Kidney Foundation (NIKUD Research Hospital)",
            "icon": Icons.water_drop,
            "url": "https://www.kidneyfoundation.net.pk/",
            "phone": "02134658733",
            "description": 'hosp_kidneyfoundation_desc'.tr,
          },
        ],
        "Cancer Care": [
          {
            "name": "KIRAN - Karachi Institute of Radiotherapy & Nuclear Medicine",
            "icon": Icons.healing,
            "url": null,
            "phone": "0214646601",
            "description": 'hosp_kiran_desc'.tr,
          },
          {
            "name": "Shaukat Khanum Memorial Cancer Hospital - Karachi",
            "icon": Icons.healing,
            "url": "https://shaukatkhanum.org.pk/karachi/",
            "phone": "02135393209",
            "description": 'hosp_shaukat_desc'.tr,
          },
          {
            "name": "Bait-ul-Sukoon Cancer Hospital & Hospice",
            "icon": Icons.healing,
            "url": "https://baitulsukoon.org/",
            "phone": "02137130261",
            "description": 'hosp_baitulsukoon_desc'.tr,
          },
          {
            "name": "Dr. Ziauddin Cancer Hospital",
            "icon": Icons.healing,
            "url": "https://www.ziauddinhospital.com/",
            "phone": "02134610271",
            "description": 'hosp_ziauddin_desc'.tr,
          },
          {
            "name": "Indus Hospital - Korangi Campus",
            "icon": Icons.healing,
            "url": "https://www.indushospital.org.pk/",
            "phone": null,
            "description": 'hosp_indus_cancer_desc'.tr,
          },
        ],
        "Heart Care": [
          {
            "name": "NICVD - National Institute of Cardiovascular Diseases",
            "icon": Icons.favorite,
            "url": "https://www.nicvd.org/",
            "phone": "021111167167",
            "description": 'hosp_nicvd_desc'.tr,
          },
          {
            "name": "Tabba Heart Institute",
            "icon": Icons.favorite,
            "url": "https://tabbaheart.org/",
            "phone": "02111844844",
            "description": 'hosp_tabba_desc'.tr,
          },
          {
            "name": "Ibn-e-Seena Hospital",
            "icon": Icons.favorite,
            "url": "https://ibneseena.org/",
            "phone": null,
            "description": 'hosp_ibneseena_desc'.tr,
          },
          {
            "name": "Baqai Hospital",
            "icon": Icons.favorite,
            "url": "https://www.baqai.edu.pk/",
            "phone": "02134410293",
            "description": 'hosp_baqai_desc'.tr,
          },
          {
            "name": "South City Hospital",
            "icon": Icons.favorite,
            "url": "https://www.southcityhospital.org/",
            "phone": "02135862301",
            "description": 'hosp_southcity_desc'.tr,
          },
          {
            "name": "PNS Shifa Hospital",
            "icon": Icons.favorite,
            "url": null,
            "phone": "02148506777",
            "description": 'hosp_pns_desc'.tr,
          },
        ],
        "Other Important": [
          {
            "name": "Dr. Ruth K.M. Pfau Civil Hospital Karachi",
            "icon": Icons.local_hospital,
            "url": "https://chk.gov.pk/",
            "phone": "02199215740",
            "description": 'hosp_civil_desc'.tr,
          },
          {
            "name": "Jinnah Postgraduate Medical Centre (JPMC)",
            "icon": Icons.local_hospital,
            "url": "https://www.jpmc.edu.pk/",
            "phone": "02199201300",
            "description": 'hosp_jpmc_desc'.tr,
          },
        ],
      };

  void _showSpecialtyHospitals(String title, List<Map<String, dynamic>> list) {
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
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final item = list[index];
                        final accent = kCardPalette[index % kCardPalette.length];
                        final String? phone = item["phone"];
                        final String? url = item["url"];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
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
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (phone != null)
                                    IconButton(
                                      icon: const Icon(Icons.call, color: Colors.green),
                                      onPressed: () => _callNumber(phone),
                                    ),
                                  if (url != null)
                                    IconButton(
                                      icon: Icon(Icons.open_in_new, color: accent),
                                      onPressed: () => _launchURL(url),
                                    ),
                                ],
                              ),
                            ),
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
  // Private hospitals - online appointment booking
  // ---------------------------------------------------------------------

  List<Map<String, dynamic>> get privateHospitals => [
        {
          "name": "Aga Khan University Hospital",
          "icon": Icons.local_hospital,
          "url": "https://hospitals.aku.edu/pakistan/Pages/default.aspx",
          "phone": "02111911911",
          "description": 'hosp_akuh_book_desc'.tr,
        },
        {
          "name": "Liaquat National Hospital",
          "icon": Icons.local_hospital,
          "url": "https://www.lnh.edu.pk/",
          "phone": "02111456456",
          "description": 'hosp_lnh_book_desc'.tr,
        },
        {
          "name": "Saifee Hospital",
          "icon": Icons.local_hospital,
          "url": "https://www.saifeehospital.com.pk/",
          "phone": "02136789400",
          "description": 'hosp_saifee_book_desc'.tr,
        },
        {
          "name": "Patel Hospital",
          "icon": Icons.local_hospital,
          "url": "https://patel-hospital.org.pk/",
          "phone": "021111174174",
          "description": 'hosp_patel_book_desc'.tr,
        },
      ];

  void _showPrivateHospitals() {
    _showSpecialtyHospitals('book_an_appointment'.tr, privateHospitals);
  }

  // ---------------------------------------------------------------------
  // Government (free) hospitals
  // ---------------------------------------------------------------------

  List<Map<String, dynamic>> get governmentHospitals => [
        {
          "name": "Dr. Ruth K.M. Pfau Civil Hospital Karachi",
          "icon": Icons.account_balance,
          "url": "https://chk.gov.pk/",
          "phone": "02199215740",
          "description": 'hosp_civil_gov_desc'.tr,
        },
        {
          "name": "Jinnah Postgraduate Medical Centre (JPMC)",
          "icon": Icons.account_balance,
          "url": "https://www.jpmc.edu.pk/",
          "phone": "02199201300",
          "description": 'hosp_jpmc_gov_desc'.tr,
        },
        {
          "name": "SIUT - Kidney & Urology (Free)",
          "icon": Icons.account_balance,
          "url": "https://siut.org/",
          "phone": "0219215752",
          "description": 'hosp_siut_gov_desc'.tr,
        },
        {
          "name": "NICVD - Heart Care (Free)",
          "icon": Icons.account_balance,
          "url": "https://www.nicvd.org/",
          "phone": "021111167167",
          "description": 'hosp_nicvd_gov_desc'.tr,
        },
      ];

  void _showGovernmentHospitals() {
    _showSpecialtyHospitals('free_government_hospitals'.tr, governmentHospitals);
  }

  // ---------------------------------------------------------------------
  // Service list data (drives the professional ListTile cards below)
  // ---------------------------------------------------------------------

  List<Map<String, dynamic>> get _services => [
        {
          "title": 'service_nearby_hospital_title'.tr,
          "subtitle": 'service_nearby_hospital_subtitle'.tr,
          "icon": Icons.local_hospital,
          "onTap": () => _openNearbySearch('hospital'),
        },
        {
          "title": 'service_24hr_hospital_title'.tr,
          "subtitle": 'service_24hr_hospital_subtitle'.tr,
          "icon": Icons.access_time,
          "onTap": () => _openNearbySearch('24 hour hospital'),
        },
        {
          "title": 'service_kidney_care_title'.tr,
          "subtitle": 'service_kidney_care_subtitle'.tr,
          "icon": Icons.water_drop,
          "onTap": () => _showSpecialtyHospitals(
              'category_kidney_care'.tr, specialtyHospitals["Kidney Care"]!),
        },
        {
          "title": 'service_cancer_care_title'.tr,
          "subtitle": 'service_cancer_care_subtitle'.tr,
          "icon": Icons.healing,
          "onTap": () => _showSpecialtyHospitals(
              'category_cancer_care'.tr, specialtyHospitals["Cancer Care"]!),
        },
        {
          "title": 'service_heart_care_title'.tr,
          "subtitle": 'service_heart_care_subtitle'.tr,
          "icon": Icons.favorite,
          "onTap": () => _showSpecialtyHospitals(
              'category_heart_care'.tr, specialtyHospitals["Heart Care"]!),
        },
        {
          "title": 'service_other_important_title'.tr,
          "subtitle": 'service_other_important_subtitle'.tr,
          "icon": Icons.local_hospital,
          "onTap": () => _showSpecialtyHospitals(
              'category_other_important'.tr, specialtyHospitals["Other Important"]!),
        },
        {
          "title": 'service_book_appointment_title'.tr,
          "subtitle": 'service_book_appointment_subtitle'.tr,
          "icon": Icons.event_available,
          "onTap": _showPrivateHospitals,
        },
        {
          "title": 'service_free_gov_hospitals_title'.tr,
          "subtitle": 'service_free_gov_hospitals_subtitle'.tr,
          "icon": Icons.account_balance,
          "onTap": _showGovernmentHospitals,
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

      // App bar style - taken directly from the Blood Bank screen: Deep
      // Teal, rounded bottom corners, logo + title, and a circular back
      // button. Color unchanged.
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
                      'hospital_services'.tr,
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
                  const Icon(Icons.local_hospital, color: Colors.white, size: 32),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'hospital_page_banner'.tr,
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

            _SectionHeader(title: 'hospital_services'.tr),
            const SizedBox(height: 6),
            Text(
              'hospital_services_subtitle'.tr,
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