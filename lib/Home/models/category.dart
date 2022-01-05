class Category {
  Category({
    this.title = '',
    this.imagePath = '',
    this.lessonCount = 0,
    this.money = 0,
    this.rating = 0.0,
  });

  String title;
  int lessonCount;
  int money;
  double rating;
  String imagePath;

  static List<Category> categoryList = <Category>[
    Category(
      imagePath: 'assets/images/profile2.jpg',
      title: 'Solomon Kassa',
      lessonCount: 2,
      rating: 4.3,
    ),
    Category(
      imagePath: 'assets/images/profile1.jpg',
      title: 'Biniyam Ksaa',
      lessonCount: 2,
      money: 1800,
      rating: 4.6,
    ),
    Category(
      imagePath: 'assets/images/profile3.jpg',
      title: 'Yoseph hailu',
      lessonCount: 3,
      rating: 4.3,
    ),
    Category(
      imagePath: 'assets/images/profile4.jpg',
      title: 'natinael meta',
      lessonCount: 5,
      rating: 4.6,
    ),
  ];

  static List<Category> popularCourseList = <Category>[
    Category(
      imagePath: 'assets/images/profile1.jpg',
      title: 'Manderas Gemechu',
      lessonCount: 2,
      rating: 4.8,
    ),
    Category(
      imagePath: 'assets/images/profile2.jpg',
      title: 'Enkubahari gossaye',
      lessonCount: 1,
      rating: 4.9,
    ),
    Category(
      imagePath: 'assets/images/profile3.jpg',
      title: 'Bernabas Gemachu',
      lessonCount: 2,
      rating: 4.8,
    ),
    Category(
      imagePath: 'assets/images/profile2.jpg',
      title: 'Abrham belete',
      lessonCount: 6,
      rating: 4.9,
    ),
  ];
}
