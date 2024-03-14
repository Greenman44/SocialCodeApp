// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:social_code_app/features/auth/presentation/bloc/profile/profile_bloc.dart';
// import 'package:social_code_app/shared/bloc/app_status/app_auth_bloc.dart';

// class AvatarBubble extends StatefulWidget {
//   const AvatarBubble({super.key});

//   @override
//   State<AvatarBubble> createState() => _AvatarBubbleState();
// }

// class _AvatarBubbleState extends State<AvatarBubble> {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(alignment: Alignment.bottomRight, children: [
//       CircleAvatar(
//           radius: 100,
//           backgroundColor: const Color.fromARGB(255, 69, 69, 69),
//           backgroundImage: BlocProvider.of<AppAuthBloc>(context)
//                       .status
//                       .currentUserData()
//                       .photoUrl !=
//                   null
//               ? NetworkImage(BlocProvider.of<AppAuthBloc>(context)
//                   .status
//                   .currentUserData()
//                   .photoUrl!)
//               : null,
//           child: BlocProvider.of<AppAuthBloc>(context)
//                       .status
//                       .currentUserData()
//                       .photoUrl ==
//                   null
//               ? const Icon(
//                   Icons.person,
//                   size: 190,
//                   color: Colors.white,
//                 )
//               : null),
//       FloatingActionButton(
//         backgroundColor: Colors.blue,
//         shape: const CircleBorder(),
//         onPressed: () {
//           BlocProvider.of<ProfileBloc>(context).add(UploadPhotoEvent());
//         },
//         child: const Icon(Icons.image),
//       )
//     ]);
//   }
// }
