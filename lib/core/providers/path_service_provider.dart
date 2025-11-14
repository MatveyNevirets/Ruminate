import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/services/path_service.dart';

final pathServiceProvider = Provider((ref) => PathServiceImpl());