// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:social_code_app/config/routes/routes.dart';
import 'package:social_code_app/features/messaging/domain/entitties/message.dart';
import 'package:social_code_app/features/messaging/presentation/bloc/message_bloc.dart';
import 'package:social_code_app/shared/presentation/bloc/app_status/app_auth_bloc.dart';

class MessageView extends StatefulWidget {
  MessageView(
      {super.key,
      required this.message,
      required this.textColor,
      required this.backgroundColor,
      required this.userImage});
  Message message;
  final dynamic textColor;
  final dynamic backgroundColor;
  final NetworkImage userImage;

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  List<Widget> messageStructure = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    messageStructure = [];
    messageStructure.add(messageHeader());
    for (var chunk in widget.message.chunks) {
      if (chunk.language == "text") {
        messageStructure.add(Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            chunk.chunk,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ));
      } else {
        messageStructure.add(
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: HighlightView(
              chunk.chunk,
              language: chunk.language,
              theme: githubTheme,
            ),
          ),
        );
      }
    }
    messageStructure.add(const SizedBox(
      height: 4,
    ));
    messageStructure.add(messageFooter());
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xfff8f8f8),
          borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: messageStructure,
      ),
    );
  }

  getDate(DateTime date) {
    var minute = date.minute > 10 ? "" : "0";
    return "${date.day}/${date.month}/${date.year}, ${date.hour}:${minute + date.minute.toString()}";
  }

  messageHeader() {
    return Row(
      children: [
        CircleAvatar(
          //backgroundColor: widget.backgroundColor,
          foregroundImage: widget.userImage,
          child: const CircularProgressIndicator(),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          (widget.message.user.name != null &&
                  widget.message.user.name!.isNotEmpty)
              ? widget.message.user.name!
              : widget.message.user.email!,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: widget.textColor,
          ),
        )
      ],
    );
  }

  messageFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocListener<MessageBloc, MessageState>(
          listener: (context, state) {
            if (state is LikedPosted) {
              setState(() {});
            }
          },
          child: BlocBuilder<MessageBloc, MessageState>(
            bloc: BlocProvider.of<MessageBloc>(context),
            builder: (context, state) {
              return Row(
                children: [
                  BlocBuilder<AppAuthBloc, AppState>(
                    builder: (context, state) {
                      if (state.status == AppStatus.authenticated) {
                        var future = BlocProvider.of<MessageBloc>(context)
                            .userLikesMessage
                            .call(params: <String, dynamic>{
                          "message": widget.message,
                          "user":
                              BlocProvider.of<AppAuthBloc>(context).state.user
                        });
                        return GestureDetector(
                          onTap: () {
                            BlocProvider.of<MessageBloc>(context).add(
                                PostUnPostLike(
                                    widget.message,
                                    BlocProvider.of<AppAuthBloc>(context)
                                        .state
                                        .user));
                          },
                          child: FutureBuilder(
                              future: future,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return snapshot.data!
                                      ? const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )
                                      : const Icon(
                                          Icons.favorite_border,
                                          color: Colors.red,
                                        );
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              }),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    _buildLoginDialog(context));
                          },
                          child: const Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    "${widget.message.likes.length.toString()} likes",
                    style: const TextStyle(
                        color: Color.fromARGB(255, 161, 160, 160)),
                  )
                ],
              );
            },
          ),
        ),
        Text(
          getDate(widget.message.timeStamp),
          style: const TextStyle(color: Color.fromARGB(255, 161, 160, 160)),
        ),
      ],
    );
  }

  _buildLoginDialog(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        height: 100,
        width: 300,
        child: Column(
          children: [
            const Text(
              "Want to post a like? Please login.",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => routes["/login"]!,
                          settings: const RouteSettings(name: "/login")));
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
