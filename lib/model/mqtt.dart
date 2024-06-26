import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  final String serverUri;
  final int port;
  final String clientId;
  final String topic;
  final String username;
  final String password;
  late MqttServerClient client;

  MqttService({
    required this.serverUri,
    required this.port,
    required this.clientId,
    required this.topic,
    required this.username,
    required this.password,
  }) {
    client = MqttServerClient.withPort(serverUri, clientId, port);
    client.logging(on: true); // Enable logging
    client.keepAlivePeriod = 20;
    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;
    client.onSubscribed = onSubscribed;
    client.secure = false; // Set to true if using a secure connection
    client.port = 8884; // WebSocket port
    client.useWebSocket = true; // Enable WebSocket
    client.setProtocolV311();
    client.autoReconnect = true;

    client.connectionMessage = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .authenticateAs(username, password)
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
  }

  Future<void> connect() async {
    try {
      await client.connect();
      if (client.connectionStatus?.state == MqttConnectionState.connected) {
        print('Connected');
        client.subscribe(topic, MqttQos.atLeastOnce);
      } else {
        print('Connection failed');
        client.disconnect();
      }
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }
  }

  Stream<List<MqttReceivedMessage<MqttMessage>>> get updates => client.updates!;

  void onDisconnected() {
    print('Disconnected');
  }

  void onConnected() {
    print('Connected');
  }

  void onSubscribed(String topic) {
    print('Subscribed to $topic');
  }
}
