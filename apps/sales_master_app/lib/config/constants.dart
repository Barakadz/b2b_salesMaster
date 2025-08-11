import 'package:flutter/material.dart';

const double paddingXxs = 4;
const double paddingXs = 10;
const double paddingS = 12;
const double paddingM = 16;
const double textfieldsPadding = 12;
const double formSectionTopPadding = 18;
const double formSectionBottomPadding = 14;
const double paddingOtpGap = 15;
const double paddingBetweenOtp = 5;
const double paddingXm = 20;
const double paddingXmm = 30;
const double paddingL = 25;
const double paddingXl = 32;
const double paddingXxl = 42;
const double paddingXxxl = 51;
const double paddingXxxxl = 99;
const double paddingXxxxxl = 125;

const double borderRadius = 15;
const double borderRadiusSmall = 5;
const double borderRadiusMedium = 10;
const double primaryButtonHeight = 55;

const double startsIconSize = 18;

const String outlookNotificationAsset = "assets/outlook_notification.svg";
const String meetingNotificationAsset = "assets/group_notification.svg";
const String reminderNotificationAsset = "assets/alert_notification.svg";

const String homeAsset = "assets/home.svg";
const String selectedHomeAsset = "assets/home_selected.svg";
const String todolistAsset = "assets/todolist.svg";
const String selectedTodolistAsset = "assets/selected_todolist.svg";
const String catalogueAsset = "assets/catalogue.svg";
const String selectedCatalogueAsset = "assets/selected_catalogue.svg";
const String dashboardAsset = "assets/dashboard.svg";
const String clientsAsset = "assets/clients.svg";
const String selectedClientsAsset = "assets/clients_selected.svg";
const String pipelineAsset = "assets/pipeline.svg";
const String selectedPipelineAsset = "assets/selected_pipeline.svg";
const String logoutAsset = "assets/logout.svg";
const String processAsset = "assets/process_forms.svg";

Map<String, dynamic> notificationAssets = {
  "outlook": outlookNotificationAsset,
  "meeting": meetingNotificationAsset,
  "reminder": reminderNotificationAsset
};

Map<bool, dynamic> clientActiveColors = {
  true: {"textColor": Color(0xff53DAA0), "bgColor": Color(0x2652DF96)},
  false: {"textColor": Color(0XffEF2B48), "bgColor": Color(0X1AEF2B481A)}
};
