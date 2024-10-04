table 61305 "HRM-Position Supervised"
{

    fields
    {
        field(1; "Job ID"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Company Jobs"."Job ID";
        }
        field(2; "Position Supervised"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Company Jobs"."Job ID";

            trigger OnValidate()
            begin
                if Jobs.Get("Position Supervised") then
                    Description := Jobs."Job Description";
            end;
        }
        field(3; Description; Text[250])
        {
        }
        field(4; Remarks; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Job ID", "Position Supervised")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Jobs: Record "HRM-Company Jobs";
}

