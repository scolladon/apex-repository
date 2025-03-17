public class AggregateResultProxy {
  private final Map<String, Object> valuesByAlias;
  public AggregateResultProxy(final AggregateResult groupedResult) {
    this(groupedResult.getPopulatedFieldsAsMap());
  }

  @TestVisible
  private AggregateResultProxy(Map<String, Object> valuesByAlias) {
    this.valuesByAlias = valuesByAlias;
  }

  public Object get(final String key) {
    return this.valuesByAlias.get(key);
  }
}
