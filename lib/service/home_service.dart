import 'package:dio/dio.dart';
import 'package:testimony/model/testimony_model.dart';

class HomeService {
  final dio = Dio();
  final baseURL = 'https://6319bfa08e51a64d2beb602d.mockapi.io/mock';

  Future<List<TestimonyModel>> getTestimonies({
    int? page,
    String? search,
  }) async {
    try {
      final response = await dio.get('$baseURL/v1/testimonials', queryParameters: {
        'page': page,
        'limit': 5,
        'search': search,
      });

      final testimonies = (response.data as List).map((e) {
        return TestimonyModel.fromJson(e);
      }).toList();

      return testimonies;
    } catch (_) {
      rethrow;
    }
  }
}
