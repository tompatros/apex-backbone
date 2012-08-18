public with sharing class BackboneDataRecord {
	public Id id { get; set; }
	public String sObjectType { get; set; }
	public Map<String, Object> fields { get; set; }
}