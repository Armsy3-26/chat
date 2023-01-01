import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController {
  late IO.Socket socket;
  //establishing connection statuses and receiving restaraunt messages
  String? status;

  socketConnection() {
    socket.onConnect((data) {
      if (data != null) {
        print(data);
      }
      socket.emit(
          "connection", {'sender': 'cooler', 'receiver': 'Cloud Restaraunt'});
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
      DateTime now = DateTime.now();
      print(data);
      if (data['sender'] == "AliXe-Server") {
        print(data);
      } else {
        chat.add({
          "message": data['message'],
          "id": 2,
          'datetime': "${now.hour}:${now.minute}",
          'status': true
        });
      }

      update();
    });
  }

  //sending a message to restaraunt client
  sendMessage(msg) {
    socket.emit('message',
        {'message': msg, 'receiver': 'Cloud Restaurant', 'sender': 'cooler'});

    update();
  }

//adds sender message to chat list
  addSenderMessage(msg) {
    //get current datetime only hour and minutes

    DateTime now = DateTime.now();

    chat.add(
      {
        'message': msg,
        'id': 1,
        'datetime': "${now.hour}:${now.minute}",
        'status': true
      },
    );
    update();
  }

  List chat = [];

  List hotWords = [
    "Hello",
    "Sasa",
    "Hey",
    "Can I book a reservation?",
    "Can I get a refund?",
    "Thanks",
    "Hey restraunt name"
  ];
}
