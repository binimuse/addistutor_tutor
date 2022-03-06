// ignore_for_file: non_constant_identifier_names

class Teacher {
  int id;

  String first_name;
  String middle_name;
  String last_name;

  String phone_no;
  String email;
  String gender;
  String rating;
  String teaching_since;

  String birth_date;

  String about;
  String phone_no_office;
  String phone_no_residence;
  String subcity;
  String woreda;
  String guarantor_name;
  String guarantor_house_no;
  String guarantor_woreda;
  String guarantor_subcity;
  String guarantor_phone;
  String guarantor_phone_office;
  String guarantor_phone_residence;
  String employer_name;
  String employer_position;
  String employment_subject;
  String employment_teaching_level;
  String employer_city;
  String employer_woreda;

  Teacher({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.middle_name,
    required this.phone_no,
    required this.email,
    required this.birth_date,
    required this.about,
    required this.phone_no_office,
    required this.phone_no_residence,
    required this.subcity,
    required this.woreda,
    required this.guarantor_name,
    required this.guarantor_house_no,
    required this.guarantor_woreda,
    required this.guarantor_subcity,
    required this.guarantor_phone,
    required this.guarantor_phone_office,
    required this.guarantor_phone_residence,
    required this.employer_name,
    required this.employer_position,
    required this.employment_subject,
    required this.employment_teaching_level,
    required this.employer_city,
    required this.employer_woreda,
    required this.rating,
    required this.teaching_since,
    required this.gender,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json["id"] as int,
      first_name: json["first_name"],
      last_name: json["last_name"],
      middle_name: json["middle_name"],
      phone_no: json["phone_no"],
      email: json["email"],
      teaching_since: json["teaching_since"],
      birth_date: json["birth_date"],
      about: json["about"],
      phone_no_office: json["phone_no_office"],
      phone_no_residence: json["phone_no_residence"],
      subcity: json["subcity"],
      woreda: json["woreda"],
      guarantor_name: json["guarantor_name"],
      guarantor_house_no: json["guarantor_house_no"],
      guarantor_woreda: json["guarantor_woreda"],
      guarantor_subcity: json["guarantor_subcity"],
      guarantor_phone: json["guarantor_phone"],
      guarantor_phone_office: json["guarantor_phone_office"],
      guarantor_phone_residence: json["guarantor_phone_residence"],
      employer_name: json["employer_name"],
      employer_position: json["employer_position"],
      employment_subject: json["employment_subject"],
      employment_teaching_level: json["employment_teaching_level"],
      employer_city: json["employer_city"],
      employer_woreda: json["employer_woreda"],
      rating: json["rating"],
      gender: json["gender"],
    );
  }
}

class Activedays {
  String day;
  String is_active;
  String teacher_id;

  Activedays({
    required this.day,
    required this.is_active,
    required this.teacher_id,
  });

  factory Activedays.fromJson(Map<String, dynamic> json) {
    return Activedays(
      day: json["day"],
      is_active: json["is_active"],
      teacher_id: json["teacher_id"],
    );
  }
}

class Balance {
  String wallet_amount;

  Balance({
    required this.wallet_amount,
  });

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      wallet_amount: json["wallet_amount"],
    );
  }
}

class Transaction {
  String slip_id;
  String amount;
  String status;
  String date;

  Transaction({
    required this.slip_id,
    required this.amount,
    required this.status,
    required this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      slip_id: json["slip_id"],
      amount: json["amount"],
      status: json["status"],
      date: json["date"],
    );
  }
}

class ContactUS {
  String name;
  String email;
  String phone;
  String facebook;
  String twitter;
  String instagram;
  String linkedin;

  ContactUS({
    required this.name,
    required this.email,
    required this.phone,
    required this.facebook,
    required this.twitter,
    required this.instagram,
    required this.linkedin,
  });

  factory ContactUS.fromJson(Map<String, dynamic> json) {
    return ContactUS(
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      facebook: json["facebook"],
      twitter: json["twitter"],
      instagram: json["instagram"],
      linkedin: json["linkedin"],
    );
  }
}

