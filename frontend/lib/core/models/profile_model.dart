class ProfileModel {
  ProfileModel({
    required this.name,
    required this.role,
    required this.headline,
    required this.summary,
    required this.summaryRu,
    required this.availabilityBadge,
    required this.careerFocus,
    required this.careerFocusRu,
    required this.contacts,
    required this.links,
    required this.primaryStack,
    required this.techStack,
    required this.education,
    required this.additionalEducation,
    required this.softSkills,
  });

  final String name;
  final String role;
  final String headline;
  final String summary;
  final String summaryRu;
  final String availabilityBadge;
  final String careerFocus;
  final String careerFocusRu;
  final ContactModel contacts;
  final LinksModel links;
  final List<String> primaryStack;
  final Map<String, List<String>> techStack;
  final List<EducationModel> education;
  final List<EducationModel> additionalEducation;
  final List<String> softSkills;

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final stack = <String, List<String>>{};
    final dynamicStack = json['techStack'] as Map<String, dynamic>? ?? {};

    for (final entry in dynamicStack.entries) {
      stack[entry.key] = (entry.value as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList();
    }

    return ProfileModel(
      name: json['name'] as String? ?? '',
      role: json['role'] as String? ?? '',
      headline: json['headline'] as String? ?? '',
      summary: json['summary'] as String? ?? '',
      summaryRu: json['summaryRu'] as String? ?? '',
      availabilityBadge: json['availabilityBadge'] as String? ?? '',
      careerFocus: json['careerFocus'] as String? ?? '',
      careerFocusRu: json['careerFocusRu'] as String? ?? '',
      contacts: ContactModel.fromJson(json['contacts'] as Map<String, dynamic>?),
      links: LinksModel.fromJson(json['links'] as Map<String, dynamic>?),
      primaryStack: (json['primaryStack'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      techStack: stack,
      education: (json['education'] as List<dynamic>? ?? [])
          .map(
            (item) => EducationModel.fromJson(item as Map<String, dynamic>?),
          )
          .toList(),
      additionalEducation:
          (json['additionalEducation'] as List<dynamic>? ?? [])
              .map(
                (item) => EducationModel.fromJson(item as Map<String, dynamic>?),
              )
              .toList(),
      softSkills: (json['softSkills'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}

class ContactModel {
  ContactModel({
    required this.phone,
    required this.email,
    required this.telegram,
    required this.location,
  });

  final String phone;
  final String email;
  final String telegram;
  final String location;

  factory ContactModel.fromJson(Map<String, dynamic>? json) {
    return ContactModel(
      phone: json?['phone'] as String? ?? '',
      email: json?['email'] as String? ?? '',
      telegram: json?['telegram'] as String? ?? '',
      location: json?['location'] as String? ?? '',
    );
  }
}

class LinksModel {
  LinksModel({
    required this.github,
    required this.leetcode,
    required this.codeforces,
    required this.telegram,
    required this.university,
    required this.cvDownload,
    required this.cvDownloadEn,
    required this.cvDownloadRu,
    required this.contactMail,
  });

  final String github;
  final String leetcode;
  final String codeforces;
  final String telegram;
  final String university;
  final String cvDownload;
  final String cvDownloadEn;
  final String cvDownloadRu;
  final String contactMail;

  bool get hasCvEn => cvDownloadEn.isNotEmpty && !cvDownloadEn.startsWith('TODO_');
  bool get hasCvRu => cvDownloadRu.isNotEmpty && !cvDownloadRu.startsWith('TODO_');

  factory LinksModel.fromJson(Map<String, dynamic>? json) {
    final legacyCv = json?['cvDownload'] as String? ?? '';
    return LinksModel(
      github: json?['github'] as String? ?? '',
      leetcode: json?['leetcode'] as String? ?? '',
      codeforces: json?['codeforces'] as String? ?? '',
      telegram: json?['telegram'] as String? ?? '',
      university: json?['university'] as String? ?? '',
      cvDownload: legacyCv,
      cvDownloadEn: json?['cvDownloadEn'] as String? ?? legacyCv,
      cvDownloadRu: json?['cvDownloadRu'] as String? ?? '',
      contactMail: json?['contactMail'] as String? ?? '',
    );
  }
}

class EducationModel {
  EducationModel({
    required this.institution,
    required this.program,
    required this.gpa,
    required this.period,
    required this.details,
  });

  final String institution;
  final String program;
  final String gpa;
  final String period;
  final String details;

  factory EducationModel.fromJson(Map<String, dynamic>? json) {
    return EducationModel(
      institution: json?['institution'] as String? ?? '',
      program: json?['program'] as String? ?? '',
      gpa: json?['gpa'] as String? ?? '',
      period: json?['period'] as String? ?? '',
      details: json?['details'] as String? ?? '',
    );
  }
}
