@isTest
public class InMemoryRepositoryService implements RepositoryService {
  public Map<SObjectType, List<SObject>> mockDatabase { get; private set; }
  public List<List<SObject>> insertCallParameters { get; private set; }
  public List<List<SObject>> updateCallParameters { get; private set; }
  public List<List<SObject>> upsertCallParameters { get; private set; }
  public List<List<SObject>> deleteCallParameters { get; private set; }
  public List<List<SObject>> undeleteCallParameters { get; private set; }
  public List<Map<String, Object>> queryCallParameters { get; private set; }
  public List<String> findCallParameters { get; private set; }

  public InMemoryRepositoryService() {
    this.mockDatabase = new Map<SObjectType, List<SObject>>();
    this.insertCallParameters = new List<List<SObject>>();
    this.updateCallParameters = new List<List<SObject>>();
    this.upsertCallParameters = new List<List<SObject>>();
    this.deleteCallParameters = new List<List<SObject>>();
    this.undeleteCallParameters = new List<List<SObject>>();
    this.queryCallParameters = new List<Map<String, Object>>();

    this.findCallParameters = new List<String>();
  }

  public List<Database.SaveResult> insertRecords(List<SObject> records, Database.DmlOptions options) {
    this.insertCallParameters.add(records.deepClone());

    List<Database.SaveResult> results = new List<Database.SaveResult>();
    for (SObject record : records) {
      SObjectType objectType = record.getSObjectType();
      record.Id = DatabaseTestUtils.getFakeId(objectType);

      if (!this.mockDatabase.containsKey(objectType)) {
        this.mockDatabase.put(objectType, new List<SObject>());
      }
      this.mockDatabase.get(objectType).add(record);

      DatabaseTestUtils.SaveResultBuilder builder = new DatabaseTestUtils.SaveResultBuilder().withSuccess(true).withId(record.Id);

      results.add(builder.build());
    }
    return results;
  }

  public List<Database.SaveResult> updateRecords(List<SObject> records, Database.DmlOptions options) {
    this.updateCallParameters.add(records);

    List<Database.SaveResult> results = new List<Database.SaveResult>();
    for (SObject record : records) {
      SObjectType objectType = record.getSObjectType();
      Boolean updated = false;
      List<SObject> sobjectsForTheType = this.mockDatabase.get(objectType);
      for (Integer i = 0; i < sobjectsForTheType.size(); i++) {
        if (sobjectsForTheType[i].Id == record.Id) {
          sobjectsForTheType[i] = record;
          updated = true;
          break;
        }
      }

      DatabaseTestUtils.SaveResultBuilder builder = new DatabaseTestUtils.SaveResultBuilder().withSuccess(updated).withId(record.Id);

      results.add(builder.build());
    }
    return results;
  }

  public List<Database.UpsertResult> upsertRecords(List<SObject> records, Schema.SObjectField externalIDField, Boolean allOrNone) {
    this.upsertCallParameters.add(records);

    List<Database.UpsertResult> results = new List<Database.UpsertResult>();
    for (SObject record : records) {
      SObjectType objectType = record.getSObjectType();
      Boolean created = false;
      List<SObject> sobjectsForTheType = this.mockDatabase.get(objectType);
      for (Integer i = 0; i < sobjectsForTheType.size(); i++) {
        if (sobjectsForTheType[i].Id == record.Id) {
          sobjectsForTheType[i] = record;
          created = true;
          break;
        }
      }
      if (created) {
        record.Id = DatabaseTestUtils.getFakeId(objectType);
        if (!this.mockDatabase.containsKey(objectType)) {
          this.mockDatabase.put(objectType, new List<SObject>());
        }
        this.mockDatabase.get(objectType).add(record);
      }

      DatabaseTestUtils.UpsertResultBuilder builder = new DatabaseTestUtils.UpsertResultBuilder().withSuccess(true).withCreated(created).withId(record.Id);

      results.add(builder.build());
    }
    return results;
  }

  public List<Database.DeleteResult> deleteRecords(List<SObject> records, Boolean allOrNone) {
    this.deleteCallParameters.add(records);

    List<Database.DeleteResult> results = new List<Database.DeleteResult>();
    for (SObject record : records) {
      SObjectType objectType = record.getSObjectType();
      Boolean deleted = false;
      List<SObject> sobjectsForTheType = this.mockDatabase.get(objectType);
      for (Integer i = 0; i < sobjectsForTheType.size(); i++) {
        if (sobjectsForTheType[i].Id == record.Id) {
          sobjectsForTheType.remove(i);
          deleted = true;
          break;
        }
      }

      DatabaseTestUtils.DeleteResultBuilder builder = new DatabaseTestUtils.DeleteResultBuilder().withSuccess(deleted).withId(record.Id);

      results.add(builder.build());
    }
    return results;
  }

  public List<Database.UndeleteResult> undeleteRecords(List<SObject> records, Boolean allOrNone) {
    this.undeleteCallParameters.add(records);

    List<Database.UndeleteResult> results = new List<Database.UndeleteResult>();
    for (SObject record : records) {
      SObjectType objectType = record.getSObjectType();
      if (!this.mockDatabase.containsKey(objectType)) {
        this.mockDatabase.put(objectType, new List<SObject>());
      }
      this.mockDatabase.get(objectType).add(record);

      DatabaseTestUtils.UndeleteResultBuilder builder = new DatabaseTestUtils.UndeleteResultBuilder().withSuccess(true).withId(record.Id);

      results.add(builder.build());
    }
    return results;
  }

  Pattern SOQL_SOBJECT_PATTERN = Pattern.compile('FROM\\s*(\\w+)\\s');
  public List<SObject> query(String soql, Map<String, Object> bindMap) {
    Map<String, Object> callParams = new Map<String, Object>();
    callParams.put('soql', soql);
    callParams.put('bindMap', bindMap);
    this.queryCallParameters.add(callParams);

    Matcher sobjectMatcher = SOQL_SOBJECT_PATTERN.matcher(soql);
    if (sobjectMatcher.find()) {
      SObjectType objectType = ((SObject) Type.forName(sobjectMatcher.group(1)).newInstance()).getSObjectType();
      return this.mockDatabase.get(objectType);
    }

    return new List<SObject>();
  }

  Pattern SOSL_SOBJECT_PATTERN = Pattern.compile('FROM\\s*(\\w+)\\s');
  public List<List<SObject>> find(String sosl) {
    this.findCallParameters.add(sosl);

    List<String> sobjects = sosl.split('RETURNING ')[1].replaceAll('\\(.*\\)', '').replace(' ', '').split(',');
    List<List<SObject>> result = new List<List<SObject>>();
    for (String sobjectType : sobjects) {
      SObjectType objectType = ((SObject) Type.forName(sobjectType).newInstance()).getSObjectType();
      result.add(this.mockDatabase.get(objectType));
    }

    return result;
  }

  public List<SObject> query(final List<SObject> soql) {
    SObjectType objectType = soql.getSObjectType();
    return this.mockDatabase.get(objectType);
  }

  public List<List<SObject>> find(final List<List<SObject>> sosl) {
    List<List<SObject>> result = new List<List<SObject>>();
    for (List<SObject> subResult : sosl) {
      SObjectType objectType = subResult.getSObjectType();
      result.add(this.mockDatabase.get(objectType));
    }
    return result;
  }
}
