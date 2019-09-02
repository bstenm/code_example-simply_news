class Messages {
  final String processing;
  final String noSavedVocab;
  final String unexpectedError;
  final String toArticlesButton;
  final String unknownRoute;

  Messages.fromJson()
      : processing = 'Processing...',
        noSavedVocab = 'You have no saved vocabulary yet.',
        unknownRoute = 'Unknown route.',
        unexpectedError = 'An unexpected error occured. Please try again.',
        toArticlesButton = 'Go to Articles';

  Map toJson() => {
        'processing': processing,
        'noSavedVocab': noSavedVocab,
        'unknownRoute': unknownRoute,
        'unexpectedError': unexpectedError,
        'toArticlesButton': toArticlesButton,
      };
}
