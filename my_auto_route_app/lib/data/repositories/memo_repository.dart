import 'package:my_auto_route_app/data/models/memo.dart';

class MemoRepository {
  var _memos = <Memo>[];

  Future<List<Memo>> getMemos() async {
    await Future.delayed(const .new(milliseconds: 500));
    return .from(_memos);
  }

  Future<void> addMemo(String title, String content) async {
    await Future.delayed(const .new(milliseconds: 500));
    _memos.add(
      .new(id: DateTime.now().toString(), title: title, content: content),
    );
  }
}
