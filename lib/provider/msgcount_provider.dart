import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MsgCountProvider with ChangeNotifier {
  int msgCount = 0;

  Future<int> getMsgCount() async {
    msgCount = await getPrefs();
    return msgCount;
  }

  void setMsgCount(int val) {
    msgCount = val;
    setPrefs(msgCount);
  }

  void addMsgCount() async {
    msgCount = await getMsgCount();
    msgCount++;
    setPrefs(msgCount);
    notifyListeners();
  }

  void setPrefs(int cnt) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("msgCount", cnt.toString());
  }

  Future<int> getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    String value = prefs.getString("msgCount")!;
    return int.parse(value);
  }
}
