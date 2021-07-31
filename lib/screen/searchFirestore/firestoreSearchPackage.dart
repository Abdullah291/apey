import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_search/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'firestore_service.dart';

class FirestoreSearchScaffold extends StatefulWidget {
  /// Creates a scaffold with a search AppBar and integrated cloud_firestore search.
  ///
  /// You can set the scaffold body using the [scaffoldBody] widget
  ///
  /// You can add a bottom widget to search AppBar using the [appBarBottom] widget
  ///
  /// [firestoreCollectionName] , [dataListFromSnapshot] are required

  final Widget scaffoldBody;

  final PreferredSizeWidget appBarBottom;
  final Color appBarBackgroundColor,
      backButtonColor,
      clearSearchButtonColor,
      searchBackgroundColor,
      searchTextColor,
      searchTextHintColor,
      scaffoldBackgroundColor,
      searchBodyBackgroundColor;

  final String firestoreCollectionName, searchBy;
  final List Function(QuerySnapshot) dataListFromSnapshot;
  final Widget Function(BuildContext, AsyncSnapshot) builder;
  final int limitOfRetrievedData;

  const FirestoreSearchScaffold({
    this.appBarBottom,
    this.scaffoldBody,
    this.appBarBackgroundColor = Colors.white,
    this.backButtonColor = Colors.blue,
    this.clearSearchButtonColor = Colors.blue,
    this.searchBackgroundColor,
    this.searchTextColor,
    this.searchTextHintColor,
    this.scaffoldBackgroundColor = Colors.white,
    this.searchBodyBackgroundColor = Colors.white,

    /// Name of the cloud_firestore collection you
    /// want to search data from
    @required this.firestoreCollectionName,
    @required this.searchBy,

    /// This function takes QuerySnapshot as an argument an returns the object of your dataMode
    /// See example of such a function here
    @required this.dataListFromSnapshot,

    /// Refers to the [builder] parameter of StreamBuilder used to
    /// retrieve search results from cloud_firestore
    /// Use this function display the search results retrieved from cloud_firestore
    this.builder,
    this.limitOfRetrievedData = 10,
  })  : //Firestore parameters assertions
        assert(limitOfRetrievedData >= 1 && limitOfRetrievedData <= 30,
        'limitOfRetrievedData should be between 1 and 30.\n'),
        assert(firestoreCollectionName != null,
        'firestoreCollectionName is required.\n'),
        assert(dataListFromSnapshot != null,
        'dataListFromSnapshot is required, this function converts QuerySnapshot from firestore to a list of your custom data model.\n');

  @override
  _FirestoreSearchScaffoldState createState() =>
      _FirestoreSearchScaffoldState();
}

class _FirestoreSearchScaffoldState extends State<FirestoreSearchScaffold> {
  TextEditingController searchQueryController = TextEditingController();
  bool isSearching = false;
  String searchQuery = "";
  FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    searchFocusNode.addListener(() {
      if (searchFocusNode.hasFocus) {
        setState(() {
          isSearching = true;
        });
      }
    });
    super.initState();
  }

  Widget custom= Text("AppBar",
      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),
  );
  Icon ico= Icon(Icons.search,color: Colors.black,size: 30,);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: widget.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: widget.appBarBackgroundColor,
          leading:  GestureDetector(
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
          title: custom,

          actions: [
            IconButton(
                icon: ico,
                onPressed: () {
                  if (Icons.search == ico.icon) {
                    setState(() {
                      ico=Icon(Icons.close,size: 30,color: Colors.black,);
                      custom = Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*0.55,
                            alignment: Alignment.center,
                            height: 40.0,
                            margin: isSearching
                                ? const EdgeInsets.only(
                                bottom: 3.5, top: 3.5, right: 10.0, left: 0.0)
                                : const EdgeInsets.only(
                                bottom: 3.5, top: 3.5, right: 10.0, left: 10.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 0.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              color: widget?.searchBackgroundColor ??
                                  Colors.white.withOpacity(.2),
                            ),
                            child: TextField(
                              controller: searchQueryController,
                              focusNode: searchFocusNode,
                              autofocus: false,
                              decoration: InputDecoration(
                                hintText: "Search...",
                                border: InputBorder.none,
                                hintStyle: widget?.searchTextHintColor ??
                                    TextStyle(
                                        color: Colors.black),
                                suffixIcon: searchQueryController.text.isNotEmpty
                                    ? IconButton(
                                  alignment: Alignment.centerRight,
                                  color: widget.clearSearchButtonColor,
                                  icon: const Icon(Icons.clear,color: Colors.black,size: 30,),
                                  onPressed: clearSearchQuery,
                                )
                                    : SizedBox(
                                  height: 0.0,
                                  width: 0.0,
                                ),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.search,
                              style: TextStyle(
                                  color: widget?.searchTextColor ??
                                      Colors.black.withOpacity(.8),
                                  fontSize: 16.0),
                              onChanged: (query) => updateSearchQuery(query),
                            ),
                          ),
                        ],
                      );
                    });
                  }
                  else{
                    setState(() {
                      ico=Icon(Icons.search,color: Colors.black,size: 30,);
                      custom= Text("AppBar"
                          ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),);
                      if (isSearching)
                        isSearching = false;
                      searchFocusNode.unfocus();
                      clearSearchQuery();

                    });
                  }
                }
            )
          ],
          bottom: isSearching ? null : widget.appBarBottom,
        ),
        body: Stack(
          children: [
            widget.scaffoldBody,
            isSearching
                ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: widget.searchBodyBackgroundColor,
              child: StreamBuilder<List>(
                  stream: FirestoreServicePackage(
                      collectionName: widget.firestoreCollectionName,
                      searchBy: widget.searchBy ?? '',
                      dataListFromSnapshot:
                      widget.dataListFromSnapshot,
                      limitOfRetrievedData:
                      widget.limitOfRetrievedData)
                      .searchData(searchQuery),
                  builder: widget.builder),
            )
                : SizedBox(
              height: 0.0,
              width: 0.0,
            ),
          ],
        ));
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void stopSearching() {
    clearSearchQuery();
    setState(() {
      isSearching = false;
    });
  }

  void clearSearchQuery() {
    setState(() {
      searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchQueryController.dispose();
    super.dispose();
  }
}
