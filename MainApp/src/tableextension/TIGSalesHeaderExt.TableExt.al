tableextension 50101 "TIG Sales Header Ext" extends "Sales Header"
{
    fields
    {
        field(50100; "TIG Validated"; Boolean)
        {
            Caption = 'Validated';
            DataClassification = CustomerContent;
        }
    }
}
