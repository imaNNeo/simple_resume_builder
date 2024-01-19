import 'package:equatable/equatable.dart';

class ResumeData with EquatableMixin {
  final String fullName;
  final String location;
  final String email;
  final String linkedIn;
  final String github;
  final String summary;
  final List<WorkExperience> experience;
  final List<EducationHistory> education;
  final List<CommunityAndOpenSourceItem> communityAndOpenSource;
  final List<String> skills;
  final List<HonorAndAward> honorsAndAwards;

  ResumeData({
    required this.fullName,
    required this.location,
    required this.email,
    required this.linkedIn,
    required this.github,
    required this.summary,
    required this.experience,
    required this.education,
    required this.communityAndOpenSource,
    required this.skills,
    required this.honorsAndAwards,
  });

  factory ResumeData.fromJson(Map<String, dynamic> json) {
    return ResumeData(
      fullName: json['fullName'],
      location: json['location'],
      email: json['email'],
      linkedIn: json['linkedIn'],
      github: json['github'],
      summary: json['summary'],
      experience: List<WorkExperience>.from(
        json['experience'].map(
          (x) => WorkExperience.fromJson(x),
        ),
      ),
      education: List<EducationHistory>.from(
        json['education'].map(
          (x) => EducationHistory.fromJson(x),
        ),
      ),
      communityAndOpenSource: List<CommunityAndOpenSourceItem>.from(
        json['communityAndOpenSource'].map(
          (x) => CommunityAndOpenSourceItem.fromJson(x),
        ),
      ),
      skills: List<String>.from(
        json['skills'].map(
          (x) => x,
        ),
      ),
      honorsAndAwards: List<HonorAndAward>.from(
        json['honorsAndAwards'].map(
          (x) => HonorAndAward.fromJson(x),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'location': location,
        'email': email,
        'linkedIn': linkedIn,
        'github': github,
        'summary': summary,
        'experience': List<dynamic>.from(
          experience.map(
            (x) => x.toJson(),
          ),
        ),
        'education': List<dynamic>.from(
          education.map(
            (x) => x.toJson(),
          ),
        ),
        'communityAndOpenSource': List<dynamic>.from(
          communityAndOpenSource.map(
            (x) => x.toJson(),
          ),
        ),
        'skills': List<dynamic>.from(
          skills.map(
            (x) => x,
          ),
        ),
        'honorsAndAwards': List<dynamic>.from(
          honorsAndAwards.map(
            (x) => x.toJson(),
          ),
        ),
      };

  @override
  List<Object?> get props => [
        fullName,
        location,
        email,
        linkedIn,
        github,
        summary,
        experience,
        education,
        communityAndOpenSource,
        skills,
        honorsAndAwards,
      ];
}

class WorkExperience {
  final String company;
  final String? companyLogo;
  final String position;
  final String startDate;
  final String endDate;
  final List<String> summary;

  WorkExperience({
    required this.company,
    required this.companyLogo,
    required this.position,
    required this.startDate,
    required this.endDate,
    required this.summary,
  });

  factory WorkExperience.fromJson(Map<String, dynamic> json) {
    return WorkExperience(
      company: json['company'],
      companyLogo: json['companyLogo'],
      position: json['position'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      summary: List<String>.from(
        json['summary'].map(
          (x) => x,
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'company': company,
        'companyLogo': companyLogo,
        'position': position,
        'startDate': startDate,
        'endDate': endDate,
        'summary': List<dynamic>.from(
          summary.map(
            (x) => x,
          ),
        ),
      };
}

class EducationHistory {
  final String schoolName;
  final String? schoolLogo;
  final String degree;
  final String field;
  final String startDate;
  final String endDate;

  EducationHistory({
    required this.schoolName,
    required this.schoolLogo,
    required this.degree,
    required this.field,
    required this.startDate,
    required this.endDate,
  });

  factory EducationHistory.fromJson(Map<String, dynamic> json) {
    return EducationHistory(
      schoolName: json['schoolName'],
      schoolLogo: json['schoolLogo'],
      degree: json['degree'],
      field: json['field'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }

  Map<String, dynamic> toJson() => {
        'schoolName': schoolName,
        'schoolLogo': schoolLogo,
        'degree': degree,
        'field': field,
        'startDate': startDate,
        'endDate': endDate,
      };
}

class CommunityAndOpenSourceItem {
  final String title;
  final String? link;
  final String since;
  final String summary;
  final String logo;

  CommunityAndOpenSourceItem({
    required this.title,
    required this.link,
    required this.since,
    required this.summary,
    required this.logo,
  });

  factory CommunityAndOpenSourceItem.fromJson(Map<String, dynamic> json) {
    return CommunityAndOpenSourceItem(
      title: json['title'],
      link: json['link'],
      since: json['since'],
      summary: json['summary'],
      logo: json['logo'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'link': link,
        'since': since,
        'summary': summary,
        'logo': logo,
      };
}

class HonorAndAward {
  final String title;
  final String date;
  final String info;

  HonorAndAward({
    required this.title,
    required this.date,
    required this.info,
  });

  factory HonorAndAward.fromJson(Map<String, dynamic> json) {
    return HonorAndAward(
      title: json['title'],
      date: json['date'],
      info: json['info'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'date': date,
        'info': info,
      };
}
