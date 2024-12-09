public inherited sharing class DAL { // RepositoryService ACL
  public static IDAL instance { get; private set; }

  static {
    DAL.staticConstructor();
  }

  private static void staticConstructor() {
    DAL.instance = new DALImpl();
  }

  @testVisible
  private static DAL.Stub mock() {
    final DAL.Stub dalMock = new DAL.Stub();
    DAL.instance = dalMock.getStub();
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

    private IDAL getStub() {
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
    return DAL.instance.insertRecords(records);
  }
  public static List<Database.SaveResult> insertRecordsPartially(final List<SObject> records) {
    return DAL.instance.insertRecordsPartially(records);
  }
  public static List<Database.SaveResult> insertRecords(final List<SObject> records, final Database.DmlOptions options) {
    return DAL.instance.insertRecords(records, options);
  }
  public static List<Database.SaveResult> insertRecords(final List<SObject> records, AccessLevel accessLevel) {
    return DAL.instance.insertRecords(records, accessLevel);
  }
  public static List<Database.SaveResult> insertRecordsPartially(final List<SObject> records, AccessLevel accessLevel) {
    return DAL.instance.insertRecordsPartially(records, accessLevel);
  }
  public static List<Database.SaveResult> insertRecords(final List<SObject> records, final Database.DmlOptions options, AccessLevel accessLevel) {
    return DAL.instance.insertRecords(records, options, accessLevel);
  }
  public static List<Database.SaveResult> updateRecords(final List<SObject> records) {
    return DAL.instance.updateRecords(records);
  }
  public static List<Database.SaveResult> updateRecordsPartially(final List<SObject> records) {
    return DAL.instance.updateRecordsPartially(records);
  }
  public static List<Database.SaveResult> updateRecords(final List<SObject> records, final Database.DmlOptions options) {
    return DAL.instance.updateRecords(records, options);
  }
  public static List<Database.SaveResult> updateRecords(final List<SObject> records, AccessLevel accessLevel) {
    return DAL.instance.updateRecords(records, accessLevel);
  }
  public static List<Database.SaveResult> updateRecordsPartially(final List<SObject> records, AccessLevel accessLevel) {
    return DAL.instance.updateRecordsPartially(records, accessLevel);
  }
  public static List<Database.SaveResult> updateRecords(final List<SObject> records, final Database.DmlOptions options, AccessLevel accessLevel) {
    return DAL.instance.updateRecords(records, options, accessLevel);
  }
  public static List<Database.UpsertResult> upsertRecords(final List<SObject> records, final Schema.SObjectField externalIDField) {
    return DAL.instance.upsertRecords(records, externalIDField);
  }
  public static List<Database.UpsertResult> upsertRecordsPartially(final List<SObject> records, final Schema.SObjectField externalIDField) {
    return DAL.instance.upsertRecordsPartially(records, externalIDField);
  }
  public static List<Database.UpsertResult> upsertRecords(final List<SObject> records, final Schema.SObjectField externalIDField, AccessLevel accessLevel) {
    return DAL.instance.upsertRecords(records, externalIDField, accessLevel);
  }
  public static List<Database.UpsertResult> upsertRecordsPartially(final List<SObject> records, final Schema.SObjectField externalIDField, AccessLevel accessLevel) {
    return DAL.instance.upsertRecordsPartially(records, externalIDField, accessLevel);
  }
  public static List<Database.DeleteResult> deleteRecords(final List<SObject> records) {
    return DAL.instance.deleteRecords(records);
  }
  public static List<Database.DeleteResult> deleteRecordsPartially(final List<SObject> records) {
    return DAL.instance.deleteRecordsPartially(records);
  }
  public static List<Database.DeleteResult> deleteRecords(final List<SObject> records, AccessLevel accessLevel) {
    return DAL.instance.deleteRecords(records, accessLevel);
  }
  public static List<Database.DeleteResult> deleteRecordsPartially(final List<SObject> records, AccessLevel accessLevel) {
    return DAL.instance.deleteRecordsPartially(records, accessLevel);
  }
  public static List<Database.UndeleteResult> undeleteRecords(final List<SObject> records) {
    return DAL.instance.undeleteRecords(records);
  }
  public static List<Database.UndeleteResult> undeleteRecordsPartially(final List<SObject> records) {
    return DAL.instance.undeleteRecordsPartially(records);
  }
  public static List<Database.UndeleteResult> undeleteRecords(final List<SObject> records, AccessLevel accessLevel) {
    return DAL.instance.undeleteRecords(records, accessLevel);
  }
  public static List<Database.UndeleteResult> undeleteRecordsPartially(final List<SObject> records, AccessLevel accessLevel) {
    return DAL.instance.undeleteRecordsPartially(records, accessLevel);
  }
  public static List<SObject> query(final String soql, final Map<String, Object> bindMap) {
    return DAL.instance.query(soql, bindMap);
  }
  public static List<SObject> query(final String soql, final Map<String, Object> bindMap, AccessLevel accessLevel) {
    return DAL.instance.query(soql, bindMap, accessLevel);
  }
  public static List<SObject> query(final List<SObject> soql) {
    return DAL.instance.query(soql);
  }
  public static List<List<SObject>> find(final String sosl) {
    return DAL.instance.find(sosl);
  }
  public static List<List<SObject>> find(final String sosl, AccessLevel accessLevel) {
    return DAL.instance.find(sosl, accessLevel);
  }
  public static List<List<SObject>> find(final List<List<SObject>> sosl) {
    return DAL.instance.find(soSl);
  }

  private inherited sharing class DALImpl implements IDAL {
    public List<Database.SaveResult> insertRecords(final List<SObject> records) {
      return Database.insert(records, new Database.DmlOptions());
    }

    public List<Database.SaveResult> insertRecordsPartially(final List<SObject> records) {
      final Database.DmlOptions options = new Database.DmlOptions();
      options.OptAllOrNone = false;
      return Database.insert(records, options);
    }

    public List<Database.SaveResult> insertRecords(final List<SObject> records, final Database.DmlOptions options) {
      return Database.insert(records, options);
    }

    public List<Database.SaveResult> insertRecords(final List<SObject> records, AccessLevel accessLevel) {
      return Database.insert(records, new Database.DmlOptions(), accessLevel);
    }

    public List<Database.SaveResult> insertRecordsPartially(final List<SObject> records, AccessLevel accessLevel) {
      final Database.DmlOptions options = new Database.DmlOptions();
      options.OptAllOrNone = false;
      return Database.insert(records, options, accessLevel);
    }

    public List<Database.SaveResult> insertRecords(final List<SObject> records, final Database.DmlOptions options, AccessLevel accessLevel) {
      return Database.insert(records, options, accessLevel);
    }

    public List<Database.SaveResult> updateRecords(final List<SObject> records) {
      return Database.update(records, new Database.DmlOptions());
    }

    public List<Database.SaveResult> updateRecordsPartially(final List<SObject> records) {
      final Database.DmlOptions options = new Database.DmlOptions();
      options.OptAllOrNone = false;
      return Database.update(records, options);
    }

    public List<Database.SaveResult> updateRecords(final List<SObject> records, final Database.DmlOptions options) {
      return Database.update(records, options);
    }

    public List<Database.SaveResult> updateRecords(final List<SObject> records, AccessLevel accessLevel) {
      return Database.update(records, new Database.DmlOptions(), accessLevel);
    }

    public List<Database.SaveResult> updateRecordsPartially(final List<SObject> records, AccessLevel accessLevel) {
      final Database.DmlOptions options = new Database.DmlOptions();
      options.OptAllOrNone = false;
      return Database.update(records, options, accessLevel);
    }

    public List<Database.SaveResult> updateRecords(final List<SObject> records, final Database.DmlOptions options, AccessLevel accessLevel) {
      return Database.update(records, options, accessLevel);
    }

    public List<Database.UpsertResult> upsertRecords(final List<SObject> records, final Schema.SObjectField externalIDField) {
      return Database.upsert(records, externalIDField, true);
    }

    public List<Database.UpsertResult> upsertRecordsPartially(final List<SObject> records, final Schema.SObjectField externalIDField) {
      return Database.upsert(records, externalIDField, false);
    }

    public List<Database.UpsertResult> upsertRecords(final List<SObject> records, final Schema.SObjectField externalIDField, AccessLevel accessLevel) {
      return Database.upsert(records, externalIDField, true, accessLevel);
    }

    public List<Database.UpsertResult> upsertRecordsPartially(final List<SObject> records, final Schema.SObjectField externalIDField, AccessLevel accessLevel) {
      return Database.upsert(records, externalIDField, false, accessLevel);
    }

    public List<Database.DeleteResult> deleteRecords(final List<SObject> records) {
      return Database.delete(records, true);
    }

    public List<Database.DeleteResult> deleteRecordsPartially(final List<SObject> records) {
      return Database.delete(records, false);
    }

    public List<Database.DeleteResult> deleteRecords(final List<SObject> records, AccessLevel accessLevel) {
      return Database.delete(records, true, accessLevel);
    }

    public List<Database.DeleteResult> deleteRecordsPartially(final List<SObject> records, AccessLevel accessLevel) {
      return Database.delete(records, false, accessLevel);
    }

    public List<Database.UndeleteResult> undeleteRecords(final List<SObject> records) {
      return Database.undelete(records, true);
    }

    public List<Database.UndeleteResult> undeleteRecordsPartially(final List<SObject> records) {
      return Database.undelete(records, false);
    }

    public List<Database.UndeleteResult> undeleteRecords(final List<SObject> records, AccessLevel accessLevel) {
      return Database.undelete(records, true, accessLevel);
    }

    public List<Database.UndeleteResult> undeleteRecordsPartially(final List<SObject> records, AccessLevel accessLevel) {
      return Database.undelete(records, false, accessLevel);
    }

    public List<SObject> query(final String soql, final Map<String, Object> bindMap) {
      return Database.queryWithBinds(soql, bindMap, AccessLevel.SYSTEM_MODE);
    }

    public List<SObject> query(final String soql, final Map<String, Object> bindMap, AccessLevel accessLevel) {
      return Database.queryWithBinds(soql, bindMap, accessLevel);
    }

    public List<SObject> query(final List<SObject> soql) {
      return soql;
    }

    public List<List<SObject>> find(final String sosl) {
      return Search.query(sosl);
    }

    public List<List<SObject>> find(final String sosl, AccessLevel accessLevel) {
      return Search.query(sosl, accessLevel);
    }

    public List<List<SObject>> find(final List<List<SObject>> sosl) {
      return sosl;
    }
  }
}
