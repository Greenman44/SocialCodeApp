import 'package:get_it/get_it.dart';
import 'package:social_code_app/features/auth/data/repository/firebase_authentication_repository.dart';
import 'package:social_code_app/features/auth/data/repository/firebase_photo_uploader.dart';
import 'package:social_code_app/features/auth/domain/repository/photo_loader_repository.dart';
import 'package:social_code_app/features/auth/domain/repository/user_authentication_repository.dart';
import 'package:social_code_app/features/auth/domain/usecases/login_usecases.dart';
import 'package:social_code_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:social_code_app/features/messaging/data/datasources/data_source.dart';
import 'package:social_code_app/features/messaging/data/datasources/remote/firestore_messages.dart';
import 'package:social_code_app/features/messaging/data/repository/message_rep_impl.dart';
import 'package:social_code_app/features/messaging/domain/repository/message_repository.dart';
import 'package:social_code_app/features/messaging/domain/usecases/delete_messages.dart';
import 'package:social_code_app/features/messaging/domain/usecases/like_dislike_message.dart';
import 'package:social_code_app/features/messaging/domain/usecases/message_streamer.dart';
import 'package:social_code_app/features/messaging/domain/usecases/popular_message_streamer.dart';
import 'package:social_code_app/features/messaging/domain/usecases/upload_message.dart';
import 'package:social_code_app/features/messaging/domain/usecases/user_likes_message.dart';
import 'package:social_code_app/features/messaging/presentation/bloc/message_bloc.dart';
import 'package:social_code_app/shared/shared.dart';

final sl = GetIt.instance;

Future<void> initializedDependencies() async {
  //DATASOURCES
  sl.registerSingleton<MessageDatasource>(FirestoreMessageDB());
  // DEPENDENCIES
  sl.registerSingleton<IUserAuthenticationRepository>(
      IFirebaseAuthenticationRepository());
  sl.registerSingleton<IPhotoUpLoaderRepository>(
      FirebaseStoragePhotoUpLoader());
  sl.registerSingleton<IUserStatus>(FirebaseUserStatus());
  sl.registerSingleton<IMessagingRepository>(MessageRepImpl(db: sl()));
  //USECASES
  sl.registerSingleton<GetUser>(GetUser(repository: sl()));
  sl.registerSingleton<LogOut>(LogOut(repository: sl()));
  sl.registerSingleton<LogInWithEmailAndPassword>(
      LogInWithEmailAndPassword(repository: sl()));
  sl.registerSingleton<LogInWithGoogle>(LogInWithGoogle(repository: sl()));
  sl.registerSingleton<SignUp>(SignUp(repository: sl()));
  sl.registerSingleton<UserIsLogin>(UserIsLogin(status: sl()));
  sl.registerSingleton<UserLogOut>(UserLogOut(status: sl()));
  sl.registerSingleton<UserCurrentData>(UserCurrentData(status: sl()));
  sl.registerSingleton<UpLoadPhoto>(UpLoadPhoto(photoUploader: sl()));
  sl.registerSingleton<MessageStreamer>(MessageStreamer(repository: sl()));
  sl.registerSingleton<UpLoadMessage>(UpLoadMessage(repository: sl()));
  sl.registerSingleton<DeleteMessages>(DeleteMessages(repository: sl()));
  sl.registerSingleton<LikeDislikeMessage>(
      LikeDislikeMessage(repository: sl()));
  sl.registerSingleton<UserLikesMessage>(UserLikesMessage(repository: sl()));
  sl.registerSingleton<PopularMessageStreamer>(
      PopularMessageStreamer(repository: sl()));
  //BLOC
  sl.registerSingleton<AppAuthBloc>(
      AppAuthBloc(login: sl(), logOut: sl(), currentData: sl()));
  sl.registerFactory<RegisterBloc>(() => RegisterBloc(signUp: sl()));
  sl.registerFactory<LoginBloc>(
      () => LoginBloc(logInWithEmailAndPassword: sl(), logInWithGoogle: sl()));
  sl.registerFactory<ProfileBloc>(
      () => ProfileBloc(userAuth: sl(), photoUp: sl()));
  sl.registerFactory<MessageBloc>(() => MessageBloc(
      likePoster: sl(),
      upLoadMessage: sl(),
      streamer: sl(),
      deleteMessages: sl(),
      userLikesMessage: sl(),
      populars: sl()));
}
