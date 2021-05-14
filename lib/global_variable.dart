import 'dart:async';

import 'package:commons/commons.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';

StreamSubscription<Position> homeTabPageStreamSubscription;

StreamSubscription<Position> liveLocationStreamSubscription;

StreamSubscription<Event> transactionBookingStreamSubscription;

StreamSubscription<Event> transactionCancelStreamSubscription;

StreamSubscription<Event> transactionMapStreamSubscription;

DateFormat serverFormater = DateFormat('yyyy-MM-dd');

DateFormat timeCheckFormater = DateFormat('yyyy-MM-dd HH:mm');
