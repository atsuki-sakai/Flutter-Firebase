class APIPath {
  // ! document
  static String job(String uid, String jobId) => 'users/$uid/jobs/$jobId';
  //! collection
  static String jobs(String uid) => 'users/$uid/jobs';
}
