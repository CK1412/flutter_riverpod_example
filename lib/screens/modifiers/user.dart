class User {
  final String name;
  final String urlAvater;
  final int age;
  final Gender gender;

  const User({
    required this.name,
    required this.urlAvater,
    required this.age,
    required this.gender,
  });
}

enum Gender { male, female }

final users = [
  const User(
    name: 'Cho Yi-hyun',
    urlAvater:
        'https://media-cdn-v2.laodong.vn/storage/newsportal/2022/2/5/1001311/90_03B545a4850c06aa5.jpeg',
    age: 22,
    gender: Gender.female,
  ),
  const User(
    name: 'IU',
    urlAvater:
        'https://nld.mediacdn.vn/zoom/700_438/2019/10/19/1571405322-201910180-iu-15714805252122044141800.jpg',
    age: 28,
    gender: Gender.female,
  ),
  const User(
    name: 'Sơn Tùng MTP',
    urlAvater:
        'https://yt3.ggpht.com/ytc/AKedOLRkY5n3Hd-EXXEpeUPp4INtDJTT_awisaAOhndN1g=s900-c-k-c0x00ffffff-no-rj',
    age: 27,
    gender: Gender.male,
  ),
  const User(
    name: 'John Wick',
    urlAvater:
        'https://genk.mediacdn.vn/zoom/700_438/139269124445442048/2020/6/1/photo1590986620309-1590986620437749357799.jpg',
    age: 57,
    gender: Gender.male,
  ),
];
