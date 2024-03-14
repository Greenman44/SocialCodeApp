import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_code_app/shared/shared.dart';
import 'package:social_code_app/config/routes/routes.dart';
import 'package:social_code_app/features/auth/presentation/bloc/profile/profile_bloc.dart';
import 'package:social_code_app/injection_container.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool noNameEdit = true;
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => sl(),
      child: BlocListener<AppAuthBloc, AppState>(
        listener: (context, state) {
          if (state.status == AppStatus.unauthenticated) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => routes["/home"]!,
                settings: const RouteSettings(name: "/home")));
          }
        },
        child: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is PhotoChangedState) {
              setState(() {});
            }
          },
          child: BlocBuilder<AppAuthBloc, AppState>(
            builder: (context, state) {
              if (state.status == AppStatus.authenticated) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Center(
                        child: Text(
                      "Profile",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    actions: [
                      IconButton(
                          onPressed: () {
                            BlocProvider.of<AppAuthBloc>(context)
                                .add(const AppLogOutRequest());
                          },
                          icon: const Icon(Icons.logout))
                    ],
                  ),
                  body: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Stack(alignment: Alignment.bottomRight, children: [
                            const CircleAvatar(
                                radius: 100,
                                backgroundColor:
                                    Color.fromARGB(255, 69, 69, 69),
                                foregroundImage: NetworkImage(
                                    "https://umbrellacreative.com.au/wp-content/uploads/2020/01/hide-the-pain-harold-why-you-should-not-use-stock-photos-1024x683.jpg"),
                                //  BlocProvider.of<AppAuthBloc>(
                                //                 context)
                                //             .state
                                //             .user
                                //             .photoUrl !=
                                //         null
                                //     #? NetworkImage(
                                //         BlocProvider.of<AppAuthBloc>(context)
                                //             .state
                                //             .user
                                //             .photoUrl!)
                                //     : null,
                                child: CircularProgressIndicator()),
                            FloatingActionButton(
                              backgroundColor: Colors.blue,
                              shape: const CircleBorder(),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          width: 200,
                                          height: 120,
                                          child: const Center(
                                            child: Text(
                                                "This is just a placeholder for future versions. Rigth now is not a requirement."),
                                          ),
                                        ),
                                      );
                                    });
                                // ProfileBloc bloc = sl();
                                // String email =
                                //     BlocProvider.of<AppAuthBloc>(context)
                                //         .state
                                //         .user
                                //         .email!;
                                // bloc.add(UploadPhotoEvent(email));
                              },
                              child: const Icon(Icons.image),
                            )
                          ]),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller: TextEditingController(
                                  text: BlocProvider.of<AppAuthBloc>(context)
                                      .state
                                      .user
                                      .email),
                              readOnly: true,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.email),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                label: const Text(
                                  "Email",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller: controller,
                              readOnly: noNameEdit,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.text_fields),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide:
                                          const BorderSide(color: Colors.grey)),
                                  label: const Text(
                                    "Name",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Dialog(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                width: 200,
                                                height: 120,
                                                child: const Center(
                                                  child: Text(
                                                      "This is just a placeholder for future versions. Rigth now is not a requirement."),
                                                ),
                                              ),
                                            );
                                          });
                                      // if (noNameEdit) {
                                      //   noNameEdit = false;
                                      //   setState(() {});
                                      // }
                                    },
                                    icon: noNameEdit
                                        ? const Icon(Icons.edit)
                                        : const Icon(Icons.done),
                                    color: Colors.blue,
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          width: 200,
                                          height: 120,
                                          child: const Center(
                                            child: Text(
                                                "This is just a placeholder for future versions. Rigth now is not a requirement."),
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(25),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).focusColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.delete),
                                    Text(
                                      "Delete Account",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(
                                      Icons.cancel_outlined,
                                      color: Colors.red,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  bottomNavigationBar: const BottomBar(starterIndex: 0),
                );
              }
              return Scaffold(
                appBar: AppBar(
                  title: const Center(
                      child: Text(
                    "Profile",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.dangerous,
                        size: 150,
                      ),
                      const Text(
                        "Seems like you are not currently log in.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Please ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => routes["/login"]!,
                                  settings:
                                      const RouteSettings(name: "/login")));
                            },
                            child: const Text(
                              "login.",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.blue),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                bottomNavigationBar: const BottomBar(starterIndex: 0),
              );
            },
          ),
        ),
      ),
    );
  }
}
