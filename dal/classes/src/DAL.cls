public inherited sharing class DAL { // RepositoryService ACL
  public static IDAL instance { get; private set; }

  static {
    DAL.staticConstructor();
  }

  private static void staticConstructor() {
    DAL.instance = new DALImpl();
  }

  @TestVisible
  private static DAL.Stub mock() {
    final DAL.Stub dalMock = new DAL.Stub();
    DAL.instance = dalMock.getStub();
    return dalMock;
  }

  // For integrated test or post/pre processing requiring DataBase
  @TestVisible
  private static void unmock() {
    DAL.staticConstructor();
  }

  @TestVisible
  private class InsertMock implements MethodSpy.SpyBehavior {
    public Object execute(final List<Object> params) {
      for (SObject sob : (List<SObject>) params[0]) {
        sob.Id = DatabaseTestUtils.getFakeId(sob.getSObjectType());
      }
      return null;
    }
  }

  // DML Mocking by mockId (similar to SOQL.mockId)
  private static Map<String, DmlMock> dmlIdToMock = new Map<String, DmlMock>();

  @TestVisible
  private static DmlMockable mock(String mockId) {
    final DmlMock dmlMock = new DmlMock();
    DAL.dmlIdToMock.put(mockId, dmlMock);
    return dmlMock;
  }

  // Query/Find Mocking by mockId (similar to SOQL.mockId)
  private static Map<String, QueryMock> queryIdToMock = new Map<String, QueryMock>();

  @TestVisible
  private static QueryMockable mockQuery(String mockId) {
    final QueryMock queryMock = new QueryMock();
    DAL.queryIdToMock.put(mockId, queryMock);
    return queryMock;
  }

  @TestVisible
  private interface QueryMockable {
    QueryMockable thenReturn(List<SObject> records);
    QueryMockable thenReturn(Integer count);
    QueryMockable thenReturnAggregateProxy(List<AggregateResultProxy> aggregateResultProxies);
    QueryMockable thenReturnSearch(List<List<SObject>> searchResults);
    void throwException();
    void throwException(String message);
  }

  @TestVisible
  private class QueryMock implements QueryMockable {
    private List<SObject> mockedRecords;
    private Integer mockedCount;
    private List<AggregateResultProxy> mockedAggregateProxies;
    private List<List<SObject>> mockedSearchResults;
    private QueryException mockException;

    public QueryMockable thenReturn(List<SObject> records) {
      this.mockedRecords = records;
      return this;
    }

    public QueryMockable thenReturn(Integer count) {
      this.mockedCount = count;
      return this;
    }

    public QueryMockable thenReturnAggregateProxy(List<AggregateResultProxy> aggregateResultProxies) {
      this.mockedAggregateProxies = aggregateResultProxies;
      return this;
    }

    public QueryMockable thenReturnSearch(List<List<SObject>> searchResults) {
      this.mockedSearchResults = searchResults;
      return this;
    }

    public void throwException() {
      this.throwException('Query mock exception');
    }

    public void throwException(String message) {
      this.mockException = new QueryException(message);
    }

    public List<SObject> getRecords() {
      if (this.mockException != null) {
        throw this.mockException;
      }
      return this.mockedRecords != null ? this.mockedRecords : new List<SObject>();
    }

    public Integer getCount() {
      if (this.mockException != null) {
        throw this.mockException;
      }
      return this.mockedCount != null ? this.mockedCount : 0;
    }

    public List<AggregateResultProxy> getAggregateProxies() {
      if (this.mockException != null) {
        throw this.mockException;
      }
      return this.mockedAggregateProxies != null ? this.mockedAggregateProxies : new List<AggregateResultProxy>();
    }

    public List<List<SObject>> getSearchResults() {
      if (this.mockException != null) {
        throw this.mockException;
      }
      return this.mockedSearchResults != null ? this.mockedSearchResults : new List<List<SObject>>();
    }
  }

  @TestVisible
  private interface DmlMockable {
    void throwException();
    void throwException(String message);
  }

  @TestVisible
  private class DmlMock implements DmlMockable {
    private DmlException mockException;

    public void throwException() {
      this.throwException('DML mock exception');
    }

    public void throwException(String message) {
      this.mockException = new DmlException();
      this.mockException.setMessage(message);
    }

    public Boolean hasException() {
      return this.mockException != null;
    }

    public void execute(final List<SObject> records, final Boolean assignIds) {
      if (this.hasException()) {
        throw this.mockException;
      }
      if (assignIds) {
        for (SObject sob : records) {
          if (sob.Id == null) {
            sob.Id = DatabaseTestUtils.getFakeId(sob.getSObjectType());
          }
        }
      }
    }
  }

  @TestVisible
  private class Stub { // Mocking library ACL
    private final Mock dalMock;

    public Stub() {
      this.dalMock = Mock.forType(IDAL.class);
    }

    private IDAL getStub() {
      return (IDAL) this.dalMock.stub;
    }

    public MethodSpy spyOnInsert() {
      final MethodSpy insertSpy = this.spyOn('insertRecords');
      insertSpy.behaves(new InsertMock());
      return insertSpy;
    }

    public MethodSpy spyOnInsertPartially() {
      final MethodSpy insertPartiallySpy = this.spyOn('insertRecordsPartially');
      insertPartiallySpy.behaves(new InsertMock());
      return insertPartiallySpy;
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

    public MethodSpy spyOnQueryAggregate() {
      return this.spyOn('queryAggregate');
    }

    public MethodSpy spyOnQueryCount() {
      return this.spyOn('queryCount');
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
  public static List<Database.UpsertResult> upsertRecords(final List<SObject> records) {
    return DAL.instance.upsertRecords(records);
  }
  public static List<Database.UpsertResult> upsertRecordsPartially(final List<SObject> records) {
    return DAL.instance.upsertRecordsPartially(records);
  }
  public static List<Database.UpsertResult> upsertRecords(final List<SObject> records, final AccessLevel accessLevel) {
    return DAL.instance.upsertRecords(records, accessLevel);
  }
  public static List<Database.UpsertResult> upsertRecordsPartially(final List<SObject> records, final AccessLevel accessLevel) {
    return DAL.instance.upsertRecordsPartially(records, accessLevel);
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
  public static List<AggregateResultProxy> queryAggregate(final List<AggregateResult> aggregateResults) {
    return DAL.instance.queryAggregate(aggregateResults);
  }
  public static Integer queryCount(final Integer count) {
    return DAL.instance.queryCount(count);
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

  // DML methods with mockId support (similar to SOQL.mockId)
  // Insert with mockId
  public static List<Database.SaveResult> insertRecords(final List<SObject> records, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, true);
      return null;
    }
    return DAL.instance.insertRecords(records);
  }
  public static List<Database.SaveResult> insertRecordsPartially(final List<SObject> records, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, true);
      return null;
    }
    return DAL.instance.insertRecordsPartially(records);
  }
  public static List<Database.SaveResult> insertRecords(final List<SObject> records, final Database.DmlOptions options, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, true);
      return null;
    }
    return DAL.instance.insertRecords(records, options);
  }
  public static List<Database.SaveResult> insertRecords(final List<SObject> records, AccessLevel accessLevel, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, true);
      return null;
    }
    return DAL.instance.insertRecords(records, accessLevel);
  }
  public static List<Database.SaveResult> insertRecordsPartially(final List<SObject> records, AccessLevel accessLevel, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, true);
      return null;
    }
    return DAL.instance.insertRecordsPartially(records, accessLevel);
  }
  public static List<Database.SaveResult> insertRecords(final List<SObject> records, final Database.DmlOptions options, AccessLevel accessLevel, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, true);
      return null;
    }
    return DAL.instance.insertRecords(records, options, accessLevel);
  }
  // Update with mockId
  public static List<Database.SaveResult> updateRecords(final List<SObject> records, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, false);
      return null;
    }
    return DAL.instance.updateRecords(records);
  }
  public static List<Database.SaveResult> updateRecordsPartially(final List<SObject> records, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, false);
      return null;
    }
    return DAL.instance.updateRecordsPartially(records);
  }
  public static List<Database.SaveResult> updateRecords(final List<SObject> records, final Database.DmlOptions options, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, false);
      return null;
    }
    return DAL.instance.updateRecords(records, options);
  }
  public static List<Database.SaveResult> updateRecords(final List<SObject> records, AccessLevel accessLevel, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, false);
      return null;
    }
    return DAL.instance.updateRecords(records, accessLevel);
  }
  public static List<Database.SaveResult> updateRecordsPartially(final List<SObject> records, AccessLevel accessLevel, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, false);
      return null;
    }
    return DAL.instance.updateRecordsPartially(records, accessLevel);
  }
  public static List<Database.SaveResult> updateRecords(final List<SObject> records, final Database.DmlOptions options, AccessLevel accessLevel, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, false);
      return null;
    }
    return DAL.instance.updateRecords(records, options, accessLevel);
  }
  // Upsert with mockId
  public static List<Database.UpsertResult> upsertRecords(final List<SObject> records, final Schema.SObjectField externalIDField, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, true);
      return null;
    }
    return DAL.instance.upsertRecords(records, externalIDField);
  }
  public static List<Database.UpsertResult> upsertRecordsPartially(final List<SObject> records, final Schema.SObjectField externalIDField, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, true);
      return null;
    }
    return DAL.instance.upsertRecordsPartially(records, externalIDField);
  }
  public static List<Database.UpsertResult> upsertRecords(final List<SObject> records, final Schema.SObjectField externalIDField, AccessLevel accessLevel, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, true);
      return null;
    }
    return DAL.instance.upsertRecords(records, externalIDField, accessLevel);
  }
  public static List<Database.UpsertResult> upsertRecordsPartially(final List<SObject> records, final Schema.SObjectField externalIDField, AccessLevel accessLevel, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, true);
      return null;
    }
    return DAL.instance.upsertRecordsPartially(records, externalIDField, accessLevel);
  }
  public static List<Database.UpsertResult> upsertRecords(final List<SObject> records, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, true);
      return null;
    }
    return DAL.instance.upsertRecords(records);
  }
  public static List<Database.UpsertResult> upsertRecordsPartially(final List<SObject> records, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, true);
      return null;
    }
    return DAL.instance.upsertRecordsPartially(records);
  }
  public static List<Database.UpsertResult> upsertRecords(final List<SObject> records, final AccessLevel accessLevel, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, true);
      return null;
    }
    return DAL.instance.upsertRecords(records, accessLevel);
  }
  public static List<Database.UpsertResult> upsertRecordsPartially(final List<SObject> records, final AccessLevel accessLevel, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, true);
      return null;
    }
    return DAL.instance.upsertRecordsPartially(records, accessLevel);
  }
  // Delete with mockId
  public static List<Database.DeleteResult> deleteRecords(final List<SObject> records, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, false);
      return null;
    }
    return DAL.instance.deleteRecords(records);
  }
  public static List<Database.DeleteResult> deleteRecordsPartially(final List<SObject> records, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, false);
      return null;
    }
    return DAL.instance.deleteRecordsPartially(records);
  }
  public static List<Database.DeleteResult> deleteRecords(final List<SObject> records, AccessLevel accessLevel, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, false);
      return null;
    }
    return DAL.instance.deleteRecords(records, accessLevel);
  }
  public static List<Database.DeleteResult> deleteRecordsPartially(final List<SObject> records, AccessLevel accessLevel, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, false);
      return null;
    }
    return DAL.instance.deleteRecordsPartially(records, accessLevel);
  }
  // Undelete with mockId
  public static List<Database.UndeleteResult> undeleteRecords(final List<SObject> records, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, false);
      return null;
    }
    return DAL.instance.undeleteRecords(records);
  }
  public static List<Database.UndeleteResult> undeleteRecordsPartially(final List<SObject> records, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, false);
      return null;
    }
    return DAL.instance.undeleteRecordsPartially(records);
  }
  public static List<Database.UndeleteResult> undeleteRecords(final List<SObject> records, AccessLevel accessLevel, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, false);
      return null;
    }
    return DAL.instance.undeleteRecords(records, accessLevel);
  }
  public static List<Database.UndeleteResult> undeleteRecordsPartially(final List<SObject> records, AccessLevel accessLevel, final String mockId) {
    if (DAL.dmlIdToMock.containsKey(mockId)) {
      DAL.dmlIdToMock.get(mockId).execute(records, false);
      return null;
    }
    return DAL.instance.undeleteRecordsPartially(records, accessLevel);
  }

  // Query/Find methods with mockId support (similar to SOQL.mockId)
  // Query with mockId
  public static List<SObject> query(final String soql, final Map<String, Object> bindMap, final String mockId) {
    if (DAL.queryIdToMock.containsKey(mockId)) {
      return DAL.queryIdToMock.get(mockId).getRecords();
    }
    return DAL.instance.query(soql, bindMap);
  }
  public static List<SObject> query(final String soql, final Map<String, Object> bindMap, AccessLevel accessLevel, final String mockId) {
    if (DAL.queryIdToMock.containsKey(mockId)) {
      return DAL.queryIdToMock.get(mockId).getRecords();
    }
    return DAL.instance.query(soql, bindMap, accessLevel);
  }
  public static List<SObject> query(final List<SObject> soql, final String mockId) {
    if (DAL.queryIdToMock.containsKey(mockId)) {
      return DAL.queryIdToMock.get(mockId).getRecords();
    }
    return DAL.instance.query(soql);
  }
  // QueryAggregate with mockId
  public static List<AggregateResultProxy> queryAggregate(final List<AggregateResult> aggregateResults, final String mockId) {
    if (DAL.queryIdToMock.containsKey(mockId)) {
      return DAL.queryIdToMock.get(mockId).getAggregateProxies();
    }
    return DAL.instance.queryAggregate(aggregateResults);
  }
  // QueryCount with mockId
  public static Integer queryCount(final Integer count, final String mockId) {
    if (DAL.queryIdToMock.containsKey(mockId)) {
      return DAL.queryIdToMock.get(mockId).getCount();
    }
    return DAL.instance.queryCount(count);
  }
  // Find with mockId
  public static List<List<SObject>> find(final String sosl, final String mockId) {
    if (DAL.queryIdToMock.containsKey(mockId)) {
      return DAL.queryIdToMock.get(mockId).getSearchResults();
    }
    return DAL.instance.find(sosl);
  }
  public static List<List<SObject>> find(final String sosl, AccessLevel accessLevel, final String mockId) {
    if (DAL.queryIdToMock.containsKey(mockId)) {
      return DAL.queryIdToMock.get(mockId).getSearchResults();
    }
    return DAL.instance.find(sosl, accessLevel);
  }
  public static List<List<SObject>> find(final List<List<SObject>> sosl, final String mockId) {
    if (DAL.queryIdToMock.containsKey(mockId)) {
      return DAL.queryIdToMock.get(mockId).getSearchResults();
    }
    return DAL.instance.find(sosl);
  }

  private inherited sharing class DALImpl implements IDAL {
    // Note: here, no Database.DmlOptions is given, so it creates a new instance of it, but the attributes there gets null value, so it behaves as a partial DML since OptAllOrNone is null, as if it was false.
    // The following alternatives are also valid to enforce allOrNone behavior:
    //   return Database.insert(records, true);                  // explicit allOrNone = true
    //   final Database.DmlOptions options = new Database.DmlOptions();
    //   options.OptAllOrNone = true;
    //   return Database.insert(records, options);               // explicit DmlOptions with OptAllOrNone = true
    // But the simplest form already defaults to allOrNone = true
    public List<Database.SaveResult> insertRecords(final List<SObject> records) {
      return Database.insert(records);
    }

    public List<Database.SaveResult> insertRecordsPartially(final List<SObject> records) {
      final Database.DmlOptions options = new Database.DmlOptions();
      // Note: this is not needed, since leaving it as null would behave as false, but for clarity of the intention of the method, it's being set explicitly
      options.OptAllOrNone = false;
      return Database.insert(records, options);
    }

    public List<Database.SaveResult> insertRecords(final List<SObject> records, final Database.DmlOptions options) {
      return Database.insert(records, options);
    }

    // Note: here, no Database.DmlOptions is given, so it creates a new instance of it, but the attributes there gets null value, so it behaves as a partial DML since OptAllOrNone is null, as if it was false.
    public List<Database.SaveResult> insertRecords(final List<SObject> records, AccessLevel accessLevel) {
      return Database.insert(records, accessLevel);
    }

    public List<Database.SaveResult> insertRecordsPartially(final List<SObject> records, AccessLevel accessLevel) {
      final Database.DmlOptions options = new Database.DmlOptions();
      // Note: this is not needed, since leaving it as null would behave as false, but for clarity of the intention of the method, it's being set explicitly
      options.OptAllOrNone = false;
      return Database.insert(records, options, accessLevel);
    }

    public List<Database.SaveResult> insertRecords(final List<SObject> records, final Database.DmlOptions options, AccessLevel accessLevel) {
      return Database.insert(records, options, accessLevel);
    }

    // Note: here, no Database.DmlOptions is given, so it creates a new instance of it, but the attributes there gets null value, so it behaves as a partial DML since OptAllOrNone is null, as if it was false.
    public List<Database.SaveResult> updateRecords(final List<SObject> records) {
      return Database.update(records);
    }

    public List<Database.SaveResult> updateRecordsPartially(final List<SObject> records) {
      final Database.DmlOptions options = new Database.DmlOptions();
      // Note: this is not needed, since leaving it as null would behave as false, but for clarity of the intention of the method, it's being set explicitly
      options.OptAllOrNone = false;
      return Database.update(records, options);
    }

    public List<Database.SaveResult> updateRecords(final List<SObject> records, final Database.DmlOptions options) {
      return Database.update(records, options);
    }

    // Note: here, no Database.DmlOptions is given, so it creates a new instance of it, but the attributes there gets null value, so it behaves as a partial DML since OptAllOrNone is null, as if it was false.
    public List<Database.SaveResult> updateRecords(final List<SObject> records, AccessLevel accessLevel) {
      return Database.update(records, accessLevel);
    }

    public List<Database.SaveResult> updateRecordsPartially(final List<SObject> records, AccessLevel accessLevel) {
      final Database.DmlOptions options = new Database.DmlOptions();
      // Note: this is not needed, since leaving it as null would behave as false, but for clarity of the intention of the method, it's being set explicitly
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

    public List<Database.UpsertResult> upsertRecords(final List<SObject> records) {
      return Database.upsert(records, true);
    }

    public List<Database.UpsertResult> upsertRecordsPartially(final List<SObject> records) {
      return Database.upsert(records, false);
    }

    public List<Database.UpsertResult> upsertRecords(final List<SObject> records, final AccessLevel accessLevel) {
      return Database.upsert(records, true, accessLevel);
    }

    public List<Database.UpsertResult> upsertRecordsPartially(final List<SObject> records, final AccessLevel accessLevel) {
      return Database.upsert(records, false, accessLevel);
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
      return Database.queryWithBinds(String.escapeSingleQuotes(soql), bindMap, AccessLevel.SYSTEM_MODE);
    }

    public List<SObject> query(final String soql, final Map<String, Object> bindMap, AccessLevel accessLevel) {
      return Database.queryWithBinds(String.escapeSingleQuotes(soql), bindMap, accessLevel);
    }

    public List<SObject> query(final List<SObject> soql) {
      return soql;
    }

    public List<AggregateResultProxy> queryAggregate(final List<AggregateResult> aggregateResults) {
      AggregateResultProxy[] aggregateResultProxies = new List<AggregateResultProxy>();
      for (AggregateResult aggregateResult : aggregateResults) {
        aggregateResultProxies.add(new AggregateResultProxy(aggregateResult));
      }
      return aggregateResultProxies;
    }

    public Integer queryCount(final Integer count) {
      return count;
    }

    public List<List<SObject>> find(final String sosl) {
      return Search.query(String.escapeSingleQuotes(sosl));
    }

    public List<List<SObject>> find(final String sosl, AccessLevel accessLevel) {
      return Search.query(String.escapeSingleQuotes(sosl), accessLevel);
    }

    public List<List<SObject>> find(final List<List<SObject>> sosl) {
      return sosl;
    }
  }
}
