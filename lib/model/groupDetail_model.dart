
class Group{
  Group({this.image,this.title,this.subtitle});
  final image;final title;final subtitle;
}


List<Group> GroupList=[
  Group(title:"Kistina Grebenshehikeva" ,subtitle:"Love colors" ),
  Group(image: "assets/cristinai_iphone@3x.png",title:"Tavir Ahassan Anik" ,subtitle: "Happy group 😍"),
  Group(image: "assets/cristina_iphone@3x.png",title:"Kistina Grebenshehikeva" ,subtitle: "Love colors"),
  Group(image: "assets/Excellent WebWorld_iphone@3x.png",title: "Excellent WebWorld",subtitle: "Happy group 😍",),
  Group(image: "assets/cristinae_iphone@3x.png",title:"Excellent WebWorld" ,subtitle:"Happy group 😍", ),
  Group(image: "assets/Roxana Carabas_iphone@3x.png",title: "Excellent WebWorld",subtitle:"Happy group 😍" ),
];

List <Group> get GroupListGet=>GroupList;
