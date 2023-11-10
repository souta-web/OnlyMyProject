import 'package:flutter/material.dart';
import '/utils/database_helper.dart';

class MaintagGraphData {
  final String? actionName;
  final String? actionTotalMinutes;
  final String? actionTotalTime;
  final String? thisActionTag;

  MaintagGraphData({
    this.actionName,
    this.actionTotalMinutes,
    this.actionTotalTime,
    this.thisActionTag,
  });
}