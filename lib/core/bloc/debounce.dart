import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

EventTransformer<E> debounce<E>(Duration duration) {
  return (events, mapper) {
    return restartable<E>().call(
      events.transform(
        StreamTransformer<E, E>.fromBind((stream) {
          StreamSubscription<E>? subscription;
          Timer? timer;

          E? latestEvent;
          var hasPendingEvent = false;

          late StreamController<E> controller;

          void emitPending() {
            if (!hasPendingEvent || controller.isClosed) return;

            controller.add(latestEvent as E);
            latestEvent = null;
            hasPendingEvent = false;
          }

          controller = StreamController<E>(
            onListen: () {
              subscription = stream.listen(
                (event) {
                  latestEvent = event;
                  hasPendingEvent = true;

                  timer?.cancel();
                  timer = Timer(duration, emitPending);
                },
                onError: controller.addError,
                onDone: () {
                  timer?.cancel();
                  emitPending();
                  controller.close();
                },
              );
            },
            onPause: () {
              subscription?.pause();
            },
            onResume: () {
              subscription?.resume();
            },
            onCancel: () async {
              timer?.cancel();
              await subscription?.cancel();
            },
          );

          return controller.stream;
        }),
      ),
      mapper,
    );
  };
}
