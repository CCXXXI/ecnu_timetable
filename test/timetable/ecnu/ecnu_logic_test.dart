import 'package:dio/dio.dart';
import 'package:ecnu_timetable/timetable/ecnu/ecnu_logic.dart';
import 'package:ecnu_timetable/utils/database.dart';
import 'package:ecnu_timetable/utils/web.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart' hide Response;
import 'package:hive_flutter/adapters.dart';

class FakeDio extends Fake implements Dio {
  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    await Future.delayed(const Duration(days: 1));

    throw DioError(
      requestOptions: RequestOptions(path: path),
    );
  }
}

void main() {
  setUpAll(() async {
    await initDatabase(clear: true);
  });

  tearDownAll(() async {
    await Hive.close();
  });

  test('idValidator', () {
    expect(EcnuLogic.idValidator(null), isNotEmpty);
    expect(EcnuLogic.idValidator(''), isNotEmpty);
    expect(EcnuLogic.idValidator('123456'), isNotEmpty);
    expect(EcnuLogic.idValidator('123456' * 10), isNotEmpty);
    expect(EcnuLogic.idValidator('10101001000'), isNull);
  });

  test('passwordValidator', () {
    expect(EcnuLogic.passwordValidator(null), isNotEmpty);
    expect(EcnuLogic.passwordValidator(''), isNotEmpty);
    expect(EcnuLogic.passwordValidator('123456'), isNull);
    expect(EcnuLogic.passwordValidator('123456' * 10), isNull);
    expect(EcnuLogic.passwordValidator('10101001000'), isNull);
  });

  test('captchaValidator', () {
    expect(EcnuLogic.captchaValidator(null), isNotEmpty);
    expect(EcnuLogic.captchaValidator(''), isNotEmpty);
    expect(EcnuLogic.captchaValidator('1234'), isNull);
    expect(EcnuLogic.captchaValidator('123456'), isNotEmpty);
    expect(EcnuLogic.captchaValidator('10101001000'), isNotEmpty);
  });

  test('guess year & semester', () {
    expect(EcnuLogic.guessYear(DateTime(2021, 10)), 2021);
    expect(EcnuLogic.guessSemester(DateTime(2021, 10)), 0);

    expect(EcnuLogic.guessYear(DateTime(2022, 4)), 2021);
    expect(EcnuLogic.guessSemester(DateTime(2022, 4)), 1);

    expect(EcnuLogic.guessYear(DateTime(2022, 7)), 2021);
    expect(EcnuLogic.guessSemester(DateTime(2022, 7)), 2);
  });

  test('semester.id', () {
    expect(EcnuLogic.semesterId(2018, 0), 705);
    expect(EcnuLogic.semesterId(2018, 1), 705 + 32);
    expect(EcnuLogic.semesterId(2017, 2), 705 - 32);
  });

  test('getIds', () {
    expect(
      EcnuLogic.getIds('''
     	function searchTable(){
   		if(jQuery("#courseTableType").val()=="std"){
   			bg.form.addInput(form,"ids","123456");
   		}else{
   			bg.form.addInput(form,"ids","7890");
   		}
       	bg.form.submit(form,"courseTableForStd!courseTable.action","contentDiv");
   	}'''),
      '123456',
    );
  });

  test('getCourses', () {
    final r = EcnuLogic.getCourses(coursesJs);
    courses.addAll(r);
    expect(courses, isNotEmpty);
    expect(
      Course.fromJson(courses.getAt(0)!.toJson()).toJson(),
      r.first.toJson(),
    );
    expect(courses.toMap().toString(), coursesResult);
  });

  test('years', () {
    dio = FakeDio();

    final logic = Get.put(EcnuLogic());

    logic.year.value = 2021;
    expect(logic.years, {
      2019: '2019 - 2020',
      2020: '2020 - 2021',
      2021: '2021 - 2022',
      2022: '2022 - 2023',
      2023: '2023 - 2024',
    });

    Get.delete<EcnuLogic>();
  });
}

