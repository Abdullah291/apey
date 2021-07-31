


class HomeFeed{
  HomeFeed({
    this.img1, this.title1, this.subtitle1,
    this.img2, this.title2, this.subtitle2,
    this.img3, this.title3,
    this.maintxt,
    this.like, this.unlike, this.comment,
  });

  final img1;
  final title1;
  final subtitle1;
  final img2;
  final title2;
  final subtitle2;
  final img3;
  final title3;
  final maintxt;
  final like;
  final unlike;
  final comment;
}



  List feed=[
    HomeFeed(
      img1: "assets/Game boy_iphone@3x.png", title1: "Beatles", subtitle1: "100 K member",
      img2: "assets/Excellent WebWorld_iphone@3x.png", title2: "Sweete", subtitle2: "Love Color",
      img3:"assets/Homestatus_iphone@3x.png", title3: "Status",
      maintxt: "This morning, I'm very Happy😍",
      like: "5.3k", unlike: "1k", comment: "1k",
    ),
    HomeFeed(
      img1: "assets/Game boy_iphone@3x.png", title1: "Beatles", subtitle1: "100 K member",
      img2: "assets/Excellent Web_iphone@3x.png", title2: "Excellent", subtitle2: "Love Color",
      img3:"assets/HomeSurvey_iphone@3x.png", title3: "Survey",
      maintxt: "This morning, I'm very Happy😍",
      like: "5.3k", unlike: "1k", comment: "1k",
    ),
    HomeFeed(
      img1: "assets/Game boy_iphone@3x.png", title1: "Beatles", subtitle1: "100 K member",
      img2: "assets/Roxana Carabas_iphone@3x.png", title2: "Roxana", subtitle2: "Love Color",
      img3:"assets/Homestatus_iphone@3x.png", title3: "Status",
      maintxt: "This morning, I'm very Happy😍",
      like: "5.3k", unlike: "1k", comment: "1k",
    ),
  ];

List get getfeed=>feed;
