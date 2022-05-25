
import '/services/url_db.dart';
import 'package:http/http.dart' as http;

import '../models/message_model.dart';

class ConversationService {

  Future <http.Response> getConversations(String? token) async{

      http.Response response = await http.post(
        Uri.parse(getConversationsURL),
        body: {
          'auth_user' : 'client_dechet',
          'auth_second_user' : 'responsable_commercial',
        },
        headers: {
          'Authorization' : 'Bearer $token',
          'Accept' : 'application/json'
      });
      return response;


  }
  Future <http.Response> addConversation(token)async{

      http.Response response =await http.post(
        Uri.parse(addConversationURL),
          headers: {
            'Authorization' : 'Bearer ${token.toString()}',
            'Accept' : 'application/json'
            },
            body: {
              'user_id' : 1.toString(),
              'auth_user' : 'client_dechet',
              'auth_second_user' : 'responsable_commercial',
            }
        );

      return response;

  }

  Future <http.Response> sendMessage(MessageModel message , String? token)async{

      http.Response response = await http.post(
        Uri.parse(sendMessageURL),
        headers: {
          'Authorization' : 'Bearer $token',
          'Accept' : 'application/json'
        },
        body: {
          'body' : message.body ,
          'conversation_id' : message.conversationId.toString(),

        }
        );
      return response;

  }

  Future <http.Response> makeConversationRead(int? idConversation,String? token)async{


      http.Response response = await http.post(
        Uri.parse(makeConversationReadURL),
        headers: {
          'Authorization' : 'Bearer $token',
          'Accept' : 'application/json'
        },
        body: {
          'conversation_id' : idConversation.toString()
        }
      );

      return response;


  }

}