class NotificationData {
  String message;
  String redirect_url;
  String notification_type;

  String teacher_name;
  int booking_id;
  String student_name;

  NotificationData({
    required this.message,
    required this.redirect_url,
    required this.notification_type,
    required this.teacher_name,
    required this.booking_id,
    required this.student_name,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      message: json["message"],
      redirect_url: json["redirect_url"],
      notification_type: json["notification_type"],
      teacher_name: json["teacher_name"],
      booking_id: json["booking_id"],
      student_name: json["student_name"],
    );
  }
}

class Notifications {
  String id;
  String type;
  String notifiable_type;
  String notifiable_id;
  String read_at;
  String created_at;
  NotificationData data;
  Notifications({
    required this.id,
    required this.type,
    required this.notifiable_type,
    required this.notifiable_id,
    required this.read_at,
    required this.created_at,
    required this.data,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json["id"],
      type: json["type"],
      notifiable_type: json["notifiable_type"],
      notifiable_id: json["notifiable_id"],
      read_at: json["read_at"],
      created_at: json["created_at"],
      data: NotificationData.fromJson(json["data"]),
    );
  }
}

class Locations {
  int id;

  String name;
  String description;

  Locations({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Locations.fromJson(Map<String, dynamic> json) {
    return Locations(
      id: json["id"],
      name: json["name"],
      description: json["description"],
    );
  }
}

class RequestedBooking {
  int id;

  String session;
  String message;
  String is_active;
  String student_id;
  String ended_at;
  List<Bookingschedule> booking_schedule;
  ReqTech teacher;
  ReqStu student;
  Subjects subject;

  String created_at;

  RequestedBooking({
    required this.id,
    required this.session,
    required this.message,
    required this.student_id,
    required this.is_active,
    required this.teacher,
    required this.student,
    required this.subject,
    required this.ended_at,
    required this.booking_schedule,
    required this.created_at,
  });

  factory RequestedBooking.fromJson(Map<String, dynamic> json) {
    return RequestedBooking(
      id: json["id"] as int,
      session: json["session"],
      message: json["message"],
      student_id: json["student_id"],
      is_active: json["is_active"],
      created_at: json["created_at"],
      ended_at: json["ended_at"],
      teacher: ReqTech.fromJson(json["teacher"]),
      student: ReqStu.fromJson(json["student"]),
      subject: Subjects.fromJson(json["subject"]),
      booking_schedule: List<Bookingschedule>.from(
          json["booking_schedule"].map((x) => Bookingschedule.fromJson(x))),
    );
  }
}

class Subjects {
  int id;

  String code;
  String title;
  String tutoring_level_id;

  Subjects({
    required this.id,
    required this.code,
    required this.title,
    required this.tutoring_level_id,
  });

  factory Subjects.fromJson(Map<String, dynamic> json) {
    return Subjects(
      id: json["id"] as int,
      code: json["code"],
      title: json["title"],
      tutoring_level_id: json["tutoring_level_id"],
    );
  }
}

class Bookingschedule {
  int id;

  String day;
  String readable_time;
  String booking_id;

  Bookingschedule({
    required this.id,
    required this.day,
    required this.readable_time,
    required this.booking_id,
  });

  factory Bookingschedule.fromJson(Map<String, dynamic> json) {
    return Bookingschedule(
      id: json["id"] as int,
      day: json["day"],
      readable_time: json["readable_time"],
      booking_id: json["booking_id"],
    );
  }
}

class ReqStu {
  int id;
  String is_parent;

  String parent_first_name;
  String parent_last_name;
  String first_name;
  String last_name;
  String grade;
  String study_purpose;

  String phone_no;
  String gender;
  String birth_date;
  String about;
  String rating;
  String location_id;
  String profile_img;
  String teaching_since;
  Locations location;

  ReqStu({
    required this.id,
    required this.is_parent,
    required this.parent_first_name,
    required this.parent_last_name,
    required this.first_name,
    required this.last_name,
    required this.grade,
    required this.study_purpose,
    required this.phone_no,
    required this.gender,
    required this.birth_date,
    required this.about,
    required this.rating,
    required this.location_id,
    required this.location,
    required this.profile_img,
    required this.teaching_since,
  });

  factory ReqStu.fromJson(Map<String, dynamic> json) {
    return ReqStu(
      is_parent: json["is_parent"],
      id: json["id"],
      parent_first_name: json["parent_first_name"],
      parent_last_name: json["parent_last_name"],
      first_name: json["first_name"],
      last_name: json["last_name"],
      phone_no: json["phone_no"],
      grade: json["grade"],
      study_purpose: json["study_purpose"],
      gender: json["gender"],
      birth_date: json["birth_date"],
      about: json["about"],
      rating: json["rating"],
      profile_img: json["profile_img"],
      teaching_since: json["teaching_since"],
      location_id: json["location_id"],
      location: Locations.fromJson(json["location"]),
    );
  }
}

class ReqTech {
  int id;

  String first_name;
  String middle_name;
  String last_name;
  String phone_no;
  String gender;
  String birth_date;
  String about;
  String rating;
  String location_id;
  String profile_img;
  String teaching_since;

  ReqTech({
    required this.id,
    required this.first_name,
    required this.middle_name,
    required this.last_name,
    required this.phone_no,
    required this.gender,
    required this.birth_date,
    required this.about,
    required this.rating,
    required this.location_id,
    required this.profile_img,
    required this.teaching_since,
  });

  factory ReqTech.fromJson(Map<String, dynamic> json) {
    return ReqTech(
      id: json["id"],
      first_name: json["first_name"],
      middle_name: json["middle_name"],
      last_name: json["last_name"],
      phone_no: json["phone_no"],
      gender: json["gender"],
      birth_date: json["birth_date"],
      about: json["about"],
      rating: json["rating"],
      profile_img: json["profile_img"],
      teaching_since: json["teaching_since"],
      location_id: json["location_id"],
    );
  }
}

class GetLocation {
  int id;

  String name;
  String description;

  List<Locations> locaion;
  GetLocation({
    required this.id,
    required this.name,
    required this.description,
    required this.locaion,
  });

  factory GetLocation.fromJson(Map<String, dynamic> json) {
    return GetLocation(
      id: json["id"] as int,
      name: json["name"],
      description: json["description"],
      locaion: List<Locations>.from(
          json["locations"].map((x) => Locations.fromJson(x))),
    );
  }
}

class GetLevel {
  int id;

  String title;
  String price;
  String description;

  GetLevel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
  });

