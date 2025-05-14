import 'dart:math';

import 'package:ego/widgets/emotion_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_graph_view/flutter_graph_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GraphWidget extends StatefulWidget {
  final FilterSelection filterSelection;

  const GraphWidget({super.key, required this.filterSelection});

  @override
  _GraphWidgetState createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  bool _isLoading = true;
  Map<String, dynamic> _graphData = {};
  late FilterSelection _currentFilter;

  @override
  void initState() {
    super.initState();
    _currentFilter = widget.filterSelection;
    _fetchGraphData();
  }

  @override
  void didUpdateWidget(covariant GraphWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 필터가 변경되었을 경우 다시 데이터를 불러옴
    if (oldWidget.filterSelection.index != widget.filterSelection.index ||
        oldWidget.filterSelection.count != widget.filterSelection.count) {
      _currentFilter = widget.filterSelection;
      _fetchGraphData();
    }
  }

  Future<void> _fetchGraphData() async {
    setState(() {
      _isLoading = true;
    });

    var r = Random();
    var vertexes = <Map<String, dynamic>>[];

    // "나" 노드 추가
    vertexes.add({
      'id': '나',
      'tag': '나',
      'tags': ['central'],
    });

    var names = ['마리오', '엔젤', '준호', '지훈', '소연', '미나', '태호', '보라'];
    var relations = ['배드민턴', '활발한', '영화중독', '게이머', '맛집러버'];

    Map<String, String> personToRelation = {};
    for (int i = 0; i < names.length; i++) {
      personToRelation[names[i]] = i < relations.length
          ? relations[i]
          : relations[r.nextInt(relations.length)];
    }

    String selectedRelation = relations[_currentFilter.index];

    var edges = <Map<String, dynamic>>[];

    for (var name in names) {
      if (personToRelation[name] == selectedRelation) {
        vertexes.add({
          'id': name,
          'tag': name,
          'tags': [
            'tag${r.nextInt(9)}',
            if (r.nextBool()) 'tag${r.nextInt(4)}',
            if (r.nextBool()) 'tag${r.nextInt(8)}',
          ],
        });

        edges.add({
          'srcId': '나',
          'dstId': name,
          'edgeName': selectedRelation,
          'ranking': r.nextInt(1000),
        });
      }
    }

    setState(() {
      _graphData = {
        'vertexes': vertexes,
        'edges': edges,
      };
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
        height: 300.h,
        child: ClipRect(
          child: FlutterGraphWidget(
            data: _graphData,
            algorithm: ForceDirected(
              decorators: [
                HookeDecorator(),
                ForceDecorator(),
                ForceMotionDecorator(),
              ],
            ),
            convertor: MapConvertor(),
            options: Options()
              ..graphStyle = (GraphStyle()
                ..tagColor = {'tag8': Colors.orangeAccent.shade200}
                ..tagColorByIndex = [
                  Colors.red.shade200,
                  Colors.orange.shade200,
                  Colors.yellow.shade200,
                  Colors.green.shade200,
                  Colors.blue.shade200,
                  Colors.blueAccent.shade200,
                  Colors.purple.shade200,
                  Colors.pink.shade200,
                  Colors.blueGrey.shade200,
                  Colors.deepOrange.shade200,
                ])
              ..useLegend = false
              ..edgePanelBuilder = edgePanelBuilder
              ..vertexPanelBuilder = vertexPanelBuilder
              ..edgeShape = EdgeLineShape()
              ..vertexShape = VertexCircleShape(),
          ),
        ),
      ),
    );
  }
}


// 간선 패널 빌더 - 간선에 텍스트 표시
Widget edgePanelBuilder(Edge edge, Viewfinder viewfinder) {
  var c = (edge.start.cpn!.position + edge.end!.cpn!.position) / 2; // 간선의 중심 위치
  return Positioned(
    left: c.x + 10, // 적절한 위치 조정
    top: c.y + 5, // 간선 중심에서 약간 위로
    child: SizedBox(
      width: 150,
      child: ColoredBox(
        color: Colors.red,
        child: ListTile(
          title: Text(
            '${edge.edgeName}', // 간선의 관계 이름을 텍스트로 표시
            style: TextStyle(color: Colors.white), // 텍스트 색상 설정
          ),
        ),
      ),
    ),
  );
}

// 노드 패널 빌더
Widget vertexPanelBuilder(Vertex<dynamic> hoverVertex, Viewfinder viewfinder) {
  return Positioned(
    left: hoverVertex.cpn!.position.x + hoverVertex.radius + 5,
    top: hoverVertex.cpn!.position.y - 20,
    child: SizedBox(
      width: 120,
      child: ColoredBox(
        color: Colors.white,
        child: ListTile(
          title: Text('Id: ${hoverVertex.id}'),
          subtitle: Text(
            'Tag: ${hoverVertex.data['tag']}\nDegree: ${hoverVertex.degree}',
          ),
        ),
      ),
    ),
  );
}
