import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Master of the Classroom',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 버튼 스타일 정의
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      minimumSize: Size(200, 50), // 버튼의 최소 크기 설정
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Master of the Classroom'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Master of the Classroom',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BuildingSelectionPage(),
                  ),
                );
              },
              child: const Text('강의실 검색하기'),
            ),
            // '층 별 강의실 위치 보기' 버튼이 여기서 제거되었습니다.
          ],
        ),
      ),
    );
  }
}



// 새로운 페이지: 각 층의 강의실 배치도를 보여주는 페이지
class FloorPlanImagePage extends StatelessWidget {
  final String imageAssetPath;

  const FloorPlanImagePage({Key? key, required this.imageAssetPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('강의실 배치도'),
      ),
      body: Center(
        child: Image.asset(imageAssetPath, fit: BoxFit.contain),
      ),
    );
  }
}

// 기존 FloorPlanPage 클래스
class FloorPlanPage extends StatelessWidget {
  const FloorPlanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('층 별 강의실 위치'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FloorPlanImagePage(imageAssetPath: 'assets/images/1floor.png'),
                  ),
                );
              },
              child: const Text('1층 강의실 배치도'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FloorPlanImagePage(imageAssetPath: 'assets/images/2floor.png'),
                  ),
                );
              },
              child: const Text('2층 강의실 배치도'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FloorPlanImagePage(imageAssetPath: 'assets/images/3floor.png'),
                  ),
                );
              },
              child: const Text('3층 강의실 배치도'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FloorPlanImagePage(imageAssetPath: 'assets/images/4floor.png'),
                  ),
                );
              },
              child: const Text('4층 강의실 배치도'),
            ),
          ],
        ),
      ),
    );
  }
}



class BuildingSelectionPage extends StatefulWidget {
  const BuildingSelectionPage({Key? key}) : super(key: key);

  @override
  _BuildingSelectionPageState createState() => _BuildingSelectionPageState();
}

class _BuildingSelectionPage extends StatefulWidget {
  const _BuildingSelectionPage({Key? key}) : super(key: key);

  @override
  _BuildingSelectionPageState createState() => _BuildingSelectionPageState();
}

class _BuildingSelectionPageState extends State<BuildingSelectionPage> {
  String? _selectedBuilding;

  @override
  void initState() {
    super.initState();
    _selectedBuilding = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('건물 선택'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('건물을 선택하세요', style: TextStyle(fontSize: 16.0)),
            ),
            DropdownButton<String>(
              value: _selectedBuilding,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedBuilding = newValue;
                });
              },
              items: <String>['한빛관', '보듬관']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                if (_selectedBuilding != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClassroomSearchPage(buildingName: _selectedBuilding!),
                    ),
                  );
                }
              },
              child: const Text('강의실 검색으로 이동'),
            ),
            // '한빛관'을 선택했을 때만 '층 별 강의실 위치 보기' 버튼을 표시합니다.
            if (_selectedBuilding == '한빛관')
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FloorPlanPage(),
                    ),
                  );
                },
                child: const Text('층 별 강의실 위치 보기'),
              ),
          ],
        ),
      ),
    );
  }
}

class ClassroomSearchPage extends StatefulWidget {
  final String buildingName;
  const ClassroomSearchPage({Key? key, required this.buildingName}) : super(key: key);

  @override
  _ClassroomSearchPageState createState() => _ClassroomSearchPageState();
}

class _ClassroomSearchPageState extends State<ClassroomSearchPage> {
  late List<String> _classrooms;
  List<String> _filteredClassrooms1F = [];
  List<String> _filteredClassrooms2F = [];
  List<String> _filteredClassrooms3F = [];
  List<String> _filteredClassrooms4F = [];
  TextEditingController _searchController = TextEditingController();

