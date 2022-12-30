import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController {
  late IO.Socket socket;
  //establishing connection statuses and receiving restaraunt messages
  String? status;

  socketConnection() {
    socket.onConnect((data) {
      socket.emit("connection", "cooler");
      status = "Connected.";

      update();
    });
    socket.onDisconnect((data) {
      status = "Disconnected.";
      update();
    });
    socket.onConnectError((data) {
      //print(data);
      status = "Connection Error";

      update();
    });
    socket.on('message', (data) {
      chat.add({"message": data, "id": 2});
      update();
    });
  }

  //sending a message to restaraunt client
  sendMessage(msg) {
    socket.emit('message', {
      'message': msg,
      'receiver': 'Yummy Restaraunt.',
      'sender': 'alixe-client'
    });

    update();
  }

//adds sender message to chat list
  addSenderMessage(msg) {
    //get current datetime only hour and minutes

    DateTime now = DateTime.now();

    chat.add(
        {'message': msg, 'id': 1, 'datetime': "${now.hour}:${now.minute}"});
    update();
  }

  List chat = [];

  List hotWords = [
    "Hello",
    "Sasa",
    "Hey",
    "Can I book a reservation?",
    "Can I get a refund?",
    "Thanks"
  ];
}
