import 'package:get/get.dart';

/// Central place for ALL translatable strings in the app.
/// Add a new key here every time you add a new page's text,
/// then use it in the UI as: 'your_key'.tr
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          // Profile screen
          'profile': 'Profile',
          'logout_title': 'Logout?',
          'logout_confirm': 'Are you sure you want to log out?',
          'cancel': 'Cancel',
          'yes_logout': 'Yes, Logout',
          'service_history': 'Service History',
          'error': 'Error',
          'user_not_logged_in': 'User not logged in',

          // ---------- inside 'en_US': { ... } ----------
          
'please_log_in': 'Please log in',
'loading_dots': 'Loading...',
'address_not_available': 'Address not available',
'unable_to_fetch_address': 'Unable to fetch address',
 
'profile_personal_information': 'Personal Information',
'label_full_name': 'Full Name',
'label_email_address': 'Email Address',
'label_address': 'Address',
'label_phone_number': 'Phone Number',
 
'update_password': 'Update Password',
'update_password_subtitle': 'Enter your current and new password',
'current_password': 'Current Password',
'new_password': 'New Password',
'confirm_password': 'Confirm Password',
'update': 'Update',
 
'confirm_password_change_title': 'Confirm Password Change?',
'confirm_password_change_msg': 'Are you sure you want to change your password?',
'yes_update': 'Yes, Update',
 
'success': 'Success',
'success_password_updated': 'Password updated successfully!',
 
