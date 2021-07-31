


class GroupList{
  GroupList({this.image,this.title,this.subtitle,this.members,this.followers});
  final image;
  final title;
  final subtitle;
  final members;
  final followers;
}



List <GroupList>  grouplist=[
  GroupList(image: "assets/cristinae_iphone@3x.png",title: "Cristinae",subtitle: "Love Color", members: "5.2M",followers: "23M"),
  GroupList(image: "assets/Sweetss_iphone@3x.png",title: "Sweet",subtitle: "Love Color", members: "5.2M",followers: "23M"),
  GroupList(image: "assets/cristinai_iphone@3x.png",title: "Cristinai",subtitle: "Love Color", members: "5.2M",followers: "23M"),
  GroupList(image: "assets/Excellent Web_iphone@3x.png",title: "Sweet",subtitle: "Love Color", members: "5.2M",followers: "23M"),
  GroupList(image: "assets/Excellent WebWorld_iphone@3x.png",title: "Excellent",subtitle: "Love Color", members: "5.2M",followers: "23M"),
];


List <GroupList> get Getgrouplist=>grouplist;