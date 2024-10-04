page 69003 "HRM-Job Applicants Qualified"
{
    CardPageID = "HRM-Job Apps. Qualified";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HRM-Job Applications (B)";
    SourceTableView = WHERE(Qualified = FILTER(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Date of Interview"; Rec."Date of Interview")
                {
                    ApplicationArea = all;
                }
                field("From Time"; Rec."From Time")
                {
                    ApplicationArea = all;
                }
                field("To Time"; Rec."To Time")
                {
                    ApplicationArea = all;
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = all;
                }
                field(Floor; Rec.Floor)
                {
                    ApplicationArea = all;
                }
                field("Room No"; Rec."Room No")
                {
                    ApplicationArea = all;
                }
                field("Interview Type"; Rec."Interview Type")
                {
                    ApplicationArea = all;
                }
                field(Qualified; Rec.Qualified)
                {
                    ApplicationArea = all;
                }
                field("Interview Invitation Sent"; Rec."Interview Invitation Sent")
                {
                    ApplicationArea = all;
                }
                field("Job Applied For"; Rec."Job Applied For")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Applicant)
            {
                Caption = 'Applicant';
                action("Send Interview Invitation")
                {
                    ApplicationArea = all;
                    Caption = 'Send Interview Invitation';
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        //IF CONFIRM('Send this Requisition for Approval?',TRUE)=FALSE THEN EXIT;
                        if not Confirm(Text002, false) then exit;

                        //todo Rec.TestField(Qualified, Rec.Qualified::);
                        HRJobApplications.SetRange(HRJobApplications."Application No", Rec."Application No");
                        CurrPage.SetSelectionFilter(HRJobApplications);
                        if HRJobApplications.Find('-') then
                            //GET E-MAIL PARAMETERS FOR JOB APPLICATIONS
                            HREmailParameters.Reset;
                        HREmailParameters.SetRange(HREmailParameters."Associate With", HREmailParameters."Associate With"::"Interview Invitations");
                        if HREmailParameters.Find('-') then begin
                            repeat
                                HRJobApplications.TestField(HRJobApplications."E-Mail");
                            //todo  SMTP.CreateMessage(HREmailParameters."Sender Name", HREmailParameters."Sender Address", HRJobApplications."E-Mail",
                            //todo   HREmailParameters.Subject, 'Dear' + ' ' + HRJobApplications."First Name" + ' ' + HREmailParameters.Body + ' ' + HRJobApplications."Job Applied for Description" + ' ' + 'applied on' + Format(Rec."Date Applied") + ' ' + HREmailParameters."Body 2" +//,TRUE);
                            //todo  Format(HRJobApplications."Date of Interview") + ' ' + 'Starting ' + ' ' + Format(HRJobApplications."From Time") + ' ' + 'to' + Format(HRJobApplications."To Time") + ' ' + 'at' + HRJobApplications.Venue + '.', true);
                            //HREmailParameters.Body,TRUE);
                            //todo  SMTP.Create();
                            until HRJobApplications.Next = 0;

                            if Confirm('Do you want to send this invitation alert?', false) = true then begin
                                Rec."Interview Invitation Sent" := true;
                                Rec.Modify;
                                Message('All Qualified shortlisted candidates have been invited for the interview ')
                            end;
                        end;
                    end;
                }
                action("Job Interview details")
                {
                    ApplicationArea = all;
                    Caption = 'Job Interview details';
                    Image = ApplicationWorksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HRM-Job Interview";
                    RunPageLink = "Applicant No" = FIELD("Application No");
                }
                action(Card)
                {
                    ApplicationArea = all;
                    Caption = 'Card';
                    Image = Card;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Page "HRM-Job Applications Card";
                    RunPageLink = "Application No" = FIELD("Application No");
                }
                action("&Upload to Employee Card")
                {
                    ApplicationArea = all;
                    Caption = '&Upload to Employee Card';
                    Image = Export;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        //TESTFIELDS;
                        Interview.Reset;
                        Interview.SetRange(Interview."Applicant No", Rec."Application No");
                        if Interview.Find('-') then begin
                            if Interview."Total Score" < 0 then begin
                                Error('Applicants interview details must be entered before hiring');
                            end;
                            if not Confirm(Text001, false) then exit;
                            if Rec."Employee No" = '' then begin

                                IF NOT CONFIRM('Are you sure you want to Upload Applications Information to the Employee Card', FALSE) THEN EXIT;
                                HRJobApplications.SetFilter(HRJobApplications."Application No", Rec."Application No");
                                REPORT.Run(51177, true, false, HRJobApplications);
                            end else begin
                                Message('This applicants information already exists in the employee card');
                            end;
                        end;
                    end;
                }
                action(Qualifications)
                {
                    ApplicationArea = all;
                    Caption = 'Qualifications';
                    Image = QualificationOverview;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Page "ACA-Applicant Qualifications";
                    RunPageLink = "Application No" = FIELD("Application No");
                }
                action(Referees)
                {
                    ApplicationArea = all;
                    Caption = 'Referees';
                    Image = ContactReference;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Page "HRM-Applicant Referees";
                    RunPageLink = "Job Application No" = FIELD("Application No");
                }
                action(Hobbies)
                {
                    ApplicationArea = all;
                    Caption = 'Hobbies';
                    Image = Holiday;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Page "HRM-Applicant Hobbies";
                    RunPageLink = "Job Application No" = FIELD("Application No");
                }
            }
            group(Print)
            {
                Caption = 'Print';
                action("&Print")
                {
                    ApplicationArea = all;
                    Caption = '&Print';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedCategory = Category6;

                    trigger OnAction()
                    begin
                        HRJobApplications.Reset;
                        HRJobApplications.SetRange(HRJobApplications."Application No", Rec."Application No");
                        if HRJobApplications.Find('-') then
                            REPORT.Run(39003925, true, true, HRJobApplications);
                    end;
                }
            }
        }
    }

    var
        HRJobApplications: Record "HRM-Job Applications (B)";
        //ApprovalmailMgt: Codeunit "Approvals Mgt Notification";
        SMTP: Codeunit "Email Message";
        CTEXTURL: Text[30];
        HREmailParameters: Record "HRM-EMail Parameters";
        Text001: Label 'Are you sure you want to Upload Applicants Details to the Employee Card?';
        Text002: Label 'Are you sure you want to Send this Interview invitation?';
        Interview: Record "HRM-Job Interview";

    procedure TESTFIELDS()
    begin
        Rec.TestField("Total Score");
    end;
}

