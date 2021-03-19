import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';

StreamSubscription<Position> homeTabPageStreamSubscription;

StreamSubscription<Position> liveLocationStreamSubscription;

StreamSubscription<Event> transactionBookingStreamSubscription;

StreamSubscription<Event> transactionCancelStreamSubscription;
