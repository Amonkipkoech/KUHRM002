table 61827 "HRM-Emp. Qualifications Final"
{
    Caption = 'HRM-Academic Qualification';
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No.";
        }
        field(2; Type; Option)
        {
            OptionCaption = ' ,Internal,External,Others';
            OptionMembers = " ",Internal,External,Others;
        }
        field(3; "From Date"; Date)
        {
        }
        field(4; "To Date"; Date)
        {
        }
        field(5; Institution; Text[250])
        {
            Caption = 'Institution Attended';
            // TableRelation = "HRM-Institutions"."Institution Code";
        }
        field(6; Description; Text[150])
        {
        }
        field(7; Qualification; Text[150])
        {
            Caption = 'Academic Qualification';
            // TableRelation = "HRM-Terms Values".Code where("Term Code" = filter('ACADEMIC|ACADEMICS'));

        }
        field(8; "Institution Name"; Text[250])
        {
            // CalcFormula = Lookup("HRM-Institutions"."Institution Name" WHERE("Institution Code" = FIELD(Institution)));
            // FieldClass = FlowField;
        }
        field(9; "Highest Qualification"; Boolean)
        {

            // trigger OnValidate()
            // begin
            //     if ("Highest Qualification" = true) then begin
            //         qual.Reset;
            //         qual.SetRange(qual."Employee No.", "Employee No.");
            //         qual.SetRange(qual."Highest Qualification", true);
            //         if qual.Find('-') then begin
            //             if qual.Count > 0 then Error('You cannot have more than one highest qualifications for' + Format(qual."Employee No."));
            //         end;
            //     end;
            // end;
        }
        //  Enum "Academic Levels"
        field(10; "Qualification Category"; Option)
        {
            OptionMembers = Doctorate,Masters,Bachelor,Diploma,Certificate,"Postgraduate Diploma","Advanced Diploma","Higher Diploma","Advanced Certificate",STL,Baccalaureate,"Post-Doctoral",Licentiate,"International Advanced Diploma","International Diploma","African Certificate","Higher National Diploma";


        }
        field(11; "Academic Qualification"; Text[200])
        {
            //Editable = false;
            // FieldClass = FlowField;
            // CalcFormula = lookup("HRM-Terms Values".Description where("Code" = field("Academic Qualification Code")));
        }
        field(12; "Academic Specialisation Code"; Text[30])
        {
            // Caption = 'Academic Specialisation Code';
            // TableRelation = "HRM-Terms Values".Code where("Term Code" = filter('SPECIALIZATION|SPECIALIZATIONS|SPECIALISATION|SPECIALISATIONS'));

        }
        field(13; "Academic Specialisation"; Text[200])
        {
            Caption = 'Academic Specialization ';
            // FieldClass = FlowField;
            // CalcFormula = lookup("HRM-Terms Values".Description where("Code" = field("Academic Specialisation Code")));

        }
        field(14; "Academic Qualification Code"; Text[200])
        {
            Caption = 'Academic Qualification';
            // TableRelation = "HRM-Terms Values".Code where("Term Code" = filter('ACADEMIC|ACADEMICS'));

        }
        field(20; "Year Attended From"; Code[20])
        {
            // MinValue = 1980;
            // MaxValue = 2050;
        }
        field(21; "Year Attended To"; Code[20])
        {
            // MinValue = 1980;
            // MaxValue = 2050;

        }
        field(22; "Employee Name"; text[200])
        {
            CalcFormula = lookup("HRM-Employee (D)"."Full Name" where("No." = field("Employee No.")));
            fieldclass = flowfield;
        }
    }

    keys
    {
        key(Key1; "Employee No.", Qualification, Type)
        {
        }
    }

    fieldgroups
    {
    }

    var
        qual: Record "HRM-Emp. Qualifications Final";
        emp: Record "HRM-Employee (D)";

    procedure GenerateFullNames() nos: integer
    var
        fullname: Text[200];
    begin
        nos := 0;
        emp.RESET;
        IF emp.FIND('-') THEN begin
            REPEAT
                fullname := '';
                if emp."First Name" <> '' then
                    fullname += emp."First Name";
                if emp."Middle Name" <> '' then begin
                    if fullname <> '' then begin
                        fullname += ' ' + emp."Middle Name";
                    end else
                        fullname += emp."Middle Name";
                end;
                if emp."Last Name" <> '' then
                    fullname += ' ' + emp."Last Name";
                emp."Last Name" := fullname;
                emp.modify;
                nos += 1;
            UNTIL emp.Next = 0;
        end;
    end;
}

