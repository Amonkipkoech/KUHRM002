table 50017 "HRM-Licence"
{
    Caption = 'HRM-Licence';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "License Code"; code[20])
        {

        }
        field(2; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "Licensing Body"; Text[100])
        {

        }
        field(4; "Licensing Period From"; Date)
        {

        }
        field(5; "Licensing Period To"; Date)
        {
            
        }
    }
    keys
    {
        key(PK; "License Code", "Line No")
        {
            Clustered = true;
        }
    }
}
