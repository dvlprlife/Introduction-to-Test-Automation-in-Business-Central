tableextension 50100 "TIG Customer Ext" extends Customer
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