const coursesJs = '''
	// function CourseTable in TaskActivity.js
	var table0 = new CourseTable(2021,98);
	var unitCount = 14;
	var index=0;
	var activity=null;
			activity = new TaskActivity("76694","??????","340936(SOFT0031132992.01)","??????????????????????????????????????????(SOFT0031132992.01)","2375","?????????226","01111111111111111100000000000000000000000000000000000",null,"","","","");
			index =3*unitCount+2;
			table0.activities[index][table0.activities[index].length]=activity;
			index =3*unitCount+3;
			table0.activities[index][table0.activities[index].length]=activity;
			activity = new TaskActivity("76646","?????????","302608(SOFT0031131018.01)","?????????????????????????????????(SOFT0031131018.01)","5036","????????????B517","00101010101010101000000000000000000000000000000000000",null,"","","","");
			index =1*unitCount+5;
			table0.activities[index][table0.activities[index].length]=activity;
			index =1*unitCount+6;
			table0.activities[index][table0.activities[index].length]=activity;
			activity = new TaskActivity("76646","?????????","292975(SOFT0031131073.01)","???????????????????????????(SOFT0031131073.01)","2375","?????????226","01111111111111111100000000000000000000000000000000000",null,"","","","");
			index =1*unitCount+0;
			table0.activities[index][table0.activities[index].length]=activity;
			index =1*unitCount+1;
			table0.activities[index][table0.activities[index].length]=activity;
			activity = new TaskActivity("76848","?????????","340398(MATH0031112991.02)","??????????????????????(MATH0031112991.02)","2370","?????????218","01111111111111111100000000000000000000000000000000000",null,"","","","");
			index =0*unitCount+10;
			table0.activities[index][table0.activities[index].length]=activity;
			index =0*unitCount+11;
			table0.activities[index][table0.activities[index].length]=activity;
			index =0*unitCount+12;
			table0.activities[index][table0.activities[index].length]=activity;
			activity = new TaskActivity("76447","??????","343774(COEN0031162002.04)","??????????????????(COEN0031162002.04)","2377","?????????302","01111111111111111000000000000000000000000000000000000",null,"","","","");
			index =4*unitCount+2;
			table0.activities[index][table0.activities[index].length]=activity;
			index =4*unitCount+3;
			table0.activities[index][table0.activities[index].length]=activity;
			activity = new TaskActivity("76743","?????????","295546(SOFT0031132019.01)","????????????(SOFT0031132019.01)","2370","?????????218","01111111111111111100000000000000000000000000000000000",null,"","","","");
			index =0*unitCount+7;
			table0.activities[index][table0.activities[index].length]=activity;
			index =0*unitCount+8;
			table0.activities[index][table0.activities[index].length]=activity;
			activity = new TaskActivity("76663","?????????","331020(SOFT0031132228.01)","?????????????????????(SOFT0031132228.01)","2609","????????????B226","01111110111111111100000000000000000000000000000000000",null,"","","","");
			index =1*unitCount+2;
			table0.activities[index][table0.activities[index].length]=activity;
			index =1*unitCount+3;
			table0.activities[index][table0.activities[index].length]=activity;
			activity = new TaskActivity("24935984","??????","334873(SOFT0031132231.01)","?????????????????????(SOFT0031132231.01)","2370","?????????218","01111111111111111100000000000000000000000000000000000",null,"","","","");
			index =3*unitCount+5;
			table0.activities[index][table0.activities[index].length]=activity;
			index =3*unitCount+6;
			table0.activities[index][table0.activities[index].length]=activity;
			activity = new TaskActivity("76663","?????????","331020(SOFT0031132228.01)","?????????????????????(SOFT0031132228.01)","","","00000000100000000000000000000000000000000000000000000",null,"","","","?????????B226");
			index =0*unitCount+0;
			table0.activities[index][table0.activities[index].length]=activity;
			index =0*unitCount+1;
			table0.activities[index][table0.activities[index].length]=activity;
	table0.marshalTable(2,1,18);
	fillTable(table0,7,14,0);
''';
const coursesResult =
    '{0: {teacherId: 76694, teacherName: ??????, courseId: 340936, courseCode: SOFT0031132992, courseNo: 01, courseName: ??????????????????????????????????????????, roomId: 2375, roomName: ?????????226, weeks: [false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false], taskId: null, expLessonGroupId: , expLessonGroupIndexNo: , remark: , specialRoom: , periods: [{weekday: 3, unit: 2}, {weekday: 3, unit: 3}]}, 1: {teacherId: 76646, teacherName: ?????????, courseId: 302608, courseCode: SOFT0031131018, courseNo: 01, courseName: ?????????????????????????????????, roomId: 5036, roomName: ????????????B517, weeks: [false, false, true, false, true, false, true, false, true, false, true, false, true, false, true, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false], taskId: null, expLessonGroupId: , expLessonGroupIndexNo: , remark: , specialRoom: , periods: [{weekday: 1, unit: 5}, {weekday: 1, unit: 6}]}, 2: {teacherId: 76646, teacherName: ?????????, courseId: 292975, courseCode: SOFT0031131073, courseNo: 01, courseName: ???????????????????????????, roomId: 2375, roomName: ?????????226, weeks: [false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false], taskId: null, expLessonGroupId: , expLessonGroupIndexNo: , remark: , specialRoom: , periods: [{weekday: 1, unit: 0}, {weekday: 1, unit: 1}]}, 3: {teacherId: 76848, teacherName: ?????????, courseId: 340398, courseCode: MATH0031112991, courseNo: 02, courseName: ??????????????????????, roomId: 2370, roomName: ?????????218, weeks: [false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false], taskId: null, expLessonGroupId: , expLessonGroupIndexNo: , remark: , specialRoom: , periods: [{weekday: 0, unit: 10}, {weekday: 0, unit: 11}, {weekday: 0, unit: 12}]}, 4: {teacherId: 76447, teacherName: ??????, courseId: 343774, courseCode: COEN0031162002, courseNo: 04, courseName: ??????????????????, roomId: 2377, roomName: ?????????302, weeks: [false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false], taskId: null, expLessonGroupId: , expLessonGroupIndexNo: , remark: , specialRoom: , periods: [{weekday: 4, unit: 2}, {weekday: 4, unit: 3}]}, 5: {teacherId: 76743, teacherName: ?????????, courseId: 295546, courseCode: SOFT0031132019, courseNo: 01, courseName: ????????????, roomId: 2370, roomName: ?????????218, weeks: [false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false], taskId: null, expLessonGroupId: , expLessonGroupIndexNo: , remark: , specialRoom: , periods: [{weekday: 0, unit: 7}, {weekday: 0, unit: 8}]}, 6: {teacherId: 76663, teacherName: ?????????, courseId: 331020, courseCode: SOFT0031132228, courseNo: 01, courseName: ?????????????????????, roomId: 2609, roomName: ????????????B226, weeks: [false, true, true, true, true, true, true, false, true, true, true, true, true, true, true, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false], taskId: null, expLessonGroupId: , expLessonGroupIndexNo: , remark: , specialRoom: , periods: [{weekday: 1, unit: 2}, {weekday: 1, unit: 3}]}, 7: {teacherId: 24935984, teacherName: ??????, courseId: 334873, courseCode: SOFT0031132231, courseNo: 01, courseName: ?????????????????????, roomId: 2370, roomName: ?????????218, weeks: [false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false], taskId: null, expLessonGroupId: , expLessonGroupIndexNo: , remark: , specialRoom: , periods: [{weekday: 3, unit: 5}, {weekday: 3, unit: 6}]}, 8: {teacherId: 76663, teacherName: ?????????, courseId: 331020, courseCode: SOFT0031132228, courseNo: 01, courseName: ?????????????????????, roomId: , roomName: , weeks: [false, false, false, false, false, false, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false], taskId: null, expLessonGroupId: , expLessonGroupIndexNo: , remark: , specialRoom: ?????????B226, periods: [{weekday: 0, unit: 0}, {weekday: 0, unit: 1}]}}';
