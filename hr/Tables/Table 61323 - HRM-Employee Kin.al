table 61323 "HRM-Employee Kin"
{
    Caption = 'Employee Relative';

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Employee (D)"."No.";
        }
        field(2; Relationship; Text[50])
        {
            NotBlank = true;
            //TableRelation = Relative.Code;
        }
        field(3; SurName; Text[50])
        {
            NotBlank = true;
        }
        field(4; "Other Names"; Text[100])
        {
            NotBlank = true;
        }
        field(5; "ID No/Passport No"; Text[50])
        {
        }
        field(6; "Date Of Birth"; Date)
        {
            trigger OnValidate()
            begin

                if "Date Of Birth" <> 0D then begin
                    Age := Today - "Date Of Birth";
                    Age := Age / 3600;
                    EditGuardian := true;
                    if Age > 18 then
                        EditGuardian := false;
                end;
            end;
        }
        field(7; Occupation; Text[100])
        {
        }
        field(8; Address; Text[250])
        {
        }
        field(9; "Office Tel No"; Text[100])
        {
            Caption = 'Alternate Phone No.';
        }
        field(10; "Home Tel No"; Text[50])
        {
            Caption = 'Phone No.';
        }
        field(11; Remarks; Text[250])
        {
        }
        field(12; Type; Option)
        {
            OptionMembers = "Next of Kin",Beneficiary,Dependant;
        }
        field(13; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(14; Comment; Boolean)
        {
            CalcFormula = Exist("Human Resource Comment Line" WHERE("Table Name" = CONST("Employee Relative"),
                                                                     "No." = FIELD("Employee Code"),
                                                                     "Table Line No." = FIELD("Line No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Code"; Code[10])
        {
        }
        field(16; "Percentage(%)"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Percentage(%)" > 100 then
                    Error('The total Percentage for all Beneficiaries should not be more than 100%');
            end;
        }
        field(50000; "No."; Code[10])
        {
        }
        field(50001; "First Name"; Text[30])
        {
        }
        field(50002; "Middle Name"; Text[30])
        {
        }
        field(50003; "Last Name"; Text[30])
        {
        }
        field(50004; "Name"; Text[100])
        {
        }
        field(50005; "Is Beneficiary"; Boolean)
        {
        }
        field(50006; Age; Duration)
        {
        }
        field(50007; "Nominated Guardian"; Text[100])
        {
            trigger OnValidate()
            begin
                TestField("Date Of Birth");
            end;
        }
        field(50008; "Guardian Phone No."; Text[15])
        {
            ExtendedDatatype = PhoneNo;
        }
        field(50009; "Guardian Email Address"; Text[30])
        {
            ExtendedDatatype = EMail;
        }
        field(50010; "Nominated Guardian Gender"; Option)
        {
            OptionMembers = " ",Male,Female;
        }
        field(50011; "RelationShip of Guardian"; Code[30])
        {
            TableRelation = Relative.Code;
        }


    }

    keys
    {
        key(Key1; "Employee Code", SurName, "Other Names")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        HRCommentLine: Record "Human Resource Comment Line";
    begin
        HRCommentLine.SetRange("Table Name", HRCommentLine."Table Name"::"Employee Relative");
        HRCommentLine.SetRange("No.", "Employee Code");
        HRCommentLine.DeleteAll;
    end;

    var
        EditGuardian: Boolean;
}

