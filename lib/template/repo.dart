import 'package:flutter/material.dart';
class Repo extends StatelessWidget{
  var name,description;
  // ignore: non_constant_identifier_names
  final int stargazers_count,forks_count;
  Repo(this.name, this.description, this.stargazers_count, this.forks_count){
    if(this.description==null){
      this.description = "No Description";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(vertical: 5.0,),
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                margin: const EdgeInsets.only(right: 10.0),
                child: CircleAvatar(child: Text(name[0].toUpperCase(),style: const TextStyle(fontSize: 42.0),)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(name,style: const TextStyle(fontSize: 20.0),maxLines: 12,),
              //                    new Text(description,maxLines: 12,),
                  Text("Star : $stargazers_count"),
                  Text("Fork : $forks_count"),
                ],
              ),
            ],
          )
      ),
    );
  }

}