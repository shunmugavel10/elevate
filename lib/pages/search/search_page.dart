import 'package:farm_direct/pages/common/cart_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'search_showCase_widget.dart';

class SearchProduct extends SearchDelegate<dynamic>{
  
  @override
  List<Widget> buildActions(BuildContext context) {
    return [cart(context)];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return
      IconButton(icon: Icon(Icons.arrow_back), onPressed: () {close(context, null) ; },);
  }

  @override
  Widget buildResults(BuildContext context) {

    return FutureBuilder<dynamic>(
      future:null,
      builder: (context, snapshot) {
        return  SearchShowCase();
      },
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: null,
      builder: (context, snapshot) {
        return SearchShowCase();
          },
    );
  }

}
