import 'package:chat/chatcontrollers.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _textController = TextEditingController();

  //accessing chatcontroller back-logic

  ChatController chatController = Get.put(ChatController());

  @override
  void initState() {
    super.initState();
    chatController.socket = IO.io(
        'http://127.0.0.1:5000',
        IO.OptionBuilder().setTransports(['websocket']).setQuery(
            {'username': "armsy"}).build());
    chatController.socketConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
              child: GetBuilder<ChatController>(builder: (context) {
                return Text(chatController.status ?? "Connecting...",
                    style: TextStyle(fontSize: 7.sp, color: Colors.black));
              }),
            ),
          ],
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.restore))
        ],
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GetBuilder<ChatController>(builder: (_) {
                return Expanded(
                  child: chatController.chat.isEmpty
                      ? Container(
                          //color: Colors.pink,
                          padding: EdgeInsets.symmetric(vertical: 8.w),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.chat,
                                  size: 80,
                                  color: Colors.grey.shade400,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                const Text(
                                  'No outreach to restraunt name\n\nConversation will self-destruct on exit.',
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: chatController.chat.length,
                          itemBuilder: (BuildContext ctx, index) =>
                              chatController.chat[index]['id'] == 1
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                            "${chatController.chat[index]['datetime']}",
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                fontStyle: FontStyle.italic)),
                                        BubbleSpecialOne(
                                            text:
                                                "${chatController.chat[index]['message']}",
                                            isSender: false,
                                            color: Colors.green.shade100,
                                            textStyle: TextStyle(
                                                fontSize: 15.sp,
                                                //color: Colors.purple,
                                                fontStyle: FontStyle.italic)),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        BubbleSpecialOne(
                                            text:
                                                "${chatController.chat[index]['message']}",
                                            isSender: false,
                                            color: Colors.purple.shade100,
                                            textStyle: TextStyle(
                                                fontSize: 15.sp,
                                                color: Colors.purple,
                                                fontStyle: FontStyle.italic)),
                                        Text(
                                            "${chatController.chat[index]['datetime']}",
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                fontStyle: FontStyle.italic)),
                                      ],
                                    )),
                );
              }),
              Align(
                alignment: Alignment.bottomCenter,
                child: Card(
                  color: Colors.yellow,
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 8.r,
                      left: 8.r,
                      bottom: MediaQuery.of(context).viewInsets.bottom > 0.r
                          ? 7.5.r
                          : 14.r,
                      //top: 2.r, //no to margin near hot and message input
                    ),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              // color: Colors.blue,
                              height: 55,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.all(10.0.r),
                                children: chatController.hotWords
                                    .map(
                                      (e) => Wrap(children: [
                                        GestureDetector(
                                          onTap: () {
                                            chatController.addSenderMessage(e);

                                            chatController.sendMessage(e);
                                          },
                                          child: Chip(
                                              padding: EdgeInsets.all(8.0.r),
                                              label: Text(e)),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        )
                                      ]),
                                    )
                                    .toList(),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: _textController,
                                          minLines: 1,
                                          maxLines: 5,
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding: EdgeInsets.only(
                                                right: 16.r,
                                                left: 20.r,
                                                bottom: 10.r,
                                                top: 10.r),
                                            hintStyle: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.grey.shade700),
                                            hintText: 'Alixe:)-',
                                            border: InputBorder.none,
                                            filled: true,
                                            fillColor: Colors.grey.shade100,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              gapPadding: 0,
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade200),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              gapPadding: 0,
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade300),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  splashRadius: 20.r,
                                  icon: const Icon(
                                    Icons.send,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    if (_textController.text.isNotEmpty) {
                                      chatController.addSenderMessage(
                                          _textController.text);
                                      /*chatController
                                          .sendMessage(_textController.text);*/
                                      _textController.clear();
                                    }
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
