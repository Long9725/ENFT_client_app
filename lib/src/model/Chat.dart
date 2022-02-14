class Chat {
  final String image, name, lastMessage, time;
  final bool isActive;

  Chat({required this.image, required this.name, required this.lastMessage, required this.time, required this.isActive});
}

List chatsData = [
  Chat(image: "assets/photos/basic-profile.jpg", name: "강선규", lastMessage: "안녕하세요", time: "5분 전", isActive: true),
  Chat(image: "assets/photos/basic-profile.jpg", name: "문민수", lastMessage: "안녕하세요", time: "5분 전", isActive: false),
  Chat(image: "assets/photos/basic-profile.jpg", name: "배해진", lastMessage: "안녕하세요", time: "5분 전", isActive: true),
  Chat(image: "assets/photos/basic-profile.jpg", name: "장성호", lastMessage: "안녕하세요", time: "5분 전", isActive: false),
];