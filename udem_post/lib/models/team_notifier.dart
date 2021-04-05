

import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:udem_post/models/team.dart';

class TeamNotifier with ChangeNotifier {
  List<Team> _teamList = [];
  Team _currentTeam;

  UnmodifiableListView<Team> get teamList => UnmodifiableListView(_teamList);

  Team get currentTeam => currentTeam;

  set teamList(List<Team> teamList) {
    _teamList = teamList;
    notifyListeners();
  }

  set currentTeam(Team team) {
    _currentTeam = team;
    notifyListeners();
  }
}