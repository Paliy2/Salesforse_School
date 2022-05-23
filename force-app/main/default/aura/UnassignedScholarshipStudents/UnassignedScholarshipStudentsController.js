({
    init: function (cmp, event, helper) {
        cmp.set('v.columns', [
            {label: 'Student Name', fieldName: 'Name', type: 'text'},
            {label: 'Average Grade', fieldName: 'Average_Grade__c', type: 'text'},
            {label: 'Email', fieldName: 'Email__c', type: 'text'},
            {label: 'Year_of_Study__c', fieldName: 'Year_of_Study__c', type: 'text'},
            ]);

        helper.fetchData(cmp);
    }
});