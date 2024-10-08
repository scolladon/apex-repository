@isTest
public class InMemoryRepositoryService implements RepositoryService {
  public List<SObject> mockDatabase { get; private set; }
  public List<List<SObject>> insertCallParameters { get; private set; }
  public List<List<SObject>> updateCallParameters { get; private set; }
  public List<List<SObject>> upsertCallParameters { get; private set; }
  public List<List<SObject>> deleteCallParameters { get; private set; }
  public List<Map<String, Object>> queryCallParameters { get; private set; }
  public List<String> findCallParameters { get; private set; }

  public InMemoryRepositoryService() {
    this.mockDatabase = new List<SObject>();
    this.insertCallParameters = new List<List<SObject>>();
    this.updateCallParameters = new List<List<SObject>>();
    this.upsertCallParameters = new List<List<SObject>>();
    this.deleteCallParameters = new List<List<SObject>>();
    this.queryCallParameters = new List<Map<String, Object>>();

    this.findCallParameters = new List<String>();
  }

  public List<Database.SaveResult> insertRecords(List<SObject> records, Database.DmlOptions options) {
    this.insertCallParameters.add(records.deepClone());

    List<Database.SaveResult> results = new List<Database.SaveResult>();
    for (SObject record : records) {
      record.Id = getFakeId(record.getSObjectType());
      this.mockDatabase.add(record);

      SaveResultBuilder builder = new SaveResultBuilder().withSuccess(true).withId(record.Id);

      results.add(builder.build());
    }
    return results;
  }

  public List<Database.SaveResult> updateRecords(List<SObject> records, Database.DmlOptions options) {
    this.updateCallParameters.add(records);

    List<Database.SaveResult> results = new List<Database.SaveResult>();
    for (SObject record : records) {
      Boolean updated = false;
      for (Integer i = 0; i < this.mockDatabase.size(); i++) {
        if (this.mockDatabase[i].Id == record.Id) {
          this.mockDatabase[i] = record;
          updated = true;
          break;
        }
      }

      SaveResultBuilder builder = new SaveResultBuilder().withSuccess(updated).withId(record.Id);

      results.add(builder.build());
    }
    return results;
  }

  public List<Database.UpsertResult> upsertRecords(List<SObject> records, Schema.SObjectField externalIDField, Boolean allOrNone) {
    this.upsertCallParameters.add(records);

    List<Database.UpsertResult> results = new List<Database.UpsertResult>();
    for (SObject record : records) {
      Boolean created = true;
      for (Integer i = 0; i < mockDatabase.size(); i++) {
        if (this.mockDatabase[i].Id == record.Id) {
          this.mockDatabase[i] = record;
          created = false;
          break;
        }
      }
      if (created) {
        record.Id = getFakeId(record.getSObjectType());
        this.mockDatabase.add(record);
      }

      UpsertResultBuilder builder = new UpsertResultBuilder().withSuccess(true).withCreated(created).withId(record.Id);

      results.add(builder.build());
    }
    return results;
  }

  public List<Database.DeleteResult> deleteRecords(List<SObject> records, Boolean allOrNone) {
    this.deleteCallParameters.add(records);

    List<Database.DeleteResult> results = new List<Database.DeleteResult>();
    for (SObject record : records) {
      Boolean deleted = false;
      for (Integer i = 0; i < this.mockDatabase.size(); i++) {
        if (this.mockDatabase[i].Id == record.Id) {
          this.mockDatabase.remove(i);
          deleted = true;
          break;
        }
      }

      DeleteResultBuilder builder = new DeleteResultBuilder().withSuccess(deleted).withId(record.Id);

      results.add(builder.build());
    }
    return results;
  }

  public List<SObject> query(String soql, Map<String, Object> bindMap) {
    Map<String, Object> callParams = new Map<String, Object>();
    callParams.put('soql', soql);
    callParams.put('bindMap', bindMap);
    this.queryCallParameters.add(callParams);

    return new List<SObject>(this.mockDatabase);
  }

  public List<List<SObject>> find(String sosl) {
    this.findCallParameters.add(sosl);

    return new List<List<SObject>>{ new List<SObject>(this.mockDatabase) };
  }

  public class DeleteResultBuilder {
    private Boolean success;
    private String id;
    private List<Database.Error> errors;

    public DeleteResultBuilder() {
      this.success = true;
      this.errors = new List<Database.Error>();
    }

    public DeleteResultBuilder withSuccess(Boolean success) {
      this.success = success;
      return this;
    }

    public DeleteResultBuilder withId(String id) {
      this.id = id;
      return this;
    }

    public DeleteResultBuilder withErrors(List<Database.Error> errors) {
      this.errors = errors;
      return this;
    }

    public Database.DeleteResult build() {
      String jsonString = '{"success":' + String.valueOf(success) + ',"id":"' + id + '","errors":' + JSON.serialize(errors) + '}';
      return (Database.DeleteResult) JSON.deserialize(jsonString, Database.DeleteResult.class);
    }
  }

  public class UpsertResultBuilder {
    private Boolean success;
    private Boolean created;
    private String id;
    private List<Database.Error> errors;

    public UpsertResultBuilder() {
      this.success = true;
      this.created = false;
      this.errors = new List<Database.Error>();
    }

    public UpsertResultBuilder withSuccess(Boolean success) {
      this.success = success;
      return this;
    }

    public UpsertResultBuilder withCreated(Boolean created) {
      this.created = created;
      return this;
    }

    public UpsertResultBuilder withId(String id) {
      this.id = id;
      return this;
    }

    public UpsertResultBuilder withErrors(List<Database.Error> errors) {
      this.errors = errors;
      return this;
    }

    public Database.UpsertResult build() {
      String jsonString = '{"success":' + String.valueOf(success) + ',"created":' + String.valueOf(created) + ',"id":"' + id + '","errors":' + JSON.serialize(errors) + '}';
      return (Database.UpsertResult) JSON.deserialize(jsonString, Database.UpsertResult.class);
    }
  }

  public class SaveResultBuilder {
    private Boolean success;
    private String id;
    private List<Database.Error> errors;

    public SaveResultBuilder() {
      this.success = true;
      this.errors = new List<Database.Error>();
    }

    public SaveResultBuilder withSuccess(Boolean success) {
      this.success = success;
      return this;
    }

    public SaveResultBuilder withId(String id) {
      this.id = id;
      return this;
    }

    public SaveResultBuilder withErrors(List<Database.Error> errors) {
      this.errors = errors;
      return this;
    }

    public Database.SaveResult build() {
      String jsonString = '{"success":' + String.valueOf(success) + ',"id":"' + id + '","errors":' + JSON.serialize(errors) + '}';
      return (Database.SaveResult) JSON.deserialize(jsonString, Database.SaveResult.class);
    }
  }

  static Integer identifier = 1;
  public static String getFakeId(Schema.SObjectType sot) {
    String result = String.valueOf(identifier++);
    return sot.getDescribe().getKeyPrefix() + '0'.repeat(12 - result.length()) + result;
  }
}
