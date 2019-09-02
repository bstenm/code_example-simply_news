bool hasToken(List l, Map m) {
  final lemmas = l.map((e) => e['lemma']);
  return lemmas.contains(m['lemma']);
}
