import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

// Color theme matched to Police Options / User Dashboard for a consistent look
const Color kPrimary = Color(0xFF0F4C5C);
const Color kPrimaryLight = Color(0xFF16697A);
const Color kPageBackground = Color(0xFFF5F7F8);

class HelplineOptions extends StatefulWidget {
  const HelplineOptions({super.key});

  @override
  State<HelplineOptions> createState() => _HelplineOptionsState();
}

class _HelplineOptionsState extends State<HelplineOptions> {
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
      _showSnack('msg_no_official_website'.tr);
      return;
    }

    // Ensure website has proper protocol
    String finalUrl = website;
    if (!finalUrl.startsWith('http://') && !finalUrl.startsWith('https://')) {
      finalUrl = 'https://$finalUrl';
    }

    final Uri url = Uri.parse(finalUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
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
  // Data
  // (getters, not final fields, so they re-read the current locale's
  // strings every time the widget rebuilds after a language switch)
  // ---------------------------------------------------------------------

  List<Map<String, dynamic>> get helplines => [
        {
          "category": 'category_trauma_centers'.tr,
          "icon": Icons.emergency_rounded,
          "numbers": [
            {"name": 'helpline_civil_hospital_trauma'.tr, "number": "02199215740"},
            {"name": 'helpline_jpmc_emergency'.tr, "number": "99201300"},
            {"name": 'helpline_rescue_1122_road'.tr, "number": "1122"},
          ]
        },
        {
          "category": 'category_mental_health'.tr,
          "icon": Icons.self_improvement_rounded,
          "numbers": [
            {"name": 'helpline_umang'.tr, "number": "03117786264"},
            {"name": 'helpline_taskeen'.tr, "number": "03168275336"},
            {"name": 'helpline_national_youth'.tr, "number": "080069457"},
          ]
        },
        {
          "category": 'category_pet_animal_safety'.tr,
          "icon": Icons.pets_rounded,
          "numbers": [
            {"name": 'helpline_acf_animal_rescue'.tr, "number": "02111122311"},
            {"name": 'helpline_edhi_animal_shelter'.tr, "number": "115"},
          ]
        },
      ];

  // Detailed ambulance service directory with REAL working websites.
  // Organisation names are proper nouns and stay untranslated; the
  // description and detail bullets are localized.
  List<_AmbulanceService> get _ambulanceServices => [
        _AmbulanceService(
          name: 'Edhi Foundation',
          number: '115',
          website: 'https://www.edhi.org/ambulance',
          colors: const [Color(0xFFC62828), Color(0xFFEF5350)],
          icon: Icons.emergency_share_rounded,
          description: 'amb_edhi_desc'.tr,
          details: [
            'amb_edhi_detail1'.tr,
            'amb_edhi_detail2'.tr,
            'amb_edhi_detail3'.tr,
          ],
        ),
        _AmbulanceService(
          name: 'Chhipa Ambulance',
          number: '1020',
          website: 'https://www.chhipa.org/services/chhipa-ambulance/',
          colors: const [Color(0xFF2E7D32), Color(0xFF66BB6A)],
          icon: Icons.local_shipping_rounded,
          description: 'amb_chhipa_desc'.tr,
          details: [
            'amb_chhipa_detail1'.tr,
            'amb_chhipa_detail2'.tr,
            'amb_chhipa_detail3'.tr,
          ],
        ),
        _AmbulanceService(
          name: 'Aman Foundation',
          number: '1021',
          website: 'https://amanfoundation.org/',
          colors: const [Color(0xFF1565C0), Color(0xFF42A5F5)],
          icon: Icons.medical_services_rounded,
          description: 'amb_aman_desc'.tr,
          details: [
            'amb_aman_detail1'.tr,
            'amb_aman_detail2'.tr,
            'amb_aman_detail3'.tr,
          ],
        ),
        _AmbulanceService(
          name: 'Pakistan Red Crescent',
          number: '1030',
          website: 'https://prcsindh.org.pk/',
          colors: const [Color(0xFFB71C1C), Color(0xFFE53935)],
          icon: Icons.add_circle_rounded,
          description: 'amb_redcrescent_desc'.tr,
          details: [
            'amb_redcrescent_detail1'.tr,
            'amb_redcrescent_detail2'.tr,
            'amb_redcrescent_detail3'.tr,
          ],
        ),
      ];

  // ---------------------------------------------------------------------
  // Ambulance service detail sheet
  // ---------------------------------------------------------------------

  void _showAmbulanceDetails(_AmbulanceService service) {
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
                          gradient: LinearGradient(colors: service.colors),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(service.icon, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1B1B1B),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${'helpline_colon'.tr} ${service.number}',
                              style: TextStyle(
                                color: service.colors.first,
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
                    service.description,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...service.details.map(
                    (point) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.circle, size: 7, color: service.colors.first),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              point,
                              style: const TextStyle(fontSize: 13.5, height: 1.4),
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
                            callNumber(service.number);
                          },
                          icon: const Icon(Icons.call, color: Colors.white),
                          label: Text('call_now'.tr),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimary,
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
                            openWebsite(service.website);
                          },
                          icon: Icon(Icons.public_rounded, color: kPrimary),
                          label: Text('website'.tr),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: kPrimary,
                            side: BorderSide(color: kPrimary),
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

      // -------------------------------------------------------------
      // App bar — same curved, logo + title + back-button style as
      // the Police Options screen for a consistent look across the app.
      // -------------------------------------------------------------
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
                      'helpline_center'.tr,
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
                  const Icon(Icons.support_agent_rounded, color: Colors.white, size: 32),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'helpline_page_banner'.tr,
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

            const SizedBox(height: 24),
            _SectionHeader(title: 'ambulance_services'.tr),
            const SizedBox(height: 6),
            Text(
              'ambulance_services_subtitle'.tr,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12.5),
            ),
            const SizedBox(height: 12),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _ambulanceServices.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.05,
              ),
              itemBuilder: (context, index) {
                final service = _ambulanceServices[index];
                return _AmbulanceCard(
                  service: service,
                  onTap: () => _showAmbulanceDetails(service),
                );
              },
            ),

            const SizedBox(height: 24),
            _SectionHeader(title: 'helplines_by_category'.tr),
            const SizedBox(height: 10),

            /// HELPLINES - Only Trauma Centers, Mental Health, and Pet/Animal Safety
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: helplines.length,
              itemBuilder: (context, index) {
                final category = helplines[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 2,
                  child: ExpansionTile(
                    shape: const RoundedRectangleBorder(side: BorderSide.none),
                    leading: Icon(category["icon"] as IconData, color: kPrimary),
                    title: Text(
                      category["category"] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    children: [
                      ...List.generate((category["numbers"] as List).length, (i) {
                        final item = category["numbers"][i];

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 1,
                              ),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: kPrimary.withOpacity(0.1),
                                child: Icon(
                                  Icons.call,
                                  color: kPrimary,
                                  size: 20,
                                ),
                              ),
                              title: Text(
                                item["name"],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                item["number"],
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              trailing: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kPrimary,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                ),
                                onPressed: () => callNumber(item["number"]),
                                child: Text('call'.tr),
                              ),
                            ),
                          ),
                        );
                      })
                    ],
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
// Data model
// ---------------------------------------------------------------------

class _AmbulanceService {
  final String name;
  final String number;
  final String website;
  final List<Color> colors;
  final IconData icon;
  final String description;
  final List<String> details;

  _AmbulanceService({
    required this.name,
    required this.number,
    required this.website,
    required this.colors,
    required this.icon,
    required this.description,
    required this.details,
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

/// Colour-coded card for a single ambulance provider (Edhi, Chhipa, Aman,
/// Red Crescent). Tapping opens a sheet with Call + Website.
class _AmbulanceCard extends StatelessWidget {
  final _AmbulanceService service;
  final VoidCallback onTap;

  const _AmbulanceCard({required this.service, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shadowColor: service.colors.first.withOpacity(0.4),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: service.colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Icon(service.icon, color: Colors.white, size: 22),
              ),
              const Spacer(),
              Text(
                service.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.5,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.call, color: Colors.white, size: 13),
                  const SizedBox(width: 4),
                  Text(
                    service.number,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  const Icon(Icons.public_rounded, color: Colors.white70, size: 12),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      service.website.isEmpty ? 'no_website_listed'.tr : 'visit_website'.tr,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white70, fontSize: 10.5),
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