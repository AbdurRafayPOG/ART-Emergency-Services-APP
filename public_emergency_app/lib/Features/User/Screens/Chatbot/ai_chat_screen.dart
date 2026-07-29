import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'api_config.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  Position? _currentPosition;
  String _locationInfo = "Karachi, Pakistan";
  String _selectedLanguage = "English";
  bool _stopRequested = false;

  bool _isUrduScript(String text) {
    final urduRegex = RegExp(r'[\u0600-\u06FF]');
    return urduRegex.hasMatch(text);
  }

  @override
  void initState() {
    super.initState();
    _showLanguageDialog();
    _getCurrentLocation();
  }

  void _showLanguageDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              _selectedLanguage == "Urdu" ? "زبان منتخب کریں" : "Select Language",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F4C5C),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _selectedLanguage == "Urdu" 
                      ? "براہ کرم اپنی پسندیدہ زبان منتخب کریں"
                      : "Please select your preferred language",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildLanguageButton("English"),
                    _buildLanguageButton("Urdu"),
                  ],
                ),
              ],
            ),
          );
        },
      );
    });
  }

  Widget _buildLanguageButton(String language) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLanguage = language;
        });
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F4C5C),
              Color(0xFF1A7A8C),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0F4C5C).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          language,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _locationInfo = "Karachi, Pakistan";
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _locationInfo = "Karachi, Pakistan";
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _locationInfo = "Karachi, Pakistan";
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      
      _currentPosition = position;
      await _getLocationDetails(position.latitude, position.longitude);
      
    } catch (e) {
      setState(() {
        _locationInfo = "Karachi, Pakistan";
      });
    }
  }

  Future<void> _getLocationDetails(double lat, double lng) async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$lng&format=json&accept-language=en"
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final address = data["address"] ?? {};
        
        String area = address["suburb"] ?? 
                      address["neighbourhood"] ?? 
                      address["city_district"] ?? 
                      "";
        
        String city = address["city"] ?? 
                     address["town"] ?? 
                     address["village"] ?? 
                     "Karachi";
        
        String country = address["country"] ?? "Pakistan";
        
        String location = area.isNotEmpty ? "$area, $city" : "$city, $country";
        
        setState(() {
          _locationInfo = location;
        });
      } else {
        setState(() {
          _locationInfo = "Karachi, Pakistan";
        });
      }
    } catch (e) {
      setState(() {
        _locationInfo = "Karachi, Pakistan";
      });
    }
  }

  void _stopGeneration() {
    setState(() {
      _stopRequested = true;
      _isLoading = false;
    });
    Get.snackbar(
      _selectedLanguage == "Urdu" ? "رک گیا" : "Stopped",
      _selectedLanguage == "Urdu" ? "جواب روک دیا گیا" : "Response stopped",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      duration: const Duration(seconds: 1),
    );
  }

  Future<void> _sendMessage(String text) async {
    if (text.isEmpty) return;

    _stopRequested = false;

    setState(() {
      _messages.add({"role": "user", "text": text});
      _isLoading = true;
    });
    _controller.clear();
    _scrollToBottom();

    String responseLanguage;
    String languageInstruction;
    
    if (_selectedLanguage == "Urdu") {
      responseLanguage = "Urdu";
      languageInstruction = "Respond ONLY in URDU language using Urdu script (اردو). Write in proper Urdu. ALWAYS use Urdu script regardless of what language the user wrote in. Do NOT use English.";
    } else {
      responseLanguage = "English";
      languageInstruction = "Respond ONLY in ENGLISH language. Do NOT use Urdu. Always respond in English regardless of what language the user wrote in.";
    }

    String prompt = """
You are an emergency and medical assistant.

CRITICAL LANGUAGE INSTRUCTION: $languageInstruction

Location: $_locationInfo

The user asked: "$text"

Give helpful, practical, step-by-step advice for emergencies and medical situations.
If the question is not about emergencies or medical issues, politely decline.

Use **bold** for emergency numbers like 1122, 15, 16.
Use numbered steps (1., 2., 3.) for procedures.
Use bullet points for lists.
Keep paragraphs short and readable.

Your response MUST be in $responseLanguage.
""";

    try {
      final response = await http.post(
        Uri.parse(ApiConfig.geminiApiUrl),
        headers: {
          "Authorization": "Bearer ${ApiConfig.geminiApiKey}",
          "Content-Type": "application/json",
          "HTTP-Referer": "https://your-app.com",
          "X-Title": "Emergency AI Assistant",
        },
        body: jsonEncode({
          "model": "google/gemini-3.5-flash",
          "messages": [
            {
              "role": "system",
              "content": "You are a helpful emergency and medical expert. Provide clear, practical, life-saving advice. Format with **bold**, numbered steps, and bullet points. CRITICAL: You must follow the language instruction in the user's message EXACTLY."
            },
            {
              "role": "user",
              "content": prompt
            }
          ],
          "temperature": 0.7,
          "max_tokens": 2000,
          "top_p": 0.9,
          "top_k": 50,
        }),
      );

      if (_stopRequested) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      String fallbackRefusal = _selectedLanguage == "Urdu"
          ? "میں صرف ہنگامی حالات اور طبی صحت کے سوالات میں آپ کی مدد کر سکتا ہوں۔"
          : "I can only assist with emergencies and medical health questions.";

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String reply = data["choices"]?[0]?["message"]?["content"] ?? fallbackRefusal;
        
        setState(() {
          _messages.add({"role": "assistant", "text": reply.trim()});
        });
        _scrollToBottom();
      } else {
        setState(() {
          _messages.add({
            "role": "assistant",
            "text": "Error ${response.statusCode}: Please try again.",
          });
        });
      }
    } catch (e) {
      if (!_stopRequested) {
        setState(() {
          _messages.add({
            "role": "assistant",
            "text": _selectedLanguage == "Urdu"
                ? "⚠️ کنکشن کی خرابی۔ براہ کرم دوبارہ کوشش کریں۔"
                : "⚠️ Connection error. Please try again.",
          });
        });
      }
    } finally {
      if (!_stopRequested) {
        setState(() {
          _isLoading = false;
        });
        _scrollToBottom();
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _renderFormattedMessage(String messageText, bool isUser) {
    List<Widget> textSpans = [];
    final lines = messageText.split('\n');

    for (var line in lines) {
      if (line.trim().isEmpty) continue;

      Widget lineWidget;
      double leftPadding = 0.0;
      double topPadding = 2.0;
      double bottomPadding = 2.0;
      
      bool isHeader3 = line.trim().startsWith('###');
      bool isHeader2 = line.trim().startsWith('##');
      bool isHeader1 = line.trim().startsWith('#');
      
      String cleanLine = line;
      TextStyle customTextStyle = TextStyle(
        color: isUser ? Colors.white : Colors.black87,
        fontSize: 14,
        height: 1.4,
      );

      if (isHeader3) {
        cleanLine = line.replaceFirst('###', '').trim();
        customTextStyle = TextStyle(
          color: isUser ? Colors.white : const Color(0xFF0F4C5C),
          fontSize: 16,
          fontWeight: FontWeight.bold,
          height: 1.5,
        );
        topPadding = 8.0;
        bottomPadding = 4.0;
      } else if (isHeader2) {
        cleanLine = line.replaceFirst('##', '').trim();
        customTextStyle = TextStyle(
          color: isUser ? Colors.white : const Color(0xFF0F4C5C),
          fontSize: 18,
          fontWeight: FontWeight.bold,
          height: 1.5,
        );
        topPadding = 10.0;
        bottomPadding = 6.0;
      } else if (isHeader1) {
        cleanLine = line.replaceFirst('#', '').trim();
        customTextStyle = TextStyle(
          color: isUser ? Colors.white : const Color(0xFF0F4C5C),
          fontSize: 20,
          fontWeight: FontWeight.bold,
          height: 1.6,
        );
        topPadding = 12.0;
        bottomPadding = 6.0;
      }

      String trimmedLine = cleanLine.trim();
      bool isBullet = trimmedLine.startsWith('*') || 
                      trimmedLine.startsWith('-') || 
                      trimmedLine.startsWith('•') ||
                      trimmedLine.startsWith('---') ||
                      trimmedLine.startsWith('--');
      
      bool isNumeric = RegExp(r'^\d+\.\s+').hasMatch(trimmedLine);

      String displayText = cleanLine;
      String marker = "";
      bool hasMarker = false;
      
      if (isBullet) {
        displayText = cleanLine.replaceFirst(RegExp(r'^[\*\-•]+\s*'), '');
        displayText = displayText.replaceFirst(RegExp(r'^[\-]+\s*'), '');
        marker = "• ";
        leftPadding = 12.0;
        hasMarker = true;
      } else if (isNumeric) {
        final match = RegExp(r'^(\d+)\.\s+').firstMatch(trimmedLine);
        if (match != null) {
          marker = "${match.group(1)}. ";
          displayText = cleanLine.replaceFirst(RegExp(r'^\d+\.\s*'), '');
          leftPadding = 12.0;
          hasMarker = true;
        }
      }

      List<TextSpan> spans = [];
      final inlineRegex = RegExp(r'(\*\*(.*?)\*\*)|(\*(.*?)\*)|(\_(.*?)\_)');
      int lastIndex = 0;

      for (var match in inlineRegex.allMatches(displayText)) {
        if (match.start > lastIndex) {
          spans.add(TextSpan(text: displayText.substring(lastIndex, match.start)));
        }

        if (match.group(2) != null) {
          spans.add(TextSpan(
            text: match.group(2),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ));
        } else if (match.group(4) != null) {
          spans.add(TextSpan(
            text: match.group(4),
            style: const TextStyle(fontStyle: FontStyle.italic),
          ));
        } else if (match.group(6) != null) {
          spans.add(TextSpan(
            text: match.group(6),
            style: const TextStyle(decoration: TextDecoration.underline),
          ));
        }
        lastIndex = match.end;
      }

      if (lastIndex < displayText.length) {
        spans.add(TextSpan(text: displayText.substring(lastIndex)));
      }

      if (hasMarker) {
        lineWidget = Padding(
          padding: EdgeInsets.only(left: leftPadding, top: topPadding, bottom: bottomPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                marker,
                style: TextStyle(
                  color: isUser ? Colors.white70 : const Color(0xFF0F4C5C),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Expanded(
                child: SelectableText.rich(
                  TextSpan(
                    style: customTextStyle,
                    children: spans,
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        lineWidget = Padding(
          padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
          child: SelectableText.rich(
            TextSpan(
              style: customTextStyle,
              children: spans,
            ),
          ),
        );
      }
      textSpans.add(lineWidget);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: textSpans,
    );
  }

  Widget _buildTopicCard(String label, String subtitle, String query, IconData icon) {
    return GestureDetector(
      onTap: () => _sendMessage(query),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF0F4C5C).withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: const Color(0xFF0F4C5C), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF14313A),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.grey.shade500,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.chevron_right_rounded, size: 20, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final double topPadding = (screenHeight * 0.035).clamp(15.0, 40.0);
    final double iconHeight = (screenHeight * 0.055).clamp(36.0, 52.0);
    final double buttonSize = (screenWidth * 0.11).clamp(36.0, 48.0);
    final double fixedAppBarHeight = (screenHeight * 0.12).clamp(90.0, 130.0);
    final double backButtonTop = topPadding + (iconHeight / 2) - (buttonSize / 2) - 6;

    bool isUrdu = _selectedLanguage == "Urdu";

    final List<Map<String, dynamic>> topics = isUrdu
        ? [
            {"label": "سی پی آر کیسے کریں", "subtitle": "دل کی دھڑکن رکنے پر مراحل", "query": "سی پی آر کیسے کریں", "icon": Icons.monitor_heart_outlined},
            {"label": "فرسٹ ایڈ بنیادی باتیں", "subtitle": "ہر صورتحال کے لیے بنیادی اصول", "query": "فرسٹ ایڈ کے بنیادی اصول کیا ہیں", "icon": Icons.medical_services_outlined},
            {"label": "جلنے کا علاج", "subtitle": "فوری دیکھ بھال کے اقدامات", "query": "جلنے کی صورت میں فرسٹ ایڈ کیسے دیں", "icon": Icons.local_fire_department_outlined},
            {"label": "دم گھٹنے پر عمل", "subtitle": "بالغ اور بچوں کے لیے طریقہ", "query": "دم گھٹنے کی صورت میں کیا کریں", "icon": Icons.air_outlined},
            {"label": "خون بہنے پر کنٹرول", "subtitle": "زخم کو دبانے اور باندھنے کا طریقہ", "query": "زخم سے خون بہنے کو کیسے روکیں", "icon": Icons.healing_outlined},
          ]
        : [
            {"label": "How to perform CPR", "subtitle": "Steps for cardiac arrest response", "query": "How do I perform CPR step by step", "icon": Icons.monitor_heart_outlined},
            {"label": "First aid basics", "subtitle": "Core principles for any situation", "query": "What are the basics of first aid", "icon": Icons.medical_services_outlined},
            {"label": "Treating a burn", "subtitle": "Immediate care and next steps", "query": "How do I give first aid for a burn", "icon": Icons.local_fire_department_outlined},
            {"label": "Choking response", "subtitle": "For adults, children, and infants", "query": "What should I do if someone is choking", "icon": Icons.air_outlined},
            {"label": "Controlling bleeding", "subtitle": "Pressure, wrapping, and warning signs", "query": "How do I control severe bleeding from a wound", "icon": Icons.healing_outlined},
          ];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade50,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(fixedAppBarHeight + topPadding),
        child: Container(
          padding: EdgeInsets.only(top: topPadding),
          decoration: const BoxDecoration(
            color: Color(0xFF0F4C5C),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(24),
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
                      width: iconHeight,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                      isAntiAlias: true,
                      cacheHeight: (iconHeight * MediaQuery.of(context).devicePixelRatio).round(),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isUrdu ? "اے آئی اسسٹنٹ" : "AI Assistant",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isUrdu ? "طبی رہنمائی، تسلی بخش اور واضح" : "Clear, trustworthy health guidance",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.75),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 12,
                top: backButtonTop,
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
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: const Color(0xFF0F4C5C),
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          if (_messages.isEmpty)
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 4),
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0F4C5C).withOpacity(0.08),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.health_and_safety_outlined,
                            size: 30,
                            color: Color(0xFF0F4C5C),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          isUrdu
                              ? "ہیلو، میں آپ کا اے آئی اسسٹنٹ ہوں"
                              : "Hello, I'm your AI Assistant",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F4C5C),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          isUrdu
                              ? "طبی سوالات اور فرسٹ ایڈ کے مراحل میں رہنمائی کے لیے پوچھیں"
                              : "Ask about first aid, CPR, and everyday medical concerns",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.5,
                            color: Colors.grey.shade600,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            isUrdu ? "مشہور موضوعات" : "Common topics",
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF14313A),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 4),
                      itemCount: topics.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final t = topics[index];
                        return _buildTopicCard(
                          t["label"] as String,
                          t["subtitle"] as String,
                          t["query"] as String,
                          t["icon"] as IconData,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 14),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F4C5C).withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF0F4C5C).withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            size: 16,
                            color: const Color(0xFF0F4C5C),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              isUrdu
                                  ? "یہ اسسٹنٹ عمومی رہنمائی فراہم کرتا ہے اور پیشہ ورانہ طبی مشورے کا متبادل نہیں ہے۔"
                                  : "This assistant offers general guidance and is not a substitute for professional medical advice.",
                              style: TextStyle(
                                fontSize: 11.5,
                                color: Colors.grey.shade700,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (_messages.isNotEmpty)
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(12),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  final isUser = msg["role"] == "user";
                  final text = msg["text"] ?? "";

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Align(
                      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          gradient: isUser
                              ? const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF0F4C5C),
                                    Color(0xFF1A7A8C),
                                  ],
                                )
                              : null,
                          color: isUser ? null : Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(isUser ? 16 : 4),
                            topRight: Radius.circular(isUser ? 4 : 16),
                            bottomLeft: const Radius.circular(16),
                            bottomRight: const Radius.circular(16),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(isUser ? 0.1 : 0.05),
                              blurRadius: isUser ? 12 : 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!isUser)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 18,
                                      height: 18,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF0F4C5C),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.health_and_safety_outlined,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      isUrdu ? "میڈیکل اسسٹنٹ" : "Medical Assistant",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF0F4C5C),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            _renderFormattedMessage(text, isUser),
                            const SizedBox(height: 4),
                            Text(
                              _getTimeString(),
                              style: TextStyle(
                                fontSize: 9,
                                color: isUser ? Colors.white70 : Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFF0F4C5C),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        isUrdu ? "سوچ رہا ہوں..." : "Thinking...",
                        style: const TextStyle(
                          color: Color(0xFF0F4C5C),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 6, 8, 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                        hintText: isUrdu ? "یہاں لکھیں..." : "Ask me anything...",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        suffixIcon: _controller.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(
                                  Icons.close_rounded,
                                  color: Colors.grey.shade400,
                                  size: 18,
                                ),
                                onPressed: () {
                                  _controller.clear();
                                  setState(() {});
                                },
                              )
                            : null,
                      ),
                      textInputAction: TextInputAction.send,
                      onChanged: (value) => setState(() {}),
                      onSubmitted: (value) => _sendMessage(value),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                if (_isLoading)
                  GestureDetector(
                    onTap: _stopGeneration,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.red.shade400,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.shade400.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.stop_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            isUrdu ? "روکیں" : "Stop",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: _controller.text.isNotEmpty
                          ? const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF0F4C5C),
                                Color(0xFF1A7A8C),
                              ],
                            )
                          : LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.grey.shade300,
                                Colors.grey.shade400,
                              ],
                            ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        if (_controller.text.isNotEmpty)
                          BoxShadow(
                            color: const Color(0xFF0F4C5C).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: _controller.text.isNotEmpty && !_isLoading
                          ? () => _sendMessage(_controller.text)
                          : null,
                      padding: EdgeInsets.zero,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getTimeString() {
    final now = DateTime.now();
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }
}