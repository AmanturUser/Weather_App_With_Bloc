import 'package:flutter/material.dart';

class MySearchDelegate extends SearchDelegate{
  String? selectedResult;
  final Function callback;

  MySearchDelegate(this.callback);

  @override
  List<Widget> buildActions(BuildContext context){
    return [
      IconButton(onPressed: (){
        query='';
      }, icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildResults(BuildContext context){
    return Container(
      child: Center(
        child: Text(selectedResult!),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context){
    List<String> searchResults=['Helsiki','Moskow','Berlin','New York', 'Saint Peterburg', query].where((element)=>element.contains(query)).toList();

    return ListView.builder(itemCount: searchResults.length,itemBuilder: (context,index){
      return ListTile(
        title: Text(selectedResult![index]),
        onTap: (){
          selectedResult=searchResults[index];
          callback(selectedResult);
          Navigator.pop(context);
        },
      );
    });
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}