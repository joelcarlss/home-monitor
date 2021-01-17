import 'package:HomeMonitor/actions/hue.dart';
import 'package:HomeMonitor/widgets/unit_list_item.dart';
import 'package:built_collection/src/list.dart';
import 'package:flutter/material.dart';
import 'package:hue_dart/hue_dart.dart';

class LightScreen extends StatefulWidget {
  LightScreen(this.group, this.onLightUpdate);
  final Group group;
  final onLightUpdate;
  @override
  _LightScreenState createState() => _LightScreenState();
}

class _LightScreenState extends State<LightScreen> {
  // @override
  // void initState() {
  //   super.initState();
  // }
  updateLight(Light light) {
    // print(light);
    print(light.state.on);
    widget.onLightUpdate(light, on: !light.state.on);
  }

  @override
  Widget build(BuildContext context) {
    BuiltList<Light> lights = widget.group.groupLights;
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, childAspectRatio: 5 / 5.2),
        itemCount: lights.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.all(25),
              child: InkWell(
                onTap: () => updateLight(lights[index]),
                child: UnitListItem(
                    icon: Icons.ac_unit, title: lights[index].name),
              ));
        },
      ),
    );
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
