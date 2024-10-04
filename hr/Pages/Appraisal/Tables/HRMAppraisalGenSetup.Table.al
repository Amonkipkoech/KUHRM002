table 75008 "HRM-Appraisal Gen. Setup"
{

    fields
    {
        field(1; "Appraisal Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(2; "Appraisal Registration Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(3; "Primary Key"; Code[10])
        {
        }
        field(17; "Clearance Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

