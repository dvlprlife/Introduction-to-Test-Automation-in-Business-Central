namespace Tigunia.Sales.Customer;

using Microsoft.Sales.Customer;

pageextension 50101 "TIG Customer Card Ext" extends "Customer Card"
{
    layout
    {
        addlast("Address & Contact")
        {
            field(TIGAddressValidated; Rec."TIG Address Validated")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Indicates the validation status of the customer address.';
            }
        }
    }
}
