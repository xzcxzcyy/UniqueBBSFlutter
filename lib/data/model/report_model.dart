import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/data/bean/report/report.dart';
import 'package:UniqueBBSFlutter/data/dio.dart';
import 'package:UniqueBBSFlutter/data/repo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReportModel extends ChangeNotifier {
  Map<int, List> _yearList = Map<int, List>();
  int _pageNum = 1;
  bool _fetching = false;
  int _maxCount = null;
  int _fetchedCount = 0;

  keysCount() => _yearList.keys.length;

  keysFirst() => _yearList.keys.first;

  singleYearListLength(int year) => _yearList[year].length;

  getItemData(int year, int index) => _yearList[year][index];

  fetchData() {
    if (_fetching || (_maxCount != null && _fetchedCount >= _maxCount)) {
      return;
    }
    _fetching = true;
    Server.instance.reports(Repo.instance.uid, _pageNum).then((rsp) {
      if (!rsp.success) {
        Fluttertoast.showToast(msg: rsp.msg);
        Future.delayed(Duration(seconds: HyperParam.requestInterval))
            .then((_) => fetchData());
        return;
      }
      int tot = rsp.data.reports.length;
      _fetchedCount += rsp.data.reports.length;
      _maxCount = rsp.data.count;
      for (int i = 0; i < tot; i++) {
        var data = rsp.data.reports[i];
        int year = _generateYearNum(data);
        if (_yearList.keys.contains(year)) {
          _yearList[year].insert(_yearList[year].length, data);
        } else {
          _yearList[year] = List();
          _yearList[year].insert(_yearList[year].length, data);
        }
      }
      _onFetchFinished();
    });
  }

  _onFetchFinished() {
    _pageNum++;
    _fetching = false;
    notifyListeners();
  }

  _generateYearNum(Report data) => int.parse(data.createDate.substring(0, 4));
}