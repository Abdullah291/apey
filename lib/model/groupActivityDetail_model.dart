class GroupActivityDetail{
  GroupActivityDetail({this.image,this.title,this.subtitle});
  final image;
  final title;
  final subtitle;
}



List<GroupActivityDetail> gadlist=[
  GroupActivityDetail(image: "assets/food_iphone@3x.png",title: "Burger",subtitle:"Drink Activities", ),
  GroupActivityDetail(image: "assets/bootel_iphone@3x.png",title: "Drink",subtitle:"Drink Activities", ),
  GroupActivityDetail(image: "assets/phone_iphone@3x.png",title: "Books",subtitle:"Drink Activities", ),
  GroupActivityDetail(image: "assets/food_iphone@3x.png",title: "Book",subtitle:"Drink Activities", ),
  GroupActivityDetail(image: "assets/bootel_iphone@3x.png",title: "Drink",subtitle:"Drink Activities", ),
  GroupActivityDetail(image: "assets/phone_iphone@3x.png",title: "Books",subtitle:"Drink Activities", ),

];


List <GroupActivityDetail>  get Getgadlist=>gadlist;