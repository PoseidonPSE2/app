import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:hello_worl2/model/user.dart';

class MqttService {
  late MqttServerClient client;
  bool _messageReceived = false;
  String _message = '';
  User currentUser;

  bool get messageReceived => _messageReceived;
  String get message => _message;

  MqttService(this.currentUser) {
    client = MqttServerClient('maqiatto.com', 'vsmqtt_client_b094');
    client.port = 1883;
    client.logging(on: true);
    client.onDisconnected = _onDisconnected;
    client.onConnected = _onConnected;
    client.onSubscribed = _onSubscribed;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier('vsmqtt_client_b094')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;

    _connect();
  }

  void _connect() async {
    try {
      await client.connect('alexresklin@gmail.com', 'poseidon');
    } catch (e) {
      print('Exception: $e');
      _disconnect();
    }
  }

  void _disconnect() {
    client.disconnect();
  }

  void _onConnected() {
    print('Connected');
    _subscribeToTopic(
        'alexresklin@gmail.com/AppData/User-${currentUser.userId}');
  }

  void _onDisconnected() {
    print('Disconnected');
  }

  void _onSubscribed(String topic) {
    print('Subscribed to $topic');
  }

  void _subscribeToTopic(String topic) {
    client.subscribe(topic, MqttQos.atLeastOnce);
    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      final String pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print('Message received: $pt');
      _messageReceived = true;
      _message = pt;
    });
  }
}
