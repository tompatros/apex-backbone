public with sharing class BackboneModelController {

	public String types {
		get {
			if(!ApexPages.currentPage().getParameters().containsKey('types')) return 'sObject';
			return ApexPages.currentPage().getParameters().get('types');
		}
		set;
	}
	
	public List<BackboneModel> models {
		get {
			if(models == null) {
				
				if(types == 'sObject') return null;
				
				List<String> typesList = types.split(',');
				
				models = new List<BackboneModel>();
				
				for(String s : typesList) {
					
					if(!Schema.getGlobalDescribe().containsKey(s)) continue;
					
					Schema.DescribeSObjectResult r = Schema.getGlobalDescribe().get(s).getDescribe();
					
					BackboneModel m = new BackboneModel();
					m.name = r.getName();
					
					for(Schema.sObjectField f : r.fields.getMap().values()) {
						m.fields.add(f.getDescribe().getName());
						if(f.getDescribe().getDefaultValueFormula() == null) continue;
						
						// TODO: handle more string-ish types
						if(f.getDescribe().getType().name() == 'String') m.defaults.put(f.getDescribe().getName(), '\'' + (String)f.getDescribe().getDefaultValueFormula() + '\'');
						else m.defaults.put(f.getDescribe().getName(), (String)f.getDescribe().getDefaultValueFormula());
					}
					
					models.add(m);
					
					// TODO: more work here, not really implemented yet
					for(Schema.ChildRelationship cr : r.getChildRelationships()) {
						m.children.put(cr.getRelationshipName(), null);
					}
					
				}
			}
			return models;
		}
		set;
	}

}