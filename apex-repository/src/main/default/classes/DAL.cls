public inherited sharing class DAL { // RepositoryService ACL
  @testVisible // Usefull only for DAL_TEST but should not be used in other tests
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
  private static DAL.UnitTestDouble mock() {
    final DAL.UnitTestDouble dalMock = new DAL.UnitTestDouble();
    DAL.repoService = dalMock.getStub();
    DAL.mocking = true;
    return dalMock;
  }

  @testVisible
  private class UnitTestDouble { // Mocking library ACL
    private final Mock repoServiceMock;

    public UnitTestDouble() {
      this.repoServiceMock = Mock.forType(RepositoryService.class);
    }

    private RepositoryService getStub() {
      return (RepositoryService) this.repoServiceMock.stub;
    }

    public MethodSpy spyOnInsert() {
      return this.spyOn('insertRecords');
    }

    public MethodSpy spyOnUpdate() {
      return this.spyOn('updateRecords');
    }

    public MethodSpy spyOnUpsert() {
      return this.spyOn('upsertRecords');
    }

    public MethodSpy spyOnDelete() {
      return this.spyOn('deleteRecords');
    }

    public MethodSpy spyOnQuery() {
      return this.spyOn('query');
    }

    public MethodSpy spyOnFind() {
      return this.spyOn('find');
    }

    private MethodSpy spyOn(final String methodName) {
      return this.repoServiceMock.spyOn(methodName);
    }
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