  void _searchClassroom(String query) {
    query = query.toLowerCase();
    if (query.isEmpty) {
      // 각 층별로 강의실을 필터링합니다.
      _filteredClassrooms1F = _classrooms.where((classroom) => classroom.startsWith("101") || classroom.startsWith("102") || classroom.startsWith("103") || classroom.startsWith("104") || classroom.startsWith("106") || classroom.startsWith("107")).toList();
      _filteredClassrooms2F = _classrooms.where((classroom) => classroom.startsWith("201") || classroom.startsWith("202") || classroom.startsWith("203") || classroom.startsWith("204") || classroom.startsWith("205") || classroom.startsWith("206") || classroom.startsWith("207") || classroom.startsWith("208") || classroom.startsWith("209") || classroom.startsWith("210") || classroom.startsWith("211") || classroom.startsWith("212") || classroom.startsWith("213") || classroom.startsWith("214") || classroom.startsWith("215") || classroom.startsWith("216")).toList();
      // 3층 및 4층 강의실에 대한 필터링 로직을 추가합니다.
      _filteredClassrooms3F = _classrooms.where((classroom) => classroom.startsWith("301") || classroom.startsWith("302") || classroom.startsWith("303") || classroom.startsWith("304") || classroom.startsWith("305") || classroom.startsWith("306") || classroom.startsWith("307") || classroom.startsWith("308") || classroom.startsWith("309") || classroom.startsWith("310") || classroom.startsWith("311") || classroom.startsWith("312-1") || classroom.startsWith("312-2") || classroom.startsWith("313") || classroom.startsWith("314")).toList();
      _filteredClassrooms4F = _classrooms.where((classroom) => classroom.startsWith("401") || classroom.startsWith("402") || classroom.startsWith("403") || classroom.startsWith("404") || classroom.startsWith("405") || classroom.startsWith("406") || classroom.startsWith("407") || classroom.startsWith("408") || classroom.startsWith("409") || classroom.startsWith("410") || classroom.startsWith("411") || classroom.startsWith("412") || classroom.startsWith("413")).toList();
    } else {
      // 검색 쿼리에 맞는 강의실을 필터링합니다.
      _filteredClassrooms1F = _classrooms
          .where((classroom) => classroom.toLowerCase().contains(query) && (classroom.startsWith("101") || classroom.startsWith("102") || classroom.startsWith("103") || classroom.startsWith("104") || classroom.startsWith("106") || classroom.startsWith("107")))
          .toList();
      _filteredClassrooms2F = _classrooms
          .where((classroom) => classroom.toLowerCase().contains(query) && (classroom.startsWith("201") || classroom.startsWith("202") || classroom.startsWith("203") || classroom.startsWith("204") || classroom.startsWith("205") || classroom.startsWith("206") || classroom.startsWith("207") || classroom.startsWith("208") || classroom.startsWith("209") || classroom.startsWith("210") || classroom.startsWith("211") || classroom.startsWith("212") || classroom.startsWith("213") || classroom.startsWith("214") || classroom.startsWith("215") || classroom.startsWith("216")))
          .toList();
      // 3층 및 4층 강의실에 대한 필터링 로직을 추가합니다.
      _filteredClassrooms3F = _classrooms
          .where((classroom) => classroom.toLowerCase().contains(query) && (classroom.startsWith("301") || classroom.startsWith("302") || classroom.startsWith("303") || classroom.startsWith("304") || classroom.startsWith("305") || classroom.startsWith("306") || classroom.startsWith("307") || classroom.startsWith("308") || classroom.startsWith("309") || classroom.startsWith("310") || classroom.startsWith("311") || classroom.startsWith("312-1") || classroom.startsWith("312-2") || classroom.startsWith("313") || classroom.startsWith("314")))
          .toList();
      _filteredClassrooms4F = _classrooms
          .where((classroom) => classroom.toLowerCase().contains(query) && (classroom.startsWith("401") || classroom.startsWith("402") || classroom.startsWith("403") || classroom.startsWith("404") || classroom.startsWith("405") || classroom.startsWith("406") || classroom.startsWith("407") || classroom.startsWith("408") || classroom.startsWith("409") || classroom.startsWith("410") || classroom.startsWith("411") || classroom.startsWith("412") || classroom.startsWith("413")))
          .toList();
    }
    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    // 각 층별 강의실 목록을 업데이트합니다.
    _classrooms = [
      '101 - 공용장비센터 신뢰성실험실-1', '102 - 행정실', '102-1 - 공용장비센터 시제품 제작실 및 3차원 측정실',
      '103 - 강원지역혁신플랫폼 데이터혁신본부', '104 - 강원지역혁신플랫폼 정밀의료사업단', '106 - IT대학 행정실',
      '107 - IT대학 학장실 회의실', '201 - AI융합학과 디지털밀리터리학과 전공 강의실', '202 - AI융합학과 디지털밀리터리학과 전공 강의실',
      '203 - AI융합학과 디지털밀리터리학과 학과 사무실', '204 - AI융합학과 ACS, ESP 사업단', '205', '206 - AI융합학과 손경호',
      '207 - AI융합학과 박성규', '208 - AI융합학과 이병기', '209 - 디지털밀리터리학과 김재원', '210 - 디지털밀리터리학과 김익현',
      '211', '212 - 디지털밀리터리학과 객원교수', '213 - AI융합학과 디지털밀리터리학과 전공 강의실', '214 - AI융합학과 학생회실',
      '215 - 디지털밀리터리학과 학생회실', '216 - AI융합학과 정보보증 연구실', '301 - 컴퓨터공학과 이창기', '302 - 인텔리전트 소프트웨어 연구실',
      '303 - 컴퓨터 공학과 문양세', '304 - 데이터 지식공학 연구실', '305 - 컴퓨터공학과 최미정', '306 - 네트워크 매니지먼트 연구실',
      '307 - 컴퓨터공학과 임현승', '308 - 프로그래밍언어 및 기계학습 연구실', '309 - 컴퓨터공학과 전산 실습실', '310 - 컴퓨터 공학과 학과 사무실',
      '311 - 컴퓨터 공학과 인터넷 실습실', '312-1 - 프로그래밍언어 및 기계학습 연구실 2', '312-2 - 컴퓨터공학과 대학원 세미나실',
      '313 - 네트워크 매니지먼트 연구실', '314 - 공동실험실-2', '401 - 데이터지식공학 연구실', '402 - 인텔리전트 소프트웨어 연구실 2',
      '403 - 컴퓨터공학과 김도형', '404 - 지능형컴퓨터 네트워크 연구실', '405 - 컴퓨터공학과 박치현', '406 - 의생명데이터과학 연구실',
      '407 - 컴퓨터공학과 김진호', '408 - 데이터베이스 연구실', '409 - 공동실험실-1', '410 - 공동실험실-3', '411 - 컴퓨터공학과 전공 강의실',
      '412 - 컴퓨터공학과 전공 강의실', '413 - 데이터베이스 연구실2'
    ];
    _searchClassroom('');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.buildingName} 강의실 검색'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                onChanged: _searchClassroom,
                decoration: const InputDecoration(
                  labelText: '강의실 검색',
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            _buildClassroomList(_filteredClassrooms1F, '1층 강의실'),
            _buildClassroomList(_filteredClassrooms2F, '2층 강의실'),
            _buildClassroomList(_filteredClassrooms3F, '3층 강의실'),
            _buildClassroomList(_filteredClassrooms4F, '4층 강의실'),
          ],
        ),
      ),
    );
  }

