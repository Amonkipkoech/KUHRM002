table 61064 "HRM-Applicant Qualif. Lines"
{
    //  Job ID,Requirements


    fields
    {
        field(1; "Entry No"; Integer)
        {
        }
        field(2; "Applicant ID"; Integer)
        {
        }
        field(3; "Qualification code"; Code[20])
        {
            TableRelation = Qualification.Code;

            trigger OnValidate()
            begin
                /*JobRq.SETRANGE(JobRq."Job Specification","Qualification code");
                JobRq.SETRANGE(JobRq."Qualification Type","Job ID");
                IF JobRq.FIND('-') THEN
                "Qualification Description":=JobRq."Qualification Code";
                Creteria.SETCURRENTKEY("Job ID",Requirements);
                Creteria.SETRANGE("Job ID","Job ID");
                Creteria.SETRANGE(Creteria.Requirements,"Qualification code");
                IF Creteria.FIND('-') THEN
                 IF Desiredscore.GET(Creteria.Score) THEN
                 "Desired Score" :=Desiredscore.Score;
               */

            end;
        }
        field(4; "Qualification Description"; Text[250])
        {
        }
        field(5; "Job ID"; Code[20])
        {
            TableRelation = "HRM-Company Jobs";

            trigger OnValidate()
            begin
                if Qualification.Get("Qualification code") then
                    "Qualification Description" := Qualification.Description;
            end;
        }
        field(6; Qualified; Boolean)
        {
        }
        field(7; "From Date"; Date)
        {
        }
        field(8; "To Date"; Date)
        {
        }
        field(9; Institution; Text[50])
        {
        }
        field(10; "Qualification Type"; Option)
        {
            OptionMembers = " ",Academic,Professional,Technical,Experience;
        }
        field(11; "No of Years"; Decimal)
        {
        }
        field(12; "Actual Score"; Code[20])
        {
            TableRelation = "HRM-Score Setup"."Score ID";

            trigger OnValidate()
            begin
                if Desiredscore.Get("Actual Score") then;
                //    ActualScore:=Desiredscore.Score;
            end;
        }
        field(13; "Desired Score"; Integer)
        {
        }
        field(14; ActualScore; Decimal)
        {
        }
        field(15; "Recruitment Stage"; Integer)
        {
            TableRelation = "HRM-Recruitment Stages (B)";
        }
        field(16; "User ID"; Code[20])
        {
            //todo TableRelation = Table2000000002.Field1;
        }
    }

    keys
    {
        key(Key1; "Applicant ID", "Job ID", "Recruitment Stage", "User ID", "Entry No")
        {
            SumIndexFields = ActualScore;
        }
        key(Key2; "User ID")
        {
            SumIndexFields = ActualScore;
        }
    }

    fieldgroups
    {
    }

    var
        JobRq: Record "HRM-Job Requirement";
        Qualification: Record Qualification;
        Creteria: Record "HRM-Shortlisting creteria";
        Desiredscore: Record "HRM-Score Setup";
}

