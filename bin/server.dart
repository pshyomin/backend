import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:shelf_router/shelf_router.dart' as shelf_router;

int maxRetries = 3;
int retryDelaySeconds = 1;

Future<Response> getLive(Request request) async {
  int retries = 0;

  final _data = request.params['baseData'];
  final _hour = request.params['hour'];
  final _latx = request.params['latlongx'];
  final _laty = request.params['latlongy'];

  try {
    final response = await http.get(
      Uri.parse(
          'https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst?serviceKey=$_serviceKey&pageNo=1&numOfRows=1000&dataType=json&base_date=$_data&base_time=${_hour}00&nx=$_latx&ny=$_laty'),
    );
    if (response.statusCode == 200) {
      return Response.ok(response.body, headers: headers);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    if (retries < maxRetries) {
      print('Error occurred: $e\nRetrying after $retryDelaySeconds seconds.');
      retries++;
      await Future.delayed(Duration(seconds: retryDelaySeconds));
    } else {
      print('Max retries exceeded. Aborting request.');
      return Response.badRequest(body: 'Request failed.');
    }
  }
  return Response.badRequest(body: 'Request failed.');
}

Future<Response> getLiveDay(Request request) async {
  int retries = 0;

  final _data = request.params['baseData'];
  final _hour = request.params['hour'];
  final _minute = request.params['minute'];
  final _latx = request.params['latlongx'];
  final _laty = request.params['latlongy'];

  try {
    final response = await http.get(
      Uri.parse(
          'https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst?serviceKey=$_serviceKey&pageNo=1&numOfRows=1000&dataType=json&base_date=$_data&base_time=$_hour$_minute&nx=$_latx&ny=$_laty'),
    );
    if (response.statusCode == 200) {
      return Response.ok(response.body, headers: headers);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    if (retries < maxRetries) {
      print('Error occurred: $e\nRetrying after $retryDelaySeconds seconds.');
      retries++;
      await Future.delayed(Duration(seconds: retryDelaySeconds));
    } else {
      print('Max retries exceeded. Aborting request.');
      return Response.badRequest(body: 'Request failed.');
    }
  }
  return Response.badRequest(body: 'Request failed.');
}

Future<Response> getDaily(Request request) async {
  int retries = 0;

  final _data = request.params['baseData'];
  final _latx = request.params['latlongx'];
  final _laty = request.params['latlongy'];
  try {
    final response = await http.get(
      Uri.parse(
          'https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=$_serviceKey&pageNo=1&numOfRows=1000&dataType=json&base_date=$_data&base_time=0500&nx=$_latx&ny=$_laty'),
    );
    if (response.statusCode == 200) {
      return Response.ok(response.body, headers: headers);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    if (retries < maxRetries) {
      print('Error occurred: $e\nRetrying after $retryDelaySeconds seconds.');
      retries++;
      await Future.delayed(Duration(seconds: retryDelaySeconds));
    } else {
      print('Max retries exceeded. Aborting request.');
      return Response.badRequest(body: 'Request failed.');
    }
  }
  return Response.badRequest(body: 'Request failed.');
}

Future<Response> getSun(Request request) async {
  int retries = 0;

  final _data = request.params['baseData'];
  final _legalcode = request.params['legalcode'];

  try {
    final response = await http.get(
      Uri.parse(
          'https://apis.data.go.kr/B090041/openapi/service/RiseSetInfoService/getAreaRiseSetInfo?serviceKey=$_serviceKey&locdate=$_data&location=$_legalcode'),
    );
    if (response.statusCode == 200) {
      return Response.ok(response.body, headers: headers);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    if (retries < maxRetries) {
      print('Error occurred: $e\nRetrying after $retryDelaySeconds seconds.');
      retries++;
      await Future.delayed(Duration(seconds: retryDelaySeconds));
    } else {
      print('Max retries exceeded. Aborting request.');
      return Response.badRequest(body: 'Request failed.');
    }
  }
  return Response.badRequest(body: 'Request failed.');
}

Future<Response> getDust(Request request) async {
  int retries = 0;

  final _legalcode = request.params['legalcode'];
  try {
    final response = await http.get(
      Uri.parse(
          'https://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty?serviceKey=$_serviceKey&returnType=json&numOfRows=100&pageNo=1&sidoName=$_legalcode&ver=1.0'),
    );
    if (response.statusCode == 200) {
      return Response.ok(response.body, headers: headers);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    if (retries < maxRetries) {
      print('Error occurred: $e\nRetrying after $retryDelaySeconds seconds.');
      retries++;
      await Future.delayed(Duration(seconds: retryDelaySeconds));
    } else {
      print('Max retries exceeded. Aborting request.');
      return Response.badRequest(body: 'Request failed.');
    }
  }
  return Response.badRequest(body: 'Request failed.');
}

Future<Response> getGeocoding(Request request) async {
  int retries = 0;

  final _lat = request.params['lat'];
  final _long = request.params['long'];

  Map<String, String> headers = {
    'X-NCP-APIGW-API-KEY-ID': _naverKeyID, //Client ID
    'X-NCP-APIGW-API-KEY': _naverKey, //Client secret
  };
  try {
    final response = await http.get(
        Uri.parse(
            'https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?coords=$_long,$_lat&output=json'),
        headers: headers);

    if (response.statusCode == 200) {
      return Response.ok(response.body, headers: headers);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    if (retries < maxRetries) {
      print('Error occurred: $e\nRetrying after $retryDelaySeconds seconds.');
      retries++;
      await Future.delayed(Duration(seconds: retryDelaySeconds));
    } else {
      print('Max retries exceeded. Aborting request.');
      return Response.badRequest(body: 'Request failed.');
    }
  }
  return Response.badRequest(body: 'Request failed.');
}

Future<Response> getQnA(Request request) async {
  int retries = 0;

  final jsonData = await request.readAsString();
  final data = jsonDecode(jsonData);

  final question = data['question'];

  Map<String, String> headers = {
    'Authorization': 'Bearer $_gptServiceKey',
    'Content-Type': 'application/json; charset=UTF-8'
  };

  final body = jsonEncode({
    "model": "text-davinci-003",
    "prompt": question,
    "temperature": 0,
    "max_tokens": 250,
    "top_p": 1,
    "frequency_penalty": 0.0,
    "presence_penalty": 0.0,
    "stop": ["\n"],
  });

  try {
    final response = await http.post(
        Uri.parse('https://api.openai.com/v1/completions'),
        headers: headers,
        body: body,
        encoding: Encoding.getByName('UTF-8'));

    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      print(responseBody);
      return Response.ok(json.decode(responseBody)['choices'][0]['text'],
          headers: headers);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    if (retries < maxRetries) {
      print('Error occurred: $e\nRetrying after $retryDelaySeconds seconds.');
      retries++;
      await Future.delayed(Duration(seconds: retryDelaySeconds));
    } else {
      print('Max retries exceeded. Aborting request.');
      return Response.badRequest(body: 'Request failed.');
    }
  }
  return Response.badRequest(body: 'Request failed.');
}

/*Response robotsHandler(Request request) {
  var headers = {'Content-Type': 'text/plain'};
  var content = 'User-agent: *\nAllow: /\n';
  return Response.ok(content, headers: headers);
} */

final String _serviceKey = '';
final String _gptServiceKey = '';
final String _naverKeyID = '';
final String _naverKey = '';

final _router = shelf_router.Router()
  ..get('/api/live/<baseData>/<hour>/<latlongx>/<latlongy>', getLive)
  ..get('/api/liveday/<baseData>/<hour>/<minute>/<latlongx>/<latlongy>',
      getLiveDay)
  ..get('/api/daily/<baseData>/<latlongx>/<latlongy>', getDaily)
  ..get('/api/sun/<baseData>/<legalcode>', getSun)
  ..get('/api/dust/<legalcode>', getDust)
  ..get('/api/geo/<lat>/<long>', getGeocoding)
  ..post('/api/qna', getQnA);

final headers = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST',
  'Access-Control-Allow-Headers': '*'
};

void main() async {
  try {
    final bundle = File('ca_bundle.crt').path;
    final cert = File('certificate.crt').readAsBytesSync();
    final key = File('private.key').readAsBytesSync();

    final serverContext = SecurityContext()
      ..useCertificateChainBytes(cert)
      ..usePrivateKeyBytes(key, password: 'password');

    serverContext.setTrustedCertificates(bundle);

    var handler = Pipeline()
        .addMiddleware(corsHeaders())
        .addMiddleware(logRequests())
        .addHandler(_router);

    final server = await serve(handler, InternetAddress.anyIPv4, 80,
        securityContext: serverContext);

    // WebSocket 연결 처리
    var socketHandler = webSocketHandler((WebSocketChannel channel) {
      channel.stream.listen((message) {
        print('WebSocket message received: $message');
        channel.sink.add('message: $message');
      });
    });

    // WebSocket 서버 시작
    var socketServer =
        await serve(socketHandler, InternetAddress.anyIPv4, 8081);
    print('WebSocket 서버 포트 : ${socketServer.port}');

    // WebSocket 클라이언트 시작
    var channel = IOWebSocketChannel.connect('ws://localhost:8081');
    channel.stream.listen((message) {
      print('WebSocket message received: $message');
    });

    // 5초 후에 메시지 전송 테스트
    Timer(Duration(seconds: 5), () {
      channel.sink.add(json.encode({'message': 'Socket Test'}));
    });

    print(
        'Portfolio Server Info: https://${server.address.host}:${server.port}');
  } on SocketException catch (e) {
    print('SocketException occurred: $e');
  } catch (e) {
    print('Error occurred: $e');
  }
}
