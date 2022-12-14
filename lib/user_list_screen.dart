import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rest_api_flutter/data_sources/api_services.dart';
import 'package:rest_api_flutter/models/users.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        child: FutureBuilder<List<User>>(
          future: ApiServices().fetchUser(),
          builder: (context, snapshot) {
            if ((snapshot.hasError) || (!snapshot.hasData)) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<User>? userList = snapshot.data;
            return ListView.builder(
                itemCount: userList!.length,
                itemBuilder: (BuildContext context, int index) {
                  return UserItem(
                    user: userList[index],
                  );
                });
          },
        ),
      ),
    );
  }
}

class UserItem extends StatelessWidget {
  User? user;

  UserItem({this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: Row(
        children: <Widget>[
          Container(
            height: 80.0,
            width: 80.0,
            margin: const EdgeInsets.only(right: 20.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(user!.picture!.medium!),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${user!.name!.first!} ${user!.name!.last!}",
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: Text(
                  user!.email!,
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
