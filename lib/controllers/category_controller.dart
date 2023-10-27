import 'package:get/get.dart';
import 'package:music_streaming_mobile/helper/common_import.dart';

class CategoryController extends GetxController{
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  bool isLoading = false;

  loadCategories({String? searchText, DataType? dataType}){
    isLoading = true;
    getIt<FirebaseManager>()
        .searchCategories(searchText: searchText)
        .then((result) {
        categories = RxList(result);
        isLoading = false;
        update();
    });
  }
}