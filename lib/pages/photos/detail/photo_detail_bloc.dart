import 'package:rxdart/rxdart.dart';
import 'package:unsplash_app/data/api_data.dart';
import 'package:unsplash_app/models/photos_model.dart';


class PhotoDetailBloc {
  final ApiData _apiData;
  final String _photoId;

  PhotoDetailBloc({
    ApiData apiData,
    String photoId,
  }) : _apiData = apiData ?? ApiData(),
        _photoId = photoId;


  final data = BehaviorSubject<Photos>();

  final isLoading = BehaviorSubject<bool>.seeded(false);

  getPhotoDetail() async {
    isLoading.add(true);
    try {
      Photos response = await _apiData.getPhotoDetail(_photoId);
      data.add(response);
    } catch (e) {
      data.addError(e);
    } finally {
      isLoading.add(false);
    }
  }

  void dispose() {
    data.close();
    isLoading.close();
  }
}
