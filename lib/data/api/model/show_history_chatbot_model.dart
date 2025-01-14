class HistoryChatBot {
  List<Data>? data;

  HistoryChatBot({this.data});

  HistoryChatBot.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? date;
  List<MessageData>? messageData;

  Data({this.date, this.messageData});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['message_data'] != null) {
      messageData = <MessageData>[];
      json['message_data'].forEach((v) {
        messageData!.add(new MessageData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.messageData != null) {
      data['message_data'] = this.messageData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MessageData {
  String? message;
  String? sender;
  String? createdAt;

  MessageData({this.message, this.sender, this.createdAt});

  MessageData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    sender = json['sender'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['sender'] = this.sender;
    data['created_at'] = this.createdAt;
    return data;
  }
}
