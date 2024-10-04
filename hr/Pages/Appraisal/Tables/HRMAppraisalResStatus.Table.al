table 75018 "HRM-Appraisal Res. Status"
{
    DrillDownPageID = "HRM-Appraisal Recomm List";
    LookupPageID = "HRM-Appraisal Recomm List";

    fields
    {
        field(1; "Code"; Code[50])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(7; "Status Msg1"; Text[250])
        {
        }
        field(8; "Status Msg2"; Text[250])
        {
        }
        field(9; "Status Msg3"; Text[250])
        {
        }
        field(10; "Status Msg4"; Text[250])
        {
        }
        field(11; "Status Msg5"; Text[250])
        {
        }
        field(12; "Order No"; Integer)
        {
        }
        field(14; "Show Reg. Remarks"; Boolean)
        {
        }
        field(15; "Manual Status Processing"; Boolean)
        {
        }
        field(50001; Prefix; Code[20])
        {
        }
        field(50005; "Status Msg6"; Text[250])
        {
        }
        field(50006; "IncludeVariable 1"; Boolean)
        {
        }
        field(50007; "IncludeVariable 2"; Boolean)
        {
        }
        field(50008; "IncludeVariable 3"; Boolean)
        {
        }
        field(50009; "IncludeVariable 4"; Boolean)
        {
        }
        field(50010; "IncludeVariable 5"; Boolean)
        {
        }
        field(50011; "IncludeVariable 6"; Boolean)
        {
        }
        field(50012; "Minimum Units Failed"; Integer)
        {
        }
        field(50013; "Maximum Units Failed"; Integer)
        {
        }
        field(63020; Status; Option)
        {
            OptionCaption = 'Registration,Current,Alluminae,Dropped Out,Deffered,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred,Disciplinary,Unknown,Completed not graduated,Graduated no Certificates,Graduated with Certificate';
            OptionMembers = Registration,Current,Alluminae,"Dropped Out",Deffered,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred,Disciplinary,Unknown,"Completed not graduated","Graduated no Certificates","Graduated with Certificate";
        }
        field(63021; "Summary Page Caption"; Text[250])
        {
        }
        field(63022; "Include Failed Targets Headers"; Boolean)
        {
        }
        field(63023; "Appraisal Year Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Appraisal Years".Code;
        }
    }

    keys
    {
        key(Key1; "Code", "Appraisal Year Code")
        {
            Clustered = true;
        }
        key(Key2; "Order No")
        {
        }
    }

    fieldgroups
    {
    }
}

