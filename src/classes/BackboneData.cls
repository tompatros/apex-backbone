public with sharing class BackboneData {

	// this is used to handle an insert  
	@RemoteAction
	public static List<sObject> insertRecords(List<BackboneDataRecord> records) {
		
		List<sObject> inserts = new List<sObject>();
		
		for(BackboneDataRecord d : records) {
			sObject so = Schema.getGlobalDescribe().get(d.sObjectType).newSObject();
			for(String s : d.fields.keySet()) so.put(s, d.fields.get(s));
			inserts.add(so);
		}    
		
		insert inserts;    
		return inserts;   
	}
	
	// handles update
	@RemoteAction
	public static List<sObject> updateRecords(List<BackboneDataRecord> records) {
		
		List<sObject> updates = new List<sObject>();
		
		for(BackboneDataRecord d : records) {
			sObject so = Schema.getGlobalDescribe().get(d.sObjectType).newSObject(d.Id);
			for(String s : d.fields.keySet()) so.put(s, d.fields.get(s));
			updates.add(so);
		}    
		
		update updates;    
		return updates; 
		
	}
	

}