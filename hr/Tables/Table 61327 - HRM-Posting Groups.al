table 61327 "HRM-Posting Groups"
{
    DrillDownPageID = "HRM-Posting Groups";
    LookupPageID = "HRM-Posting Groups";

    fields
    {
        field(1; "Posting Group"; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Training Debit Account"; Code[20])
        {
            NotBlank = true;
            TableRelation = "G/L Account"."No.";
        }
        field(3; "Training Credit A/C Type"; Option)
        {
            NotBlank = true;
            OptionCaption = 'G/L Account,Bank Account';
            OptionMembers = "G/L Account","Bank Account";
        }
        field(4; "Training Credit Account"; Code[20])
        {
            NotBlank = true;
            TableRelation = IF ("Training Credit A/C Type" = CONST("G/L Account")) "G/L Account"."No."
            ELSE
            IF ("Training Credit A/C Type" = CONST("Bank Account")) "Bank Account"."No.";
        }
        field(5; "Recruitment Debit Account"; Code[20])
        {
            NotBlank = true;
            TableRelation = "G/L Account"."No.";
        }
        field(6; "Recruitment Credit A/C Type"; Option)
        {
            NotBlank = true;
            OptionCaption = 'G/L Account,Bank Account';
            OptionMembers = "G/L Account","Bank Account";
        }
        field(7; "Recruitment Credit Account"; Code[20])
        {
            NotBlank = true;
            TableRelation = IF ("Recruitment Credit A/C Type" = CONST("G/L Account")) "G/L Account"."No."
            ELSE
            IF ("Recruitment Credit A/C Type" = CONST("Bank Account")) "Bank Account"."No.";
        }
        field(8; "Comp. Act. Debit Account"; Code[20])
        {
            NotBlank = true;
            TableRelation = "G/L Account"."No.";
        }
        field(9; "Comp. Act. Credit A/C Type"; Option)
        {
            NotBlank = true;
            OptionCaption = 'G/L Account,Bank Account';
            OptionMembers = "G/L Account","Bank Account";
        }
        field(10; "Comp. Act. Credit Account"; Code[20])
        {
            NotBlank = true;
            TableRelation = IF ("Comp. Act. Credit A/C Type" = CONST("G/L Account")) "G/L Account"."No."
            ELSE
            IF ("Comp. Act. Credit A/C Type" = CONST("Bank Account")) "Bank Account"."No.";
        }
    }

    keys
    {
        key(Key1; "Posting Group")
        {
        }
    }

    fieldgroups
    {
    }
}

