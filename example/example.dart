import 'package:delimatrix_dart/delimatrix.dart';

void main() {
  final fromMap = JsonTransformers.fromMap
      .chain(ToDxJsonTransformer(JsonEscapeConfigs.shavian));

  final toMap = FromDxJsonTransformer(JsonEscapeConfigs.shavian)
      .chain(JsonTransformers.toMap);

  const DxResult<Map<String, String>> input = DxSuccess({'key': "line1\nline\\2 \n\t\tindented 🙂\na/b/c"});

  // Convert a Map<String, String> to Delimatrix style JSON
  final jsonishStringResult = fromMap.transform(input);
  print(jsonishStringResult.value);
  // {𐑣key𐑣:𐑣line1𐑯nline𐑯𐑯2 𐑯n𐑯t𐑯tindented 🙂𐑯na/b/c𐑣}

  // Convert Delimatrix style JSON back to  Map<String, String>
  final mapResult = toMap.transform(jsonishStringResult);
  print(mapResult.value);
  // {key: line1
  // line\2
  //    indented 🙂
  // a/b/c}
  }
