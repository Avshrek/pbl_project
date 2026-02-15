# OnSight: Digital Forensic Evidence Identification Assistant

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![GitHub Pages](https://img.shields.io/badge/Docs-GitHub%20Pages-blue)](https://avshrek.github.io/pbl_project/)

> **The Offline-First, AI-Augmented Intelligence for Forensic First Responders**

OnSight is a mobile, offline-first forensic support system designed to bridge the critical gap in the identification phase of digital investigations. By combining Computer Vision, Signal Analysis, and Rule-Based Knowledge Graphs, OnSight helps investigators identify, prioritize, and legally preserve digital evidence at crime scenes—ensuring no data is left behind and every action is legally defensible.

---

## 🎯 Problem Statement

Modern crime scenes contain numerous potential digital evidence sources (phones, IoT devices, cloud accounts, wearables, surveillance systems), yet investigators often rely on memory or generic checklists during the critical identification phase. This leads to:

- **High omission rates** - Critical evidence missed at the scene
- **Volatile data loss** - RAM, active sessions, and ephemeral data lost
- **Inconsistent procedures** - Lack of standardization across investigations
- **Legal vulnerabilities** - Incomplete documentation and chain-of-custody gaps

OnSight addresses these challenges by providing an intelligent, context-aware assistant that standardizes the identification process and augments investigator expertise.

---

## ✨ Key Features

### 🔍 **AR Evidence Overlay**
Real-time object detection using YOLO/EfficientDet models to scan crime scenes through the camera viewfinder. The system draws bounding boxes around potential evidence (routers, gaming consoles, sticky notes, devices) ensuring exhaustive visual discovery.

### 📡 **"Silent Sniffer" Spectrum Analysis**
Leverages native Wi-Fi and Bluetooth antennas to detect invisible, active signals in the vicinity. Identifies hidden devices like:
- Concealed Raspberry Pi systems
- Dropped AirTags or tracking devices
- Hidden smart cameras
- Active wireless surveillance equipment

### ⏱️ **"Volatility Countdown" Triage Engine**
Implements RFC 3227 Order of Volatility standards to automatically rank evidence by urgency rather than proximity. Critical items like RAM contents or active cloud sessions are flagged "Red" (Immediate Action Required) to prevent data loss from battery death or session timeouts.

### ⚖️ **"Legal Compass" Jurisdictional AI**
Rule-based compliance engine that cross-references crime types with seizure regulations. Proactively warns investigators against legal overreach (e.g., "Do not seize personal devices without specific warrant; limit scope to company assets") to prevent evidence dismissal in court.

### 🔐 **"Chain of Genesis" Integrity Ledger**
Creates cryptographic SHA-256 hashes for every photo, note, and action at the exact moment of capture. Establishes an immutable audit trail from "Second Zero" that mathematically proves scene documentation was never altered, ensuring bulletproof chain of custody.

### 📋 **Context-Aware Recommendations**
Provides specific, explainable instructions instead of generic advice:
> "Seize Laptop immediately; high risk of remote wipe. Use Faraday Bag. Check screen for active cloud sessions before closing lid."

### 📄 **Automated ISO/IEC 27037 Compliant Reports**
Auto-generates timestamped, hash-verified PDF reports containing:
- All identified evidence items
- Actions taken with timestamps
- Reasoning behind each decision
- Complete audit trail
- Ready for handover to forensic labs

---

## 🏗️ Technical Architecture

### **Frontend**
- **Framework:** Flutter (Dart) for cross-platform native iOS/Android compilation
- **UI:** Responsive, offline-first mobile interface optimized for field use

### **Local Intelligence (The Brain)**
- **Inference Engine:** TensorFlow Lite for on-device object detection
- **Computer Vision:** YOLO v5/v8 and EfficientDet models
- **NLP Processing:** Entity extraction from scene descriptions
- **Logic Core:** Custom Rule-Based Expert System using Forensic Knowledge Graphs

### **Data Persistence (The Vault)**
- **Database:** Drift (SQLite abstraction) / Realm
- **Security:** SQLCipher with AES-256 encryption
- **Format:** JSON Knowledge Graphs for device-to-artifact mapping

### **Signal & Detection**
- **Wireless:** Native Wi-Fi API access for spectrum scanning
- **Bluetooth:** BLE scanning for device discovery
- **AR:** ARCore (Android) / ARKit (iOS) for augmented reality overlay

### **Security & Compliance**
- **Hashing:** SHA-256 cryptographic integrity verification
- **Standards:** ISO/IEC 27037, RFC 3227 compliance
- **Audit:** Immutable timestamped action logs

### **Output & Integration**
- **Reports:** PDF generation with legal compliance
- **Export:** JSON/CSV for forensic suite integration
- **Compatible:** Autopsy, EnCase, X-Ways Forensics

---

## 📊 Expected Outcomes

| Metric | Target |
|--------|--------|
| Evidence Recognition Accuracy | 95%+ |
| Reduction in Omission Errors | 40% |
| Scene Assessment Speed | 60% faster |
| Audit Trail Coverage | 100% |

### **Impact Areas**

**Investigative Quality**
- Improved completeness of evidence identification
- Reduced cognitive burden on investigators
- Standardized procedures across cases and personnel

**Operational Efficiency**
- Faster scene processing and evidence triage
- Reduced revisits to crime scenes
- Better resource allocation for collection and analysis phases

**Legal Defensibility**
- Comprehensive documentation with cryptographic audit trails
- Explainable reasoning for all evidence decisions
- Court-defensible methodology and chain of custody

**Training Support**
- Educational tool for new investigators
- Knowledge base encoding of expert forensic practices
- Repeatable test scenarios for skill development

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0+)
- Dart (3.0+)
- Android Studio / Xcode
- Git

