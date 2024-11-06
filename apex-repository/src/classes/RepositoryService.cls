public interface RepositoryService {
  List<Database.SaveResult> insertRecords(List<SObject> records, Database.DmlOptions options);
  List<Database.SaveResult> updateRecords(List<SObject> records, Database.DmlOptions options);
  List<Database.UpsertResult> upsertRecords(List<SObject> records, Schema.SObjectField externalIDField, Boolean allOrNone);
  List<Database.DeleteResult> deleteRecords(List<SObject> records, Boolean allOrNone);
  List<SObject> query(String soql, Map<String, Object> bindMap);
  List<SObject> query(List<SObject> soql);
  List<List<SObject>> find(String sosl);
  List<List<SObject>> find(List<List<SObject>> sosl);
}
