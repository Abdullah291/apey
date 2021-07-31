import 'package:cloud_firestore/cloud_firestore.dart';

class GroupChatModel {
  String groupImg;
  Timestamp createdAt;
  String groupName;
  String createdBy;
  String roomId;
  List<String> users;
  bool isGroup;

  GroupChatModel(
      { this.groupImg,
        this.groupName,
        this.createdBy,
        this.roomId,
        this.users,
        this.isGroup});

  GroupChatModel.fromJson(dynamic json) {
    groupImg = json["groupImage"];
    createdAt = json["createdAt"];
    groupName = json["groupName"];
    createdBy = json["createdBy"];
    roomId = json["roomId"];
    users = json["members"] != null ? json["members"].cast<String>() : [];
    isGroup = json["isGroup"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["groupImage"] = groupImg;
    map["createdAt"] = createdAt;
    map["groupName"] = groupName;
    map["createdBy"] = createdBy;
    map["roomId"] = roomId;
    map["members"] = users;
    map["isGroup"] = isGroup;
    return map;
  }
}