// 각 층별 강의실 목록을 생성하는 메서드
  Widget _buildClassroomList(List<String> classrooms, String title) {
    return classrooms.isNotEmpty
        ? ExpansionTile(
      title: Text(title),
      children: classrooms.map((classroom) => ListTile(
        title: Text(classroom),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClassroomSchedulePage(classroomName: classroom),
            ),
          );
        },
      )).toList(),
    )
        : SizedBox.shrink();
  }


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class ClassroomSchedulePage extends StatelessWidget {
  final String classroomName;

  const ClassroomSchedulePage({Key? key, required this.classroomName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$classroomName 일정'),
      ),
      body: Column(
        children: [
          Expanded(
            child: classroomName == '201 - AI융합학과 디지털밀리터리학과 전공 강의실'
                ? Image.asset('assets/images/Schedule-201.png', fit: BoxFit.contain)
                : Center(child: Text('$classroomName 일정 없음')),
          ),
          ElevatedButton(
            onPressed: () {
              if (classroomName == '201 - AI융합학과 디지털밀리터리학과 전공 강의실') {
                _showClassroomLocation(context, 'assets/images/classroom-201.png');
              } else {
                // 다른 강의실에 대한 처리 (예: 메시지 표시 또는 다른 이미지 표시)
                _showClassroomLocation(context, 'assets/images/other-classroom.png');
              }
            },
            child: const Text('강의실 안내'),
          ),
        ],
      ),
    );
  }

  void _showClassroomLocation(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('강의실 위치'),
          content: InteractiveViewer(
            boundaryMargin: EdgeInsets.all(20.0),
            minScale: 0.1,
            maxScale: 4.0,
            child: Image.asset(imagePath, fit: BoxFit.contain),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('닫기'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}