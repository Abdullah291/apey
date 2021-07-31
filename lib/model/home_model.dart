


class Homemodel{
  Homemodel({this.image,this.title,this.member,this.food,this.description,this.join});
  final image;
  final title;
  final member;
  final food;
  final description;
  final join;
}


List <Homemodel> homemodellist=[
  Homemodel(image: "assets/Game boy_iphone@3x.png",title: "Game boy",member: "100K Member",food:"#food#Pocket" ,description: "if you could only store one type of food in your pocket,your carry, what is wrost present you have ever store.....",join: "Join Group",),
  Homemodel(image: "assets/Master list_iphone@3x.png",title: "Master List",member: "100K Member",food:"#Chat#debate",description: "if you could only store one type of food in your pocket,your carry, what is wrost present you have ever store.....",join:"Write Message", ),
  Homemodel(image: "assets/Messenger Boy_iphone@3x.png",title: "Messenger Boy",member: "100K Member",food:"#food#Pocket",description: "if you could only store one type of food in your pocket,your carry, what is wrost present you have ever store.....",join: "Join Group",),
];


List<Homemodel> get Gethomemodellist=>homemodellist;