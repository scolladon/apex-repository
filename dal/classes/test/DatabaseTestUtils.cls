@IsTest
public class DatabaseTestUtils {
  static Integer identifier = 1;
  public static String getFakeId(Schema.SObjectType sot) {
    String result = String.valueOf(identifier++);
    return sot.getDescribe().getKeyPrefix() + '0'.repeat(12 - result.length()) + result;
  }

  public static Object makeData(final Type sobjectType, final Map<String, Object> data) {
    final JSONGenerator generator = JSON.createGenerator(false);
    generator.writeStartObject();
    final List<String> fieldNames = new List<String>(data.keySet());
    // Reverse order mirrors JSON.serialize(Map): order-sensitive platform types (Database.SaveResult lets a later "errors" override an earlier "success") must keep behaving the same
    for (Integer i = fieldNames.size() - 1; i >= 0; --i) {
      final String fieldName = fieldNames[i];
      final Object fieldValue = data.get(fieldName);
      generator.writeFieldName(fieldName);
      if (fieldValue == null) {
        generator.writeNull();
      } else if (fieldValue instanceof List<SObject>) {
        writeChildRelationship(generator, (List<SObject>) fieldValue);
      } else {
        generator.writeObject(fieldValue); // Lookup | Primitive
      }
    }
    generator.writeEndObject();
    return JSON.deserialize(generator.getAsString(), sobjectType);
  }

  // QueryResult wire format, the only shape the SObject deserializer accepts for a child relationship
  private static void writeChildRelationship(final JSONGenerator generator, final List<SObject> children) {
    generator.writeStartObject();
    generator.writeNumberField('totalSize', children.size());
    generator.writeBooleanField('done', true);
    generator.writeFieldName('records');
    generator.writeObject(children);
    generator.writeEndObject();
  }
}
