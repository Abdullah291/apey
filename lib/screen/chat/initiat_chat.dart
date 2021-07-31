import 'package:apey/database/collection.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_model.dart';

class InitiateChat {
  String to;
  String by;
  String name;
  String peerId;

  InitiateChat({@required this.peerId, this.to, this.by, this.name});

  // ignore: deprecated_member_use
  List<ChatRoomModel> chatRooms = List<ChatRoomModel>();


  DocumentSnapshot myChatRoom;

  Future<ChatRoomModel> now() async{
     QuerySnapshot querySnapshot= await Collection.chatRoom.get();

    querySnapshot.docs.forEach((element) {
           chatRooms.add(ChatRoomModel.fromJson(element));
    });

    if(!EmptyList.isTrue(querySnapshot.docs))
    {
            List<ChatRoomModel> roomInfo=
             chatRooms.where((element) =>
             (element.createdBy== by  || element.createdBy == peerId) &&
             (element.peerId== peerId || element.peerId == by)
             ).toList();
         if(EmptyList.isTrue(roomInfo)){
             myChatRoom = await getRoomDoc(to, by, name);
             return ChatRoomModel.fromJson(myChatRoom.data());
         }
         else {
            return roomInfo[0];
         }

    }

    else
     {
         DocumentSnapshot documentSnapshot= await getRoomDoc(to, by, name);
         return ChatRoomModel.fromJson(documentSnapshot);
     }
  }


  Future<DocumentSnapshot> getRoomDoc(String to, String by, String name) async {
    String docId = DateTime.now().millisecondsSinceEpoch.toString();
    ChatRoomModel chatRoomModel = ChatRoomModel(
      createdAt: Timestamp.now(),
      createdBy: by,
      roomId: docId,
      peerId: peerId,
      users: [by, peerId],
    );
    print(chatRoomModel.toJson());
    await Collection.chatRoom.doc(docId).set(chatRoomModel.toJson());
    DocumentSnapshot chatRoomDoc = await Collection.chatRoom.doc(docId).get();
    return chatRoomDoc;
  }


}

class EmptyList {
  static bool isTrue(List list) {
    if (list == null || list.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}