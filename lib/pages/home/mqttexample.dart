import 'package:flutter/material.dart';
import 'package:hello_worl2/model/mqtt.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hello_worl2/model/user.dart';
import 'package:hello_worl2/provider/user_provider.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:provider/provider.dart';

class MqttExample extends StatefulWidget {
  @override
  _MqttExampleState createState() => _MqttExampleState();
}

class _MqttExampleState extends State<MqttExample>
    with SingleTickerProviderStateMixin {
  late MqttService _mqttService;
  bool _messageReceived = false;
  late AnimationController _animationController;
  User? currentUser;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        currentUser = Provider.of<UserProvider>(context, listen: false).user;
      });
      if (currentUser != null) {
        _mqttService = MqttService(
          serverUri: 'fe265cd34caa4bfdb65ebf91b76283a1.s1.eu.hivemq.cloud',
          port: 8884, // WebSocket port
          clientId: currentUser!.userId.toString(),
          topic: 'AppData/User-${currentUser!.userId.toString()}',
          username: 'Application',
          password: 'Poseidon_app1',
        );
        _connectAndListen();
      }
    });
  }

  void _connectAndListen() async {
    await _mqttService.connect();
    if (_mqttService.client.connectionStatus?.state ==
        MqttConnectionState.connected) {
      _mqttService.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
        final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
        final String pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        print('Message received: $pt');
        setState(() {
          _messageReceived = true;
          _animationController.forward(from: 0.0);
        });
      });
    } else {
      print('Connection failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MQTT Example'),
      ),
      body: Center(
        child: _messageReceived
            ? AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Icon(
                    Icons.message,
                    size: 100 * _animationController.value,
                    color: Colors.blue,
                  );
                },
              )
            : SpinKitCircle(
                color: Colors.blue,
                size: 50.0,
              ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _mqttService.client.disconnect();
    super.dispose();
  }
}
