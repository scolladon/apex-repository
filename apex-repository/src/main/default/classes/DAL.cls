public inherited sharing class DAL {
  @testVisible
  private static RepositoryService repoService;
  private static Boolean mocking = false;

  static {
    DAL.setDefaultMode();
  }

  public static void setDefaultMode() {
    DAL.setDatabaseAccessMode(new RepositoryFactory().asUser());
  }

  public static void setUserMode() {
    DAL.setDatabaseAccessMode(new RepositoryFactory().asUser());
  }

  public static void setSystemMode() {
    DAL.setDatabaseAccessMode(new RepositoryFactory().asSystemWithoutSharing());
  }

  public static void setSystemWithSharingMode() {
    DAL.setDatabaseAccessMode(new RepositoryFactory().asSystemWithSharing());
  }

  private static void setDatabaseAccessMode(final RepositoryService repoService) {
    if (DAL.mocking == true) {
      return;
    }
    DAL.repoService = repoService;
  }

  @testVisible
  private static Mock mock() {
    final Mock repoServiceMock = Mock.forType(RepositoryService.class);
    DAL.setDatabaseAccessMode((RepositoryService) repoServiceMock.stub);
    DAL.mocking = true;
    return repoServiceMock;
  }

  // For integrated test or post/pre processing requiring DataBase
  @testVisible
  private static void unmock() {
    DAL.mocking = false;
    DAL.setDefaultMode();
  }

  public static List<Database.SaveResult> insertRecords(final List<SObject> records) {
    return DAL.repoService.insertRecords(records, new Database.DmlOptions());
  }
  public static List<Database.SaveResult> insertRecordsPartially(final List<SObject> records) {
    final Database.DmlOptions options = new Database.DmlOptions();
    options.OptAllOrNone = false;
    return DAL.repoService.insertRecords(records, options);
  }
  public static List<Database.SaveResult> insertRecords(final List<SObject> records, final Database.DmlOptions options) {
    return DAL.repoService.insertRecords(records, options);
  }
  public static List<Database.SaveResult> updateRecords(final List<SObject> records) {
    return DAL.repoService.updateRecords(records, new Database.DmlOptions());
  }
  public static List<Database.SaveResult> updateRecordsPartially(final List<SObject> records) {
    final Database.DmlOptions options = new Database.DmlOptions();
    options.OptAllOrNone = false;
    return DAL.repoService.updateRecords(records, options);
  }
  public static List<Database.SaveResult> updateRecords(final List<SObject> records, final Database.DmlOptions options) {
    return DAL.repoService.updateRecords(records, options);
  }
  public static List<Database.UpsertResult> upsertRecords(final List<SObject> records, final Schema.SObjectField externalIDField) {
    return DAL.repoService.upsertRecords(records, externalIDField, true);
  }
  public static List<Database.UpsertResult> upsertRecordsPartially(final List<SObject> records, final Schema.SObjectField externalIDField) {
    return DAL.repoService.upsertRecords(records, externalIDField, false);
  }
  public static List<Database.DeleteResult> deleteRecords(final List<SObject> records) {
    return DAL.repoService.deleteRecords(records, true);
  }
  public static List<Database.DeleteResult> deleteRecordsPartially(final List<SObject> records) {
    return DAL.repoService.deleteRecords(records, false);
  }
  public static List<SObject> query(final String soql, final Map<String, Object> bindMap) {
    return DAL.repoService.query(soql, bindMap);
  }
  public static List<SObject> query(final List<SObject> soql) {
    return DAL.repoService.query(soql);
  }
  public static List<List<SObject>> find(final String sosl) {
    return DAL.repoService.find(sosl);
  }
  public static List<List<SObject>> find(final List<List<SObject>> sosl) {
    return DAL.repoService.find(soSl);
  }
}
