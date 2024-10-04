table 61065 "HRM-Shortlisting creteria"
{

    fields
    {
        field(1; "Requitment Stage"; Code[20])
        {
            NotBlank = false;
            TableRelation = "HRM-Recruitment Stages (B)";
        }
        field(2; "Job ID"; Code[20])
        {
            NotBlank = true;
        }
        field(3; Requirements; Code[20])
        {
            NotBlank = true;
            TableRelation = Qualification.Code;

            trigger OnValidate()
            begin
                JobRq.Get(Requirements);
                Description := JobRq.Description;
            end;
        }
        field(4; Description; Text[100])
        {
        }
        field(5; Score; Code[20])
        {
            TableRelation = "HRM-Score Setup";
        }
        field(6; "Desired Score"; Decimal)
        {
        }
        field(7; "Qualification Type"; Option)
        {
            OptionMembers = " ",Academic,Professional,Technical,Experience;
        }
    }

    keys
    {
        key(Key1; "Job ID", "Requitment Stage", Requirements, "Qualification Type")
        {
            SumIndexFields = "Desired Score";
        }
        key(Key2; "Job ID", Requirements)
        {
            SumIndexFields = "Desired Score";
        }
        key(Key3; "Job ID", "Qualification Type")
        {
        }
    }

    fieldgroups
    {
    }

    var
        JobRq: Record Qualification;
        ScoreSetup: Record "HRM-Score Setup";
}

