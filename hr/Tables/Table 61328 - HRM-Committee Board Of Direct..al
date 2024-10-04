table 61328 "HRM-Committee Board Of Direct."
{

    fields
    {
        field(1; Committee; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Board Of Directors".Code;

            trigger OnValidate()
            begin
                if Board.Get(Code) then begin
                    SurName := Board.SurName;
                    OtherNames := Board."Other Names";
                end;
            end;
        }
        field(3; SurName; Text[150])
        {
        }
        field(4; OtherNames; Text[150])
        {
        }
        field(5; Designation; Text[100])
        {
        }
        field(6; Remarks; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; Committee, "Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Board: Record "HRM-Board Of Directors";
}

