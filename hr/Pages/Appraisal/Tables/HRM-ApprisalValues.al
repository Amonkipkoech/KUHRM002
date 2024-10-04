table 85517 "HRM Apprisal Values"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "PF. No."; Code[20])
        {
            Editable = true;
            NotBlank = true;
        }


        field(2; Values; Option)
        {
            OptionMembers = " ","Witness of Life",Prayer,Truthfulness,Honesty,Excellence,Commitment,Competence;


        }
        field(3; Weighting; Integer)
        {

        }
        field(4; "Acheivement Score"; Integer)
        {

        }
        field(5; "Final Score"; Code[5])
        {

        }
        field(6; "competences"; Option)
        {
            OptionMembers = " ","Customer Focus",Proffesionalism,"Technical Competency",Communication,"Team Work","Time Management","Continuous learning";
        }
        field(7; valueCode; Integer)
        {

        }
        field(8; "Managerial Competency"; Option)
        {
            OptionMembers = "Planning and Organizing","Training and Development of Staff", "Accountability in Managing Resources","Anticipating Risks and Taking Measures to Mitigate against them","Judgment and Objectivity";
        }
        field(9; "Bisemester Review"; Text[200])
        {

        }
        ///mid year review apprisal
        field(10; Targets; Text[100])
        {

        }
        field(11; "Perfomance Indicators"; Text[100])
        {
            
        }
        field(12; "Results Acheived"; Option)
        {
            OptionMembers = " ",Yes,No;
        }
        field(13; "Performance Apprisal"; Text[50])
        {

        }
        ////
    }

    keys
    {
        key(Key1; valueCode)
        {
            Clustered = true;
        }
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