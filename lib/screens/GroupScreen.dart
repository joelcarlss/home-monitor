import 'package:HomeMonitor/actions/hue.dart';
import 'package:HomeMonitor/widgets/unit_list_item.dart';
import 'package:flutter/material.dart';
import 'package:hue_dart/hue_dart.dart';
import 'LightScreen.dart';

class GroupScreen extends StatefulWidget {
  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  int a = 0;
  final hue = new Hue();

  Future<List<Group>> futureGroups;

  getGroups() {
    setState(() {
      futureGroups = hue.getGroups();
    });
  }

  onLightUpdate(Light light, {on}) {
    print(light);
    Future isUpdated = hue.updateLightState(light, on: on);
    isUpdated.then((value) => getGroups());
  }

  @override
  void initState() {
    Future isConnected = hue.connect();

    isConnected.then((value) => getGroups());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    buildList(groups) => GridView.builder(
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, childAspectRatio: 5 / 5.2),
          itemCount: groups.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(25),
              child: InkWell(
                child: UnitListItem(
                    icon: Icons.ac_unit, title: groups[index].name),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          LightScreen(groups[index], onLightUpdate),
                    )),
              ),
            );
          },
        );

    return Container(
        child: FutureBuilder(
      future: futureGroups,
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text(snapshot.error.toString());
        if (snapshot.hasData) return buildList(snapshot.data);
        return Center(child: CircularProgressIndicator());
      },
    ));
  }
}

// @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: GridView.builder(
//         gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 4, childAspectRatio: 5 / 5.2),
//         itemCount: rooms.length,
//         itemBuilder: (context, index) => Padding(
//           padding: EdgeInsets.all(30),
//           child: UnitListItem(icon: Icons.ac_unit, title: rooms[index]),
//         ),
//       ),
//     );
//   }
