import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tackle_the_box/models/category.dart';
import 'package:tackle_the_box/models/music.dart';
import 'package:tackle_the_box/services/category_operations.dart';
import 'package:tackle_the_box/Screens/graph.dart';
import 'package:tackle_the_box/services/music_operations.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  Widget createCategory(Category category){
    return Container(
      color: Colors.blueGrey.shade400,
      child: Row(
        children: [
          Image.network(category.imageURL,fit:BoxFit.cover),
          Padding(
            padding: EdgeInsets.only(left: 10), child: Text(category.name,style: TextStyle(color: Colors.white),),)
        ],
      ),
    );
  }
  List<Widget> createListOfCategories(){
    List<Category> categoryList = CategoryOperations.getCategories();
    List<Widget> categories = categoryList.map((Category category)=>createCategory(category)).toList();
    return categories;
  }
  Widget createMusic(Music music){
  return Padding(
    padding: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    Container(
      height: 200,
        width: 200,
        //child: InkWell(
          //onTap: (){
           // Navigator.push(
              //  context,
             //   MaterialPageRoute(builder: (context) => Graph()),
            //);
         // },
          child:Image.network(
          music.image, fit: BoxFit.cover,
        ),
    ),//),
    Text(music.name,style: TextStyle(color: Colors.white),),
    Text(music.desc,style: TextStyle(color: Colors.white))],
    ),
  );
  }

  Widget createMusicList(String label) {
    List<Music> musicList = MusicOperations.getMusic();
    return Padding(
      padding: EdgeInsets.only(left: 10),
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children:[ Text(label, style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold),
        ),
          Container(
        height: 300,
      child: ListView.builder(
        //padding: EdgeInsets.all(5),
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index){
      return createMusic(musicList[index]);

    },
    itemCount: musicList.length,)
    )
    ]),
    );
  }


  Widget createGrid(){
    return Container(
      padding: EdgeInsets.all(10),
      height: 280,
      child: GridView.count(
        childAspectRatio: 5/2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: createListOfCategories(),
      crossAxisCount: 2,
    ),);
  }

  Widget createAppBar(String message){
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(message),
      actions: [Padding(
          padding: EdgeInsets.only(right: 20),
          child: Icon(Icons.settings))
      ],
    );

  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: InkWell(
        onTap: (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Graph()),
      );
    },
      child: SafeArea(
      child: Container(
        child: Column(
          children: [
            createAppBar("Good Morning, Rizwan"), SizedBox(height: 5,),
            createGrid(),
            createMusicList('Music for amFOSS'),
            createMusicList('Popular Playlist')
          ],
        ),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blueGrey.shade300,
            Colors.black,
            Colors.black,
            Colors.black
          ],begin: Alignment.topLeft, end: Alignment.bottomRight)),)
    ),
    ),
    );
  }
}
