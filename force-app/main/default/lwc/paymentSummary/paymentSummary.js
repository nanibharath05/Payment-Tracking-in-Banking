import { LightningElement, api, wire } from 'lwc';
import getPaymentSummary from '@salesforce/apex/PaymentSummaryController.getPaymentSummary';

export default class PaymentSummary extends LightningElement {
    @api recordId; // will automatically pick Loan__c record Id from Record Page
    summary;
    error;
    isLoading = true;

    @wire(getPaymentSummary, { loanId: '$recordId' })
    wiredSummary({ error, data }) {
        this.isLoading = false;
        if (data) {
            this.summary = data;
            this.error = undefined;
        } else if (error) {
            this.error = 'Error loading payment summary';
            this.summary = undefined;
        }
    }
}
