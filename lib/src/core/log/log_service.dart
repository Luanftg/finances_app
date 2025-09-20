import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

enum LogLevel { info, warning, error }

class HttpLogger {
  bool enabled;
  final Map<String, DateTime> _activeProcesses = {};
  final List<Map<String, dynamic>> _history = [];

  HttpLogger({this.enabled = true});

  /// Log simples no console
  void _log(String message, {LogLevel level = LogLevel.info}) {
    if (!enabled) return;
    final timestamp = DateTime.now();
    final logMessage = '[$timestamp] [${level.name.toUpperCase()}] $message';
    print(logMessage);
  }

  void info(String message) => _log(message, level: LogLevel.info);
  void warning(String message) => _log(message, level: LogLevel.warning);
  void error(String message) => _log(message, level: LogLevel.error);

  /// Inicia um processo com nome e parâmetros opcionais
  void startProcess(String name, {dynamic data}) {
    if (!enabled) return;
    _activeProcesses[name] = DateTime.now();

    final String dataSummary = _summarizeData(data);
    info('🚀 Processo "$name" iniciado. $dataSummary');
  }

  /// Finaliza processo e loga duração
  void endProcess(String name) {
    if (!enabled) return;
    final now = DateTime.now();
    final start = _activeProcesses[name];
    if (start != null) {
      final duration = now.difference(start);
      info(
          '✅ Processo "$name" finalizado. ⏱️ Duração: ${duration.inMilliseconds}ms');
      _activeProcesses.remove(name);
    } else {
      warning('Processo "$name" não encontrado.');
    }
  }

  /// Loga request com método, URL, status code e dados
  Future<void> logRequest({
    required String method,
    required String url,
    int? statusCode,
    dynamic data,
    dynamic responseData,
    required int durationMs,
  }) async {
    if (!enabled) return;

    final String dataSummary = _summarizeData(data);
    final String responseDataSummary = _summarizeData(responseData);
    info(
        '$method $url - Status: ${statusCode ?? "N/A"} - Parametros: $dataSummary - Response: $responseDataSummary');

    final record = {
      'timestamp': DateTime.now().toIso8601String(),
      'duration': durationMs,
      'method': method,
      'url': url,
      'status': statusCode,
      'data': data,
      'responseData': responseData,
    };

    _history.add(record);
    await _saveRequestBackup(record);
  }

  /// Resume os dados para log e backup como JSON string
  String _summarizeData(dynamic data) {
    if (data == null) return '';
    try {
      if (data is Map || data is List) {
        return jsonEncode(data);
      }
      return data.toString();
    } catch (e) {
      // Caso não consiga serializar, retorna toString
      return data.toString();
    }
  }

  /// Histórico em memória (somente leitura)
  List<Map<String, dynamic>> get history => List.unmodifiable(_history);

  /// Limpa histórico e processos ativos
  void clearHistory() {
    _history.clear();
    _activeProcesses.clear();
  }

  /// Ativa ou desativa logs globalmente
  void setEnabled(bool value) => enabled = value;

  /// Salva backup de request em arquivo JSON
  Future<void> _saveRequestBackup(Map<String, dynamic> record) async {
    try {
      final dir = await _getBackupDirectory();
      final file = File('${dir.path}/requests_backup.json');

      List<Map<String, dynamic>> existing = [];
      if (await file.exists()) {
        final content = await file.readAsString();
        if (content.isNotEmpty) {
          existing = List<Map<String, dynamic>>.from(jsonDecode(content));
        }
      }

      existing.add(record);
      final created =
          await file.writeAsString(jsonEncode(existing), flush: true);
      // log('arquivo salvo em : ${created.path}');
      return;
    } catch (e) {
      error('Falha ao salvar backup de request: $e');
    }
  }

  /// Retorna diretório para backups, criando se necessário
  Future<Directory> _getBackupDirectory() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    // final appDocDir = await MidiaHelper.instance.fetchExternalStorage();
    final backupDir = Directory('${appDocDir.path}/backupRequests');
    _log('Arquivo de BACKUP salvo em: ${backupDir.path}');
    if (!await backupDir.exists()) {
      await backupDir.create(recursive: true);
    }
    return backupDir;
  }
}