'err_enter_current_password': 'Please enter your current password',
'err_new_password_length': 'New password must be at least 6 characters long',
'err_new_password_same': 'New password must be different from current password',
'err_passwords_mismatch': 'Passwords do not match',
'err_not_logged_in': 'You are not logged in. Please log in again.',
'err_wrong_password': 'Current password is incorrect',
'err_requires_recent_login': 'Please log out and log in again, then try updating your password.',
'err_too_many_requests': 'Too many attempts. Please wait and try again later.',
'err_weak_password': 'New password is too weak. Use at least 6 characters.',
'err_user_not_found': 'User not found. Please log in again.',
'err_user_disabled': 'User account is disabled. Contact support.',
'err_network_request_failed': 'Network error. Please check your internet connection.',
'err_unexpected': 'An unexpected error occurred. Please try again.',
 

          // Dashboard grid items
          'police': 'Police',
          'emergency_police': 'Emergency Police',
          'fire_brigade': 'Fire Brigade',
          'emergency_fire_brigade': 'Emergency Fire Brigade',
          'pharmacy': 'Pharmacy',
          'emergency_pharmacy': 'Emergency Pharmacy',
          'hospitals': 'Hospitals',
          'emergency_hospitals': 'Emergency Hospitals',
          'blood_bank': 'Blood Bank',
          'emergency_blood_services': 'Emergency Blood Services',
          'helpline': 'Helpline',
          'emergency_helpline': 'Emergency Helpline',
          'service_not_available': 'Service not available',

          // Police page (older sample keys - some superseded by the
          // full Police Options page keys further below)
          'pharmacy_services_subtitle': 'Access trusted pharmacies and essential medications anytime.',
          'women_police_station': 'Women Police Station',
          'traffic_police': 'Traffic Police',
          'specialised_police_wings': 'Specialised Police Wings',
          'police_station_map_display': 'Police Station Map Display',
          'find_nearest_police_station': 'Find the nearest police station on the map',
          'call_police_helpline': 'Call Police Station Helpline',
          'call_police_helpline_sub': 'Directly call the police station helpline (15)',

          // Fire / Pharmacy / Hospital / Blood bank / Helpline sections
          'medical_fire_rescue': 'Medical, fire & rescue emergencies',
          'pharmacy_services': 'Pharmacy Services',
          'hospital_services': 'Hospital Services',
          'helplines_by_category': 'Helplines by Category',
          'blood_bank_services': 'Blood Bank Services',
          'find_fire_station': 'Find Fire Station',
          'nearby_fire_hydrants': 'Nearby Fire Hydrants',

          // Dashboard page
          'dashboard': 'Dashboard',
          'arb_medical_centre': 'ARB Medical Centre',
          'haseen_habib_foundation_trust': 'Haseen Habib Foundation Trust',
          'onboard_doctor': 'Onboard Doctor',
          'connect_with_doctor_instantly': 'Connect with a doctor instantly',
          'location_permission_denied': 'Location permission denied',
          'failed_to_load_weather': 'Failed to load weather data',
          'error_fetching_weather': 'Error fetching weather',

          // ---------------- Fire Fighter screen ----------------
          'fire_page_banner': 'Your complete fire safety guide. Learn, prepare, and stay safe.',
          'emergency_contacts': 'Emergency Contacts',
          'quick_actions': 'Quick Actions',
          'safety_guides': 'Safety Guides',
          'safety_guides_subtitle': 'Learn essential fire safety tips and procedures.',
          'safety_tips': 'Safety Tips',
          'buy_equipment': 'Buy Equipment',
          'fire_safety_tips': 'Fire Safety Tips',
          'fire_safety_products': 'Fire Safety Products',

          // Emergency contact names
          'fire_department': 'Call Fire Department',
          'rescue_1122': 'Rescue 1122',
          'ambulance': 'Ambulance',

          // Guide titles
          'guide_fire_title': 'What to do during a fire',
          'guide_extinguisher_title': 'How to use a fire extinguisher (PASS)',
          'guide_burn_title': 'Burn first aid',
          'guide_evacuation_title': 'Safe evacuation checklist',
          'guide_gas_leak_title': 'Gas leak safety instructions',

          // Guide 1: What to do during a fire
          'guide_fire_step1': '1. Stay calm and act quickly',
          'guide_fire_step2': '2. Alert everyone in the building',
          'guide_fire_step3': '3. Evacuate immediately using the nearest exit',
          'guide_fire_step4': '4. Do not use elevators - use stairs',
          'guide_fire_step5': '5. Crawl low under smoke to avoid inhalation',
          'guide_fire_step6': '6. Feel doors with the back of your hand before opening',
          'guide_fire_step7': '7. If trapped, seal doors with wet towels and call for help',
          'guide_fire_step8': '8. Once outside, stay out and call 16',
          'guide_fire_step9': '9. Never re-enter a burning building',

          // Guide 2: PASS
          'guide_extinguisher_step1': 'P - Pull the pin at the top of the extinguisher',
          'guide_extinguisher_step2': 'A - Aim the nozzle at the base of the fire',
          'guide_extinguisher_step3': 'S - Squeeze the handle slowly and evenly',
          'guide_extinguisher_step4': 'S - Sweep the nozzle from side to side',
          'guide_extinguisher_step5': 'Always keep a safe distance from the fire',
          'guide_extinguisher_step6': 'Test the extinguisher before approaching the fire',
          'guide_extinguisher_step7': 'Only use on small, contained fires',
          'guide_extinguisher_step8': 'Evacuate if the fire is too large or spreading',

          // Guide 3: Burn first aid
          'guide_burn_step1': '1. Stop the burning process (remove from heat source)',
          'guide_burn_step2': '2. Cool the burn with running cool water for 20 minutes',
          'guide_burn_step3': '3. Remove any clothing or jewelry near the burn',
          'guide_burn_step4': '4. Cover the burn with a sterile, non-adhesive dressing',
          'guide_burn_step5': '5. Do not apply ice, butter, or creams to the burn',
          'guide_burn_step6': '6. Do not break any blisters that form',
          'guide_burn_step7': '7. Seek medical attention for serious burns',
          'guide_burn_step8': '8. For chemical burns, flush with water for 30 minutes',
          'guide_burn_step9': '9. Keep the person warm to prevent hypothermia',

          // Guide 4: Safe evacuation checklist
          'guide_evacuation_step1': '✓ Know two ways out of every room',
          'guide_evacuation_step2': '✓ Keep exits clear of furniture and debris',
          'guide_evacuation_step3': '✓ Have a designated meeting point outside',
          'guide_evacuation_step4': '✓ Practice your evacuation plan regularly',
          'guide_evacuation_step5': '✓ Keep a flashlight and whistle near your bed',
          'guide_evacuation_step6': '✓ Know how to open windows and doors easily',
          'guide_evacuation_step7': '✓ Stay low to the ground while evacuating',
          'guide_evacuation_step8': '✓ Close doors behind you to slow fire spread',
          'guide_evacuation_step9': '✓ Never use elevators during a fire',

          // Guide 5: Gas leak safety instructions
          'guide_gas_leak_step1': '1. Do not use any electrical switches or appliances',
          'guide_gas_leak_step2': '2. Do not use phones or flashlights near the leak',
          'guide_gas_leak_step3': '3. Open all doors and windows immediately',
          'guide_gas_leak_step4': '4. Turn off the main gas supply valve if safe',
          'guide_gas_leak_step5': '5. Evacuate everyone from the building',
          'guide_gas_leak_step6': '6. Do not smoke or use any open flames',
          'guide_gas_leak_step7': '7. Call the gas company emergency line',
          'guide_gas_leak_step8': '8. Wait outside until the area is declared safe',
          'guide_gas_leak_step9': '9. Do not re-enter the building until cleared',

          // Safety tips (quick-action sheet)
          'tip_smoke_detectors_title': 'Install Smoke Detectors',
          'tip_smoke_detectors_desc': 'Install smoke detectors on every floor and test them monthly.',
          'tip_fire_extinguisher_title': 'Keep Fire Extinguisher',
          'tip_fire_extinguisher_desc': 'Keep a fire extinguisher in the kitchen and know how to use it.',
          'tip_escape_routes_title': 'Plan Escape Routes',
          'tip_escape_routes_desc': 'Have at least two escape routes from every room in your home.',
          'tip_electrical_wiring_title': 'Check Electrical Wiring',
          'tip_electrical_wiring_desc': 'Regularly check electrical wiring for damage or overheating.',
          'tip_flammables_title': 'Store Flammables Safely',
          'tip_flammables_desc': 'Store gasoline, paint, and other flammables in approved containers.',
          'tip_kitchen_safety_title': 'Kitchen Safety',
          'tip_kitchen_safety_desc': 'Never leave cooking unattended and keep a lid nearby to smother fires.',

          // Buy Equipment - product website descriptions (names stay as brand names)
          'product_daraz_desc': 'Fire extinguishers, alarms, and safety equipment in Pakistan',
          'product_amazon_desc': 'International fire safety products with wide selection',
          'product_alibaba_desc': 'Wholesale fire safety equipment from global suppliers',
          'product_ebay_desc': 'New and used fire safety gear from many sellers',

          // Snackbar / status messages
          'msg_could_not_start_call': 'Could not start the call',
          'msg_no_website_listed': 'No website is listed',
          'msg_could_not_open_website': 'Could not open the website',
          'msg_unable_to_get_location': 'Unable to get location. Opening maps...',
          'msg_could_not_open_maps': 'Could not open maps',
          'msg_platform_not_supported': 'Platform not supported',

          // ---------------- Helpline screen ----------------
          'helpline_center': 'Helpline Center',
          'helpline_page_banner':
              "All emergency, medical, and support helplines in one place — tap any card to call, or open a service's website.",
          'ambulance_services': 'Ambulance Services',
          'ambulance_services_subtitle': 'Tap a service to call its helpline or visit its website.',
          'msg_no_official_website': 'No official website is listed for this service',
          'call_now': 'Call Now',
          'website': 'Website',
          'call': 'Call',
          'helpline_colon': 'Helpline:',
          'no_website_listed': 'No website listed',
          'visit_website': 'Visit website',

          // Helpline categories
          'category_trauma_centers': 'Trauma Centers',
          'category_mental_health': 'Mental Health Support',
          'category_pet_animal_safety': 'Pet & Animal Safety',

          // Helpline entries
          'helpline_civil_hospital_trauma': 'Civil Hospital Karachi Trauma Centre',
          'helpline_jpmc_emergency': 'JPMC Accident & Emergency',
          'helpline_rescue_1122_road': 'Rescue 1122 (Road Accidents)',
          'helpline_umang': 'Umang Mental Health Helpline',
          'helpline_taskeen': 'Taskeen Helpline',
          'helpline_national_youth': 'National Youth Helpline',
          'helpline_acf_animal_rescue': 'ACF Animal Rescue',
          'helpline_edhi_animal_shelter': 'Edhi Animal Shelter',

          // Ambulance services (org names stay untranslated - proper nouns)
          'amb_edhi_desc':
              "The world's largest volunteer-run ambulance network, operating the largest private fleet of ambulances in Pakistan, plus an air ambulance service for disaster response.",
          'amb_edhi_detail1': 'Free 24/7 land ambulance service covering Karachi and most major cities.',
          'amb_edhi_detail2': 'Also runs an air ambulance service with planes and a helicopter for emergencies.',
          'amb_edhi_detail3': 'Funded entirely by public donations, with no government funding accepted.',

          'amb_chhipa_desc':
              'Chhipa Welfare Association runs the second largest ambulance network in Pakistan, with vehicles stationed at road roundabouts and near government hospitals.',
          'amb_chhipa_detail1': 'Over 500 ambulances stationed across Karachi and other regions.',
          'amb_chhipa_detail2': 'First responder to major incidents such as bomb blasts, fires, and building collapses.',
          'amb_chhipa_detail3': 'Ambulances are fully equipped with first aid boxes and oxygen cylinders.',

          'amb_aman_desc':
              "Aman Foundation's ambulance service, later expanded through Sindh Integrated Emergency & Health Services, offers home-to-hospital emergency transport across Karachi.",
          'amb_aman_detail1': 'Provides free patient transfers between home and hospital.',
          'amb_aman_detail2': 'Operated in partnership with the Sindh government in several areas.',
          'amb_aman_detail3': 'Focused on improving ambulance coverage in underserved parts of the city.',

          'amb_redcrescent_desc':
              "Pakistan's national Red Crescent society, providing emergency medical response and disaster relief since 1947 as part of the global Red Cross and Red Crescent movement.",
          'amb_redcrescent_detail1': 'Provides emergency medical and relief services during natural and man-made disasters.',
          'amb_redcrescent_detail2': 'Runs first aid training programs and blood donation drives nationwide.',
          'amb_redcrescent_detail3': 'Operates provincial branches across Pakistan, including Sindh and Karachi.',

          // ---------------- Blood Bank screen ----------------
          'msg_could_not_open_link': 'Could not open link',
          'msg_could_not_place_call': 'Could not place call',
          'blood_donation_availability': 'Blood Donation & Availability',
          'blood_bank_page_banner': 'Find blood banks, check live availability, and get emergency help fast.',
          'blood_bank_services_subtitle': 'Everything you need to find blood and get help fast.',

          // Donation website descriptions (names stay as brand/org names)
          'donation_sbta_desc': 'Sindh Blood Transfusion Authority - real-time blood availability near you',
          'donation_fatimid_desc': 'Thalassemia care and voluntary blood donation across Pakistan',
          'donation_indus_desc': 'Free blood transfusion services and donation drives',
          'donation_redcrescent_desc': 'Nationwide blood donation camps and emergency blood services',

          // Service list
          'service_nearby_blood_bank_title': 'Nearby Blood Bank',
          'service_nearby_blood_bank_subtitle': 'Find the nearest blood bank on the map',
          'service_emergency_helpline_subtitle': 'Call (021) 35650411 - free call for blood emergencies',
          'service_24hr_blood_bank_title': '24 Hours Blood Bank',
          'service_24hr_blood_bank_subtitle': 'Find blood banks open anytime',
          'service_realtime_availability_title': 'Real-Time Blood Availability & Donation',
          'service_realtime_availability_subtitle': 'Check live availability and verified donation sources',

          // ---------------- Hospital screen ----------------
          'hospital_page_banner': 'Find hospitals nearby, by specialty, or book an appointment fast.',
          'hospital_services_subtitle': 'Everything you need to find hospitals and get help fast.',

          // Specialty category titles (also used as modal sheet titles)
          'category_kidney_care': 'Kidney Care',
          'category_cancer_care': 'Cancer Care',
          'category_heart_care': 'Heart Care',
          'category_other_important': 'Other Important',
          'book_an_appointment': 'Book an Appointment',
          'free_government_hospitals': 'Free Government Hospitals',

          // Service list (drives the main ListTile cards)
          'service_nearby_hospital_title': 'Nearby Hospital',
          'service_nearby_hospital_subtitle': 'Find the nearest hospital on the map',
          'service_24hr_hospital_title': '24 Hours Hospital',
          'service_24hr_hospital_subtitle': 'Find hospitals open anytime',
          'service_kidney_care_title': 'Kidney Care Hospitals',
          'service_kidney_care_subtitle': '5 nephrology, dialysis and kidney transplant centers',
          'service_cancer_care_title': 'Cancer Care Hospitals',
          'service_cancer_care_subtitle': '5 oncology, chemotherapy and radiotherapy centers',
          'service_heart_care_title': 'Heart Care Hospitals',
          'service_heart_care_subtitle': '6 cardiology and emergency cardiac centers',
          'service_other_important_title': 'Other Important Hospitals',
          'service_other_important_subtitle': 'Major public hospitals for all specialties',
          'service_book_appointment_title': 'Book Appointment (Private Hospitals)',
          'service_book_appointment_subtitle': 'Aga Khan, Liaquat National, Saifee, Patel',
          'service_free_gov_hospitals_title': 'Free Government Hospitals',
          'service_free_gov_hospitals_subtitle': 'Website and call info for free public hospitals',

          // Kidney Care descriptions (hospital names stay untranslated - proper nouns)
          'hosp_siut_desc': 'Free kidney treatment, dialysis and transplant services, near Civil Hospital',
          'hosp_tkc_desc': 'Not-for-profit specialist hospital for dialysis, nephrology & transplant',
          'hosp_ckgh_desc': '24/7 dialysis unit with indoor medicine, surgery and emergency care',
          'hosp_mmi_desc': 'Chronic kidney disease management, dialysis and stone treatment',
          'hosp_kidneyfoundation_desc': 'Not-for-profit renal & urological diseases hospital, Karachi University',

          // Cancer Care descriptions
          'hosp_kiran_desc': 'Low-cost radiotherapy, chemotherapy and oncology care, Gulzar-e-Hijri',
          'hosp_shaukat_desc': 'Free & subsidized multi-modality cancer care, DHA City Karachi',
          'hosp_baitulsukoon_desc': "Pakistan's only free cancer hospital with hospice care",
          'hosp_ziauddin_desc': 'Radiotherapy, chemotherapy and dedicated oncology day care unit',
          'hosp_indus_cancer_desc': 'Completely free chemotherapy, radiation and diagnostic oncology services',

          // Heart Care descriptions
          'hosp_nicvd_desc': 'Free cardiac surgery, angioplasty and emergency heart care',
          'hosp_tabba_desc': "Karachi's leading dedicated cardiac hospital, 24/7 emergency",
          'hosp_ibneseena_desc': '200-bed general hospital with a dedicated cardiology department',
          'hosp_baqai_desc': 'Tertiary care hospital with angioplasty and cardiac surgery services',
          'hosp_southcity_desc': 'Cath Lab for angioplasty and invasive cardiology, Clifton',
          'hosp_pns_desc': '600-bed Navy hospital with cardiology and 24/7 emergency care',

          // Other Important descriptions
          'hosp_civil_desc': 'Large public tertiary care hospital, all specialties',
          'hosp_jpmc_desc': 'Major public hospital with 24/7 emergency services',

          // Private hospitals - booking descriptions
          'hosp_akuh_book_desc': 'Book appointments online - National Stadium Road, Karachi',
          'hosp_lnh_book_desc': 'Book appointments online - Stadium Road, Karachi',
          'hosp_saifee_book_desc': 'Book appointments online - North Nazimabad, Karachi',
          'hosp_patel_book_desc': 'Book appointments online - Gulshan-e-Iqbal, Karachi',

          // Free government hospitals descriptions
          'hosp_civil_gov_desc': 'Free public tertiary care hospital, all specialties',
          'hosp_jpmc_gov_desc': 'Free public hospital, 24/7 emergency services',
          'hosp_siut_gov_desc': 'Free dialysis, kidney and transplant treatment',
          'hosp_nicvd_gov_desc': 'Free cardiac emergency and surgery services',

          // ---------------- Police Options screen ----------------
          'police_options_title': 'Police Options',
          'police_page_banner': 'Reach the nearest police station or call the helpline instantly in an emergency.',
          'police_station_query': 'police station',

          'police_station_map_title': 'Police Station Map Display',
          'police_station_map_subtitle': 'Find the nearest police station on the map',
          'call_police_helpline_title': 'Call Police Station Helpline',
          'call_police_helpline_subtitle': 'Directly call the police station helpline (15)',

          'know_your_rights_safety': 'Know Your Rights & Safety',

          'helpline_label': 'Helpline',
          'find_nearest': 'Find Nearest',
          'notice_label': 'Notice',

          'msg_enable_location': 'Please enable location services to find nearby stations',
          'msg_location_permission_required': 'Location permission is required to show the map',
          'msg_location_permanently_denied': 'Location permission permanently denied. Enable it from app settings.',
          'msg_map_error': 'Something went wrong while fetching your location',
          'msg_could_not_open_map': 'Could not open the map',
          'msg_phone_permission_required': 'Phone permission is required to make a call',
          'msg_call_error': 'Something went wrong while placing the call',

          'wing_women_title': 'Women Police Station',
          'wing_women_subtitle': 'Support for women in distress',
          'wing_women_desc':
              'Handles complaints of domestic abuse, harassment and other crimes against women, staffed by female officers wherever available.',
          'wing_women_detail1':
              'Reachable through the national Police Helpline 15 — ask to be connected to the Women & Child Protection Cell.',
          'wing_women_detail2': 'You can request a female officer to record your statement.',
          'wing_women_detail3': 'Bring any evidence such as messages, photos, or medical reports if available.',

          'wing_child_title': 'Child Protection',
          'wing_child_subtitle': 'Reporting abuse or a missing child',
          'wing_child_desc':
              'Deals with cases of child abuse, exploitation, and missing or runaway children, working alongside the Child Protection Authority.',
          'wing_child_detail1': 'Report immediately — do not wait if a child is in danger or missing.',
          'wing_child_detail2': 'Provide a recent photo and description of the child if reporting a missing case.',
          'wing_child_detail3': 'Cases can also be escalated to the Sindh Child Protection Authority.',

          'wing_traffic_title': 'Traffic Police',
          'wing_traffic_subtitle': 'Accidents, violations & road help',
          'wing_traffic_desc':
              'Manages road accidents, traffic violations, license issues and congestion. Response numbers can vary by city — 15 will route you appropriately.',
          'wing_traffic_detail1': 'Note the location, vehicle numbers, and time if reporting an accident.',
          'wing_traffic_detail2': 'Keep your CNIC and vehicle documents ready when contacted.',
          'wing_traffic_detail3': 'For city-specific traffic helplines, check your local Traffic Police website.',

          'wing_bomb_title': 'Bomb Disposal Squad',
          'wing_bomb_subtitle': 'Suspicious objects or threats',
          'wing_bomb_desc':
              'A specialised unit dispatched through the police helpline to handle suspicious or unattended objects and explosive threats.',
          'wing_bomb_detail1': 'Never touch, move, or attempt to inspect a suspicious object yourself.',
          'wing_bomb_detail2': 'Evacuate the area calmly and keep others away.',
          'wing_bomb_detail3': 'Call 15 immediately and clearly describe the object and exact location.',

          'wing_rescue_title': 'Rescue Support',
          'wing_rescue_subtitle': 'Medical, fire & rescue emergencies',
          'wing_rescue_desc':
              'Rescue 1122 provides free pre-hospital emergency medical, fire, and rescue response across Sindh and most of Pakistan.',
          'wing_rescue_detail1': 'Available 24/7 nationwide by dialing 1122.',
          'wing_rescue_detail2': 'Stay on the line and clearly state the nature of the emergency and your location.',
          'wing_rescue_detail3': 'Used for medical emergencies, fires, road accidents, and building collapses.',

          'wing_cyber_title': 'Cyber Crime Wing',
          'wing_cyber_subtitle': 'Online harassment & fraud',
          'wing_cyber_desc':
              'The FIA/NCCIA Cyber Crime helpline handles online harassment, financial fraud, hacking, identity theft and defamation complaints.',
          'wing_cyber_detail1': 'Dial 1991 or file a complaint through the FIA Cyber Crime Wing website.',
          'wing_cyber_detail2': 'Save all evidence — screenshots, messages, and transaction records — before reporting.',
          'wing_cyber_detail3': 'Act quickly, as digital evidence can disappear fast.',

          'info_fir_title': 'FIR Filing Guide',
          'fir_point1':
              'You can register an FIR at any police station regardless of where the incident occurred — this is known as a Zero FIR, later transferred to the relevant station.',
          'fir_point2': 'Give a clear, factual account with the date, time, location, and people involved.',
          'fir_point3': 'Registering an FIR is completely free — no police official can charge you for it.',
          'fir_point4': 'Always ask for and keep a copy of the registered FIR.',
          'fir_point5':
              'If a station refuses to register your FIR, you can approach the SP office, the Provincial Police Officer complaint cell, or a magistrate.',

          'info_rights_title': 'Citizen Rights',
          'rights_point1': 'You have the right to be informed of the reason for your arrest.',
          'rights_point2': 'You have the right to legal counsel, including free legal aid where eligible.',
          'rights_point3':
              'You cannot be held in custody beyond the legal limit without being produced before a magistrate.',
          'rights_point4':
              'You have the right to file a complaint against police misconduct with the relevant oversight authority.',
          'rights_point5': 'You have the right to dignity and protection from mistreatment while in custody.',

          'info_safety_title': 'Safety Tips',
          'safety_point1':
              'Share your live location with a trusted contact when travelling alone, especially at night.',
          'safety_point2': 'Keep emergency numbers saved and easily accessible on your phone.',
          'safety_point3': 'Avoid isolated or poorly lit areas; stick to busy, well-known routes.',
          'safety_point4': 'Keep digital copies of important documents such as your CNIC and vehicle registration.',
          'safety_point5':
              'Trust your instincts — leave any situation that feels unsafe and seek help immediately.',

          'info_faq_title': 'Frequently Asked Questions',
          'faq_q1': 'Is there a fee to register an FIR?',
          'faq_a1': 'No, registering an FIR is completely free of cost at any police station.',
          'faq_q2': 'Can I file an FIR online?',
          'faq_a2':
              'Some provinces offer digital or online police station portals — check your provincial police website or app for availability.',
          'faq_q3': 'What if the police refuse to help me?',
          'faq_a3': 'You can escalate to a senior officer, the SP complaint cell, or contact the Provincial Police Officer helpline.',
          'faq_q4': 'Who do I contact for online harassment or fraud?',
          'faq_a4': 'Reach the FIA Cyber Crime Wing / NCCIA helpline at 1991.',
          'faq_q5': 'What number do I dial for a medical or fire emergency?',
          'faq_a5': 'Dial 1122 for Rescue Support anywhere in Sindh and most of Pakistan.',

          // ---------------- Pharmacy Options screen ----------------
          
          'pharmacy_page_banner': 'Find pharmacies, order medicine, and get medical help fast.',
          'trusted_online_pharmacies': 'Trusted Online Pharmacies',
          'browse_verified_pharmacy_platforms': 'Browse verified pharmacy and health platforms',

          'service_nearby_pharmacy_title': 'Nearby Pharmacy',
          'service_nearby_pharmacy_subtitle': 'Find the nearest pharmacy on the map',
          'service_24hr_pharmacy_title': '24/7 Pharmacy',
          'service_24hr_pharmacy_subtitle': 'Find pharmacies open anytime',

          // Pharmacy website descriptions (names stay as brand names)
          'pharmacy_dawaai_desc': 'Order medicines online with home delivery across Pakistan',
          'pharmacy_dvago_desc': "Pakistan's trusted pharmacy chain for authentic medicines",
          'pharmacy_servaid_desc': 'Largest pharmacy chain in Pakistan with online ordering',
          'pharmacy_instacare_desc': 'Online pharmacy with fast delivery and doctor consultations',
          'pharmacy_sehatkahani_desc': 'Online doctor consultations and health services',

              'msg_could_not_make_call': 'Could not make call',
          'msg_could_not_open_browser': 'Could not open browser. Please visit arbmedical.org.pk manually.',
 
          'arb_call_title': 'Call ARB Medical Centre',
          'arb_about_title': 'About ARB Medical Centre',
          'arb_about_desc':
              'The ARB Medical Centre, established by the Haseen Habib Foundation Trust and named in honor of the late Hafiz Ateeq-Ur-Rahman Barry, the esteemed founder of Haseen Habib with "ARB" serving as an abbreviation of his revered name, was officially inaugurated on December 2, 2024. This state-of-the-art facility is poised to become a valuable healthcare resource for surrounding communities, particularly in the lower localities adjacent to P.E.C.H.S, including Umar Colony, Baloch Colony, Mahmoodabad, Railway Line, Chanesar Halt, Azam Basti, and Manzoor Colony, among others.',
 
          'arb_certificate_title': 'Certificate',
          'arb_cert1_title': 'Certificate Technical Assistance',
          'arb_cert2_title': 'Certificate Authorization',
          'arb_cert_tap_instruction': 'Tap on any certificate to view',
          'arb_image_not_found': 'Image not found',
 
          'location_label': 'Location',
          'call_us_label': 'Call Us',
          'online_donation_label': 'Online Donation',
          'timing_label': 'Timing',
          'arb_timing_hours': 'Monday to Saturday • 9:00 AM – 5:00 PM',
          'arb_clinic_timings_title': 'Clinic Timings (OPD)',
 
          'arb_doctor1_role': 'General Surgeon + Urologist',
          'arb_doctor1_days': 'Saturday',
          'arb_doctor1_time': '10:00 AM to 11:00 AM',
          'arb_doctor2_role': "Pediatrician (Children's Doctor)",
          'arb_doctor2_days': 'Monday, Wednesday & Saturday',
          'arb_doctor2_time': '2:30 PM to 4:30 PM',
          'arb_doctor3_role': 'Psychologist (Psychotherapist)',
          'arb_doctor3_days': 'Thursday',
          'arb_doctor3_time': '10:00 AM to 1:00 PM',
 
          'arb_footer_honor': 'In honor of the late\nHafiz Ateeq-Ur-Rahman Barry',
          'arb_footer_subtitle': 'The esteemed founder of Haseen Habib Foundation Trust',

          // ---------------- Doctor Options screen ----------------
          'doctor_options_title': 'Doctor Options',
          'doctor_referrals_title': 'Doctor Referrals',
          'doctor_referrals_subtitle': 'View external doctors and specialists',
          'active_label': 'ACTIVE',
          'checking_label': 'Checking...',
          'doctor_button_hint':
              'Press the button to request a doctor. A doctor will be assigned shortly. Available during office hours only.',
          'checking_existing_requests': 'Checking for existing doctor requests...',
          'view_active_doctor': 'View Active Doctor',
          'dr_name': 'Dr. @name',
          'dr_name_profession': 'Dr. @name (@profession)',

          'loading_title': 'Loading',
          'checking_requests_please_wait': 'Checking for existing doctor requests... Please wait.',
          'active_doctor_session_title': 'Active Doctor Session',
          'active_doctor_session_msg': 'You already have an active doctor request. Please wait.',
          'too_fast_title': 'Too Fast!',
          'wait_seconds_msg': 'Please wait @seconds seconds before requesting again.',
          'please_wait_title': 'Please Wait',
          'request_already_processing': 'Your request is already being processed...',
          'failed_request_doctor': 'Failed to request doctor. Please try again.',

          'request_a_doctor_title': 'Request a Doctor',
          'doctor_assign_shortly': 'A doctor will be assigned to you shortly.',
          'confirm_request': 'Confirm Request',

          'doctor_assigned_title': 'Doctor Assigned!',
          'doctor_assigned_msg': 'Dr. @name has been assigned to you',
          'assigned_label': 'Assigned',
          'close_label': 'Close',

          'no_doctor_available_title': 'No Doctor Available',
          'no_doctor_available_msg': 'All doctors are currently busy or unavailable. Please try again later.',
          'ok_label': 'OK',

          'session_completed_title': 'Session Completed',
          'session_completed_msg': 'Session has been ended by Dr. @name',
          'doctor_unavailable_title': 'Doctor Unavailable',
          'doctor_unavailable_msg': 'Dr. @name is no longer available',

          // ---------------- Doctor List (Referrals) screen ----------------
          'book_free_consultation_title': 'Book a free consultation online',
          'trusted_platforms_subtitle': 'Trusted platforms to find and book doctors in Pakistan',
          'book_label': 'Book',

          // Referral site descriptions (names stay as brand names)
          'referral_oladoc_desc': 'Book appointments with top doctors across Pakistan.',
          'referral_marham_desc': '16,000+ verified doctors. Book or consult online.',
          'referral_dawaai_desc': 'Ask a Doctor — free chat consultation & appointments.',
          'referral_ddoctor_desc': 'Book doctors, hospitals, labs & clinics online.',
          'referral_healthwire_desc': 'Find & book verified doctors near you for free.',
          'referral_sehatkahani_desc': 'Video consultations with certified doctors.',
        },
        'ur_PK': {
          // Profile screen
          'profile': 'پروفائل',
          'logout_title': 'لاگ آؤٹ؟',
          'logout_confirm': 'کیا آپ واقعی لاگ آؤٹ کرنا چاہتے ہیں؟',
          'cancel': 'منسوخ کریں',
          'yes_logout': 'جی ہاں، لاگ آؤٹ کریں',
          'service_history': 'سروس ہسٹری',
          'error': 'خرابی',
          'user_not_logged_in': 'صارف لاگ ان نہیں ہے',

          // Dashboard grid items
          'police': 'پولیس',
          'emergency_police': 'ہنگامی پولیس',
          'fire_brigade': 'فائر بریگیڈ',
          'emergency_fire_brigade': 'ہنگامی فائر بریگیڈ',
          'pharmacy': 'فارمیسی',
          'emergency_pharmacy': 'ہنگامی فارمیسی',
          'hospitals': 'ہسپتال',
          'emergency_hospitals': 'ہنگامی ہسپتال',
          'blood_bank': 'بلڈ بینک',
          'emergency_blood_services': 'ہنگامی خون کی خدمات',
          'helpline': 'ہیلپ لائن',
          'emergency_helpline': 'ہنگامی ہیلپ لائن',
          'service_not_available': 'سروس دستیاب نہیں',

          // Police page (older sample keys)
          'women_police_station': 'ویمن پولیس اسٹیشن',
          'traffic_police': 'ٹریفک پولیس',
          'specialised_police_wings': 'خصوصی پولیس شعبے',
          'police_station_map_display': 'پولیس اسٹیشن نقشہ',
          'find_nearest_police_station': 'قریب ترین پولیس اسٹیشن نقشے پر تلاش کریں',
          'call_police_helpline': 'پولیس ہیلپ لائن پر کال کریں',
          'call_police_helpline_sub': 'پولیس اسٹیشن ہیلپ لائن پر براہ راست کال کریں (15)',

          // Fire / Pharmacy / Hospital / Blood bank / Helpline sections
          'medical_fire_rescue': 'طبی، آتشزدگی اور بچاؤ کی ہنگامی صورتحال',
          'pharmacy_services': 'فارمیسی خدمات',
          'hospital_services': 'ہسپتال کی خدمات',
          'helplines_by_category': 'قسم کے مطابق ہیلپ لائنز',
          'blood_bank_services': 'بلڈ بینک خدمات',
          'find_fire_station': 'فائر اسٹیشن تلاش کریں',
          'nearby_fire_hydrants': 'قریبی فائر ہائیڈرینٹس',

          // Dashboard page
          'dashboard': 'ڈیش بورڈ',
          'arb_medical_centre': 'اے آر بی میڈیکل سینٹر',
          'haseen_habib_foundation_trust': 'حسین حبیب فاؤنڈیشن ٹرسٹ',
          'onboard_doctor': 'آن بورڈ ڈاکٹر',
          'connect_with_doctor_instantly': 'فوری طور پر ڈاکٹر سے رابطہ کریں',
          'location_permission_denied': 'مقام کی اجازت مسترد',
          'failed_to_load_weather': 'موسم کا ڈیٹا لوڈ کرنے میں ناکامی',
          'error_fetching_weather': 'موسم حاصل کرنے میں خرابی',

          // ---------------- Fire Fighter screen ----------------
          'fire_page_banner': 'آپ کی مکمل آتشزدگی حفاظتی رہنمائی۔ سیکھیں، تیار رہیں اور محفوظ رہیں۔',
          'emergency_contacts': 'ہنگامی رابطہ نمبرز',
          'quick_actions': 'فوری اقدامات',
          'safety_guides': 'حفاظتی رہنمائیاں',
          'safety_guides_subtitle': 'آتشزدگی سے بچاؤ کے ضروری نکات اور طریقہ کار سیکھیں۔',
          'safety_tips': 'حفاظتی نکات',
          'buy_equipment': 'سامان خریدیں',
          'fire_safety_tips': 'آتشزدگی سے حفاظت کے نکات',
          'fire_safety_products': 'آتشزدگی سے حفاظت کی مصنوعات',

          // Emergency contact names
          'fire_department': 'فائر ڈیپارٹمنٹ کال',
          'rescue_1122': 'ریسکیو 1122',
          'ambulance': 'ایمبولینس',

          // Guide titles
          'guide_fire_title': 'آگ لگنے کی صورت میں کیا کریں',
          'guide_extinguisher_title': 'آگ بجھانے کا آلہ کیسے استعمال کریں (PASS)',
          'guide_burn_title': 'جلنے کی صورت میں ابتدائی طبی امداد',
          'guide_evacuation_title': 'محفوظ انخلاء کی چیک لسٹ',
          'guide_gas_leak_title': 'گیس لیک ہونے کی صورت میں حفاظتی ہدایات',

          // Guide 1: What to do during a fire
          'guide_fire_step1': '1۔ پرسکون رہیں اور فوری کارروائی کریں',
          'guide_fire_step2': '2۔ عمارت میں موجود تمام افراد کو خبردار کریں',
          'guide_fire_step3': '3۔ قریب ترین راستے سے فوری طور پر باہر نکلیں',
          'guide_fire_step4': '4۔ لفٹ استعمال نہ کریں - سیڑھیاں استعمال کریں',
          'guide_fire_step5': '5۔ دھوئیں سے بچنے کے لیے جھک کر نیچے سے گزریں',
          'guide_fire_step6': '6۔ دروازہ کھولنے سے پہلے اسے ہاتھ کی پشت سے چھو کر دیکھیں',
          'guide_fire_step7': '7۔ اگر پھنس جائیں تو گیلے تولیوں سے دروازے بند کریں اور مدد کے لیے کال کریں',
          'guide_fire_step8': '8۔ باہر نکلنے کے بعد باہر ہی رہیں اور 16 پر کال کریں',
          'guide_fire_step9': '9۔ جلتی ہوئی عمارت میں دوبارہ ہرگز داخل نہ ہوں',

          // Guide 2: PASS
          'guide_extinguisher_step1': 'P - آلے کے اوپر لگی پن نکالیں',
          'guide_extinguisher_step2': 'A - نوزل کا رخ آگ کی بنیاد کی طرف کریں',
          'guide_extinguisher_step3': 'S - ہینڈل کو آہستہ اور برابر دبائیں',
          'guide_extinguisher_step4': 'S - نوزل کو دائیں بائیں حرکت دیں',
          'guide_extinguisher_step5': 'ہمیشہ آگ سے محفوظ فاصلہ برقرار رکھیں',
          'guide_extinguisher_step6': 'آگ کے قریب جانے سے پہلے آلے کو ٹیسٹ کریں',
          'guide_extinguisher_step7': 'صرف چھوٹی اور قابو میں آگ پر استعمال کریں',
          'guide_extinguisher_step8': 'اگر آگ بہت بڑی ہو یا پھیل رہی ہو تو فوراً باہر نکل جائیں',

          // Guide 3: Burn first aid
          'guide_burn_step1': '1۔ جلنے کا عمل روکیں (حرارت کے ذریعہ سے دور کریں)',
          'guide_burn_step2': '2۔ زخم کو 20 منٹ تک ٹھنڈے بہتے پانی سے ٹھنڈا کریں',
          'guide_burn_step3': '3۔ جلی ہوئی جگہ کے قریب کپڑے یا زیورات اتار دیں',
          'guide_burn_step4': '4۔ زخم کو جراثیم سے پاک، نہ چپکنے والی پٹی سے ڈھانپیں',
          'guide_burn_step5': '5۔ زخم پر برف، مکھن یا کریم مت لگائیں',
          'guide_burn_step6': '6۔ بننے والے چھالوں کو مت پھوڑیں',
          'guide_burn_step7': '7۔ شدید جلنے کی صورت میں طبی امداد حاصل کریں',
          'guide_burn_step8': '8۔ کیمیائی جلن کی صورت میں 30 منٹ تک پانی سے دھوئیں',
          'guide_burn_step9': '9۔ ہائپوتھرمیا سے بچاؤ کے لیے شخص کو گرم رکھیں',

          // Guide 4: Safe evacuation checklist
          'guide_evacuation_step1': '✓ ہر کمرے سے باہر نکلنے کے دو راستے معلوم رکھیں',
          'guide_evacuation_step2': '✓ راستوں کو فرنیچر اور ملبے سے صاف رکھیں',
          'guide_evacuation_step3': '✓ باہر ایک مخصوص جمع ہونے کی جگہ مقرر کریں',
          'guide_evacuation_step4': '✓ اپنے انخلاء کے منصوبے کی باقاعدگی سے مشق کریں',
          'guide_evacuation_step5': '✓ اپنے بستر کے قریب ٹارچ اور سیٹی رکھیں',
          'guide_evacuation_step6': '✓ کھڑکیاں اور دروازے آسانی سے کھولنا جانیں',
          'guide_evacuation_step7': '✓ باہر نکلتے وقت زمین کے قریب جھکے رہیں',
          'guide_evacuation_step8': '✓ آگ کے پھیلاؤ کو روکنے کے لیے پیچھے سے دروازے بند کریں',
          'guide_evacuation_step9': '✓ آگ لگنے کی صورت میں لفٹ کبھی استعمال نہ کریں',

          // Guide 5: Gas leak safety instructions
          'guide_gas_leak_step1': '1۔ کوئی بھی بجلی کا سوئچ یا آلہ استعمال نہ کریں',
          'guide_gas_leak_step2': '2۔ لیک کے قریب فون یا ٹارچ استعمال نہ کریں',
          'guide_gas_leak_step3': '3۔ فوری طور پر تمام دروازے اور کھڑکیاں کھول دیں',
          'guide_gas_leak_step4': '4۔ اگر محفوظ ہو تو مین گیس سپلائی والو بند کر دیں',
          'guide_gas_leak_step5': '5۔ عمارت میں موجود تمام افراد کو باہر نکالیں',
          'guide_gas_leak_step6': '6۔ سگریٹ نوشی یا کوئی کھلی آگ استعمال نہ کریں',
          'guide_gas_leak_step7': '7۔ گیس کمپنی کی ہنگامی لائن پر کال کریں',
          'guide_gas_leak_step8': '8۔ جب تک علاقہ محفوظ قرار نہ دیا جائے باہر انتظار کریں',
          'guide_gas_leak_step9': '9۔ اجازت ملنے تک عمارت میں دوبارہ داخل نہ ہوں',

          // Safety tips (quick-action sheet)
          'tip_smoke_detectors_title': 'سموک ڈیٹیکٹرز نصب کریں',
          'tip_smoke_detectors_desc': 'ہر منزل پر سموک ڈیٹیکٹر نصب کریں اور ہر ماہ اسے ٹیسٹ کریں۔',
          'tip_fire_extinguisher_title': 'فائر ایکسٹینگوشر رکھیں',
          'tip_fire_extinguisher_desc': 'باورچی خانے میں فائر ایکسٹینگوشر رکھیں اور اس کا استعمال جانیں۔',
          'tip_escape_routes_title': 'فرار کے راستوں کی منصوبہ بندی کریں',
          'tip_escape_routes_desc': 'اپنے گھر کے ہر کمرے سے نکلنے کے کم از کم دو راستے رکھیں۔',
          'tip_electrical_wiring_title': 'بجلی کی وائرنگ چیک کریں',
          'tip_electrical_wiring_desc': 'بجلی کی وائرنگ کو نقصان یا گرمی کے لیے باقاعدگی سے چیک کریں۔',
          'tip_flammables_title': 'آتش گیر اشیاء کو محفوظ طریقے سے رکھیں',
          'tip_flammables_desc': 'پیٹرول، پینٹ اور دیگر آتش گیر اشیاء کو منظور شدہ برتنوں میں محفوظ رکھیں۔',
          'tip_kitchen_safety_title': 'باورچی خانے کی حفاظت',
          'tip_kitchen_safety_desc': 'کھانا پکاتے وقت کبھی جگہ سے نہ ہٹیں اور آگ بجھانے کے لیے ڈھکن قریب رکھیں۔',

          // Buy Equipment - product website descriptions (names stay as brand names)
          'product_daraz_desc': 'پاکستان میں فائر ایکسٹینگوشرز، الارمز اور حفاظتی سامان',
          'product_amazon_desc': 'بین الاقوامی آتشزدگی حفاظتی مصنوعات کا وسیع انتخاب',
          'product_alibaba_desc': 'عالمی سپلائرز سے تھوک آتشزدگی حفاظتی سامان',
          'product_ebay_desc': 'متعدد فروخت کنندگان سے نیا اور استعمال شدہ حفاظتی سامان',

          // Snackbar / status messages
          'msg_could_not_start_call': 'کال شروع نہیں ہو سکی',
          'msg_no_website_listed': 'کوئی ویب سائٹ درج نہیں ہے',
          'msg_could_not_open_website': 'ویب سائٹ نہیں کھل سکی',
          'msg_unable_to_get_location': 'مقام حاصل نہیں ہو سکا۔ نقشہ کھولا جا رہا ہے...',
          'msg_could_not_open_maps': 'نقشہ نہیں کھل سکا',
          'msg_platform_not_supported': 'پلیٹ فارم سپورٹ نہیں کرتا',

          // ---------------- Helpline screen ----------------
          'helpline_center': 'ہیلپ لائن سینٹر',
          'helpline_page_banner':
              'تمام ہنگامی، طبی اور معاون ہیلپ لائنز ایک ہی جگہ — کال کرنے کے لیے کسی بھی کارڈ پر ٹیپ کریں یا سروس کی ویب سائٹ کھولیں۔',
          'ambulance_services': 'ایمبولینس سروسز',
          'ambulance_services_subtitle': 'کسی سروس کی ہیلپ لائن پر کال کرنے یا اس کی ویب سائٹ دیکھنے کے لیے اس پر ٹیپ کریں۔',
          'msg_no_official_website': 'اس سروس کے لیے کوئی سرکاری ویب سائٹ درج نہیں ہے',
          'call_now': 'ابھی کال کریں',
          'website': 'ویب سائٹ',
          'call': 'کال کریں',
          'helpline_colon': 'ہیلپ لائن:',
          'no_website_listed': 'کوئی ویب سائٹ درج نہیں',
          'visit_website': 'ویب سائٹ دیکھیں',

          // Helpline categories
          'category_trauma_centers': 'ٹراما سینٹرز',
          'category_mental_health': 'ذہنی صحت کی معاونت',
          'category_pet_animal_safety': 'پالتو اور جانوروں کی حفاظت',

          // Helpline entries
          'helpline_civil_hospital_trauma': 'سول ہسپتال کراچی ٹراما سینٹر',
          'helpline_jpmc_emergency': 'جے پی ایم سی ایکسیڈنٹ اینڈ ایمرجنسی',
          'helpline_rescue_1122_road': 'ریسکیو 1122 (سڑک حادثات)',
          'helpline_umang': 'امنگ ذہنی صحت ہیلپ لائن',
          'helpline_taskeen': 'تسکین ہیلپ لائن',
          'helpline_national_youth': 'قومی یوتھ ہیلپ لائن',
          'helpline_acf_animal_rescue': 'اے سی ایف اینیمل ریسکیو',
          'helpline_edhi_animal_shelter': 'ایدھی اینیمل شیلٹر',

          // Ambulance services (org names stay untranslated - proper nouns)
          'amb_edhi_desc':
              'دنیا کا سب سے بڑا رضاکارانہ طور پر چلایا جانے والا ایمبولینس نیٹ ورک، جو پاکستان میں ایمبولینسز کا سب سے بڑا نجی بیڑہ چلاتا ہے، ساتھ ہی آفات کے ردعمل کے لیے فضائی ایمبولینس سروس بھی فراہم کرتا ہے۔',
          'amb_edhi_detail1': 'کراچی اور زیادہ تر بڑے شہروں میں مفت 24 گھنٹے زمینی ایمبولینس سروس۔',
          'amb_edhi_detail2': 'ہنگامی حالات کے لیے ہوائی جہازوں اور ہیلی کاپٹر کے ذریعے فضائی ایمبولینس سروس بھی چلاتا ہے۔',
          'amb_edhi_detail3': 'مکمل طور پر عوامی عطیات سے چلایا جاتا ہے، کوئی سرکاری فنڈنگ قبول نہیں کی جاتی۔',

          'amb_chhipa_desc':
              'چھیپا ویلفیئر ایسوسی ایشن پاکستان کا دوسرا سب سے بڑا ایمبولینس نیٹ ورک چلاتی ہے، جس کی گاڑیاں سڑکوں کے چوراہوں اور سرکاری ہسپتالوں کے قریب موجود ہوتی ہیں۔',
          'amb_chhipa_detail1': 'کراچی اور دیگر علاقوں میں 500 سے زائد ایمبولینسز موجود ہیں۔',
          'amb_chhipa_detail2': 'بم دھماکوں، آتشزدگی اور عمارتوں کے گرنے جیسے بڑے واقعات میں سب سے پہلے پہنچنے والی ٹیم۔',
          'amb_chhipa_detail3': 'ایمبولینسز ابتدائی طبی امداد کے بکس اور آکسیجن سلنڈرز سے مکمل طور پر لیس ہیں۔',

          'amb_aman_desc':
              'امان فاؤنڈیشن کی ایمبولینس سروس، جو بعد میں سندھ انٹیگریٹڈ ایمرجنسی اینڈ ہیلتھ سروسز کے ذریعے وسعت اختیار کر گئی، کراچی بھر میں گھر سے ہسپتال تک ہنگامی نقل و حمل فراہم کرتی ہے۔',
          'amb_aman_detail1': 'گھر اور ہسپتال کے درمیان مریضوں کی مفت منتقلی فراہم کرتی ہے۔',
          'amb_aman_detail2': 'کئی علاقوں میں سندھ حکومت کے اشتراک سے چلائی جاتی ہے۔',
          'amb_aman_detail3': 'شہر کے پسماندہ علاقوں میں ایمبولینس کی سہولت بہتر بنانے پر توجہ مرکوز ہے۔',

          'amb_redcrescent_desc':
              'پاکستان کی قومی ریڈ کریسنٹ سوسائٹی، جو 1947 سے عالمی ریڈ کراس اور ریڈ کریسنٹ تحریک کے حصے کے طور پر ہنگامی طبی امداد اور آفات میں امدادی کارروائیاں فراہم کر رہی ہے۔',
          'amb_redcrescent_detail1': 'قدرتی اور انسانی آفات کے دوران ہنگامی طبی اور امدادی خدمات فراہم کرتی ہے۔',
          'amb_redcrescent_detail2': 'ملک بھر میں ابتدائی طبی امداد کی تربیت اور خون کے عطیہ کی مہمات چلاتی ہے۔',
          'amb_redcrescent_detail3': 'سندھ اور کراچی سمیت پاکستان بھر میں صوبائی شاخیں چلاتی ہے۔',

          // ---------------- Blood Bank screen ----------------
          'msg_could_not_open_link': 'لنک نہیں کھل سکا',
          'msg_could_not_place_call': 'کال نہیں ہو سکی',
          'blood_donation_availability': 'خون کا عطیہ اور دستیابی',
          'blood_bank_page_banner': 'بلڈ بینک تلاش کریں، لائیو دستیابی چیک کریں، اور فوری ہنگامی مدد حاصل کریں۔',
          'blood_bank_services_subtitle': 'خون تلاش کرنے اور فوری مدد حاصل کرنے کے لیے ہر ضروری چیز۔',

          // Donation website descriptions (names stay as brand/org names)
          'donation_sbta_desc': 'سندھ بلڈ ٹرانسفیوژن اتھارٹی - آپ کے قریب حقیقی وقت میں خون کی دستیابی',
          'donation_fatimid_desc': 'پاکستان بھر میں تھیلیسیمیا کی دیکھ بھال اور رضاکارانہ خون کا عطیہ',
          'donation_indus_desc': 'مفت خون کی منتقلی کی خدمات اور عطیہ مہمات',
          'donation_redcrescent_desc': 'ملک بھر میں خون کے عطیہ کیمپس اور ہنگامی خون کی خدمات',

          // Service list
          'service_nearby_blood_bank_title': 'قریبی بلڈ بینک',
          'service_nearby_blood_bank_subtitle': 'قریب ترین بلڈ بینک نقشے پر تلاش کریں',
          'service_emergency_helpline_subtitle': 'کال کریں (021) 35650411 - خون کی ہنگامی صورتحال کے لیے مفت کال',
          'service_24hr_blood_bank_title': '24 گھنٹے بلڈ بینک',
          'service_24hr_blood_bank_subtitle': 'ہر وقت کھلے بلڈ بینک تلاش کریں',
          'service_realtime_availability_title': 'حقیقی وقت میں خون کی دستیابی اور عطیہ',
          'service_realtime_availability_subtitle': 'لائیو دستیابی اور تصدیق شدہ عطیہ ذرائع چیک کریں',

          // ---------------- Hospital screen ----------------
          'hospital_page_banner': 'قریبی ہسپتال تلاش کریں، مخصوصیت کے مطابق دیکھیں، یا فوری طور پر اپائنٹمنٹ بک کریں۔',
          'hospital_services_subtitle': 'ہسپتال تلاش کرنے اور فوری مدد حاصل کرنے کے لیے ہر ضروری چیز۔',

          // Specialty category titles (also used as modal sheet titles)
          'category_kidney_care': 'گردے کی دیکھ بھال',
          'category_cancer_care': 'کینسر کی دیکھ بھال',
          'category_heart_care': 'دل کی دیکھ بھال',
          'category_other_important': 'دیگر اہم ہسپتال',
          'book_an_appointment': 'اپائنٹمنٹ بک کریں',
          'free_government_hospitals': 'مفت سرکاری ہسپتال',

          // Service list (drives the main ListTile cards)
          'service_nearby_hospital_title': 'قریبی ہسپتال',
          'service_nearby_hospital_subtitle': 'قریب ترین ہسپتال نقشے پر تلاش کریں',
          'service_24hr_hospital_title': '24 گھنٹے ہسپتال',
          'service_24hr_hospital_subtitle': 'ہر وقت کھلے ہسپتال تلاش کریں',
          'service_kidney_care_title': 'گردے کی دیکھ بھال کے ہسپتال',
          'service_kidney_care_subtitle': '5 نیفرولوجی، ڈائیلاسز اور گردہ ٹرانسپلانٹ سینٹرز',
          'service_cancer_care_title': 'کینسر کی دیکھ بھال کے ہسپتال',
          'service_cancer_care_subtitle': '5 آنکولوجی، کیموتھراپی اور ریڈیوتھراپی سینٹرز',
          'service_heart_care_title': 'دل کی دیکھ بھال کے ہسپتال',
          'service_heart_care_subtitle': '6 امراضِ قلب اور ہنگامی کارڈیک سینٹرز',
          'service_other_important_title': 'دیگر اہم ہسپتال',
          'service_other_important_subtitle': 'تمام شعبوں کے لیے بڑے سرکاری ہسپتال',
          'service_book_appointment_title': 'اپائنٹمنٹ بک کریں (نجی ہسپتال)',
          'service_book_appointment_subtitle': 'آغا خان، لیاقت نیشنل، سیفی، پٹیل',
          'service_free_gov_hospitals_title': 'مفت سرکاری ہسپتال',
          'service_free_gov_hospitals_subtitle': 'مفت سرکاری ہسپتالوں کی ویب سائٹ اور کال کی معلومات',

          // Kidney Care descriptions (hospital names stay untranslated - proper nouns)
          'hosp_siut_desc': 'سول ہسپتال کے قریب مفت گردے کا علاج، ڈائیلاسز اور ٹرانسپلانٹ خدمات',
          'hosp_tkc_desc': 'ڈائیلاسز، نیفرولوجی اور ٹرانسپلانٹ کے لیے غیر منافع بخش خصوصی ہسپتال',
          'hosp_ckgh_desc': 'انڈور میڈیسن، سرجری اور ایمرجنسی کے ساتھ 24/7 ڈائیلاسز یونٹ',
          'hosp_mmi_desc': 'دائمی گردے کی بیماری کا انتظام، ڈائیلاسز اور پتھری کا علاج',
          'hosp_kidneyfoundation_desc': 'کراچی یونیورسٹی میں گردے اور یورولوجیکل امراض کا غیر منافع بخش ہسپتال',

          // Cancer Care descriptions
          'hosp_kiran_desc': 'گلزارِ ہجری میں کم قیمت ریڈیوتھراپی، کیموتھراپی اور آنکولوجی کی دیکھ بھال',
          'hosp_shaukat_desc': 'ڈی ایچ اے سٹی کراچی میں مفت اور سبسڈی یافتہ ملٹی موڈیلٹی کینسر کیئر',
          'hosp_baitulsukoon_desc': 'پاکستان کا واحد مفت کینسر ہسپتال جہاں ہاسپس کیئر بھی دستیاب ہے',
          'hosp_ziauddin_desc': 'ریڈیوتھراپی، کیموتھراپی اور مخصوص آنکولوجی ڈے کیئر یونٹ',
          'hosp_indus_cancer_desc': 'مکمل طور پر مفت کیموتھراپی، ریڈی ایشن اور تشخیصی آنکولوجی خدمات',

          // Heart Care descriptions
          'hosp_nicvd_desc': 'مفت کارڈیک سرجری، انجیوپلاسٹی اور ہنگامی امراضِ قلب کی دیکھ بھال',
          'hosp_tabba_desc': 'کراچی کا سرکردہ مخصوص کارڈیک ہسپتال، 24/7 ایمرجنسی',
          'hosp_ibneseena_desc': 'مخصوص شعبہ امراضِ قلب کے ساتھ 200 بستروں کا جنرل ہسپتال',
          'hosp_baqai_desc': 'انجیوپلاسٹی اور کارڈیک سرجری خدمات کے ساتھ ترتیری نگہداشت ہسپتال',
          'hosp_southcity_desc': 'کلفٹن میں انجیوپلاسٹی اور انویزیو کارڈیالوجی کے لیے کیتھ لیب',
          'hosp_pns_desc': 'کارڈیالوجی اور 24/7 ایمرجنسی کیئر کے ساتھ نیوی کا 600 بستروں کا ہسپتال',

          // Other Important descriptions
          'hosp_civil_desc': 'تمام شعبوں کے لیے بڑا سرکاری ترتیری نگہداشت ہسپتال',
          'hosp_jpmc_desc': '24/7 ایمرجنسی خدمات کے ساتھ بڑا سرکاری ہسپتال',

          // Private hospitals - booking descriptions
          'hosp_akuh_book_desc': 'آن لائن اپائنٹمنٹ بک کریں - نیشنل اسٹیڈیم روڈ، کراچی',
          'hosp_lnh_book_desc': 'آن لائن اپائنٹمنٹ بک کریں - اسٹیڈیم روڈ، کراچی',
          'hosp_saifee_book_desc': 'آن لائن اپائنٹمنٹ بک کریں - نارتھ ناظم آباد، کراچی',
          'hosp_patel_book_desc': 'آن لائن اپائنٹمنٹ بک کریں - گلشنِ اقبال، کراچی',

          // Free government hospitals descriptions
          'hosp_civil_gov_desc': 'تمام شعبوں کے لیے مفت سرکاری ترتیری نگہداشت ہسپتال',
          'hosp_jpmc_gov_desc': 'مفت سرکاری ہسپتال، 24/7 ایمرجنسی خدمات',
          'hosp_siut_gov_desc': 'مفت ڈائیلاسز، گردہ اور ٹرانسپلانٹ علاج',
          'hosp_nicvd_gov_desc': 'مفت ایمرجنسی اور سرجری خدمات برائے امراضِ قلب',

          // ---------------- Police Options screen ----------------
          'police_options_title': 'پولیس کے اختیارات',
          'police_page_banner': 'ہنگامی صورتحال میں فوری طور پر قریب ترین پولیس اسٹیشن تک رسائی حاصل کریں یا ہیلپ لائن پر کال کریں۔',
          'police_station_query': 'پولیس اسٹیشن',

          'police_station_map_title': 'پولیس اسٹیشن نقشہ دکھائیں',
          'police_station_map_subtitle': 'قریب ترین پولیس اسٹیشن نقشے پر تلاش کریں',
          'call_police_helpline_title': 'پولیس ہیلپ لائن پر کال کریں',
          'call_police_helpline_subtitle': 'پولیس اسٹیشن ہیلپ لائن (15) پر براہ راست کال کریں',

          'know_your_rights_safety': 'اپنے حقوق اور حفاظت جانیں',

          'helpline_label': 'ہیلپ لائن',
          'find_nearest': 'قریب ترین تلاش کریں',
          'notice_label': 'اطلاع',

          'msg_enable_location': 'قریبی اسٹیشنز دکھانے کے لیے براہ کرم لوکیشن سروس آن کریں',
          'msg_location_permission_required': 'نقشہ دکھانے کے لیے لوکیشن کی اجازت درکار ہے',
          'msg_location_permanently_denied': 'لوکیشن کی اجازت مستقل طور پر مسترد کر دی گئی ہے۔ ایپ کی سیٹنگز سے فعال کریں۔',
          'msg_map_error': 'آپ کی لوکیشن حاصل کرتے وقت کچھ غلط ہو گیا',
          'msg_could_not_open_map': 'نقشہ کھولنے میں ناکامی ہوئی',
          'msg_phone_permission_required': 'کال کرنے کے لیے فون کی اجازت درکار ہے',
          'msg_call_error': 'کال کرتے وقت کچھ غلط ہو گیا',

          'wing_women_title': 'ویمن پولیس اسٹیشن',
          'wing_women_subtitle': 'مشکل میں مبتلا خواتین کے لیے معاونت',
          'wing_women_desc':
              'گھریلو تشدد، ہراسانی اور خواتین کے خلاف دیگر جرائم کی شکایات کا ازالہ کرتا ہے، جہاں ممکن ہو خاتون افسران تعینات ہوتی ہیں۔',
          'wing_women_detail1':
              'قومی پولیس ہیلپ لائن 15 کے ذریعے رابطہ کریں — ویمن اینڈ چائلڈ پروٹیکشن سیل سے ملانے کی درخواست کریں۔',
          'wing_women_detail2': 'آپ اپنا بیان درج کروانے کے لیے خاتون افسر کی درخواست کر سکتی ہیں۔',
          'wing_women_detail3': 'اگر دستیاب ہوں تو پیغامات، تصاویر یا میڈیکل رپورٹس جیسے شواہد ساتھ لائیں۔',

          'wing_child_title': 'چائلڈ پروٹیکشن',
          'wing_child_subtitle': 'بدسلوکی یا گمشدہ بچے کی اطلاع',
          'wing_child_desc':
              'بچوں کے ساتھ بدسلوکی، استحصال، اور گمشدہ یا بھاگے ہوئے بچوں کے معاملات سے نمٹتا ہے، اور چائلڈ پروٹیکشن اتھارٹی کے ساتھ مل کر کام کرتا ہے۔',
          'wing_child_detail1': 'فوری طور پر اطلاع دیں — اگر بچہ خطرے میں ہو یا لاپتہ ہو تو انتظار نہ کریں۔',
          'wing_child_detail2': 'گمشدہ بچے کی رپورٹ کرتے وقت حالیہ تصویر اور حلیہ فراہم کریں۔',
          'wing_child_detail3': 'معاملات سندھ چائلڈ پروٹیکشن اتھارٹی کو بھی بھجوائے جا سکتے ہیں۔',

          'wing_traffic_title': 'ٹریفک پولیس',
          'wing_traffic_subtitle': 'حادثات، خلاف ورزیاں اور سڑک پر مدد',
          'wing_traffic_desc':
              'سڑک حادثات، ٹریفک خلاف ورزیوں، لائسنس کے مسائل اور رش کا انتظام کرتی ہے۔ رسپانس نمبر شہر کے لحاظ سے مختلف ہو سکتے ہیں — 15 آپ کو مناسب جگہ رہنمائی کرے گا۔',
          'wing_traffic_detail1': 'حادثے کی اطلاع دیتے وقت مقام، گاڑی نمبر اور وقت نوٹ کریں۔',
          'wing_traffic_detail2': 'رابطہ کیے جانے پر اپنا شناختی کارڈ اور گاڑی کے کاغذات تیار رکھیں۔',
          'wing_traffic_detail3': 'شہر کے مخصوص ٹریفک ہیلپ لائن نمبرز کے لیے اپنی مقامی ٹریفک پولیس ویب سائٹ دیکھیں۔',

          'wing_bomb_title': 'بم ڈسپوزل اسکواڈ',
          'wing_bomb_subtitle': 'مشکوک اشیاء یا خطرات',
          'wing_bomb_desc':
              'مشکوک یا لاوارث اشیاء اور دھماکہ خیز خطرات سے نمٹنے کے لیے پولیس ہیلپ لائن کے ذریعے بھیجی جانے والی خصوصی ٹیم۔',
          'wing_bomb_detail1': 'مشکوک چیز کو کبھی ہاتھ نہ لگائیں، حرکت نہ دیں یا خود جانچنے کی کوشش نہ کریں۔',
          'wing_bomb_detail2': 'پرسکون انداز میں علاقہ خالی کروائیں اور دوسروں کو دور رکھیں۔',
          'wing_bomb_detail3': 'فوری طور پر 15 پر کال کریں اور چیز اور صحیح مقام واضح طور پر بتائیں۔',

          'wing_rescue_title': 'ریسکیو سپورٹ',
          'wing_rescue_subtitle': 'طبی، آتشزدگی اور ریسکیو ہنگامی حالات',
          'wing_rescue_desc':
              'ریسکیو 1122 سندھ اور پاکستان کے بیشتر حصوں میں مفت پری ہاسپٹل ایمرجنسی طبی، آتشزدگی اور ریسکیو خدمات فراہم کرتا ہے۔',
          'wing_rescue_detail1': '24/7 پورے ملک میں 1122 ڈائل کر کے دستیاب ہے۔',
          'wing_rescue_detail2': 'لائن پر رہیں اور ہنگامی صورتحال کی نوعیت اور اپنا مقام واضح طور پر بتائیں۔',
          'wing_rescue_detail3': 'طبی ہنگامی حالات، آگ، سڑک حادثات اور عمارت گرنے کے واقعات کے لیے استعمال ہوتا ہے۔',

          'wing_cyber_title': 'سائبر کرائم ونگ',
          'wing_cyber_subtitle': 'آن لائن ہراسانی اور فراڈ',
          'wing_cyber_desc':
              'FIA/NCCIA سائبر کرائم ہیلپ لائن آن لائن ہراسانی، مالی فراڈ، ہیکنگ، شناخت کی چوری اور ہتک عزت کی شکایات سے نمٹتی ہے۔',
          'wing_cyber_detail1': '1991 ڈائل کریں یا FIA سائبر کرائم ونگ کی ویب سائٹ کے ذریعے شکایت درج کروائیں۔',
          'wing_cyber_detail2': 'رپورٹ کرنے سے پہلے تمام شواہد — اسکرین شاٹس، پیغامات اور ٹرانزیکشن ریکارڈز — محفوظ کر لیں۔',
          'wing_cyber_detail3': 'جلدی کریں، کیونکہ ڈیجیٹل شواہد جلد ختم ہو سکتے ہیں۔',

          'info_fir_title': 'ایف آئی آر درج کروانے کی رہنمائی',
          'fir_point1':
              'آپ کسی بھی پولیس اسٹیشن پر ایف آئی آر درج کروا سکتے ہیں، چاہے واقعہ کہیں بھی پیش آیا ہو — اسے زیرو ایف آئی آر کہا جاتا ہے، جو بعد میں متعلقہ اسٹیشن منتقل کر دی جاتی ہے۔',
          'fir_point2': 'تاریخ، وقت، مقام اور ملوث افراد کے ساتھ واضح اور حقیقت پر مبنی تفصیل فراہم کریں۔',
          'fir_point3': 'ایف آئی آر درج کروانا مکمل طور پر مفت ہے — کوئی بھی پولیس اہلکار اس کے لیے پیسے نہیں لے سکتا۔',
          'fir_point4': 'ہمیشہ اپنی درج شدہ ایف آئی آر کی کاپی طلب کریں اور محفوظ رکھیں۔',
          'fir_point5':
              'اگر کوئی اسٹیشن آپ کی ایف آئی آر درج کرنے سے انکار کرے تو آپ ایس پی آفس، صوبائی پولیس افسر کے شکایتی سیل، یا مجسٹریٹ سے رجوع کر سکتے ہیں۔',

          'info_rights_title': 'شہری حقوق',
          'rights_point1': 'آپ کو اپنی گرفتاری کی وجہ سے آگاہ کیے جانے کا حق ہے۔',
          'rights_point2': 'آپ کو قانونی معاونت کا حق حاصل ہے، بشمول اہلیت کی صورت میں مفت قانونی امداد۔',
          'rights_point3': 'آپ کو قانونی مدت سے زیادہ حراست میں رکھے بغیر مجسٹریٹ کے سامنے پیش کیا جانا ضروری ہے۔',
          'rights_point4': 'آپ کو متعلقہ نگران ادارے کے پاس پولیس کی بدسلوکی کے خلاف شکایت درج کروانے کا حق ہے۔',
          'rights_point5': 'آپ کو تحویل کے دوران وقار اور بدسلوکی سے تحفظ کا حق حاصل ہے۔',

          'info_safety_title': 'حفاظتی تجاویز',
          'safety_point1': 'اکیلے سفر کرتے وقت، خاص طور پر رات کو، اپنی لائیو لوکیشن کسی قابل اعتماد شخص کے ساتھ شیئر کریں۔',
          'safety_point2': 'ہنگامی نمبرز اپنے فون میں محفوظ اور آسانی سے قابل رسائی رکھیں۔',
          'safety_point3': 'غیر آباد یا کم روشنی والے علاقوں سے گریز کریں؛ مصروف اور معروف راستے اختیار کریں۔',
          'safety_point4': 'اپنے اہم دستاویزات جیسے شناختی کارڈ اور گاڑی کی رجسٹریشن کی ڈیجیٹل کاپیاں رکھیں۔',
          'safety_point5': 'اپنی جبلت پر بھروسہ کریں — کوئی بھی صورتحال جو غیر محفوظ محسوس ہو اسے چھوڑ دیں اور فوری مدد حاصل کریں۔',

          'info_faq_title': 'اکثر پوچھے جانے والے سوالات',
          'faq_q1': 'کیا ایف آئی آر درج کروانے کی کوئی فیس ہے؟',
          'faq_a1': 'نہیں، کسی بھی پولیس اسٹیشن پر ایف آئی آر درج کروانا مکمل طور پر مفت ہے۔',
          'faq_q2': 'کیا میں آن لائن ایف آئی آر درج کروا سکتا ہوں؟',
          'faq_a2':
              'کچھ صوبے ڈیجیٹل یا آن لائن پولیس اسٹیشن پورٹل فراہم کرتے ہیں — دستیابی کے لیے اپنی صوبائی پولیس ویب سائٹ یا ایپ دیکھیں۔',
          'faq_q3': 'اگر پولیس میری مدد کرنے سے انکار کر دے تو کیا کروں؟',
          'faq_a3': 'آپ سینئر افسر، ایس پی شکایتی سیل، یا صوبائی پولیس افسر ہیلپ لائن سے رابطہ کر سکتے ہیں۔',
          'faq_q4': 'آن لائن ہراسانی یا فراڈ کے لیے کس سے رابطہ کروں؟',
          'faq_a4': '1991 پر FIA سائبر کرائم ونگ / NCCIA ہیلپ لائن سے رابطہ کریں۔',
          'faq_q5': 'طبی یا آتشزدگی کی ہنگامی صورتحال کے لیے کون سا نمبر ڈائل کروں؟',
          'faq_a5': 'سندھ اور پاکستان کے بیشتر علاقوں میں ریسکیو سپورٹ کے لیے 1122 ڈائل کریں۔',

          // ---------------- Pharmacy Options screen ----------------
          'pharmacy_page_banner': 'قریبی فارمیسیاں تلاش کریں، دوا آرڈر کریں، اور فوری طبی مدد حاصل کریں۔',
          'trusted_online_pharmacies': 'قابل اعتماد آن لائن فارمیسیز',
          'browse_verified_pharmacy_platforms': 'تصدیق شدہ فارمیسی اور صحت پلیٹ فارمز دیکھیں',
          'pharmacy_services_subtitle': 'کسی بھی وقت معتبر فارمیسیوں اور ضروری ادویات تک رسائی حاصل کریں۔',

          'service_nearby_pharmacy_title': 'قریبی فارمیسی',
          'service_nearby_pharmacy_subtitle': 'قریب ترین فارمیسی نقشے پر تلاش کریں',
          'service_24hr_pharmacy_title': '24 گھنٹے فارمیسی',
          'service_24hr_pharmacy_subtitle': 'ہر وقت کھلی فارمیسیاں تلاش کریں',

          // Pharmacy website descriptions (names stay as brand names)
          'pharmacy_dawaai_desc': 'پاکستان بھر میں ہوم ڈیلیوری کے ساتھ آن لائن دوائیں آرڈر کریں',
          'pharmacy_dvago_desc': 'اصل ادویات کے لیے پاکستان کا قابل اعتماد فارمیسی چین',
          'pharmacy_servaid_desc': 'آن لائن آرڈرنگ کے ساتھ پاکستان کا سب سے بڑا فارمیسی چین',
          'pharmacy_instacare_desc': 'تیز ڈیلیوری اور ڈاکٹر سے مشاورت کے ساتھ آن لائن فارمیسی',
          'pharmacy_sehatkahani_desc': 'آن لائن ڈاکٹر سے مشاورت اور صحت کی خدمات',


          // ---------------- ARB Medical Centre screen ----------------
          'msg_could_not_make_call': 'کال نہیں کی جا سکی',
          'msg_could_not_open_browser': 'براؤزر نہیں کھل سکا۔ براہ کرم arbmedical.org.pk دستی طور پر وزٹ کریں۔',
 
          'arb_call_title': 'اے آر بی میڈیکل سینٹر کو کال کریں',
          'arb_about_title': 'اے آر بی میڈیکل سینٹر کے بارے میں',
          'arb_about_desc':
              "اے آر بی میڈیکل سینٹر، جسے حسین حبیب فاؤنڈیشن ٹرسٹ نے قائم کیا اور حسین حبیب کے معزز بانی مرحوم حافظ عتیق الرحمن بیری کے اعزاز میں نام دیا گیا، جہاں 'اے آر بی' ان کے محترم نام کا مخفف ہے، کا باقاعدہ افتتاح 2 دسمبر 2024 کو کیا گیا۔ یہ جدید ترین سہولت گردونواح کی کمیونٹیز کے لیے ایک قیمتی صحت کا ذریعہ ثابت ہو گی، خصوصاً پی ای سی ایچ ایس سے ملحقہ نچلے علاقوں بشمول عمر کالونی، بلوچ کالونی، محمود آباد، ریلوے لائن، چنیسر ہالٹ، اعظم بستی اور منظور کالونی وغیرہ کے لیے۔",
 
          'arb_certificate_title': 'سرٹیفکیٹ',
          'arb_cert1_title': 'سرٹیفکیٹ - تکنیکی معاونت',
          'arb_cert2_title': 'سرٹیفکیٹ - اجازت نامہ',
          'arb_cert_tap_instruction': 'دیکھنے کے لیے کسی بھی سرٹیفکیٹ پر ٹیپ کریں',
          'arb_image_not_found': 'تصویر نہیں ملی',
 
          'location_label': 'مقام',
          'call_us_label': 'ہمیں کال کریں',
          'online_donation_label': 'آن لائن عطیہ',
          'timing_label': 'اوقات کار',
          'arb_timing_hours': 'پیر سے ہفتہ • صبح 9:00 بجے – شام 5:00 بجے',
          'arb_clinic_timings_title': 'کلینک کے اوقات (او پی ڈی)',
 
          'arb_doctor1_role': 'جنرل سرجن + یورولوجسٹ',
          'arb_doctor1_days': 'ہفتہ',
          'arb_doctor1_time': 'صبح 10:00 بجے سے 11:00 بجے تک',
          'arb_doctor2_role': 'ماہر اطفال (بچوں کے ڈاکٹر)',
          'arb_doctor2_days': 'پیر، بدھ اور ہفتہ',
          'arb_doctor2_time': 'دوپہر 2:30 بجے سے شام 4:30 بجے تک',
          'arb_doctor3_role': 'ماہر نفسیات (سائیکوتھراپسٹ)',
          'arb_doctor3_days': 'جمعرات',
          'arb_doctor3_time': 'صبح 10:00 بجے سے دوپہر 1:00 بجے تک',
 
          'arb_footer_honor': 'مرحوم حافظ عتیق الرحمن بیری\nکے اعزاز میں',
          'arb_footer_subtitle': 'حسین حبیب فاؤنڈیشن ٹرسٹ کے معزز بانی',

          // ---------------- Doctor Options screen ----------------
          'doctor_options_title': 'ڈاکٹر کے اختیارات',
          'doctor_referrals_title': 'ڈاکٹر ریفرلز',
          'doctor_referrals_subtitle': 'بیرونی ڈاکٹرز اور ماہرین دیکھیں',
          'active_label': 'فعال',
          'checking_label': 'چیک ہو رہا ہے...',
          'doctor_button_hint':
              'ڈاکٹر کی درخواست کے لیے بٹن دبائیں۔ جلد ہی ایک ڈاکٹر مقرر کر دیا جائے گا۔ صرف دفتری اوقات میں دستیاب ہے۔',
          'checking_existing_requests': 'موجودہ ڈاکٹر درخواستوں کی جانچ ہو رہی ہے...',
          'view_active_doctor': 'فعال ڈاکٹر دیکھیں',
          'dr_name': 'ڈاکٹر @name',
          'dr_name_profession': 'ڈاکٹر @name (@profession)',

          'loading_title': 'لوڈ ہو رہا ہے',
          'checking_requests_please_wait': 'موجودہ ڈاکٹر درخواستوں کی جانچ ہو رہی ہے... براہ کرم انتظار کریں۔',
          'active_doctor_session_title': 'فعال ڈاکٹر سیشن',
          'active_doctor_session_msg': 'آپ کے پاس پہلے ہی ایک فعال ڈاکٹر درخواست موجود ہے۔ براہ کرم انتظار کریں۔',
          'too_fast_title': 'بہت تیز!',
          'wait_seconds_msg': 'دوبارہ درخواست دینے سے پہلے براہ کرم @seconds سیکنڈ انتظار کریں۔',
          'please_wait_title': 'براہ کرم انتظار کریں',
          'request_already_processing': 'آپ کی درخواست پہلے ہی زیر عمل ہے...',
          'failed_request_doctor': 'ڈاکٹر کی درخواست ناکام ہو گئی۔ براہ کرم دوبارہ کوشش کریں۔',

          'request_a_doctor_title': 'ڈاکٹر کی درخواست کریں',
          'doctor_assign_shortly': 'جلد ہی آپ کے لیے ایک ڈاکٹر مقرر کر دیا جائے گا۔',
          'confirm_request': 'درخواست کی تصدیق کریں',

          'doctor_assigned_title': 'ڈاکٹر مقرر کر دیا گیا!',
          'doctor_assigned_msg': 'ڈاکٹر @name آپ کے لیے مقرر کر دیے گئے ہیں',
          'assigned_label': 'مقرر شدہ',
          'close_label': 'بند کریں',

          'no_doctor_available_title': 'کوئی ڈاکٹر دستیاب نہیں',
          'no_doctor_available_msg': 'تمام ڈاکٹرز فی الحال مصروف یا دستیاب نہیں ہیں۔ براہ کرم بعد میں دوبارہ کوشش کریں۔',
          'ok_label': 'ٹھیک ہے',

          'session_completed_title': 'سیشن مکمل ہو گیا',
          'session_completed_msg': 'سیشن ڈاکٹر @name کی جانب سے ختم کر دیا گیا ہے',
          'doctor_unavailable_title': 'ڈاکٹر دستیاب نہیں',
          'doctor_unavailable_msg': 'ڈاکٹر @name اب دستیاب نہیں ہیں',

          // ---------------- Doctor List (Referrals) screen ----------------
          'book_free_consultation_title': 'مفت آن لائن مشاورت بک کریں',
          'trusted_platforms_subtitle': 'پاکستان میں ڈاکٹروں کو تلاش کرنے اور بک کرنے کے لیے قابل اعتماد پلیٹ فارمز',
          'book_label': 'بک کریں',

          // Referral site descriptions (names stay as brand names)
          'referral_oladoc_desc': 'پاکستان بھر کے بہترین ڈاکٹروں کے ساتھ اپائنٹمنٹ بک کریں۔',
          'referral_marham_desc': '16,000 سے زائد تصدیق شدہ ڈاکٹرز۔ آن لائن بک کریں یا مشورہ لیں۔',
          'referral_dawaai_desc': 'ڈاکٹر سے پوچھیں — مفت چیٹ مشاورت اور اپائنٹمنٹس۔',
          'referral_ddoctor_desc': 'ڈاکٹرز، ہسپتال، لیبز اور کلینکس آن لائن بک کریں۔',
          'referral_healthwire_desc': 'اپنے قریب تصدیق شدہ ڈاکٹرز مفت میں تلاش اور بک کریں۔',
          'referral_sehatkahani_desc': 'مصدقہ ڈاکٹروں کے ساتھ ویڈیو مشاورت۔',

          // ---------- inside 'ur_PK': { ... } ----------
'please_log_in': 'براہ کرم لاگ ان کریں',
'loading_dots': 'لوڈ ہو رہا ہے...',
'address_not_available': 'پتہ دستیاب نہیں',
'unable_to_fetch_address': 'پتہ حاصل کرنے میں ناکامی',
 
'profile_personal_information': 'ذاتی معلومات',
'label_full_name': 'پورا نام',
'label_email_address': 'ای میل ایڈریس',
'label_address': 'پتہ',
'label_phone_number': 'فون نمبر',
 
'update_password': 'پاس ورڈ تبدیل کریں',
'update_password_subtitle': 'اپنا موجودہ اور نیا پاس ورڈ درج کریں',
'current_password': 'موجودہ پاس ورڈ',
'new_password': 'نیا پاس ورڈ',
'confirm_password': 'پاس ورڈ کی تصدیق کریں',
'update': 'تبدیل کریں',
 
'confirm_password_change_title': 'پاس ورڈ تبدیلی کی تصدیق کریں؟',
'confirm_password_change_msg': 'کیا آپ واقعی اپنا پاس ورڈ تبدیل کرنا چاہتے ہیں؟',
'yes_update': 'جی ہاں، تبدیل کریں',
 
'success': 'کامیابی',
'success_password_updated': 'پاس ورڈ کامیابی سے تبدیل ہو گیا!',
 
'err_enter_current_password': 'براہ کرم اپنا موجودہ پاس ورڈ درج کریں',
'err_new_password_length': 'نیا پاس ورڈ کم از کم 6 حروف پر مشتمل ہونا چاہیے',
'err_new_password_same': 'نیا پاس ورڈ موجودہ پاس ورڈ سے مختلف ہونا چاہیے',
'err_passwords_mismatch': 'پاس ورڈز میل نہیں کھاتے',
'err_not_logged_in': 'آپ لاگ ان نہیں ہیں۔ براہ کرم دوبارہ لاگ ان کریں۔',
'err_wrong_password': 'موجودہ پاس ورڈ غلط ہے',
'err_requires_recent_login': 'براہ کرم لاگ آؤٹ کر کے دوبارہ لاگ ان کریں، پھر پاس ورڈ تبدیل کرنے کی کوشش کریں۔',
'err_too_many_requests': 'بہت زیادہ کوششیں۔ براہ کرم انتظار کریں اور بعد میں دوبارہ کوشش کریں۔',
'err_weak_password': 'نیا پاس ورڈ کمزور ہے۔ کم از کم 6 حروف استعمال کریں۔',
'err_user_not_found': 'صارف نہیں ملا۔ براہ کرم دوبارہ لاگ ان کریں۔',
'err_user_disabled': 'صارف اکاؤنٹ غیر فعال ہے۔ سپورٹ سے رابطہ کریں۔',
'err_network_request_failed': 'نیٹ ورک کی خرابی۔ براہ کرم اپنا انٹرنیٹ کنکشن چیک کریں۔',
'err_unexpected': 'ایک غیر متوقع خرابی پیش آگئی۔ براہ کرم دوبارہ کوشش کریں۔',
        },
      };
}