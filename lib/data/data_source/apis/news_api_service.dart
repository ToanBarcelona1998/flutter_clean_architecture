import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/core/core.dart';
import 'package:flutter_clean_architecture/data/data.dart';
import 'package:retrofit/retrofit.dart';
part 'news_api_service.g.dart';

@RestApi()
abstract class NewsApiService {
  factory NewsApiService(Dio dio, {String? baseUrl}) = _NewsApiService;

  @GET(BaseUrl.newsBreaking)
  Future<HttpResponse<BreakingNewsResponseModel>> getBreakingNewsArticles(
    @Query(ApiParam.apiKey) String apiKey,
    @Query(ApiParam.country) String country,
    @Query(ApiParam.category) String category,
    @Query(ApiParam.page) int page,
    @Query(ApiParam.pageSize) int pageSize,
  );
}
