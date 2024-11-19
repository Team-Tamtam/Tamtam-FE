import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SmsQuery _query = SmsQuery();
  List<SmsMessage> _messages = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SMS Inbox App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('오늘의 결제 내역 sms'),
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: _messages.isNotEmpty
              ? _MessagesListView(
            messages: _messages,
          )
              : Center(
            child: Text(
              'No messages to show.\n Tap refresh button...',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var permission = await Permission.sms.status;
            if (permission.isGranted) {
              final messages = await _query.querySms(
                kinds: [
                  SmsQueryKind.inbox,
                  SmsQueryKind.sent,
                ],
                // address: '+254712345789',
                count: 20,
              );
              debugPrint('sms inbox messages: ${messages.length}');
              // 오늘 날짜의 메시지 필터링
              final today = DateTime.now();
              final todayMessages = messages.where((message) {
                final messageDate = message.date;
                return messageDate != null &&
                    messageDate.year == today.year &&
                    messageDate.month == today.month &&
                    messageDate.day == today.day;
              }).toList();

              debugPrint('오늘의 문자 메시지: ${todayMessages.length}개');
              // 카드사 문자 필터링 (문자 내용 기준)
              final cardMessages = todayMessages.where((message) {
                final body = message.body?.toLowerCase() ?? '';

                // 카드사 문자로 추정되는 키워드
                final cardKeywords = ['신용', '승인', '체크', '사용', '카드'];

                // 문자 내용에 [Web발신] 포함 여부와 키워드 포함 여부 확인
                final containsWeb = body.contains('[web발신]');
                final containsKeyword =
                cardKeywords.any((keyword) => body.contains(keyword));

                return containsWeb && containsKeyword;
              }).toList();

              debugPrint('오늘의 카드사 문자: ${cardMessages.length}개');
              setState(() => _messages = cardMessages);
            } else {
              await Permission.sms.request();
            }
          },
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}

class _MessagesListView extends StatelessWidget {
  const _MessagesListView({
    Key? key,
    required this.messages,
  }) : super(key: key);

  final List<SmsMessage> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: messages.length,
      itemBuilder: (BuildContext context, int i) {
        var message = messages[i];

        return ListTile(
          title: Text('${message.sender} [${message.date}]'),
          subtitle: Text('${message.body}'),
        );
      },
    );
  }
}