void reportError(error) {
  print('>>>>>>>> $error');
  // only executed when on debug mode
  assert(() {
    throw error;
  }());
}
