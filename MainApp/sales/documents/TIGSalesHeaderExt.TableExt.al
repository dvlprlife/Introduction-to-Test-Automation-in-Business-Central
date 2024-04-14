namespace Tigunia.Sales.Documents;

using Microsoft.Sales.Document;
using Tigunia.Sales;

tableextension 50101 "TIG Sales Header Ext" extends "Sales Header"
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
