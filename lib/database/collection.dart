import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class Collection {
  static CollectionReference signUp = db.collection('SignUp');
  static CollectionReference chatRoom = db.collection('ChatRoom');
  static CollectionReference chat = db.collection('Chat');
  static CollectionReference userFriends= db.collection('Friends');
  static CollectionReference ideaPerson = db.collection('IdealPerson');

  static CollectionReference groupChatRoom = db.collection('GroupChatRoom');
  static CollectionReference groupChat = db.collection('GroupChat');
  static CollectionReference blockGroupChatUser = db.collection('BlockGroupChatUser');



  static CollectionReference groupRoom= db.collection('GroupRoom');
  static CollectionReference userLikeGroup = db.collection('GroupLike');
  static CollectionReference userPosts = db.collection('GroupPost');
  static CollectionReference userLikePost = db.collection('PostLike');
  static CollectionReference userCommentPost = db.collection('PostComment');
  static CollectionReference blockGroupUser = db.collection('BlockGroupUser');



  static CollectionReference groupMember= db.collection('GroupMember');





}




