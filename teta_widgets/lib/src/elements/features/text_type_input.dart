// Flutter imports:
// Project imports:
// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars, avoid_escaping_inner_quotes

// Package imports:
import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';
import 'package:teta_core/teta_core.dart';

enum FTextTypeEnum { text, imageUrl, param, state, dataset, asset, combined }

enum ResultTypeEnum {
  string,
  dateTime,
  int,
  double,
  bool,
}

enum TypeDateTimeFormat {
  dateWithTime,
  dateWithoutTime,
}

class FTextTypeInput {
  /// Set of func to use text string in Teta's widgets
  FTextTypeInput({
    this.type = FTextTypeEnum.text,
    this.value = '',
    this.paramName,
    this.stateName,
    this.datasetName,
    this.datasetAttr,
    this.file,
    this.mapKey,
    this.combination,
    this.resultType = ResultTypeEnum.string,
    this.typeDateTimeFormat,
  });

  FTextTypeEnum? type;
  String? value;
  String? paramName;
  String? stateName;
  String? datasetName;
  String? datasetAttr;
  AssetFile? file;
  String? mapKey;
  List<FTextTypeInput>? combination;
  ResultTypeEnum resultType;
  TypeDateTimeFormat? typeDateTimeFormat;

  /// Returns value for texts
  String get(
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final bool forPlay,
    final int? loop,
  ) =>
      '${calc(params, states, dataset, forPlay, loop, datasetAttr ?? '')}';

  /// Returns value for images
  dynamic getForImages(
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final int? loop, {
    required final bool forPlay,
  }) =>
      calc(
        params,
        states,
        dataset,
        forPlay,
        loop,
        'https://source.unsplash.com/random',
      );

  /// Returns the value calculated based on params, states and dataset
  dynamic calc(
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final bool forPlay,
    final int? loop,
    final String placeholder,
  ) {
    final dynamic result = getRaw(
      params,
      states,
      dataset,
      forPlay,
      loop,
      placeholder,
    );
    if (result.runtimeType == XFile) {
      return result;
    } else if (result.runtimeType == String) {
      switch (resultType) {
        case ResultTypeEnum.string:
          return result;
        case ResultTypeEnum.int:
          return int.tryParse(result as String) ??
              'Impossible to convert to int type';
        case ResultTypeEnum.double:
          return double.tryParse(result as String) ??
              'Impossible to convert to double type';
        case ResultTypeEnum.bool:
          return (result as String?) == 'true'
              ? true
              : result == 'false'
                  ? false
                  : 'Impossible to convert to double type';
        case ResultTypeEnum.dateTime:
          final date = DateTime.tryParse(result as String);
          if (date != null) {
            if (typeDateTimeFormat == TypeDateTimeFormat.dateWithoutTime) {
              return DateFormat('yyyy-MM-dd').format(date);
            }
            if (typeDateTimeFormat == TypeDateTimeFormat.dateWithTime) {
              return DateFormat('yyyy-MM-dd hh:mm:ss').format(date);
            }
          }
          return 'Impossible to convert to DateTime type';
      }
    }
  }

  dynamic getRaw(
    final List<VariableObject> params,
    final List<VariableObject> states,
    final List<DatasetObject> dataset,
    final bool forPlay,
    final int? loop,
    final String placeholder,
  ) {
    if (type == FTextTypeEnum.param) {
      try {
        final param = params
            .firstWhereOrNull((final element) => element.name == paramName);
        if (param?.type == VariableType.file) {
          return param?.file;
        }
        return param?.get;
      } catch (_) {}
    }
    if (type == FTextTypeEnum.state) {
      final state =
          states.firstWhereOrNull((final element) => element.name == stateName);
      if (state?.type == VariableType.file) {
        return state?.file;
      }
      return state?.get;
    }
    if (type == FTextTypeEnum.dataset) {
      final db = dataset
          .firstWhereOrNull((final element) => element.getName == datasetName)
          ?.getMap[loop ?? 0];
      if (db != null) {
        return '${db[datasetAttr]}';
      } else {
        return placeholder;
      }
    }
    if (type == FTextTypeEnum.asset) {
      return file?.url ?? '';
    }
    if (type == FTextTypeEnum.combined) {
      final string = StringBuffer();
      for (final element in combination ?? <FTextTypeInput>[]) {
        string.write(
          element.get(params, states, dataset, forPlay, loop),
        );
      }
      return string.toString();
    }
    return value ?? '';
  }

