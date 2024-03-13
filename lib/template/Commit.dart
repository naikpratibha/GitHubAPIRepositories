// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
class Commit extends StatelessWidget{
  var meassage,name,Reponame;
  Commit(this.meassage,this.name,this.Reponame){
    if(this.meassage==null){
      this.meassage = "No message";
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
                  Text("message : $meassage"),
                  Text("Repository Name: $Reponame"),
                ],
              ),
            ],
          )
      ),
    );
  }

}