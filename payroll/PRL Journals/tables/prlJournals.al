table 80006 "Payroll Journal Batches"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; payrollPeriod; Date)
        {
            TableRelation = "PRL-Payroll Periods";
            trigger OnValidate()
            var
                prlPeriods: Record "PRL-Payroll Periods";
            begin
                // prlPeriods.Reset();
                // prlPeriods.SetRange("Date Opened", Rec.payrollPeriod);
                // if prlPeriods.Find('-') then begin
                //     Rec.periodName := prlPeriods."Period Name";
                //     Rec.createdBy := UserId;
                //     Rec.dateCreated := Today;
                //     Rec.Modify();
                // end;
            end;

        }
        field(2; periodName; text[50])
        {

        }
        field(3; createdBy; code[20])
        {

        }
        field(4; dateCreated; Date)
        {

        }
        field(5; Status; Option)
        {
            OptionMembers = "Pending Verification",Verified;
        }
        field(6; "Verified By"; code[20])
        {

        }
        field(7; Posted; Boolean)
        {

        }
        field(8; "Posting Date"; Date)
        {
            
        }
    }

    keys
    {
        key(Key1; payrollPeriod, periodName)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}