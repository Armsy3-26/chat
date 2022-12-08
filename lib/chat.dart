import 'package:chat/mainScreen.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _formKey = GlobalKey<FormState>();

  

  final _textController = TextEditingController();

  List chat = [
    {"message": "Hello", "id": 1},
    {"message": "Hey, how may i assist you", "id": 2},
    {"message": "Do you guys offer reservations?", "id": 1},
    {"message": "Yes, we do offer reservations.", "id": 2},
    {"message": "I'll like to reserver a dinner table at 7:00 pm ", "id": 1},
    {"message": "Your reservation has been saved!", "id": 2},
    {"message": "Please make sure to be on time!", "id": 2},
    {
      "message":
          "Sure i'll keep time.And can i make a special order?Sure i'll keep time.And can i make a special order?",
      "id": 1
    },
    {
      "message": "I'm sorry we are not offering special offers for now.",
      "id": 2
    },
    {"message": "Okay. Thank you for the service.", "id": 1},
    {
      "message": "Your welcomed!, Always contact us for clarifications.",
      "id": 2
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        bottomOpacity: 0,
        elevation: 0,
        backgroundColor: Colors.yellow,
        title: Column(
          children: const [
            Text("OutReach", style: TextStyle(color: Colors.black)),
            Align(
              alignment: Alignment.center,
              child: Text("This conversation will self-destruct on exit!",
                  style: TextStyle(fontSize: 7, color: Colors.black)),
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
                                'No outreach to restraunt name',
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
                                          hintText: 'Type a message',
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
                            Row(
                              children: [
                                IconButton(
                                  splashRadius: 20,
                                  icon: const Icon(
                                    Icons.send,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    chat.add({
                                      "message": _textController.text,
                                      "id": 1
                                    });
                                    _textController.clear();
                                    setState(() {});
                                  },
                                ),
                                IconButton(
                                  splashRadius: 20,
                                  icon: const Icon(
                                    Icons.send,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    chat.add({
                                      "message": _textController.text,
                                      "id": 2
                                    });
                                    _textController.clear();
                                    setState(() {});
                                  },
                                ),
                              ],
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
