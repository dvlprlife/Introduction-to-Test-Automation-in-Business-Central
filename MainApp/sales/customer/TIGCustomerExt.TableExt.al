namespace Tigunia.Sales.Customer;

using Microsoft.Sales.Customer;

tableextension 50100 "TIG Customer Ext" extends Customer
{
    fields
    {
        field(50100; "TIG Address Validated"; Boolean)
        {
            Caption = 'Address Validated';
            DataClassification = CustomerContent;
        }
    }
}
