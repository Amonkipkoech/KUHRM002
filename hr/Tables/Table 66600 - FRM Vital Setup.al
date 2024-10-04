table 61338 "FRM Vital Setup"
{

    fields
    {
        field(1; "Setup Code"; Code[10])
        {
        }
        field(2; "Farmer Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(3; "Milk Collection Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(4; "Minimum Shares"; Integer)
        {

            trigger OnValidate()
            begin
                if "Minimum Shares" < 0 then Error('Invalid Entry');
            end;
        }
        field(5; "Maximum Shares"; Integer)
        {

            trigger OnValidate()
            begin
                if "Maximum Shares" < 0 then Error('Invalid Entry');
            end;
        }
        field(6; "Share Market Value"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Share Market Value" < 0 then Error('Invalid Entry');
            end;
        }
        field(8; "Milk Reception Store"; Code[20])
        {
            TableRelation = Location.Code WHERE("Use As In-Transit" = FILTER(false));
        }
        field(9; "Milk Invoice Numbers"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(10; "Milk Collection Batch Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(11; "Can Numbers"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(12; "Farmer Application Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(13; "Farmer Registration Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(14; "Farmer General Bus. Posting G."; Code[20])
        {
            TableRelation = "Gen. Business Posting Group";
        }
        field(15; "Farmer (Cust. Posting Group)"; Code[20])
        {
            TableRelation = "Customer Posting Group";
        }
        field(16; "Farmer (Supp. Posting Group)"; Code[20])
        {
            TableRelation = "Vendor Posting Group";
        }
        field(17; "Farmer Milk Collection Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(18; "Net Payment Code"; Code[20])
        {
            //todo TableRelation = "FRM Transaction Codes"."Transaction Code";
        }
        field(19; "Milk Collection Code"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(20; "Farmer Company Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(21; "Farmer Application Approver"; Code[20])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(22; "Collection Dispatch Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(23; "Milk Payment Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(24; "Raw Milk Item No"; Code[20])
        {
            TableRelation = Item."No.";
        }
        field(25; "Temporary In-Transit Location"; Code[20])
        {
            TableRelation = Location.Code WHERE("Use As In-Transit" = FILTER(true));
        }
        field(26; "Milk Receiving No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(27; "Milk Posting No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(28; "Credit Sales Transaction Code"; Code[20])
        {
            //todo  TableRelation = "FRM Transaction Codes"."Transaction Code";
        }
        field(29; "Dividents Code"; Code[20])
        {
            //todo   TableRelation = "FRM Transaction Codes"."Transaction Code";
        }
        field(30; "Pending Credit Sales Code"; Code[20])
        {
            //todo  TableRelation = "FRM Transaction Codes"."Transaction Code";
        }
        field(31; "Invt. Posting Group Code"; Code[10])
        {
            Caption = 'Invt. Posting Group Code';
            NotBlank = true;
            TableRelation = "Inventory Posting Group";
        }
        field(32; "Inventory Account"; Code[20])
        {
            Caption = 'Inventory Account';
            TableRelation = "G/L Account";
        }
        field(33; "Inventory Account (Interim)"; Code[20])
        {
            Caption = 'Inventory Account (Interim)';
            TableRelation = "G/L Account";
        }
        field(34; "WIP Account"; Code[20])
        {
            AccessByPermission = TableData "Production Order" = R;
            Caption = 'WIP Account';
            TableRelation = "G/L Account";
        }
        field(35; "Material Variance Account"; Code[20])
        {
            Caption = 'Material Variance Account';
            TableRelation = "G/L Account";
        }
        field(36; "Capacity Variance Account"; Code[20])
        {
            Caption = 'Capacity Variance Account';
            TableRelation = "G/L Account";
        }
        field(37; "Mfg. Overhead Variance Account"; Code[20])
        {
            Caption = 'Mfg. Overhead Variance Account';
            TableRelation = "G/L Account";
        }
        field(38; "Cap. Overhead Variance Account"; Code[20])
        {
            Caption = 'Cap. Overhead Variance Account';
            TableRelation = "G/L Account";
        }
        field(39; "Subcontracted Variance Account"; Code[20])
        {
            AccessByPermission = TableData "Production Order" = R;
            Caption = 'Subcontracted Variance Account';
            TableRelation = "G/L Account";
        }
        field(40; "Farmer Payment Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template".Name;
        }
        field(41; "Farmer Payment Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Farmer Payment Template"));
        }
        field(42; "Card Charges"; Decimal)
        {
        }
        field(43; "Maximum Building Contributions"; Decimal)
        {
        }
        field(44; "Building % on Gross"; Decimal)
        {
        }
        field(45; "Building Share Code"; Code[20])
        {
            //todo  TableRelation = "FRM Transaction Codes"."Transaction Code";
        }
        field(46; "Milk Approval Start Time"; Time)
        {
        }
        field(47; "Default Customer Farmer"; Code[20])
        {
            TableRelation = Customer."No." WHERE("Customer Posting Group" = FILTER('FARMER' | 'FARMERS'));
        }
        field(48; "Raw Milk Item journal Temp."; Code[20])
        {
            TableRelation = "Item Journal Template".Name;
        }
        field(49; "Raw Milk Item Journal Batch"; Code[20])
        {
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Raw Milk Item journal Temp."));
        }
        field(50; "VET Credit Trans no."; Code[20])
        {
            //todo  TableRelation = "FRM Transaction Codes"."Transaction Code";
        }
        field(51; "Stores Credit Trans no."; Code[20])
        {
            //todo   TableRelation = "FRM Transaction Codes"."Transaction Code";
        }
        field(52; "Lab. Credit Trans no."; Code[20])
        {
            //todo   TableRelation = "FRM Transaction Codes"."Transaction Code";
        }
        field(53; "Registration Fee Code"; Code[20])
        {
            //todo  TableRelation = "FRM Transaction Codes"."Transaction Code";
        }
        field(54; "Registration Fee Amount"; Decimal)
        {
        }
        field(55; "Use Period Instalments"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Intalment Date 1"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Instalmemt Date 2"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Instalment Date 3"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Instalment Date 4"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Number of instalments"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Setup Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        if not UserSetup.Get(UserId) then Error('Access Denied!');

        //if not UserSetup."Edit Farmer Central Setup" then Error('Access Denied!');
    end;

    var
        UserSetup: Record "User Setup";
}

