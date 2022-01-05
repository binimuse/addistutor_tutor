import 'components/user_model.dart';

class Message {
  final User sender;
  final String
      time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String text;
  final bool isLiked;
  final String activeTime;
  final bool unread;

  Message(
      {required this.sender,
      required this.time,
      required this.text,
      required this.isLiked,
      required this.unread,
      required this.activeTime});
}

// YOU - current user
final User currentUser = User(
  id: 0,
  name: 'Current User',
  imageUrl: 'assets/images/profile1.jpg',
);

// USERS
final User greg = User(
  id: 1,
  name: 'Greg',
  imageUrl: 'assets/images/profile2.jpg',
);
final User james = User(
  id: 2,
  name: 'James',
  imageUrl: 'assets/images/profile3.jpg',
);
final User john = User(
  id: 3,
  name: 'John',
  imageUrl: 'assets/images/profile4.jpg',
);
final User olivia = User(
  id: 4,
  name: 'Olivia',
  imageUrl: 'assets/images/profile5.jpg',
);
final User sam = User(
  id: 5,
  name: 'Sam',
  imageUrl: 'assets/images/profile4.jpg',
);

// FAVORITE CONTACTS
List<User> favorites = [sam, james, olivia, john, greg];

// EXAMPLE CHATS ON HOME SCREEN
List<Message> chats = [
  Message(
      sender: james,
      time: '5:30 PM',
      text: 'Hey, how\'s it going? What did you do today?',
      isLiked: false,
      unread: true,
      activeTime: 'online'),
  Message(
      sender: olivia,
      time: '4:30 PM',
      text: 'Hey, how\'s it going? What did you do today?',
      isLiked: false,
      unread: true,
      activeTime: '8 hrs'),
  Message(
      sender: john,
      time: '3:30 PM',
      text: 'Hey, how\'s it going? What did you do today?',
      isLiked: false,
      unread: false,
      activeTime: '2 day'),
];

// EXAMPLE CHATS ON HOME SCREEN
List<Message> chats2 = [
  Message(
      sender: olivia,
      time: 'Pending',
      text: '23th Sept 2021 ',
      isLiked: false,
      unread: false,
      activeTime: ' 1200 birr'),
  Message(
      sender: john,
      time: 'Pending',
      text: '2nd Sept 2021',
      isLiked: false,
      unread: false,
      activeTime: '1400 birr'),
  Message(
      sender: greg,
      time: 'Completed',
      text: '1st Sept 2021',
      isLiked: false,
      unread: true,
      activeTime: '1500 birr'),
];

// EXAMPLE CHATS ON HOME SCREEN
List<Message> chats3 = [
  Message(
      sender: greg,
      time: '5:30 PM',
      text: 'Hey, how\'s it going? What did you do today?',
      isLiked: false,
      unread: true,
      activeTime: 'online'),
  Message(
      sender: john,
      time: '4:30 PM',
      text: 'Hey, how\'s it going? What did you do today?',
      isLiked: false,
      unread: true,
      activeTime: '8 hrs'),
  Message(
      sender: sam,
      time: '3:30 PM',
      text: 'Hey, how\'s it going? What did you do today?',
      isLiked: false,
      unread: false,
      activeTime: '2 day'),
];

// EXAMPLE MESSAGES IN CHAT SCREEN
List<Message> messages = [
  Message(
      sender: james,
      time: '5:30 PM',
      text: 'Hey, how\'s it going? What did you do today?',
      isLiked: true,
      unread: true,
      activeTime: 'online'),
  Message(
      sender: currentUser,
      time: '4:30 PM',
      text: 'Just walked my doge. She was super duper cute. The best pupper!!',
      isLiked: false,
      unread: true,
      activeTime: '8 hrs'),
  Message(
      sender: james,
      time: '3:45 PM',
      text: 'How\'s the doggo?',
      isLiked: false,
      unread: true,
      activeTime: 'online'),
  Message(
      sender: james,
      time: '3:15 PM',
      text: 'All the food',
      isLiked: true,
      unread: true,
      activeTime: 'online'),
  Message(
      sender: currentUser,
      time: '2:30 PM',
      text: 'Nice! What kind of food did you eat?',
      isLiked: false,
      unread: true,
      activeTime: 'online'),
  Message(
      sender: james,
      time: '2:00 PM',
      text: 'I ate so much food today.',
      isLiked: false,
      unread: true,
      activeTime: 'online'),
];
