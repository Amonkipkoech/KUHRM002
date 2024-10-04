table 75202 "InterView Setup"
{

    fields
    {
        field(1; Sn; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Employee Requisition"; Code[20])
        {
            TableRelation = "HRM-Employee Requisitions";
        }
        field(3; "Venue"; text[200])
        {

        }
        field(4; "Time"; DateTime)
        {

        }

        //You might want to add fields here

    }

    keys
    {
        key(Key1; Sn)
        {
            Clustered = true;
        }
    }

    var
        RecordHasBeenRead: Boolean;

    procedure GetRecordOnce()
    begin
        if RecordHasBeenRead then
            exit;
        Get();
        RecordHasBeenRead := true;
    end;

    procedure InsertIfNotExists()
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert(true);
        end;
    end;


}