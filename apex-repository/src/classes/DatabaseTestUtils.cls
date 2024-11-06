@isTest
public class DatabaseTestUtils {
  static Integer identifier = 1;
  public static String getFakeId(Schema.SObjectType sot) {
    String result = String.valueOf(identifier++);
    return sot.getDescribe().getKeyPrefix() + '0'.repeat(12 - result.length()) + result;
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
}