  static FTextTypeInput fromJson(final Map<String, dynamic>? json) {
    try {
      return FTextTypeInput(
        type: json?['t'] == 'text'
            ? FTextTypeEnum.text
            : json?['t'] == 'imageUrl'
                ? FTextTypeEnum.imageUrl
                : json?['t'] == 'param'
                    ? FTextTypeEnum.param
                    : json?['t'] == 'state'
                        ? FTextTypeEnum.state
                        : json?['t'] == 'dataset'
                            ? FTextTypeEnum.dataset
                            : json?['t'] == 'asset'
                                ? FTextTypeEnum.asset
                                : json?['t'] == 'combined'
                                    ? FTextTypeEnum.combined
                                    : FTextTypeEnum.text,
        value: json?['v'] as String?,
        paramName: json?['pN'] as String?,
        stateName: json?['sN'] as String?,
        datasetName: json?['dN'] as String?,
        datasetAttr: json?['dA'] as String?,
        file: json?['f'] != null
            ? AssetFile.fromJson(json?['f'] as Map<String, dynamic>?)
            : null,
        mapKey: json?['mK'] as String?,
        combination: json?['cmb'] != null
            ? (json?['cmb'] as List<dynamic>)
                .map(
                  (final dynamic e) =>
                      FTextTypeInput.fromJson(e as Map<String, dynamic>),
                )
                .toList()
            : [],
        resultType: EnumToString.fromString(
              ResultTypeEnum.values,
              json?['rType'] as String? ?? 'string',
            ) ??
            ResultTypeEnum.string,
        typeDateTimeFormat: EnumToString.fromString(
              TypeDateTimeFormat.values,
              json?['tDateTime'] as String? ??
                  EnumToString.convertToString(TypeDateTimeFormat.dateWithTime),
            ) ??
            TypeDateTimeFormat.dateWithTime,
      );
    } catch (e) {
      return FTextTypeInput();
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        't': type == FTextTypeEnum.asset
            ? 'asset'
            : type == FTextTypeEnum.dataset
                ? 'dataset'
                : type == FTextTypeEnum.param
                    ? 'param'
                    : type == FTextTypeEnum.state
                        ? 'state'
                        : type == FTextTypeEnum.imageUrl
                            ? 'imageUrl'
                            : type == FTextTypeEnum.combined
                                ? 'combined'
                                : 'text',
        'v': value,
        'pN': paramName,
        'sN': stateName,
        'dN': datasetName,
        'dA': datasetAttr,
        'mK': mapKey,
        'cmb': combination?.map((final e) => e.toJson()).toList(),
        'rType': EnumToString.convertToString(resultType),
        'tDateTime': typeDateTimeFormat != null
            ? EnumToString.convertToString(typeDateTimeFormat)
            : EnumToString.convertToString(TypeDateTimeFormat.dateWithTime),
        if (file != null) 'f': file!.toJson(),
      }..removeWhere((final String key, final dynamic value) => value == null);

  /*String toCode(
          BuildContext context,
          List<VariableObject> params,
          List<VariableObject> states,
          List<DatasetObject> dataset,
          bool forPlay,
          int? loop,) =>
      calc(params, states, dataset, forPlay, loop, '');*/

  String toCode(
    final int? loop,
  ) {
    final code = getRawToCode(loop);

    if (type == FTextTypeEnum.combined) {
      return code;
    }

    return convertType(code);
  }

  String getRawToCode(
    final int? loop,
  ) {
    if (type == FTextTypeEnum.param) {
      if (paramName?.isEmpty ?? true) return "''";
      final param = ReCase(paramName ?? '');
      return "'''\${widget.${param.camelCase}}'''";
    }
    if (type == FTextTypeEnum.state) {
      if (stateName?.isEmpty ?? true) return "''";
      final state = ReCase(stateName ?? '');
      return "'''\${${state.camelCase}}'''";
    }
    if (type == FTextTypeEnum.dataset) {
      return "this.datasets['$datasetName']?[${datasetName == 'Teta Auth User' ? '0' : 'index'}]?['$datasetAttr']?.toString() ?? ''";
    }
    if (type == FTextTypeEnum.asset) {
      return file?.url ?? '';
    }
    if (type == FTextTypeEnum.combined) {
      final string = StringBuffer("'''");
      for (final element in combination ?? <FTextTypeInput>[]) {
        final code = convertType(
          element.toCode(loop).replaceAll("'''", ''),
        ).replaceAll("'''", '');
        string.write(code);
      }
      string.write("'''");
      return string.toString();
    }
    return value ?? '';
  }

  String convertType(final String original) {
    var code = original;
    if ((type == FTextTypeEnum.dataset ||
            type == FTextTypeEnum.param ||
            type == FTextTypeEnum.state) &&
        code != "''") {
      code =
          code.replaceAll("'''", '').replaceAll(r'${', '').replaceAll('}', '');
      code = '\${$code}';
    }
    if (code != "''") {
      code = "'''$code'''";
    }
    switch (resultType) {
      case ResultTypeEnum.string:
        return code;
      case ResultTypeEnum.int:
        return "'\${int.tryParse($code)}'";
      case ResultTypeEnum.double:
        return "'\${double.tryParse($code)}'";
      case ResultTypeEnum.bool:
        return "'''\${$code == 'true'}";
      case ResultTypeEnum.dateTime:
        if (typeDateTimeFormat == TypeDateTimeFormat.dateWithoutTime) {
          return "'\${DateFormat('yyyy-MM-dd').format(DateTime.tryParse($code) ?? DateTime.now())}'";
        }
        if (typeDateTimeFormat == TypeDateTimeFormat.dateWithTime) {
          return "'\${DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.tryParse($code) ?? DateTime.now())}'";
        }
    }
    return code;
  }
}
