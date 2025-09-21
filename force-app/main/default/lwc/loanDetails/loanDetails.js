import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Loan__c.Name';
import PRINCIPAL_FIELD from '@salesforce/schema/Loan__c.Principal_Amount__c';
import STATUS_FIELD from '@salesforce/schema/Loan__c.Status__c';

export default class LoanDetails extends LightningElement {
    @api recordId;
    loan;

    @wire(getRecord, { recordId: '$recordId', fields: [NAME_FIELD, PRINCIPAL_FIELD, STATUS_FIELD] })
    wiredLoan({ error, data }) {
        if (data) {
            this.loan = {
                Name: data.fields.Name.value,
                Principal_Amount__c: data.fields.Principal_Amount__c.value,
                Status__c: data.fields.Status__c.value
            };
        } else if (error) {
            console.error('Error fetching loan:', error);
            this.loan = null;
        }
    }
}
