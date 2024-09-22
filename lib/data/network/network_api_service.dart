import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../app_exception.dart';
import 'base_api_service.dart';


class NetWorkApiService extends BaseApiService{


  // get_get_api_response
  @override
  Future getGetApiResponse(String url) async {

    dynamic responseJson;

    try{

      final response = await http.get(Uri.parse(url))
          .timeout(const Duration(seconds: 60));

      //function calling and get the result
      responseJson = returnResponse(response);

    }
    // socketException means data connection problem
    on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }


  // return_result_according_to_status_code
  dynamic returnResponse (http.Response response){
    log('response_status_in_network_service: ${response.statusCode}');
    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

        case 400:
          throw BadRequestException(response.body.toString());

        case 403:
          throw UnAuthorisedException(response.body.toString());

        case 404:
          throw UnAuthorisedException(response.body.toString());

        default:
          throw FetchDataException('Error occurred while communicating with server with status code ${response.statusCode.toString()}');
    }
  }
}