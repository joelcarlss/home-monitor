import 'package:HomeMonitor/models/Credential.dart';
import 'package:http/http.dart';
import 'package:hue_dart/hue_dart.dart';
import 'database.dart';

class Hue {
  final client = Client();
  Bridge bridge;
  final name = 'hue_dart';
  String userName;
  var db = DataBase();
  var credential = Credential('hue_token');

  Future connect() async {
    // Get username from database
    var a = await db.open();
    Future<Credential> b = credential.getFirst(a, name);
    b.then((credential) => {userName = credential.value});

    // Set up hue connection
    final discoveryResult = await search().then((value) {
      print(value);
      createBridge(value);
      return true;
    });
    return discoveryResult;
  }

  /// search for bridges
  Future<DiscoveryResult> search() async {
    final discovery = BridgeDiscovery(client);

    List<DiscoveryResult> discoverResults = await discovery.automatic();
    final discoveryResult = discoverResults.first;
    print(discoveryResult.ipAddress);
    return discoveryResult;
  }

  //create bridge
  createBridge(discoveryResult) {
    bridge = Bridge(client, discoveryResult.ipAddress);
    bridge.username = userName;
    return bridge;
  }

  Future<String> createUser(String name) async {
    /// create a user, press the push link button before calling this
    final whiteListItem = await bridge.createUser(name);
    // use username for consequent calls to the bridge
    bridge.username = whiteListItem.username;
    return whiteListItem.username;
  }

  Future<Light> getLight(int id) async {
    var light = bridge.light(id);
    return light;
  }

  /// get lights
  Future<List<Light>> getLights() async {
    var lights = bridge.lights();
    return lights;
  }

  // update light state
  updateLightState(Light light, {on}) async {
    // final light = lights.first.changeColor(red: 1.0, green: 0.5, blue: 1.0);
    // final colorLight = updateLight.changeColor(red: 1.0, green: 0.5, blue: 1.0);
    LightState state = lightStateForColorOnly(light);
    state = state.rebuild((s) => s..on = (on == null ? s.on : on)
        // ..brightness = 10,
        );
    var result = await bridge
        .updateLightState(light.rebuild(
          (l) => l..state = state.toBuilder(),
        ))
        .then((value) => true);
    return result;
  }

  Future<List<Group>> getGroups() async {
    var groups = await bridge.groups();
    return groups;
  }
}
