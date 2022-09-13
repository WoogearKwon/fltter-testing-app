import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_app/fetch_album.dart';
import 'package:flutter_test_app/models/album.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_album_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// 아래 명령어로 mock 파일 생성
// flutter pub run build_runner build
@GenerateMocks([http.Client])
void main() {
  group('fetchAlbum', () {
    test('http 호출이 성공하면 Album을 반환한다', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async =>
          http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));

      expect(await fetchAlbum(client), isA<Album>());
      // expect((await fetchAlbum(client)).title, 'mock');
    });

    test('http 호출에서 에러가 발생하면 예외를 던진다', () async {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchAlbum(client), throwsException);
    });
  });
}
