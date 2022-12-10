import 'dart:async';

import 'package:chat/mainScreen.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textController = TextEditingController();

  String status = "Establishing Connection....";

  late String errors;

  late IO.Socket socket;
  sendMessage(msg) {
    socket.emit('message', {'message': msg, 'Sender': 'Armsy326'});
  }

  socketConnection() {
    socket.onConnect((data) {
      status = "Connected to Server";
      setState(() {});
    });
    socket.onDisconnect((data) {
      status = "Disconnected from Server";
      setState(() {});
    });
    socket.onConnectError((data) {
      errors = data;
    });
    socket.on('message', (data) {
      chat.add({"message": data, "id": 2});
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();

    socket = IO.io(
        'http://localhost:5000',
        IO.OptionBuilder().setTransports(['websocket']).setQuery(
            {'username': "armsy"}).build());
    socketConnection();
  }

  List chat = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        bottomOpacity: 0,
        elevation: 0,
        backgroundColor: Colors.yellow,
        title: Column(
          children: [
            const Text("OutReach", style: TextStyle(color: Colors.black)),
            Align(
              alignment: Alignment.center,
              child: Text(status,
                  style: const TextStyle(fontSize: 7, color: Colors.black)),
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MainScreen()));
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              Expanded(
                child: chat.isEmpty
                    ? Container(
                        color: Colors.pink,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.chat,
                                size: 80,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'No outreach to restraunt name\n\nConversation will self-destruct on exit.',
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: chat.length,
                        itemBuilder: (BuildContext ctx, index) =>
                            chat[index]['id'] == 1
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      BubbleSpecialOne(
                                          text: "${chat[index]['message']}",
                                          isSender: false,
                                          color: Colors.green.shade100,
                                          textStyle: const TextStyle(
                                              fontSize: 15,
                                              //color: Colors.purple,
                                              fontStyle: FontStyle.italic)),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      BubbleSpecialOne(
                                          text: "${chat[index]['message']}",
                                          isSender: false,
                                          color: Colors.purple.shade100,
                                          textStyle: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.purple,
                                              fontStyle: FontStyle.italic)),
                                    ],
                                  )),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: 8,
                        left: 8,
                        bottom: MediaQuery.of(context).viewInsets.bottom > 0
                            ? 15
                            : 28,
                        top: 8),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      child: TextField(
                                        controller: _textController,
                                        minLines: 1,
                                        maxLines: 5,
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: const EdgeInsets.only(
                                              right: 16,
                                              left: 20,
                                              bottom: 10,
                                              top: 10),
                                          hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade700),
                                          hintText: 'Alixe:)-',
                                          border: InputBorder.none,
                                          filled: true,
                                          fillColor: Colors.grey.shade100,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            gapPadding: 0,
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade200),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            gapPadding: 0,
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade300),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              splashRadius: 20,
                              icon: const Icon(
                                Icons.send,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                if (_textController.text.isNotEmpty) {
                                  chat.add({
                                    'message': _textController.text,
                                    'id': 1
                                  });
                                  setState(() {});
                                  sendMessage(_textController.text);
                                  _textController.clear();
                                  setState(() {});
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
