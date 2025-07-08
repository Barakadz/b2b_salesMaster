bool isEmpty(String? text) {
  if (text == null || text.replaceAll(" ", "").isEmpty) {
    return true;
  }
  return false;
}
