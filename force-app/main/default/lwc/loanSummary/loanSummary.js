import { LightningElement, api, wire } from 'lwc';
import getPaymentSummary from '@salesforce/apex/PaymentSummaryController.getPaymentSummary';

export default class LoanSummary extends LightningElement {
    @api recordId;
    summary;

    @wire(getPaymentSummary, { loanId: '$recordId' })
    wiredSummary({ error, data }) {
        if (data) {
            this.summary = data;
        } else if (error) {
            console.error('Error fetching summary:', error);
            this.summary = null;
        }
    }
}
