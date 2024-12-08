public inherited sharing class DAL { // RepositoryService ACL
  public static IDAL repoServiceProxy { get; private set; }
  private static DALMode currentMode;

  static {
    DAL.staticConstructor();
  }

  public enum DALMode {
    DEFAULT_MODE,
    USER_MODE,
    SYSTEM_MODE,
    SYSTEM_WITH_SHARING_MODE
  }

  private static void staticConstructor() {
    DAL.repoServiceProxy = new DALImpl();
    DAL.setDefaultMode();
  }

  public static void setDefaultMode() {
    DAL.setDatabaseAccessMode(DALMode.DEFAULT_MODE);
  }

  public static void setUserMode() {
    DAL.setDatabaseAccessMode(DALMode.USER_MODE);
  }

  public static void setSystemMode() {
    DAL.setDatabaseAccessMode(DALMode.SYSTEM_MODE);
  }

  public static void setSystemWithSharingMode() {
    DAL.setDatabaseAccessMode(DALMode.SYSTEM_WITH_SHARING_MODE);
  }

  private static void setDatabaseAccessMode(final DALMode dalMode) {
    if (DAL.currentMode == dalMode) {
      return;
    }
    DAL.currentMode = dalMode;
    RepositoryService reposervice;
    switch on dalMode {
      when SYSTEM_WITH_SHARING_MODE {
        reposervice = new RepositoryFactory().asSystemWithSharing();
      }
      when SYSTEM_MODE {
        reposervice = new RepositoryFactory().asSystemWithoutSharing();
      }
      when USER_MODE {
        reposervice = new RepositoryFactory().asUser();
      }
      when DEFAULT_MODE, null {
        reposervice = new RepositoryFactory().asSystemWithoutSharing();
      }
    }
    DAL.repoServiceProxy.setRepositoryService(repoService);
  }

  @testVisible
  private static DAL.Stub mock() {
    final DAL.Stub dalMock = new DAL.Stub();
    DAL.repoServiceProxy = dalMock.getRepositoryServiceStub();
    DAL.currentMode = null;
    return dalMock;
  }

  // For integrated test or post/pre processing requiring DataBase
  @testVisible
  private static void unmock() {
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

    public MethodSpy spyOnSetRepositoryService() {
      return this.spyOn('setRepositoryService');
    }

    private MethodSpy spyOn(final String methodName) {
      return this.dalMock.spyOn(methodName);
    }
  }

  public static List<Database.SaveResult> insertRecords(final List<SObject> records) {
    final List<Database.SaveResult> result = DAL.repoServiceProxy.insertRecords(records);
    DAL.setDefaultMode();
    return result;
  }
  public static List<Database.SaveResult> insertRecordsPartially(final List<SObject> records) {
    final List<Database.SaveResult> result = DAL.repoServiceProxy.insertRecordsPartially(records);
    DAL.setDefaultMode();
    return result;
  }
  public static List<Database.SaveResult> insertRecords(final List<SObject> records, final Database.DmlOptions options) {
    final List<Database.SaveResult> result = DAL.repoServiceProxy.insertRecords(records, options);
    DAL.setDefaultMode();
    return result;
  }
  public static List<Database.SaveResult> updateRecords(final List<SObject> records) {
    final List<Database.SaveResult> result = DAL.repoServiceProxy.updateRecords(records);
    DAL.setDefaultMode();
    return result;
  }
  public static List<Database.SaveResult> updateRecordsPartially(final List<SObject> records) {
    final List<Database.SaveResult> result = DAL.repoServiceProxy.updateRecordsPartially(records);
    DAL.setDefaultMode();
    return result;
  }
  public static List<Database.SaveResult> updateRecords(final List<SObject> records, final Database.DmlOptions options) {
    final List<Database.SaveResult> result = DAL.repoServiceProxy.updateRecords(records, options);
    DAL.setDefaultMode();
    return result;
  }
  public static List<Database.UpsertResult> upsertRecords(final List<SObject> records, final Schema.SObjectField externalIDField) {
    final List<Database.UpsertResult> result = DAL.repoServiceProxy.upsertRecords(records, externalIDField);
    DAL.setDefaultMode();
    return result;
  }
  public static List<Database.UpsertResult> upsertRecordsPartially(final List<SObject> records, final Schema.SObjectField externalIDField) {
    final List<Database.UpsertResult> result = DAL.repoServiceProxy.upsertRecordsPartially(records, externalIDField);
    DAL.setDefaultMode();
    return result;
  }
  public static List<Database.DeleteResult> deleteRecords(final List<SObject> records) {
    final List<Database.DeleteResult> result = DAL.repoServiceProxy.deleteRecords(records);
    DAL.setDefaultMode();
    return result;
  }
  public static List<Database.DeleteResult> deleteRecordsPartially(final List<SObject> records) {
    final List<Database.DeleteResult> result = DAL.repoServiceProxy.deleteRecordsPartially(records);
    DAL.setDefaultMode();
    return result;
  }
  public static List<Database.UndeleteResult> undeleteRecords(final List<SObject> records) {
    final List<Database.UndeleteResult> result = DAL.repoServiceProxy.undeleteRecords(records);
    DAL.setDefaultMode();
    return result;
  }
  public static List<Database.UndeleteResult> undeleteRecordsPartially(final List<SObject> records) {
    final List<Database.UndeleteResult> result = DAL.repoServiceProxy.undeleteRecordsPartially(records);
    DAL.setDefaultMode();
    return result;
  }
  public static List<SObject> query(final String soql, final Map<String, Object> bindMap) {
    final List<SObject> result = DAL.repoServiceProxy.query(soql, bindMap);
    DAL.setDefaultMode();
    return result;
  }
  public static List<SObject> query(final List<SObject> soql) {
    final List<SObject> result = DAL.repoServiceProxy.query(soql);
    DAL.setDefaultMode();
    return result;
  }
  public static List<List<SObject>> find(final String sosl) {
    final List<List<SObject>> result = DAL.repoServiceProxy.find(sosl);
    DAL.setDefaultMode();
    return result;
  }
  public static List<List<SObject>> find(final List<List<SObject>> sosl) {
    final List<List<SObject>> result = DAL.repoServiceProxy.find(soSl);
    DAL.setDefaultMode();
    return result;
  }

  public static List<Database.SaveResult> insertRecords(final List<SObject> records, DALMode dalMode) {
    DAL.setDatabaseAccessMode(dalMode);
    return DAL.insertRecords(records);
  }
  public static List<Database.SaveResult> insertRecordsPartially(final List<SObject> records, DALMode dalMode) {
    DAL.setDatabaseAccessMode(dalMode);
    return DAL.insertRecordsPartially(records);
  }
  public static List<Database.SaveResult> insertRecords(final List<SObject> records, final Database.DmlOptions options, DALMode dalMode) {
    DAL.setDatabaseAccessMode(dalMode);
    return DAL.insertRecords(records, options);
  }
  public static List<Database.SaveResult> updateRecords(final List<SObject> records, DALMode dalMode) {
    DAL.setDatabaseAccessMode(dalMode);
    return DAL.updateRecords(records);
  }
  public static List<Database.SaveResult> updateRecordsPartially(final List<SObject> records, DALMode dalMode) {
    DAL.setDatabaseAccessMode(dalMode);
    return DAL.updateRecordsPartially(records);
  }
  public static List<Database.SaveResult> updateRecords(final List<SObject> records, final Database.DmlOptions options, DALMode dalMode) {
    DAL.setDatabaseAccessMode(dalMode);
    return DAL.updateRecords(records, options);
  }
  public static List<Database.UpsertResult> upsertRecords(final List<SObject> records, final Schema.SObjectField externalIDField, DALMode dalMode) {
    DAL.setDatabaseAccessMode(dalMode);
    return DAL.upsertRecords(records, externalIDField);
  }
  public static List<Database.UpsertResult> upsertRecordsPartially(final List<SObject> records, final Schema.SObjectField externalIDField, DALMode dalMode) {
    DAL.setDatabaseAccessMode(dalMode);
    return DAL.upsertRecordsPartially(records, externalIDField);
  }
  public static List<Database.DeleteResult> deleteRecords(final List<SObject> records, DALMode dalMode) {
    DAL.setDatabaseAccessMode(dalMode);
    return DAL.deleteRecords(records);
  }
  public static List<Database.DeleteResult> deleteRecordsPartially(final List<SObject> records, DALMode dalMode) {
    DAL.setDatabaseAccessMode(dalMode);
    return DAL.deleteRecordsPartially(records);
  }
  public static List<Database.UndeleteResult> undeleteRecords(final List<SObject> records, DALMode dalMode) {
    DAL.setDatabaseAccessMode(dalMode);
    return DAL.undeleteRecords(records);
  }
  public static List<Database.UndeleteResult> undeleteRecordsPartially(final List<SObject> records, DALMode dalMode) {
    DAL.setDatabaseAccessMode(dalMode);
    return DAL.undeleteRecordsPartially(records);
  }
  public static List<SObject> query(final String soql, final Map<String, Object> bindMap, DALMode dalMode) {
    DAL.setDatabaseAccessMode(dalMode);
    return DAL.query(soql, bindMap);
  }
  public static List<SObject> query(final List<SObject> soql, DALMode dalMode) {
    DAL.setDatabaseAccessMode(dalMode);
    return DAL.query(soql);
  }
  public static List<List<SObject>> find(final String sosl, DALMode dalMode) {
    DAL.setDatabaseAccessMode(dalMode);
    return DAL.find(sosl);
  }
  public static List<List<SObject>> find(final List<List<SObject>> sosl, DALMode dalMode) {
    DAL.setDatabaseAccessMode(dalMode);
    return DAL.find(sosl);
  }

  private inherited sharing class DALImpl implements IDAL {
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
