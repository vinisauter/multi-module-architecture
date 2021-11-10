// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:profile_business_module/main.dart';

void main() => runApp(const ProfileHomeApp(color: Colors.blue));

@pragma('vm:entry-point')
void topMain() => runApp(const ProfileHomeApp(color: Colors.green));

@pragma('vm:entry-point')
void bottomMain() => runApp(const ProfileHomeApp(color: Colors.purple));

