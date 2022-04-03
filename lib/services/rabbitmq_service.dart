import 'dart:convert';
import 'dart:developer';

import 'package:dart_amqp/dart_amqp.dart';
import 'package:veterinary_clinic_mobile/models/models.dart';
import 'package:veterinary_clinic_mobile/services/services.dart';

class RabbitMQService {
  late Client _client;

  Future init(
    String channelUrl,
    int port,
    String virtualHost,
    String login,
    String password,
    String queueName,
  ) async {
    try {
      ConnectionSettings settings = ConnectionSettings(
        host: channelUrl,
        port: port,
        virtualHost: virtualHost,
        authProvider: PlainAuthenticator(login, password),
      );

      _client = Client(settings: settings);

      Channel channel = await _client.channel();
      Queue queue = await channel.queue(
        queueName,
        durable: true,
      );
      Consumer consumer = await queue.consume(noAck: false);
      consumer.listen((event) async {
        var response = event.payloadAsJson;
        if (response['action'] == 'add') {
          var checkup = Checkup.fromJson(response['payload'][0]);
          await NotificationService.showNotification(
            title: 'Новый прием',
            body:
                "Прием клиента ${checkup.clientName} с питомцем ${checkup.petName}",
          );
        }
        if (response['action'] == 'end') {
          var date = DateTime.parse(response['date']);
          await NotificationService.showNotification(
            title: 'Прием завершен',
            body:
                "Прием на время: ${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year.toString().padLeft(2, '0')} ${(date.hour + 3).toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} завершен!",
          );
        }
        if (response['action'] == 'cancel') {
          var date = DateTime.parse(response['date']);
          await NotificationService.showNotification(
            title: 'Прием отменен',
            body:
                "Прием на время: ${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year.toString().padLeft(2, '0')} ${(date.hour + 3).toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} отменен!",
          );
        }

        log(event.payloadAsString);
        event.ack();
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
