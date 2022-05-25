import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import '../models/conversations_model.dart';
import '../models/message_model.dart';
import '../services/conversations_service.dart';
import '../services/user_service.dart';

class ConversationProvider extends ChangeNotifier {
  Auth _authProvider = new Auth();
  ConversationService _conversationService = ConversationService();

  List<ConversationModel> _conversations = [];

  bool _busy = false;

  List<ConversationModel> get conversations => _conversations;

  bool get busy => _busy;

  setBusy(bool val) {
    _busy = val;
    notifyListeners();
  }

  Future getConversation(String? token) async {
    Map<String, dynamic> mapData = {};
    List ListData = [];
    setBusy(true);
    http.Response response = await _conversationService.getConversations(token);
    try {
      if (response.statusCode == 200) {
        try {
          mapData = jsonDecode(response.body);
          ListData = mapData['data'];
          if (_conversations.isNotEmpty) {
            if (ListData.length == _conversations.length) {
              _conversations = [];
              for (var element in ListData) {
                _conversations.add(ConversationModel.fromJson(element));
              }
            } else {
              _conversations = [];
              for (var element in ListData) {
                _conversations.add(ConversationModel.fromJson(element));
              }
            }
          } else {
            for (var element in ListData) {
              _conversations.add(ConversationModel.fromJson(element));
            }
          }
          notifyListeners();
          setBusy(false);
        } catch (_) {}
      }
      setBusy(false);
      return _conversations;
    } catch (_) {}
  }

  Future<void> makeConversationAsReaded(
      int? idConversation, String? token) async {
    http.Response response =
        await _conversationService.makeConversationRead(idConversation, token);
    if (response.statusCode == 200) {
      try {
        var data = jsonDecode(response.body);
      } catch (_) {}
    }
  }

  Future addConversation(token) async {
    try {
      http.Response response =
          await _conversationService.addConversation(token);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data['data'];
      }
      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
        return data['data'];
      }
    } catch (_) {}
  }

  Future<void> sendMessages(MessageModel message, String? token) async {
    setBusy(true);
    http.Response response =
        await _conversationService.sendMessage(message, token);
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      addMessageToConversation(int.parse(message.conversationId.toString()),
          MessageModel.fromJson(data['data']));
      setBusy(false);
    }
    setBusy(false);
  }

  addMessageToConversation(int conversationId, MessageModel message) {
    var conversation =
        _conversations.firstWhere((element) => element.id == conversationId);
    conversation.messages.insert(0, message);
    notifyListeners();
  }
}