  factory GetLevel.fromJson(Map<String, dynamic> json) {
    return GetLevel(
      id: json["id"] as int,
      title: json["title"],
      price: json["price"],
      description: json["description"],
    );
  }
}

class GetQulification {
  int id;

  String title;
  String description;

  GetQulification({
    required this.id,
    required this.title,
    required this.description,
  });

  factory GetQulification.fromJson(Map<String, dynamic> json) {
    return GetQulification(
      id: json["id"] as int,
      title: json["title"],
      description: json["description"],
    );
  }
}

class Penalty {
  int id;

  String penalty;
  String description;
  String amount;

  Penalty({
    required this.id,
    required this.amount,
    required this.penalty,
    required this.description,
  });

  factory Penalty.fromJson(Map<String, dynamic> json) {
    return Penalty(
      id: json["id"],
      amount: json["amount"],
      penalty: json["penalty"],
      description: json["description"],
    );
  }
}

class GetPenalties {
  int id;

  String code;
  String title;
  String tutoring_level_id;
  Penalty penalty;
  GetPenalties({
    required this.id,
    required this.code,
    required this.penalty,
    required this.title,
    required this.tutoring_level_id,
  });

  factory GetPenalties.fromJson(Map<String, dynamic> json) {
    return GetPenalties(
      id: json["id"] as int,
      code: json["code"],
      title: json["title"],
      tutoring_level_id: json["tutoring_level_id"],
      penalty: Penalty.fromJson(json["penalty"]),
    );
  }
}