### Installation

```bash
# Clone the repository
git clone https://github.com/Avshrek/pbl_project.git

# Navigate to project directory
cd pbl_project

# Install dependencies
flutter pub get

# Run the application
flutter run
```

### Building for Production

```bash
# Android APK
flutter build apk --release

# iOS
flutter build ios --release

# App Bundle (for Google Play)
flutter build appbundle --release
```

---

## 📁 Project Structure

```
pbl_project/
├── lib/
│   ├── main.dart                 # Application entry point
│   ├── models/                   # Data models and entities
│   ├── services/                 # Business logic and services
│   │   ├── ar_detection/         # AR object detection service
│   │   ├── signal_analysis/      # Wi-Fi/Bluetooth scanning
│   │   ├── knowledge_graph/      # Forensic rule engine
│   │   └── crypto_ledger/        # SHA-256 integrity service
│   ├── screens/                  # UI screens and views
│   ├── widgets/                  # Reusable UI components
│   └── utils/                    # Helper functions and constants
├── android/                      # Android-specific code
├── ios/                          # iOS-specific code
├── assets/                       # Images, fonts, knowledge graphs
├── test/                         # Unit and widget tests
├── pubspec.yaml                  # Project dependencies
└── README.md                     # This file
```

---

## 🔧 Technology Stack

**Mobile Development**
- Flutter, Dart, Material Design

**AI & ML**
- TensorFlow Lite, YOLO, EfficientDet, spaCy

**Database & Storage**
- SQLite, Drift, Realm, SQLCipher

**Signal Processing**
- Native Wi-Fi APIs, Bluetooth LE

**AR & Computer Vision**
- ARCore, ARKit, OpenCV

**Security & Compliance**
- SHA-256, AES-256, ISO/IEC 27037, RFC 3227

**Integration**
- JSON, CSV, PDF generation, Autopsy/EnCase compatibility

---

## 🎓 Academic Context

**Project Type:** PBL (Project-Based Learning) Final Year Project  
**Institution:** Manipal University Jaipur  
**Department:** Computer Science & Engineering  
**Year:** 2026  

**Project Guide:** Dr. Santoshi Rudrakar  
**Developer:** Abhishek Chaturvedi - Registration Number: 2427030163

---

## 📖 Documentation

For detailed documentation, architecture diagrams, and user guides, visit:
**[https://avshrek.github.io/pbl_project/](https://avshrek.github.io/pbl_project/)**

---

## 🤝 Contributing

This is an academic project, but suggestions and feedback are welcome:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🔗 Links

- **Project Website:** [https://avshrek.github.io/pbl_project/](https://avshrek.github.io/pbl_project/)
- **GitHub Repository:** [https://github.com/Avshrek/pbl_project](https://github.com/Avshrek/pbl_project)
- **Documentation:** [Project Docs](https://avshrek.github.io/pbl_project/)

---

## 📧 Contact

For queries, suggestions, or collaboration opportunities:

- **Email:** [abhichaturvedi941@gmail.com]
- **GitHub:** [@Avshrek](https://github.com/Avshrek)
- **Project Issues:** [GitHub Issues](https://github.com/Avshrek/pbl_project/issues)

---

## 🙏 Acknowledgments

- Manipal University Jaipur - Department of Computer Science & Engineering
- Project Guide: Dr. Santoshi Rudrakar
- Digital Forensics Research Community
- Open-source contributors to Flutter, TensorFlow Lite, and related technologies

---

<p align="center">
  <strong>OnSight - Empowering First Responders with AI-Augmented Forensic Intelligence</strong>
  <br>
  <sub>A force multiplier for law enforcement in the digital age</sub>
</p>

---

**⭐ If you find this project useful, please consider giving it a star!**
