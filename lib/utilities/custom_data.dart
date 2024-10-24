

class CustomData {
  final String name;
  final String jobTitle;
  final String location;
  final String phone;
  final String email;
  final String linkedIn;
  final String github;
  final String objective;
  final List<Education> education;
  final List<String> skills;
  final List<Experience> experience;
  final List<Project> projects;
  final List<Extracurricular> extracurricular;

  
  const CustomData._({
    required this.name,
    required this.jobTitle,
    required this.location,
    required this.phone,
    required this.email,
    required this.linkedIn,
    required this.github,
    required this.objective,
    required this.education,
    required this.skills,
    required this.experience,
    required this.projects,
    required this.extracurricular,
  });

  
  static const instance = CustomData._(
    name: 'Vikas Kewat',
    jobTitle: 'Software & App Developer',
    location: 'Mumbai, India',
    phone: '+91 8169662532',
    email: 'vikaskewat025@gmail.com',
    linkedIn: 'linkedin.com/in/vikas-kewat-078a0a256/',
    github: 'github.com/codesbyvikas',
    objective:
        'Detail-oriented software and app developer with expertise in programming languages and development methodologies. Seeking to build scalable, efficient software and mobile solutions.',
    education: [
      Education(
        institution:
            'D.J Sanghavi College of Engineering - Bachelor of Technology in Computer Engineering',
        degree: '',
      ),
      Education(
        institution:
            'R.K Talreja College of Arts, Commerce and Science - Higher Secondary School Certificate',
        degree: '',
      ),
      Education(
        institution:
            'S.E.S English Medium High School - Secondary School Certificate',
        degree: '',
      ),
    ],
    skills: [
      'Languages: Dart, Java, Python, C, MySQL, JavaScript, HTML/CSS',
      'Frameworks: Flutter, Firebase',
      'Developer Tools: Git, GitHub, Postman, VS Code',
    ],
    experience: [
      Experience(
        title: 'App Developer Intern | Eventory',
        description:
            '• Contributed to the development of the company’s partner-facing mobile application.\n'
            '• Implemented BLoC architecture for efficient state management and streamlined user interactions.\n'
            '• Successfully integrated the app with backend APIs, ensuring smooth data flow and enhanced functionality.',
      ),
    ],
    projects: [
      Project(
        title:
            'Hotels Booking Application | Flutter, Dart, Postman, Firebase, Rest API',
        description:
            '• Developed a Hotel Booking Application with Flutter.\n'
            '• Implemented Authentication and favourite list with Firebase.\n'
            '• Integrated the application with Rest API to get hotel details.',
      ),
      Project(
        title: 'NOTENG | Flutter, API, Dart, Postman',
        description:
            '• Contributed to a multi-purpose App for College Students.\n'
            '• Made UI according to figma design, created reusable Widgets, integrated App with backend.\n'
            '• Presented the App to Mentors.',
      ),
      Project(
        title: 'Netflix Clone | Flutter, Dart, MySQL, TMDB API, RazorPay',
        description:
            '• Developed Netflix Clone App with SQLite DB to store User Info.\n'
            '• Used TMDB Api for movies database.\n'
            '• Integrated Razorpay Payment Gateway for Subscription.',
      ),
    ],
    extracurricular: [
      Extracurricular(
        title: 'Flutter Developer & Mentor | DJ Unicode DJSCE',
        description:
            '• Mentored Flutter Developer Mentees.\n'
            '• Planned a roadmap for their learning.\n'
            '• Provided the necessary resources and guidance.',
      ),
    ],
  );
}

class Education {
  final String institution;
  final String degree;

  const Education({
    required this.institution,
    required this.degree,
  });
}

class Experience {
  final String title;
  final String description;

  const Experience({
    required this.title,
    required this.description,
  });
}

class Project {
  final String title;
  final String description;

  const Project({
    required this.title,
    required this.description,
  });
}

class Extracurricular {
  final String title;
  final String description;

  const Extracurricular({
    required this.title,
    required this.description,
  });
}
