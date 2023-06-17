class TiengVietUtil {
  static final List<String> _vietNamese = [
    'aàáạảãâầấậẩẫăằắặẳẵ',
    'eèéẹẻẽêềếệểễ',
    'oòóọỏõôồốộổỗơờớợởỡ',
    'uùúụủũưừứựửữ',
    'iìíịỉĩ',
    'dđ',
    'yỳýỵỷỹ',
  ];

  /// xóa hết dấu, đổi hết thành chữ thường
  static String parse(String text) {
    text = text.toLowerCase();
    List<String> listInput = [];
    for (var i = 0; i < text.length; i++) {
      listInput.add(text[i]);
    }
    listInput.remove('̀');
    listInput.remove('́');
    listInput.remove('̣');
    for (var i = 0; i < listInput.length; i++) {
      for (int j = 0; j < _vietNamese.length; j++) {
        if (_vietNamese[j].contains(listInput[i])) {
          listInput[i] = _vietNamese[j][0];
          break;
        }
      }
    }
    String result = '';
    for (final obj in listInput) {
      result += obj;
    }
    return result;
  }
}
