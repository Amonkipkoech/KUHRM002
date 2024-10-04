/* tableextension 50000 "User Setup TblExt" extends "User Setup"
{
    fields
    {
        field(50037; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Employee C"."No.";
            //TableRelation = Customer."No." WHERE("Customer Posting Group" = FILTER('IMPREST'));
        }
    }

    var
        myInt: Integer;
} */