import 'dart:math';

import 'package:ego/models/ego_model_v2.dart';
import 'package:ego/theme/color.dart';
import 'package:ego/widgets/bottomsheet/ego_model_bottom_sheet.dart';
import 'package:ego/widgets/bottomsheet/today_ego_intro.dart';
import 'package:ego/widgets/customtoast/custom_toast.dart';
import 'package:ego/widgets/relation_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_graph_view/flutter_graph_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart' show FToast;

class EgoRelationWidget extends StatefulWidget {
  final FilterSelection filterSelection;

  const EgoRelationWidget({super.key, required this.filterSelection});

  @override
  _EgoRelationWidgetState createState() => _EgoRelationWidgetState();
}

class _EgoRelationWidgetState extends State<EgoRelationWidget> {
  bool _isLoading = true;
  Map<String, dynamic> _graphData = {};
  late FilterSelection _currentFilter;
  late String _selectedRelation;

  late String selectedVertex;

  @override
  void initState() {
    super.initState();

    //EGO 정보 get 필요

    _currentFilter = widget.filterSelection;
    _fetchGraphData();
  }

  @override
  void didUpdateWidget(covariant EgoRelationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.filterSelection.index != widget.filterSelection.index) {
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
      personToRelation[names[i]] =
          i < relations.length
              ? relations[i]
              : relations[r.nextInt(relations.length)];
    }

    // 전체(ALL) 처리
    _selectedRelation =
        _currentFilter.index == -1 ? '전체' : relations[_currentFilter.index];

    var edges = <Map<String, dynamic>>[];

    for (var name in names) {
      if (_selectedRelation == '전체' ||
          personToRelation[name] == _selectedRelation) {
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
          'edgeName': personToRelation[name],
          'ranking': r.nextInt(1000),
        });
      }
    }

    setState(() {
      _graphData = {'vertexes': vertexes, 'edges': edges};
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child:
          _isLoading
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
                    options:
                        Options()
                          ..graphStyle =
                              (GraphStyle()
                                ..tagColor = {'나': Colors.white}
                                ..tagColorByIndex = [
                                  AppColors.strongOrange,
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
                          ..onVertexTapDown = (vertex, details) {
                            if (vertex.id == '나') return;

                            final personalityList = ['게임중독', '맛집탐방'];

                            //EgoId에 따라 EgoInfoModel 제작
                            var tmpEgo = EgoModelV2(
                              introduction: '나는 사과가 좋아',
                              mbti: 'INTJ',
                              name: '사과짱',
                              createdAt: DateTime.now(),
                              likes: 12,
                              personalityList: personalityList,
                              profileImage: null,
                            );

                            showTodayEgoModelIntroSheet(context, tmpEgo, relationTag: '친절함');
                          }
                          ..useLegend = false
                          ..edgePanelBuilder = edgePanelBuilder
                          ..vertexPanelBuilder = vertexPanelBuilder
                          ..edgeShape = EdgeLineShape(
                            decorators: [TextEdgeDecorator()],
                          )
                          ..vertexShape = VertexCircleShape(),
                  ),
                ),
              ),
    );
  }
}

// 간선 패널 빌더
// 간선 패널 빌더 - 간선에 텍스트 및 색상 표시
Widget edgePanelBuilder(Edge edge, Viewfinder viewfinder) {
  var c = (edge.start.cpn!.position + edge.end!.cpn!.position) / 2; // 간선 중심 위치

  // 간선 색상 맵
  final Map<String, Color> edgeColorMap = {
    '배드민턴': Colors.blue,
    '활발한': Colors.green,
    '영화중독': Colors.red,
    '게이머': Colors.orange,
    '맛집러버': Colors.purple,
  };

  Color edgeColor = edgeColorMap[edge.edgeName] ?? Colors.grey; // 관계 없으면 기본 회색

  return Positioned(
    left: c.x + 10,
    top: c.y + 5,
    child: SizedBox(
      width: 150,
      child: ColoredBox(
        color: edgeColor,
        child: ListTile(
          title: Text(
            '${edge.edgeName}',
            style: TextStyle(color: Colors.white),
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

class TextEdgeDecorator extends EdgeDecorator {
  @override
  void decorate(
    Edge edge,
    Canvas canvas,
    Paint paint,
    double distance,
    int edgeCount,
  ) {
    if (edge.path == null) return;

    // 경로의 중간 지점 계산
    final metrics = edge.path!.computeMetrics().first;
    final position = metrics.getTangentForOffset(metrics.length / 2)?.position;

    if (position == null) return;

    // 표시할 텍스트
    final textSpan = TextSpan(
      text: edge.data?['edgeName'] ?? '',
      style: TextStyle(fontSize: 12, color: Colors.white),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      position - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }
}
