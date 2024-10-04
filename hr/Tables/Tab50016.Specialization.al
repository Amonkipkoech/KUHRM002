table 50016 Specialization
{
    Caption = 'Specialization';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "code"; text[50])
        {
            Caption = 'code';
        }
        field(2; Specialization; Text[50])
        {
            Caption = 'Specialization';
        }
    }
    keys
    {
        key(PK; "code")
        {
            Clustered = true;
        }
    }
}
