// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:home_business_module/main.dart';
import 'package:profile_business_module/main.dart';

void main() => runApp(const HomeApp(color: Colors.brown));

@pragma('vm:entry-point')
void homeSingleRoute() => runApp(const HomeApp(color: Colors.brown));

@pragma('vm:entry-point')
void homeTopRoute() => runApp(const HomeApp(color: Colors.green));

@pragma('vm:entry-point')
void homeBottomRoute() => runApp(const HomeApp(color: Colors.purple));

@pragma('vm:entry-point')
void profileSingleRoute() => runApp(const ProfileApp(color: Colors.orange));

@pragma('vm:entry-point')
void profileTopRoute() => runApp(const ProfileApp(color: Colors.green));

@pragma('vm:entry-point')
void profileBottomRoute() => runApp(const ProfileApp(color: Colors.purple));

