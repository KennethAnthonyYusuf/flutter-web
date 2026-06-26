import 'dart:convert';
import 'dart:async';
import 'dart:typed_data';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../models/models.dart';

class RestApiRepositoryBase {
  // late final PreferenceService _preferenceService =
  //     GetIt.instance<PreferenceService>();
  late final AppSettings _appSettings = GetIt.instance.get<AppSettings>();
  // late final AuthorizationService _authService =
  //     GetIt.instance.get<AuthorizationService>();
  late final String _baseEndpoint;

  RestApiRepositoryBase({String? base}) {
    _baseEndpoint = base ?? _appSettings.apiBaseEndpoint;
  }

  Future<List<dynamic>> getAll(String endPoint) async {
    Uri url = Uri.parse(_baseEndpoint + endPoint);

    final response = await http.get(url, headers: await getRequestHeaders());

    dynamic convertedResponse = _convertResponse(response);
    List<dynamic> result;

    if (convertedResponse is List<dynamic>) {
      result = convertedResponse;
    } else {
      throw const FormatException("API response was not of type List<dynamic>");
    }

    return result;
  }

  Future<Map<String, dynamic>> get(String endPoint) async {
    Uri url = Uri.parse(_baseEndpoint + endPoint);

    final response = await http.get(url, headers: await getRequestHeaders());

    dynamic convertedResponse = _convertResponse(response);

    Map<String, dynamic> result;

    if (convertedResponse is Map<String, dynamic>) {
      result = convertedResponse;
    } else {
      throw const FormatException(
          "API response was not of type Map<String, dynamic>");
    }

    return result;
  }

