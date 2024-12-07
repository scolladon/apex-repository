public interface IDAL {
  List<Database.SaveResult> insertRecords(List<SObject> records);
  List<Database.SaveResult> insertRecordsPartially(List<SObject> records);
  List<Database.SaveResult> insertRecords(List<SObject> records, Database.DmlOptions options);
  List<Database.SaveResult> updateRecords(List<SObject> records);
  List<Database.SaveResult> updateRecordsPartially(List<SObject> records);
  List<Database.SaveResult> updateRecords(List<SObject> records, Database.DmlOptions options);
  List<Database.UpsertResult> upsertRecords(List<SObject> records, Schema.SObjectField externalIDField);
  List<Database.UpsertResult> upsertRecordsPartially(List<SObject> records, Schema.SObjectField externalIDField);
  List<Database.DeleteResult> deleteRecords(List<SObject> records);
  List<Database.DeleteResult> deleteRecordsPartially(List<SObject> records);
  List<Database.UndeleteResult> undeleteRecords(List<SObject> records);
  List<Database.UndeleteResult> undeleteRecordsPartially(List<SObject> records);
  List<SObject> query(String soql, Map<String, Object> bindMap);
  List<SObject> query(List<SObject> soql);
  List<List<SObject>> find(String sosl);
  List<List<SObject>> find(List<List<SObject>> sosl);
  void setRepositoryService(RepositoryService repoService);
  RepositoryService getRepositoryService();
}
