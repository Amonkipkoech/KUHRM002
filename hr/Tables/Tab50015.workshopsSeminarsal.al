table 50015 "workshopsSeminars.al"
{
    Caption = 'workshopsSeminars.al';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; payrollNo; Code[20])
        {
            Caption = 'payrollNo';
        }
        field(2; LineNo; Integer)
        {
            Caption = 'LineNo';
            AutoIncrement = true;
        }
        field(3; WorkshopAtt; Text[100])
        {

        }
        field(4; "From Date"; Date)
        {

        }
        field(5; "To Date"; Date)
        {

        }
        field(6; "Sponsoring Organisation"; Text[100])
        {

        }
        field(7; Venue; text[100])
        {

        }
    }
    keys
    {
        key(PK; payrollNo, LineNo)
        {
            Clustered = true;
        }
    }
}
