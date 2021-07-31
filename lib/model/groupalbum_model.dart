


class GroupAlbumList{
  GroupAlbumList({this.image,this.title});
  final image;
  final title;
}

List <GroupAlbumList> groupalbumlist=[
  GroupAlbumList(image: "assets/Game boy_iphone@3x.png",title: "Game boy"),
  GroupAlbumList(image: "assets/Happy Club_iphone@3x.png",title: "Happy Club"),
  GroupAlbumList(image: "assets/Master list_iphone@3x.png",title: "Master list"),
  GroupAlbumList(image: "assets/girl_iphone@3x.png",title: "Sweet"),
];

List <GroupAlbumList> get getgroupalbumlist=>groupalbumlist;