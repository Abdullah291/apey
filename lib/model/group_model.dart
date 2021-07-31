import 'package:flutter/material.dart';

class ListEvent{
  ListEvent({this.image,this.title});
  final image;
  final title;
}


List<ListEvent> Events=[
  ListEvent(image: "assets/Subdivide_iphone@3x.png",title: "Subdivide"),
  ListEvent(image: "assets/Survey_iphone@3x.png",title: "Survey"),
  ListEvent(image: "assets/chat_iphone@3x.png",title: "Chat"),
  ListEvent(image: "assets/Calender Event_iphone@3x.png",title: "Calender Event"),
  ListEvent(image: "assets/Activities_iphone@3x.png",title: "Activities"),
];


List <ListEvent> get EventsGet=>Events;


class GroupMembers{
  GroupMembers({this.image,this.title});
  final image;
  final title;
}


List<GroupMembers> Members=[
  GroupMembers(image:  "assets/Sweets_iphone@3x.png",title:"Sweet"),
  GroupMembers(image:  "assets/cristinaa_iphone@3x.png",title:"Vishi",),
  GroupMembers(image:  "assets/cristina_iphone@3x.png",title:"Ashu",),
  GroupMembers(image:  "assets/cristinai_iphone@3x.png",title:"Sweet",),
  GroupMembers(image:  "assets/cristinae_iphone@3x.png",title:"Vishi",),
  GroupMembers(image:  "assets/Roxana Carabas_iphone@3x.png",title:"Ashu",),
];


List<GroupMembers> get MembersGet => Members;