  Future<Uint8List> getMultipartFile(String endPoint) async {
    Uri url = Uri.parse(_baseEndpoint + endPoint);

    final response = await http.get(url, headers: await getRequestHeaders());

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw const FormatException(
          'Error occurred while Communication with Server');
    }
  }

  Future<Map<String, dynamic>> postMultipartFile(
      String endPoint, http.MultipartFile multipartFile) async {
    Uri url = Uri.parse(_baseEndpoint + endPoint);

    http.MultipartRequest request = http.MultipartRequest('POST', url);

    request.files.add(multipartFile);
    await _addHeadersToMultipartRequest(request);

    http.StreamedResponse streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse);

    dynamic convertedResponse = _convertResponse(response);

    Map<String, dynamic> result;

    if (convertedResponse is Map<String, dynamic>) {
      result = convertedResponse;
    } else {
      throw const FormatException("API response was not of type Map");
    }

    return result;
  }

  Future<List<Map<String, dynamic>>> postMultipartFiles(
      String endPoint, http.MultipartFile multipartFile) async {
    Uri url = Uri.parse(_baseEndpoint + endPoint);

    http.MultipartRequest request = http.MultipartRequest('POST', url);

    request.files.add(multipartFile);
    await _addHeadersToMultipartRequest(request);

    http.StreamedResponse streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse);

    dynamic convertedResponse = _convertResponse(response);

    List<Map<String, dynamic>> result;

    if (convertedResponse is List<dynamic>) {
      result = convertedResponse.cast<Map<String, dynamic>>();
    } else {
      throw const FormatException("API response was not of type List<dynamic>");
    }

    return result;
  }

  Future<List<dynamic>> getAllPost(String endPoint, dynamic body) async {
    Uri url = Uri.parse(_baseEndpoint + endPoint);

    final response =
        await http.post(url, headers: await getRequestHeaders(), body: body);

    dynamic convertedResponse = _convertResponse(response);

    List<dynamic> result;

    if (convertedResponse is List<dynamic>) {
      result = convertedResponse;
    } else {
      throw const FormatException("API response was not of type List<dynamic>");
    }

    return result;
  }

  Future<Map<String, dynamic>> post(String endPoint, dynamic body,
      {Map<String, String>? additionalHeaders}) async {
    Uri url = Uri.parse(_baseEndpoint + endPoint);

    var headers = await getRequestHeaders();

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    final response = await http.post(url, headers: headers, body: body);

    dynamic convertedResponse = _convertResponse(response);

    Map<String, dynamic> result;

    if (convertedResponse is Map<String, dynamic>) {
      result = convertedResponse;
    } else {
      throw const FormatException("API response was not of type Map");
    }

    return result;
  }

  Future<Map<String, dynamic>> put(String endPoint, dynamic body) async {
    Uri url = Uri.parse(_baseEndpoint + endPoint);

    final response =
        await http.put(url, headers: await getRequestHeaders(), body: body);

    dynamic convertedResponse = _convertResponse(response);

    Map<String, dynamic> result;

    if (convertedResponse is Map<String, dynamic>) {
      result = convertedResponse;
    } else {
      throw const FormatException("API response was not of type Map");
    }

    return result;
  }

  Future<Map<String, dynamic>> delete(String endPoint, dynamic body) async {
    Uri url = Uri.parse(_baseEndpoint + endPoint);

    final response =
        await http.delete(url, headers: await getRequestHeaders(), body: body);

    dynamic convertedResponse = _convertResponse(response);

    Map<String, dynamic> result;

    if (convertedResponse is Map<String, dynamic>) {
      result = convertedResponse;
    } else {
      throw const FormatException("API response was not of type Map");
    }

    return result;
  }

  Future postContent(String endPoint, dynamic body) async {
    Uri url = Uri.parse(_baseEndpoint + endPoint);

    final response =
        await http.post(url, headers: await getRequestHeaders(), body: body);
    if (response.statusCode != 200) {
      throw Exception(
          'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Future patchContent(String endPoint, dynamic body) async {
    Uri url = Uri.parse(_baseEndpoint + endPoint);

    final response =
        await http.patch(url, headers: await getRequestHeaders(), body: body);
    if (response.statusCode != 200) {
      throw Exception(
          'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Future deleteContent(String endPoint) async {
    Uri url = Uri.parse(_baseEndpoint + endPoint);

    final response = await http.delete(url, headers: await getRequestHeaders());
    if (response.statusCode != 200) {
      throw Exception(
          'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Future _addHeadersToMultipartRequest(
      http.MultipartRequest multipartRequest) async {
    multipartRequest.headers["Authorization"] = 'Bearer ${await getToken()}';
    multipartRequest.headers["Accept-version"] = '1.0.0';
    // multipartRequest.headers["FMI-Language-ID"] =
    //     _localizationService.localeHeader;
  }

  Future<Map<String, String>> getRequestHeaders() async {
    return {
      'Authorization': 'Bearer ${await getToken()}',
      'Accept-version': '1.0.0',
      //'FMI-Language-ID': _localizationService.localeHeader,
      'content-type': 'application/json'
    };
  }

  Future<String?> getToken() async {
    // var token = await _preferenceService.getAccessToken();
    // if (token == null || JwtDecoder.isExpired(token)) {
    //   debugPrint("Expired Token. Attempting refresh");
    //   await _authService.initialize();
    //   token = await _authService.acquireTokenSilent(_appSettings.authScopes);
    // }

    // return token;
    return "";
  }

  dynamic _convertResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        String responseBody = utf8.decode(response.bodyBytes);
        dynamic responseJson = jsonDecode(responseBody);
        return responseJson;
      case 400:
        // _telemetry.trackError(
        //     isFatal: false,
        //     error: "400 ERROR: ${response.body.toString()}",
        //     userId: _profileService.profile?.email ?? "",
        //     siteCode: "");
        throw Exception(response.body.toString());
      case 401:
        // _telemetry.trackError(
        //     isFatal: false,
        //     error: "401 ERROR: ${response.body.toString()}",
        //     userId: _profileService.profile?.email ?? "",
        //     siteCode: "");
        throw Exception(response.body.toString());
      case 403:
        // _telemetry.trackError(
        //     isFatal: false,
        //     error: "401 ERROR: ${response.request?.headers["Authorization"]}}",
        //     userId: _profileService.profile?.email ?? "",
        //     siteCode: "");
        throw Exception(response.body.toString());
      case 404:
        // _telemetry.trackError(
        //     isFatal: false,
        //     error: "404 ERROR: ${response.body.toString()}",
        //     userId: _profileService.profile?.email ?? "",
        //     siteCode: "");
        throw Exception(response.body.toString());
      case 500:
      default:
        // _telemetry.trackError(
        //     isFatal: false,
        //     error: "500 ERROR: ${response.body.toString()}",
        //     userId: _profileService.profile?.email ?? "",
        //     siteCode: "");
        throw Exception(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Map<String, String> getCorrelationIdHeader(String correlationId) {
    return {"FMI-Correlation-ID": correlationId};
  }
}
