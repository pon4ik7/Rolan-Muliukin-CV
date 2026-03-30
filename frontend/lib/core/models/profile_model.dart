class ProfileModel {
  ProfileModel({
    required this.name,
    required this.nameRu,
    required this.role,
    required this.roleRu,
    required this.headline,
    required this.headlineRu,
    required this.summary,
    required this.summaryRu,
    required this.availabilityBadge,
    required this.availabilityBadgeRu,
    required this.careerFocus,
    required this.careerFocusRu,
    required this.contacts,
    required this.links,
    required this.primaryStack,
    required this.techStack,
    required this.techStackRu,
    required this.education,
    required this.additionalEducation,
    required this.softSkills,
    required this.softSkillsRu,
  });

  final String name;
  final String nameRu;
  final String role;
  final String roleRu;
  final String headline;
  final String headlineRu;
  final String summary;
  final String summaryRu;
  final String availabilityBadge;
  final String availabilityBadgeRu;
  final String careerFocus;
  final String careerFocusRu;
  final ContactModel contacts;
  final LinksModel links;
  final List<String> primaryStack;
  final Map<String, List<String>> techStack;
  final Map<String, List<String>> techStackRu;
  final List<EducationModel> education;
  final List<EducationModel> additionalEducation;
  final List<String> softSkills;
  final List<String> softSkillsRu;

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final stack = <String, List<String>>{};
    final stackRu = <String, List<String>>{};
    final dynamicStack = json['techStack'] as Map<String, dynamic>? ?? {};
    final dynamicStackRu = json['techStackRu'] as Map<String, dynamic>? ?? {};

    for (final entry in dynamicStack.entries) {
      stack[entry.key] = (entry.value as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList();
    }
    for (final entry in dynamicStackRu.entries) {
      stackRu[entry.key] = (entry.value as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList();
    }

    return ProfileModel(
      name: json['name'] as String? ?? '',
      nameRu: json['nameRu'] as String? ?? '',
      role: json['role'] as String? ?? '',
      roleRu: json['roleRu'] as String? ?? '',
      headline: json['headline'] as String? ?? '',
      headlineRu: json['headlineRu'] as String? ?? '',
      summary: json['summary'] as String? ?? '',
      summaryRu: json['summaryRu'] as String? ?? '',
      availabilityBadge: json['availabilityBadge'] as String? ?? '',
      availabilityBadgeRu: json['availabilityBadgeRu'] as String? ?? '',
      careerFocus: json['careerFocus'] as String? ?? '',
      careerFocusRu: json['careerFocusRu'] as String? ?? '',
      contacts: ContactModel.fromJson(json['contacts'] as Map<String, dynamic>?),
      links: LinksModel.fromJson(json['links'] as Map<String, dynamic>?),
      primaryStack: (json['primaryStack'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      techStack: stack,
      techStackRu: stackRu,
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
      softSkillsRu: (json['softSkillsRu'] as List<dynamic>? ?? [])
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
    required this.locationRu,
  });

  final String phone;
  final String email;
  final String telegram;
  final String location;
  final String locationRu;

  factory ContactModel.fromJson(Map<String, dynamic>? json) {
    return ContactModel(
      phone: json?['phone'] as String? ?? '',
      email: json?['email'] as String? ?? '',
      telegram: json?['telegram'] as String? ?? '',
      location: json?['location'] as String? ?? '',
      locationRu: json?['locationRu'] as String? ?? '',
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
    required this.institutionRu,
    required this.program,
    required this.programRu,
    required this.gpa,
    required this.period,
    required this.periodRu,
    required this.details,
    required this.detailsRu,
  });

  final String institution;
  final String institutionRu;
  final String program;
  final String programRu;
  final String gpa;
  final String period;
  final String periodRu;
  final String details;
  final String detailsRu;

  factory EducationModel.fromJson(Map<String, dynamic>? json) {
    return EducationModel(
      institution: json?['institution'] as String? ?? '',
      institutionRu: json?['institutionRu'] as String? ?? '',
      program: json?['program'] as String? ?? '',
      programRu: json?['programRu'] as String? ?? '',
      gpa: json?['gpa'] as String? ?? '',
      period: json?['period'] as String? ?? '',
      periodRu: json?['periodRu'] as String? ?? '',
      details: json?['details'] as String? ?? '',
      detailsRu: json?['detailsRu'] as String? ?? '',
    );
  }
}
