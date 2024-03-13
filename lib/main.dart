import 'package:flutter/material.dart';
import 'package:github_repositories/template/Commit.dart';
import 'package:github_repositories/template/repo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(ShowProfile());
}

class ShowProfile extends StatefulWidget{
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}
class ProfileState extends State<ShowProfile>{
  bool repo_loading = true,commit_loading = true;
  bool repo_data = false,commit_data = false;

  ProfileState();
  Uri base_url = Uri.parse('https://api.github.com/users/freeCodeCamp/repos');
  var ResBody;
  List<Repo> _repo = [];
  List<Commit> commit = [];
  getRepo() async{
    var res = await http.get(base_url as Uri, headers: {"Accept": "application/json"});
    ResBody = json.decode(res.body);
    setState(() {
      for(var data in ResBody){
        _repo.add(
            // ignore: unnecessary_new
            new Repo(
                data['name'],
                data['description'],
                data['stargazers_count'],
                data['forks_count']
            ));
        repo_data = true;
      }
    });
    repo_loading = false;
    }
    getCommit() async{
      Uri b_url = Uri.parse('https://api.github.com/repos/freeCodeCamp/1Aug2015GameDev/commits');
      var res = await http.get(b_url as Uri, headers: {"Accept": "application/json"});
      ResBody = json.decode(res.body);
      setState(() {
          var _commit = ResBody[0]['commit'];
          commit.add( 
            new Commit(_commit['message'],
            _commit['committer']['name'],
            "1Aug2015GameDev")); 
          commit_data = true;
        });
        commit_loading = false;
    }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Profile",
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("freeCodeCamp"),
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(child: Text("Overview")),
                Tab(child: Text("Repository")),
                Tab(child: Text("Commits")),
              ],
            )
          ),
          body: TabBarView(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(Icons.code,size: 100.0,),
                    Text("Overview",style: Theme.of(context).textTheme.titleMedium),
                  ],
                )
              ),
              Container(
                child: _Repo_data()
              ),
              Container(
                child: _Commit_data()
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRepo();
    getCommit();
  }
  Widget _Repo_data() {
    if(repo_loading){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }else if(!repo_data){
      return Center(
        child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("freeCodeCamp have No Repo",style: Theme.of(context).textTheme.titleMedium)
            ]
        ),
      );
    }else{
      return Column(
        children: <Widget>[
          Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (_, int index) => _repo[index],
                itemCount: _repo.length,
              )
          )
        ],
      );
    }
  }
  Widget _Commit_data(){
    if(commit_loading){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }else if(!commit_data){
      return Center(
        child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("have No Commit",style: Theme.of(context).textTheme.titleMedium)
            ]
        ),
      );
    }else{
      return Column(
        children: <Widget>[
          Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (_, int index) => commit[index],
                itemCount: commit.length,
              )
          )
        ],
      );
    }
  }
}