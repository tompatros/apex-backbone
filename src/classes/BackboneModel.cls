public with sharing class BackboneModel {
		
	public String name { get; set; }
	public String cleanedName {
		get {
			return name.replace('__c', '');
		}
	}
	public Set<String> fields { get; set; }
	public String fieldsJSON {
		get {
			return JSON.serialize(this.fields);
		}
	}
	public Map<String, String> defaults { get; set; }
	public String defaultsJSON {
		get {
			return JSON.serialize(this.defaults);
		}
	}
	public Map<String, String> children { get; set; }
	
	public BackboneModel() {
		defaults = new Map<String, String>();
		children = new Map<String, String>();
		fields = new Set<String>();
	}

}