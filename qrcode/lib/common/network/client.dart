import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:qrcode/common/const/string_const.dart';
import 'package:qrcode/common/exceptions/connect_exception.dart';
import 'package:qrcode/common/exceptions/server_exception.dart';
import 'package:qrcode/common/exceptions/timeout_exception.dart';
import 'package:qrcode/common/local/app_cache.dart';
import 'package:qrcode/common/local/local_app.dart';
import 'package:qrcode/common/network/app_header.dart';
import 'package:qrcode/common/network/configs.dart';
import 'package:qrcode/common/utils/log_util.dart';

class AppClient {
  AppHeader? header;
  final LocalApp localApp;
  final AppCache appCache;

  AppClient(this.localApp, this.appCache);

  void setHeader(AppHeader header) {
    this.header = header;
  }

  Future<Map> get(String endPoint) async {
    await _checkConnectionAndPosition();
    var url = Uri.parse('${Configurations.host}$endPoint');
    Response? response = await http
        .get(url, headers: header?.toJson() ?? {})
        .timeout(Duration(seconds: Configurations.connectTimeout),
            onTimeout: () {
      throw TimeOutException();
    });
    Map<String, dynamic> data = json.decode(response.body);

    String fullRequets = 'endPoint: ${Configurations.host}$endPoint\n'
        'Token: ${header?.accessToken}\n'
        'Response: ${data}';
    LOG.w('REQUEST_GET: $fullRequets');
    return _handleData(data);
  }

  Future<Map> posts(
    String endPoint, {
    dynamic body,
    String? contentType,
    bool handleResponse = true,
    bool encodeBody = true,
  }) async {
    await _checkConnectionAndPosition();
    var url = Uri.parse('${Configurations.host}$endPoint');
    Response? response = await http
        .post(url,
            body: body != null ? (encodeBody ? json.encode(body) : body) : null,
            headers: header?.toJson() ?? {'Content-Type': 'application/json'})
        .timeout(Duration(seconds: Configurations.connectTimeout),
            onTimeout: () {
      throw TimeOutException();
    });

    Map<String, dynamic> data = json.decode(response.body);

    String fullRequets = 'endPoint: ${Configurations.host}$endPoint\n'
        // 'Token: ${header?.accessToken}\n'
        'body: $body\n'
        'Response: ${response.body}';
    LOG.w('REQUEST_POST: $fullRequets');
    if (!handleResponse) {
      return data;
    }
    return _handleData(data);
  }

  Future<Map> post(
    String endPoint, {
    dynamic body,
    String? contentType,
    bool handleResponse = true,
    bool encodeBody = true,
  }) async {
    await _checkConnectionAndPosition();
    var url = Uri.parse('${Configurations.host}$endPoint');
    Response? response = await http
        .post(url,
            body: body != null ? (encodeBody ? json.encode(body) : body) : null,
            headers: header?.toJson(contentType: contentType) ??
                {'Content-Type': 'application/json'})
        .timeout(Duration(seconds: Configurations.connectTimeout),
            onTimeout: () {
      throw TimeOutException();
    });

    Map<String, dynamic> data = json.decode(response.body);

    String fullRequets = 'endPoint: ${Configurations.host}$endPoint\n'
        'Token: ${header?.accessToken}\n'
        'body: $body\n'
        'Response: ${response.body}';
    LOG.w('REQUEST_POST: $fullRequets');
    if (!handleResponse) {
      return data;
    }
    return _handleData(data);
  }

  Map<String, dynamic> _handleData(Map<String, dynamic> input) {
    if (!input['success']) {
      throw ServerException(message: input['message']);
    }
    return input;
  }

  Future<dynamic> getResponseFromApiNonToken({required String api}) async {
    await _checkConnectionAndPosition();
    try {
      var url = Uri.parse(api);
      final Response response = await http.get(url);
      return json.decode(response.body);
    } catch (e) {
      throw ServerException();
    }
  }

  Future _checkConnectionAndPosition() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {}
    } catch (_) {
      throw ConnectException(message: StringConst.connectError);
    }
  }
}
