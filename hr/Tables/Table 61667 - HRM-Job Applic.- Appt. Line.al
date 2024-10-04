table 61667 "HRM-Job Applic.- Appt. Line"
{
    Caption = 'HR Job Applications';

    fields
    {
        field(1; "Test Code"; Code[50])
        {
            TableRelation = "HRM-Job Applic. - Appt. Type".No;
        }
        field(2; "Applicants Code"; Code[20])
        {
            TableRelation = "HRM-Job Applications (B)"."Application No" WHERE(Qualified = FILTER(true));

            trigger OnValidate()
            begin

                HRJobApp.Reset;
                HRJobApp.SetRange(HRJobApp."Application No", "Applicants Code");
                if HRJobApp.Find('-') then begin
                    "Applicants Name" := HRJobApp."First Name" + ' ' + HRJobApp."Middle Name" + ' ' + HRJobApp."Last Name";
                    "E-mail" := HRJobApp."E-Mail";
                    "Telephone No" := HRJobApp."Cell Phone Number";
                end;

                "Line No" := xRec."Line No" + 1000;
                Insert;
            end;
        }
        field(3; "Applicants Name"; Text[50])
        {
        }
        field(4; Description; Text[100])
        {
        }
        field(5; "Date of Test"; Date)
        {
        }
        field(6; Venue; Text[30])
        {
        }
        field(7; FromTime; Time)
        {
        }
        field(8; "To time"; Time)
        {
        }
        field(9; "Notification Sent"; Boolean)
        {
        }
        field(10; "E-mail"; Text[30])
        {
        }
        field(11; "Line No"; Decimal)
        {
        }
        field(12; "Telephone No"; Text[30])
        {
        }
        field(13; "Followup Done"; Boolean)
        {
        }
        field(14; Status; Option)
        {
            OptionCaption = 'Apptitude,Assesment,Interview1,Interview2, Qualified';
            OptionMembers = Apptitude,Assesment,Interview1,Interview2," Qualified";
        }
        field(15; Score; Decimal)
        {
            CalcFormula = Sum("HRM-Job Applic.- Appt. Res".Score WHERE("Applicant No" = FIELD("Applicants Code"),
                                                                        Stage = FIELD(Stage)));
            FieldClass = FlowField;
        }
        field(16; "Type of Invitation Code"; Code[10])
        {
        }
        field(17; "Type of Invitation"; Text[50])
        {
        }
        field(18; Stage; Code[20])
        {
            TableRelation = "HRM-Recruitment Stages".Code;

            trigger OnValidate()
            begin
                Appt.Reset;
                Appt.SetRange(Appt.No, "Test Code");
                if Appt.Find('-') then begin
                    Description := Appt."Test Particulars";
                    "Date of Test" := Appt."Date of Test";
                    Venue := Appt.Venue;
                    FromTime := Appt."Start Time";
                    Rec."To time" := Appt."End Time";
                    Stage := Appt."Stage Code";
                end;
            end;
        }
        field(19; Response; Option)
        {
            OptionCaption = 'None,Accepted,Declined,Tentative';
            OptionMembers = "None",Accepted,Declined,Tentative;
        }
        field(20; "Invitation Type"; Option)
        {
            OptionCaption = 'Email,Phone Call,Text,Meeting';
            OptionMembers = Email,"Phone Call",Text,Meeting;
        }
    }

    keys
    {
        key(Key1; "Test Code", "Applicants Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*//GENERATE NEW NUMBER FOR THE DOCUMENT
        IF  "Aptitude Test Description" = '' THEN BEGIN
          HRSetup.GET;
          HRSetup.TESTFIELD(HRSetup."Job Application Nos");
          NoSeriesMgt.InitSeries(HRSetup."Job Application Nos",xRec."No. Series",0D,"Aptitude Test Description","No. Series");
        END;
        
        "Date Applied":=TODAY;
        */

    end;

    var
        HREmpReq: Record "HRM-Employee Requisitions";
        Employee: Record "HRM-Short Listed Applicant";
        HRSetup: Record "HRM-Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EmpQualifications: Record "HRM-Employee Qualifications";
        AppQualifications: Record "HRM-Applicant Qualifications";
        AppRefferees: Record "HRM-Applicant Referees";
        AppHobbies: Record "HRM-Applicant Hobbies";
        HRJobApp: Record "HRM-Job Applications (B)";
        Country: Record "Country/Region";
        Jobs: Record "HRM-Jobs";
        Appt: Record "HRM-Job Applic. - Appt. Type";

    procedure FullName(): Text[100]
    begin
    end;
}

