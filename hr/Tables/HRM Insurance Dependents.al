table 50007 "HRM-Insurance Dependants"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Payroll No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Dependent Names"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Dependent ID No/ Birth Cert No"; Code[30])
        {

            DataClassification = ToBeClassified;
        }
        field(4; "Dependent DoB"; Code[20])
        {
            Caption = 'Dependent Date of Birth';

        }
        field(5; "Dependent Insurance No."; Code[20])
        {

            DataClassification = ToBeClassified;
        }
        field(6; Gender; Option)
        {
            OptionMembers = " ",Male,Female;
        }
        field(8; "R/ship to Principal"; Option)
        {
            Caption = 'Relationship to the Principal';
            OptionMembers = " ",Child,Spouse;

            //OptionMembers = " ",Father,Mother,Brother,Sister,Uncle,Aunt;
        }


    }

    keys
    {
        key(Key1; "Payroll No.", "Dependent Insurance No.")
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