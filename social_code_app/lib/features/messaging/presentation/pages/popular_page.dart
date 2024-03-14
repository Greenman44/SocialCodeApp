import 'package:flutter/material.dart';
import 'package:social_code_app/features/messaging/presentation/widgets/popular_view.dart';
import "package:social_code_app/shared/shared.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_code_app/features/messaging/presentation/bloc/message_bloc.dart';
import 'package:social_code_app/features/messaging/presentation/widgets/my_text_controller.dart';
import 'package:social_code_app/injection_container.dart';
import 'package:social_code_app/features/messaging/domain/domain.dart';

// ignore: must_be_immutable
class PopularPage extends StatefulWidget {
  const PopularPage({super.key});

  @override
  State<PopularPage> createState() => _PopularState();
}

class _PopularState extends State<PopularPage> {
  final TextEditor controller = TextEditor();
  String selectedValue = "text";
  bool textReadOnly = false;
  List<Message> messages = [];
  Map<String, NetworkImage> userImages = {
    "basic": const NetworkImage(
        "https://umbrellacreative.com.au/wp-content/uploads/2020/01/hide-the-pain-harold-why-you-should-not-use-stock-photos-1024x683.jpg")
  };
  final scroller = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MessageBloc>(
      create: (BuildContext context) => sl(),
      child: BlocListener<AppAuthBloc, AppState>(
        listener: (context, state) {
          if (state.status == AppStatus.authenticated) {
            if (textReadOnly) {
              textReadOnly = false;
              setState(() {});
            }
          } else {
            if (!textReadOnly) {
              textReadOnly = true;
              setState(() {});
            }
          }
        },
        child: BlocBuilder<AppAuthBloc, AppState>(builder: (context, state) {
          var future = BlocProvider.of<MessageBloc>(context).populars.call();
          return Scaffold(
            appBar: AppBar(
              title: const Center(child: Text("Popular")),
              actions: [
                state.status == AppStatus.authenticated
                    ? const LogoutButton()
                    : const LoginButton()
              ],
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: FutureBuilder(
                        future: future,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return StreamBuilder(
                              stream: snapshot.data!,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  _buildUserImages(snapshot.data!);
                                  return ListView.separated(
                                    controller: scroller,

                                    //shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      var data = snapshot.data!;
                                      return Stack(
                                        children: [
                                          PopularView(
                                            message: data[index],
                                            textColor: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .background,
                                            userImage: userImages[
                                                data[index].user.email!]!,
                                          ),
                                        ],
                                      );
                                    },
                                    itemCount: snapshot.data!.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        height: 16,
                                      );
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                }
                                return const CircularProgressIndicator();
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: FloatingActionButton.small(
                    //     onPressed: () {
                    //       buildBottomSheet(context);
                    //     },
                    //     child: const Icon(Icons.edit),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: const BottomBar(starterIndex: 2),
          );
        }),
      ),
    );
  }

  // Future buildBottomSheet(BuildContext context) {
  //   return showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         return SingleChildScrollView(
  //           child: Padding(
  //             padding: EdgeInsets.fromLTRB(
  //                 0, 0, 0, MediaQuery.of(context).viewInsets.bottom + 200),
  //             child: Container(
  //               height: 300,
  //               padding: const EdgeInsets.all(12),
  //               decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.circular(30)),
  //               child: Column(
  //                 children: [
  //                   const Text(
  //                       "Select the language for the code you will write",
  //                       style: TextStyle(
  //                           fontWeight: FontWeight.bold, color: Colors.black)),
  //                   LanguageDropDown(selectedValue, _buildLanguagesList()),
  //                   const SizedBox(
  //                     height: 5,
  //                   ),
  //                   const TextField(
  //                     decoration: InputDecoration(
  //                       enabledBorder: OutlineInputBorder(
  //                           borderSide: BorderSide(color: Colors.black)),
  //                       focusedBorder: OutlineInputBorder(
  //                           borderSide: BorderSide(color: Colors.black)),
  //                       hintText: "Write some code!",
  //                     ),
  //                     maxLines: null,
  //                     keyboardType: TextInputType.multiline,
  //                     cursorColor: Colors.black,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  // }

  // _buildLoginDialog(BuildContext context) {
  //   return Dialog(
  //     child: Container(
  //       padding: const EdgeInsets.all(10),
  //       color: Colors.white,
  //       height: 100,
  //       width: 300,
  //       child: Column(
  //         children: [
  //           const Text(
  //             "Want to post something? Please login.",
  //             style:
  //                 TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
  //           ),
  //           const SizedBox(
  //             height: 8,
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               TextButton(
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                   child: const Text(
  //                     "Cancel",
  //                     style: TextStyle(
  //                         fontWeight: FontWeight.bold, color: Colors.black),
  //                   )),
  //               TextButton(
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                     Navigator.of(context).push(MaterialPageRoute(
  //                         builder: (context) => routes["/login"]!,
  //                         settings: const RouteSettings(name: "/login")));
  //                   },
  //                   child: const Text(
  //                     "Login",
  //                     style: TextStyle(
  //                         fontWeight: FontWeight.bold, color: Colors.black),
  //                   ))
  //             ],
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // _buildLanguagesList() {
  //   List<PopupMenuItem<String>> items = languages.map((value) {
  //     return PopupMenuItem<String>(
  //       value: value,
  //       child: Text(value),
  //       onTap: () {
  //         controller.currentLanguage = value;
  //       },
  //     );
  //   }).toList();
  //   items.add(PopupMenuItem(
  //     value: "text",
  //     child: const Text("text"),
  //     onTap: () {
  //       controller.currentLanguage = "text";
  //     },
  //   ));

  //   return items;
  // }

  // // _buildMenu() {
  // //   return DropdownMenu(
  // //     width: 20,
  // //     dropdownMenuEntries: _buildLanguagesList(),
  // //     leadingIcon: const Icon(Icons.code),
  // //   );
  // // }

  // _parseMessageField(BuildContext context) {
  //   List<MessageChunk> chunks = [];
  //   for (var chunk in controller.chunks) {
  //     int min = chunk.start;
  //     int max = chunk.end ?? controller.text.length;
  //     if (min >= controller.text.length || min == max) {
  //       continue;
  //     }
  //     String language = chunk.text;
  //     String text = controller.text.characters.getRange(min, max).string;
  //     chunks.add(MessageChunk(chunk: text, language: language));
  //   }
  //   DateTime timestamp = DateTime.now();
  //   User user = BlocProvider.of<AppAuthBloc>(context).state.user;
  //   return Message(
  //       chunks: chunks, user: user, jumps: [], timeStamp: timestamp, likes: []);
  // }

  // _buildDeleteDialog(BuildContext context, Message message, MessageBloc bloc) {
  //   return Dialog(
  //       child: Container(
  //     padding: const EdgeInsets.all(10),
  //     color: Colors.white,
  //     height: 100,
  //     width: 300,
  //     child: Column(
  //       children: [
  //         const Text(
  //           "Are you sure you want to delete?",
  //           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
  //         ),
  //         const SizedBox(
  //           height: 8,
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: const Text(
  //                   "No",
  //                   style: TextStyle(
  //                       fontWeight: FontWeight.bold, color: Colors.black),
  //                 )),
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                   bloc.add(DeleteMessageEvent(message));
  //                 },
  //                 child: const Text(
  //                   "Yes",
  //                   style: TextStyle(
  //                       fontWeight: FontWeight.bold, color: Colors.black),
  //                 ))
  //           ],
  //         )
  //       ],
  //     ),
  //   ));
  // }

  void _buildUserImages(List<Message> data) {
    for (var message in data) {
      if (!userImages.containsKey(message.user.email!)) {
        if (message.user.photoUrl != null &&
            message.user.photoUrl!.isNotEmpty) {
          userImages[message.user.email!] =
              NetworkImage(message.user.photoUrl!);
        } else {
          userImages[message.user.email!] = userImages["basic"]!;
        }
      } else if (message.user.photoUrl != null &&
          message.user.photoUrl!.isNotEmpty &&
          userImages[message.user.email!]!.url != message.user.photoUrl!) {
        userImages[message.user.email!] = NetworkImage(message.user.photoUrl!);
      }
    }
  }
}
