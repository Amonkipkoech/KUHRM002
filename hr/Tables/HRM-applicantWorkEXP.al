table 85534 "HRM-Work eXP"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Application No"; Code[10])
        {
            Caption = 'Application No';
            TableRelation = "HRM-Job Applications (B)"."Application No";
        }

        field(3; "Organisation"; text[200])
        {

        }
        field(4; Position; text[80])
        {

        }
        field(5; "Duration"; Integer)
        {

        }
        field(6; "From Date"; code[20])
        {

        }
        field(7; "To Date"; code[20])
        {
            
        }


    }


    keys
    {
        key(Key1; "Application No", Organisation)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;



}