class APIPath {
  // ! document
  static String job(String uid, String jobId) => 'users/$uid/jobs/$jobId';
  //! collection
  static String jobs(
    String uid,
  ) =>
      'users/$uid/jobs';
  static String entry(String uid, String entryId) =>
      'users/$uid/jobs/entries/$entryId';
  static String entries(String uid) => 'users/$uid/entries';
}
