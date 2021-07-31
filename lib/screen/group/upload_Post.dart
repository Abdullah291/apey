import 'dart:io';

import 'package:apey/constant.dart';
import 'package:apey/database/collection.dart';
import 'package:apey/database/userSingleton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:progress_dialog/progress_dialog.dart';




class Group_Upload_Post extends StatefulWidget {
  final roomIds;
  Group_Upload_Post({this.roomIds});
  @override
  _Group_Upload_PostState createState() => _Group_Upload_PostState();
}

class _Group_Upload_PostState extends State<Group_Upload_Post> {

  ProgressDialog Pd;


  @override
  void initState() {
    // TODO: implement initState
    print("Cool Ids");
    print(widget.roomIds);
    super.initState();
  }

  bool uploading = false;
  double val = 0;
  CollectionReference imgRef;

  List<File> _image = [];
  final picker = ImagePicker();




  chooseImage() async {
    print("1 done");
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile?.path));
    });
    if (pickedFile.path == null) retrieveLostData();
    print("last done");
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file.path));
      });
    } else {
      print(response.file);
    }
  }


  Future<List<String>> uploadFiles(List<File> _images) async {
    var imageUrls = await Future.wait(_images.map((_image) => uploadFile(_image)));
    print(imageUrls);
    return imageUrls;
  }

  Future<String>  uploadFile(File _image) async {
     FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("userProfile/images/${DateTime.now().toString()}");
      UploadTask uploadTask = ref.putFile(_image);
      TaskSnapshot res = await uploadTask;
      String imageUrl = await res.ref.getDownloadURL();
      // imagesUrls.add(await imageUrl.toString());
    // });
    return imageUrl;
  }

  final GlobalKey<ScaffoldState> _scaffoldkey=GlobalKey<ScaffoldState>();

  TextEditingController message=TextEditingController();

  @override
  Widget build(BuildContext context) {
    Pd= new ProgressDialog(context,type: ProgressDialogType.Normal,);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldkey,
        backgroundColor: Kthirdcolor2,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                overflow: Overflow.visible,
                children: [
                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                      color: Kthirdcolor2,
                      image: DecorationImage(
                          image: AssetImage("assets/Bg2.png"),fit: BoxFit.fill),
                    ),
                    child: ListTile(
                      leading: GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Transform.rotate(angle: 3.1,child: Image.asset("assets/arrow_iphone@3x.png",width: 25,height: 24,color: Colors.black,)),
                          ],
                        ),
                      ),
                      title: Container(
                          margin: EdgeInsets.only(right: 0,top: 5),
                          child: Text(
                            "Creat Post",
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.center,
                          )),

                      trailing: Container(

                        height: 35,
                        width: Get.width * 0.25,
                        child: Card(
                          color: KClipperColor,
                          margin: EdgeInsets.all(0),
                          child: FlatButton(
                            onPressed: () async{
                              if(message.text.isNotEmpty ||  _image.length != 0) {
                                Pd.show();
                                var id = DateTime
                                    .now()
                                    .millisecondsSinceEpoch
                                    .toString();
                                List<String> urls = await uploadFiles(_image);
                                print("cool");
                                await Collection.userPosts.doc(id).set({
                                  'text': message.text.toString(),
                                  'group_id': widget.roomIds,
                                  'post_id': id,
                                  'created_at': DateTime.now(),
                                  'images': urls,
                                  'status': true,
                                  'user_email': UserSingleton.userData
                                      .userEmail,
                                }).whenComplete(() => {
                                  setState((){
                                    message.clear();
                                    _image=null;
                                  })
                                }).whenComplete(() => Pd.hide().whenComplete(() => Get.back()).whenComplete(() => {
                                // ignore: deprecated_member_use
                                _scaffoldkey.currentState.showSnackBar(
                                SnackBar(
                                backgroundColor: KClipperColor,
                                content: Text("Post Upload Successfully",style: TextStyle(color:KSecondaryColor),),
                                duration: Duration(seconds: 3),
                                ),
                                )
                                }));

                              }
                              else{
                                  // ignore: deprecated_member_use
                                  _scaffoldkey.currentState.showSnackBar(
                                    SnackBar(
                                      backgroundColor: KClipperColor,
                                      content: Text("Post not valid",style: TextStyle(color:KSecondaryColor),),
                                      duration: Duration(seconds: 3),
                                    ),
                                );
                              }
                            },
                            child: FittedBox(child: Text("POST",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),)),
                          ),
                        ),
                      ),

                    ),

                  ),
                  Positioned(
                    child: Container(
                      margin:EdgeInsets.only(top: 90,left: 10),
                      child: ListTile(

                          leading: Container(
                            width: 60,
                            height: 60,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image(
                                image: NetworkImage(UserSingleton.userData.imageUrl.toString()),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(
                            UserSingleton.userData.firstName + ' ' +UserSingleton.userData.lastName ,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                          ),
                        subtitle: Text(UserSingleton.userData.userId,
                        style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: KGreyColor),
                        ),
                      ),
                    ),
                  ),


                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    TextFormField(
                      controller: message,
                      autofocus: true,
                      minLines: 1,
                      maxLines: 20,
                      cursorColor: kprimarycolor,
                      decoration: InputDecoration(
                          hintText: "What's on your mind?",
                          hintStyle: TextStyle(
                              fontSize: 14, color: KGreyColor),
                          border: InputBorder.none,
                          ),
                    ),

                  ],
                ),
              ),


            _image!=null? GridView.builder(
                 shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _image.length==1?1:2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                  ),
                  itemCount: _image.length,
                  itemBuilder:  (context,index){
                    return Image.file(_image[index],fit: BoxFit.cover,);
                  }
              ):Container(),

            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kforhtcolor,
          onPressed: ()async{
           await chooseImage();
          },
          child: Center(child: Image.asset("assets/HomePhoto _iphone@3x.png",fit: BoxFit.cover,)),
        ),
      ),

    );
  }
}
// )