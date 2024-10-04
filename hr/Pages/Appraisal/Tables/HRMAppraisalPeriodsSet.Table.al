table 75017 "HRM-Appraisal Periods Set"
{

    fields
    {
        field(1; "Period Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Period Description"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Order"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Period Month"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,January,February,March,April,May,June,July,August,September,October,November,December';
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
        }
    }

    keys
    {
        key(Key1; "Period Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

