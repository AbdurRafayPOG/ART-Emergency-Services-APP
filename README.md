# ART Emergency Services 🚨

ART Emergency Services is a Flutter-based Android mobile application developed to address the critical gap in centralized emergency response infrastructure for the citizens of Karachi, Pakistan. It unifies six essential emergency service categories, namely **Helplines, Hospitals, Police Stations, Fire Stations, Pharmacies, and Blood Banks**, into a single, centralized, and accessible platform.

## 📖 About the Project

Emergency response in Pakistan, particularly Karachi, continues to rely on outdated and fragmented mechanisms. Citizens facing life-threatening situations are often forced to search across multiple scattered helplines and unreliable sources under extreme pressure, directly contributing to preventable casualties and delays in care. Emergency Service was built to solve this by delivering a centralized, intelligent, and structured mobile platform.

## ✨ Key Features

- 🔐 **Secure Authentication** — Firebase-powered registration and login, with mandatory email verification before access is granted
- 🗺️ **Real-Time GPS & Navigation** — Locates users and routes them to the nearest emergency service across all six categories via Google Maps
- 🆘 **SOS Emergency Management** — A one-tap SOS button transmits the user's precise location, automatically assigning the nearest available responder based on distance
- 👨‍⚕️ **Onboard Doctor** — Users can view doctor referrals and send an immediate consultation request, automatically assigned to an available doctor
- 📞 **Call & Video Call** — Direct call or video call access to the assigned responder or doctor for real-time communication, powered by Zegocloud (WebRTC)
- 🤖 **AI Assistant** — A Gemini API-powered chatbot delivering context-aware emergency and medical guidance
- 🌦️ **Live Weather Updates** — Real-time situational awareness on the dashboard
- 🌐 **Dual Language Support** — Full accessibility in English and Urdu
- 🧑‍💼 **Role-Based Dashboards** — Dedicated dashboards for Regular Users, Responders, Doctors, and Admin, each with role-specific access and an ON/OFF availability toggle for Responders and Doctors
- 🛡️ **Admin Dashboard** — Add, view, and remove doctors and responders, view and block users, and monitor the complete history of emergencies and consultations

## 🧑‍🤝‍🧑 User Roles

| Role | Description |
|------|-------------|
| **Regular User** | Accesses the dashboard, all six emergency service categories, SOS, Onboard Doctor, AI Assistant, and profile features |
| **Responder** | Receives automatically assigned SOS requests based on proximity; manages availability and responds via call/video call |
| **Onboard Doctor** | Receives automatically assigned consultation requests based on availability; manages availability and consults via call/video call |
| **Admin** | Manages doctors, responders, and users; monitors platform-wide activity history |

## 🛠️ Tech Stack

- **Framework:** Flutter (v3.18.0+), Dart (v3.9.2)
- **Backend:** Firebase Authentication, Firebase Realtime Database
- **Location Services:** Google Maps Flutter, Geolocator, Geocoding
- **Real-Time Communication:** Zegocloud (`zego_uikit_prebuilt_call`) using WebRTC
- **AI:** Gemini API
- **Weather:** OpenWeather API
- **State Management:** GetX (`get`)
- **Minimum SDK:** Android 8.0 (API Level 26)

## 📱 Screens

- Splash, Login, Sign Up, Forget Password
- Dashboard (with ARB Medical Center & Onboard Doctor widgets)
- Service Options (Map Display / Call)
- Doctor Options
- SOS Screen
- Profile (with Service History & language toggle)
- AI Assistant
- Responder Dashboard & Profile
- Doctor Dashboard & Profile
- Admin Screen

## 🌍 Scope

ART Emergency Services launches its first phase focused on **Karachi**, with a scalable system architecture designed to support future expansion across major cities in Pakistan.

## 🤝 Acknowledgements

**ARB Medical Centre**, a project of the Haseen Habib Foundation Trust, served as a technical assistance partner, providing system support and medical domain expertise that helped shape the platform's medical and consultation-related features.

**Onboard Doctor**, 6 certified doctors were onboarded onto the platform during the FYP Exhibition and University Job Fair.

**Project Showcase**, This project was displayed at the FYP Exhibition and the University Job Fair.



###  👨‍💻 Author
###  Abdur Rafay Imran
###  GitHub: https://github.com/AbdurRafayPOG
