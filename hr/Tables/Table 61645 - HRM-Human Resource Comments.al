table 61645 "HRM-Human Resource Comments"
{

    fields
    {
        field(1; "Table Name"; Option)
        {
            OptionMembers = Employee,Relative,"Relation Management","Correspondence History",Images,"Absence and Holiday","Cost to Company","Pay History","Bank Details",Maternity,"SAQA Training History","Absence Information","Incident Report","Emp History","Medical History","Career History",Appraisal,Disciplinary,"Exit Interviews",Grievances,"Existing Qualifications","Proffesional Membership","Education Assistance","Learning Intervention","NOSA or other Training","Company Skills Plan","Development Plan","Skills Plan","Emp Salary",Unions;
        }
        field(2; "No."; Code[20])
        {
            TableRelation = IF ("Table Name" = CONST(Employee)) "HRM-Employee SIC Numbers"."Employee No."
            ELSE
            IF ("Table Name" = CONST(Relative)) "HRM-Employee Attachments"."Employee No"
            ELSE
            IF ("Table Name" = CONST("Relation Management")) "HRM-Applicant Qualifications"."Application No"
            ELSE
            IF ("Table Name" = CONST("Correspondence History")) "HRM-Applicant Hobbies"."Job Application No"
            ELSE
            IF ("Table Name" = CONST(Images)) "HRM-Document Content Source".Code
            ELSE
            IF ("Table Name" = CONST("Absence and Holiday")) "HRM-Absence and Holiday"."Employee No."
            ELSE
            IF ("Table Name" = CONST("Cost to Company")) "HRM-Appraisal Evaluation Areas".Code
            ELSE
            IF ("Table Name" = CONST("Bank Details")) "HRM-Appraisal Ratings (B)".Code;
            /*  ELSE
             IF ("Table Name" = CONST(Maternity)) "GEN-Additional Group Approvers"."Approval Code"; */
        }
        field(3; "Table Line No."; Integer)
        {
        }
        field(4; "Key Date"; Date)
        {
        }
        field(5; mm; Integer)
        {
        }
        field(6; "Line No."; Integer)
        {
        }
        field(7; Date; Date)
        {
        }
        field(8; "Code"; Code[10])
        {
        }
        field(9; Comment; Text[80])
        {
        }
        field(10; User; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Table Name", "Table Line No.")
        {
        }

    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        lRec_UserTable: Record User;
    begin

        lRec_UserTable.Get(UserId);
        User := lRec_UserTable."Full Name";
        Date := WorkDate;
    end;

    trigger OnModify()
    var
        lRec_UserTable: Record User;
    begin

        lRec_UserTable.Get(UserId);
        User := lRec_UserTable."Full Name";
        Date := WorkDate;
    end;

    procedure SetUpNewLine()
    var
        HumanResCommentLine: Record "HRM-Human Resource Comments";
    begin
        HumanResCommentLine := Rec;
        HumanResCommentLine.SetRecFilter;
        HumanResCommentLine.SetRange("Line No.");
        if not HumanResCommentLine.Find('-') then
            Date := WorkDate;
    end;
}

