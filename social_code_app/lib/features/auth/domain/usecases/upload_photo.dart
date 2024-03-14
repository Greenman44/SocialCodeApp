import 'package:social_code_app/core/usecase/usecase.dart';
import 'package:social_code_app/features/auth/domain/repository/photo_loader_repository.dart';

class UpLoadPhoto extends Usecase<String?, String?> {
  final IPhotoUpLoaderRepository photoUploader;
  UpLoadPhoto({required this.photoUploader});
  @override
  Future<String?> call({String? params}) async {
    return await photoUploader.uploadPhoto(params!);
  }
}
