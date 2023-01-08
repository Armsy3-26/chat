import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController {
  late IO.Socket socket;
  //establishing connection statuses and receiving restaraunt messages
  String? status;

  String? receiverConnectionStatus;

  socketConnection() {
    socket.onConnect((data) {
      if (data != null) {
        print(data + "fucks");
      }
      socket.emit("connection", {
        'sender': 'cooler',
        'receiver': 'Future Restaurant',
        'origin': 'user'
      });
      status = "You Connected.";

      update();
    });
    socket.onDisconnect((data) {
      status = "You Disconnected.";
      update();
    });
    socket.onConnectError((data) {
      //print(data);
      status = "Connection Error";

      update();
    });
    socket.on('message', (data) {
      DateTime now = DateTime.now();

      if (data['feedback'] == "Sent-Status") {
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

    socket.on("connectionstatus", (data) {
      receiverConnectionStatus = data['feedback'];

      update();
    });

    socket.on('restore', (data) {
      if (data['status'] == "ok") {
        for (var index = 0; index < data['conversation'].length; index++) {
          if (data['conversation'][index]['id'] == 1) {
            chat.add({
              "message": data['conversation'][index]['message'],
              "id": 2,
              "datetime": data['conversation'][index]['time']
            });
          } else {
            chat.add({
              "message": data['conversation'][index]['message'],
              "id": 1,
              "datetime": data['conversation'][index]['time']
            });
          }
        }

        chat.add(data['conversation'][0]);
      } else if (data['status'] == "failed") {
        print(data['status']);
      }

      update();
    });
  }

  //sending a message to restaraunt client
  sendMessage(msg) {
    socket.emit('message',
        {'message': msg, 'receiver': 'Future Restaurant', 'sender': 'cooler'});

    update();
  }

//requesting/trying to retrieve a conversation
//takes username as a payload

  retrieveConversation() {
    socket.emit('restore', {
      {
        "username": "cooler",
        "requested": 'Future Restaurant',
        "origin": 'client'
      }
    });
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
