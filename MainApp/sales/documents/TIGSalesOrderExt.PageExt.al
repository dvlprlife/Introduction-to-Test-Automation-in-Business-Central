namespace Tigunia.Sales.Documents;

using Microsoft.Sales.Document;

pageextension 50102 "TIG Sales Order Ext" extends "Sales Order"
{
    layout
    {
        addlast("Shipping and Billing")
        {
            field(TIGAddressValidated; Rec."TIG Address Validated")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Indicates the validation status of the customer.';
            }
        }
    }
}
