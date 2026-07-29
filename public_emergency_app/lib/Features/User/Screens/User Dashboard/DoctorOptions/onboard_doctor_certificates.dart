import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Simple data model for a doctor's onboarding record.
class DoctorCertificate {
  final String name;
  final String specialization;
  final String hospital;
  final String imageAsset; // profile photo, fallback to icon if missing
  final String certificateImagePath; // bundled PNG certificate path
  final bool isVerified;

  const DoctorCertificate({
    required this.name,
    required this.specialization,
    required this.hospital,
    required this.imageAsset,
    required this.certificateImagePath,
    this.isVerified = false,
  });
}

class OnboardDoctorCertificatesPage extends StatelessWidget {
  const OnboardDoctorCertificatesPage({Key? key}) : super(key: key);

  
  static final List<DoctorCertificate> _doctors = [
    const DoctorCertificate(
      name: "Samroze Hashmi",
      specialization: "Nurse Practitioner (NP)",
      hospital: "Aga Khan University Hospital",
      imageAsset: "assets/doctors/doctor1.png",
      certificateImagePath: "assets/certificates/samroze_hashmi.png",
      isVerified: true,
    ),
    const DoctorCertificate(
      name: "Dr. Sidrat UL Muntaha",
      specialization: "Physiotherapist (PT)",
      hospital: "Private Clinic",
      imageAsset: "assets/doctors/doctor2.png",
      certificateImagePath: "assets/certificates/sidrat_ul_muntaha.png",
      isVerified: true,
    ),
    const DoctorCertificate(
      name: "Dr. Asif Ali Khawaja",
      specialization: "MBBS, Vascular & Endovascular Surgeon",
      hospital: "The Sindh Institute of Urology & Transplantation (SIUT)",
      imageAsset: "assets/doctors/doctor3.png",
      certificateImagePath: "assets/certificates/asif_ali_khowaja.png",
      isVerified: true,
    ),
    const DoctorCertificate(
      name: "Dr. Abrar konchwala",
      specialization: "Dentist",
      hospital: "konchwala Dental Clinic",
      imageAsset: "assets/doctors/doctor4.png",
      certificateImagePath: "assets/certificates/abrar_konchwala.png",
      isVerified: true,
    ),
    const DoctorCertificate(
      name: "Dr. Ambreen Khawaja",
      specialization: "Gynecologist",
      hospital: "JPMC Hospital",
      imageAsset: "assets/doctors/doctor5.png",
      certificateImagePath: "assets/certificates/ambreen_khawaja.png",
      isVerified: true,
    ),
    const DoctorCertificate(
      name: "Dr. Anum",
      specialization: "General Physician",
      hospital: "UT South Western Medical Center Dallas TX",
      imageAsset: "assets/doctors/doctor6.png",
      certificateImagePath: "assets/certificates/Anum.png",
      isVerified: true,
    ),
  ];

  /// Pushes a full-screen viewer showing the doctor's certificate image
  /// (pinch-to-zoom enabled via InteractiveViewer).
  void _openCertificate(BuildContext context, DoctorCertificate doc) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _CertificateImageViewerPage(
          title: doc.name,
          imagePath: doc.certificateImagePath,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = Get.height * 0.12 + kToolbarHeight;
    final double iconHeight = Get.height * 0.09;
    final double buttonSize = 44;

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
                    const Text(
                      "Verified Partner Doctor",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF6A4C93).withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF6A4C93).withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6A4C93).withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.local_hospital_rounded,
                      color: Color(0xFF6A4C93),
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      "These doctors are officially associated with our platform and have signed the required agreement.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _doctors.isEmpty
                  ? const Center(
                      child: Text(
                        "No certificates uploaded yet.",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemCount: _doctors.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        final doc = _doctors[index];
                        return _DoctorCard(
                          doctor: doc,
                          onViewCertificate: () => _openCertificate(context, doc),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Simple in-app viewer for a doctor's certificate image (pinch/zoom).
class _CertificateImageViewerPage extends StatelessWidget {
  final String title;
  final String imagePath;

  const _CertificateImageViewerPage({required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F4C5C),
        foregroundColor: Colors.white,
        title: Text("$title's Certificate"),
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.8,
          maxScale: 4,
          child: Image.asset(
            imagePath,
            errorBuilder: (_, __, ___) => const Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                "Certificate image not found.",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DoctorCard extends StatelessWidget {
  final DoctorCertificate doctor;
  final VoidCallback onViewCertificate;

  const _DoctorCard({
    required this.doctor,
    required this.onViewCertificate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile avatar
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFF0F4C5C).withOpacity(0.1),
            backgroundImage: AssetImage(doctor.imageAsset),
            onBackgroundImageError: (_, __) {},
            child: Image.asset(
              doctor.imageAsset,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.person_rounded,
                color: Color(0xFF0F4C5C),
                size: 30,
              ),
              width: 0,
              height: 0,
            ),
          ),
          const SizedBox(width: 14),
          // Doctor details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        doctor.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: doctor.isVerified
                            ? Colors.green.withOpacity(0.12)
                            : Colors.orange.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            doctor.isVerified
                                ? Icons.verified_rounded
                                : Icons.hourglass_top_rounded,
                            size: 13,
                            color: doctor.isVerified ? Colors.green : Colors.orange,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            doctor.isVerified ? "Verified" : "Pending",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: doctor.isVerified ? Colors.green.shade700 : Colors.orange.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.medical_services_outlined, size: 14, color: Color(0xFF6A4C93)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        doctor.specialization,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF6A4C93),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.apartment_rounded, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        doctor.hospital,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Certificate button
                InkWell(
                  onTap: onViewCertificate,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F4C5C).withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.image_rounded, size: 16, color: Color(0xFF0F4C5C)),
                        SizedBox(width: 6),
                        Text(
                          "View Certificate",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0F4C5C),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}