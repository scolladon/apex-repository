@IsTest
public class Fabricator {
  private static final Integer ID_NUMERIC_LENGTH = 12;
  private static final Map<Schema.SObjectType, String> keyPrefixes = new Map<Schema.SObjectType, String>();
  private static Integer identifier = 0;

  public static Id nextId(final Schema.SObjectType sot) {
    String keyPrefix = keyPrefixes.get(sot);
    if (keyPrefix == null) {
      keyPrefix = describeKeyPrefix(sot);
      keyPrefixes.put(sot, keyPrefix);
    }
    return Id.valueOf(keyPrefix + String.valueOf(++identifier).leftPad(ID_NUMERIC_LENGTH, '0'));
  }

  private static String describeKeyPrefix(final Schema.SObjectType sot) {
    final String keyPrefix = sot.getDescribe(SObjectDescribeOptions.DEFERRED).getKeyPrefix();
    if (keyPrefix == null) {
      throw new IllegalArgumentException(sot + ' has no key prefix, no Id can be forged for it');
    }
    return keyPrefix;
  }

  public static Object make(final Type targetType, final Map<String, Object> data) {
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
    return JSON.deserialize(generator.getAsString(), targetType);
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
