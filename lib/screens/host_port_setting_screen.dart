import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ego/services/setting_service.dart';

class HostPortSettingScreen extends StatefulWidget {
  const HostPortSettingScreen({Key? key}) : super(key: key);

  @override
  State<HostPortSettingScreen> createState() => _HostPortSettingScreenState();
}

class _HostPortSettingScreenState extends State<HostPortSettingScreen> {
  final _hostController = TextEditingController();
  final _dbPortController = TextEditingController();
  final _wsPortController = TextEditingController();
  final _diaryPortController = TextEditingController();
  final _imagePortController = TextEditingController();

  final _settings = SettingsService();

  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {

    setState(() {
      _hostController.text = _settings.host;
      _dbPortController.text = _settings.dbPort;
      _wsPortController.text = _settings.wsTextPort;
      _diaryPortController.text = _settings.diaryCreatePort;
      _imagePortController.text = _settings.imageGenPort;
      _isInitialized = true;
    });
  }

  Future<void> _saveSettings() async {
    await _settings.setHost(_hostController.text);
    await _settings.setApiPort(_dbPortController.text);
    await _settings.setWsPort(_wsPortController.text);
    await _settings.setDiaryPort(_diaryPortController.text);
    await _settings.setImagePort(_imagePortController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('설정이 저장되었습니다.')),
    );
  }

  @override
  void dispose() {
    _hostController.dispose();
    _dbPortController.dispose();
    _wsPortController.dispose();
    _diaryPortController.dispose();
    _imagePortController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Scaffold(
        appBar: AppBar(title: Text('설정')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('설정'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField('호스트 주소', _hostController, hint: '예: 10.0.2.2'),
            _buildTextField('DB 포트', _dbPortController, isNumber: true),
            _buildTextField('WebSocket 포트', _wsPortController, isNumber: true),
            _buildTextField('일기 생성 포트', _diaryPortController, isNumber: true),
            _buildTextField('이미지 생성 포트', _imagePortController, isNumber: true),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: _saveSettings,
              child: Text('저장'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label,
      TextEditingController controller, {
        bool isNumber = false,
        String? hint,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        inputFormatters: isNumber
            ? [FilteringTextInputFormatter.digitsOnly]
            : null,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
