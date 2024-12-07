public inherited sharing class DAL { // RepositoryService ACL
  @testVisible // Usefull only for DAL_TEST but should not be used in other test classes
  private static IDAL repoServiceProxy;
  private static Boolean mocking = false;

  static {
    DAL.staticConstructor();
  }

  private static void staticConstructor() {
    DAL.repoServiceProxy = new DALImpl();
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
    DAL.repoServiceProxy.setRepositoryService(repoService);
  }

  @testVisible
  private static DAL.Stub mock() {
    final DAL.Stub dalMock = new DAL.Stub();
    DAL.repoServiceProxy = dalMock.getRepositoryServiceStub();
    DAL.mocking = true;
    return dalMock;
  }

  // For integrated test or post/pre processing requiring DataBase
  @testVisible
  private static void unmock() {
    DAL.mocking = false;
    DAL.staticConstructor();
  }

  @testVisible
  private class Stub { // Mocking library ACL
    private final Mock dalMock;

    public Stub() {
      this.dalMock = Mock.forType(IDAL.class);
    }

    private IDAL getRepositoryServiceStub() {
      return (IDAL) this.dalMock.stub;
    }

    public MethodSpy spyOnInsert() {
      return this.spyOn('insertRecords');
    }

    public MethodSpy spyOnInsertPartially() {
      return this.spyOn('insertRecordsPartially');
    }

    public MethodSpy spyOnUpdate() {
      return this.spyOn('updateRecords');
    }

    public MethodSpy spyOnUpdatePartially() {
      return this.spyOn('updateRecordsPartially');
    }

    public MethodSpy spyOnUpsert() {
      return this.spyOn('upsertRecords');
    }

    public MethodSpy spyOnUpsertPartially() {
      return this.spyOn('upsertRecordsPartially');
    }

    public MethodSpy spyOnDelete() {
      return this.spyOn('deleteRecords');
    }

    public MethodSpy spyOnDeletePartially() {
      return this.spyOn('deleteRecordsPartially');
    }

    public MethodSpy spyOnUndelete() {
      return this.spyOn('undeleteRecords');
    }

    public MethodSpy spyOnUndeletePartially() {
      return this.spyOn('undeleteRecordsPartially');
    }

    public MethodSpy spyOnQuery() {
      return this.spyOn('query');
    }

    public MethodSpy spyOnFind() {
      return this.spyOn('find');
    }

    private MethodSpy spyOn(final String methodName) {
      return this.dalMock.spyOn(methodName);
    }
  }

  public static List<Database.SaveResult> insertRecords(final List<SObject> records) {
    return DAL.repoServiceProxy.insertRecords(records);
  }
  public static List<Database.SaveResult> insertRecordsPartially(final List<SObject> records) {
    return DAL.repoServiceProxy.insertRecordsPartially(records);
  }
  public static List<Database.SaveResult> insertRecords(final List<SObject> records, final Database.DmlOptions options) {
    return DAL.repoServiceProxy.insertRecords(records, options);
  }
  public static List<Database.SaveResult> updateRecords(final List<SObject> records) {
    return DAL.repoServiceProxy.updateRecords(records);
  }
  public static List<Database.SaveResult> updateRecordsPartially(final List<SObject> records) {
    return DAL.repoServiceProxy.updateRecordsPartially(records);
  }
  public static List<Database.SaveResult> updateRecords(final List<SObject> records, final Database.DmlOptions options) {
    return DAL.repoServiceProxy.updateRecords(records, options);
  }
  public static List<Database.UpsertResult> upsertRecords(final List<SObject> records, final Schema.SObjectField externalIDField) {
    return DAL.repoServiceProxy.upsertRecords(records, externalIDField);
  }
  public static List<Database.UpsertResult> upsertRecordsPartially(final List<SObject> records, final Schema.SObjectField externalIDField) {
    return DAL.repoServiceProxy.upsertRecordsPartially(records, externalIDField);
  }
  public static List<Database.DeleteResult> deleteRecords(final List<SObject> records) {
    return DAL.repoServiceProxy.deleteRecords(records);
  }
  public static List<Database.DeleteResult> deleteRecordsPartially(final List<SObject> records) {
    return DAL.repoServiceProxy.deleteRecordsPartially(records);
  }
  public static List<Database.UndeleteResult> undeleteRecords(final List<SObject> records) {
    return DAL.repoServiceProxy.undeleteRecords(records);
  }
  public static List<Database.UndeleteResult> undeleteRecordsPartially(final List<SObject> records) {
    return DAL.repoServiceProxy.undeleteRecordsPartially(records);
  }
  public static List<SObject> query(final String soql, final Map<String, Object> bindMap) {
    return DAL.repoServiceProxy.query(soql, bindMap);
  }
  public static List<SObject> query(final List<SObject> soql) {
    return DAL.repoServiceProxy.query(soql);
  }
  public static List<List<SObject>> find(final String sosl) {
    return DAL.repoServiceProxy.find(sosl);
  }
  public static List<List<SObject>> find(final List<List<SObject>> sosl) {
    return DAL.repoServiceProxy.find(soSl);
  }

  private class DALImpl implements IDAL {
    private RepositoryService repoService;

    public void setRepositoryService(RepositoryService repoService) {
      this.repoService = repoService;
    }

    public RepositoryService getRepositoryService() {
      return this.repoService;
    }

    public List<Database.SaveResult> insertRecords(final List<SObject> records) {
      return this.repoService.insertRecords(records, new Database.DmlOptions());
    }

    public List<Database.SaveResult> insertRecordsPartially(final List<SObject> records) {
      final Database.DmlOptions options = new Database.DmlOptions();
      options.OptAllOrNone = false;
      return this.repoService.insertRecords(records, options);
    }

    public List<Database.SaveResult> insertRecords(final List<SObject> records, final Database.DmlOptions options) {
      return this.repoService.insertRecords(records, options);
    }

    public List<Database.SaveResult> updateRecords(final List<SObject> records) {
      return this.repoService.updateRecords(records, new Database.DmlOptions());
    }

    public List<Database.SaveResult> updateRecordsPartially(final List<SObject> records) {
      final Database.DmlOptions options = new Database.DmlOptions();
      options.OptAllOrNone = false;
      return this.repoService.updateRecords(records, options);
    }

    public List<Database.SaveResult> updateRecords(final List<SObject> records, final Database.DmlOptions options) {
      return this.repoService.updateRecords(records, options);
    }

    public List<Database.UpsertResult> upsertRecords(final List<SObject> records, final Schema.SObjectField externalIDField) {
      return this.repoService.upsertRecords(records, externalIDField, true);
    }

    public List<Database.UpsertResult> upsertRecordsPartially(final List<SObject> records, final Schema.SObjectField externalIDField) {
      return this.repoService.upsertRecords(records, externalIDField, false);
    }

    public List<Database.DeleteResult> deleteRecords(final List<SObject> records) {
      return this.repoService.deleteRecords(records, true);
    }

    public List<Database.DeleteResult> deleteRecordsPartially(final List<SObject> records) {
      return this.repoService.deleteRecords(records, false);
    }

    public List<Database.UndeleteResult> undeleteRecords(final List<SObject> records) {
      return this.repoService.undeleteRecords(records, true);
    }

    public List<Database.UndeleteResult> undeleteRecordsPartially(final List<SObject> records) {
      return this.repoService.undeleteRecords(records, false);
    }

    public List<SObject> query(final String soql, final Map<String, Object> bindMap) {
      return this.repoService.query(soql, bindMap);
    }

    public List<SObject> query(final List<SObject> soql) {
      return this.repoService.query(soql);
    }

    public List<List<SObject>> find(final String sosl) {
      return this.repoService.find(sosl);
    }

    public List<List<SObject>> find(final List<List<SObject>> sosl) {
      return this.repoService.find(soSl);
    }
  }
}
