page 85515 "HRM Successfull Candidate"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions,Other Details,Kin Details,Attachment';
    SourceTable = "HRM-Job Applications (B)";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Date Applied"; Rec."Date Applied")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field(Initials; Rec.Initials)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Job Type"; Rec."Job Type")
                {
                    ToolTip = 'Specifies the value of the Job Type field.';
                    ApplicationArea = All;
                }

                field("Applicant Type"; Rec."Applicant Type")
                {
                    ApplicationArea = all;
                    Enabled = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = all;
                    Caption = 'Internal';
                    Editable = true;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = all;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field(Citizenship; Rec.Citizenship)
                {
                    ApplicationArea = all;
                }
                field("Country Details"; Rec."Citizenship Details")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Employee Requisition No"; Rec."Employee Requisition No")
                {
                    ApplicationArea = all;
                    Caption = 'Application Reff No.';
                    Importance = Promoted;
                }
                field("Job Applied For"; Rec."Job Applied For")
                {
                    ApplicationArea = all;
                    Caption = 'Position Applied For';
                    Enabled = true;
                    Importance = Promoted;
                }
                field("Job Applied for Description"; Rec."Job Applied for Description")
                {
                    ApplicationArea = all;
                    Caption = 'Job Description';
                }
                field("Interview Marks"; Rec."Interview Marks")
                {
                    ApplicationArea = All;
                }
                field("Shortlisting Summary"; '')
                {
                    ApplicationArea = all;
                    CaptionClass = Text19064672;
                    Caption = 'Shortlisting Summary';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Qualified; Rec.Qualified)
                {
                    ApplicationArea = all;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }

            }
            group(Personal)
            {
                Caption = 'Personal';
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Visible = false;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field(Religion; Rec.Religion)
                {
                    ToolTip = 'Specifies the value of the Religion field.';
                    ApplicationArea = All;
                }
                field(Denomination; Rec.Denomination)
                {
                    ToolTip = 'Specifies the value of the Denomination field.';
                    ApplicationArea = All;
                }

                field("Ethnic Origin"; Rec."Ethnic Origin")
                {
                    ApplicationArea = all;
                }
                field(Disabled; Rec.Disabled)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        if Rec.Disabled = Rec.Disabled::Yes then
                            enabledisFields := TRUE
                        ELSE
                            enabledisFields := false;

                        CurrPage.Update();

                    end;
                }
                field("Disability Code"; Rec."Disability Code")
                {
                    ToolTip = 'Specifies the value of the Disability Code field.';
                    ApplicationArea = All;
                    Editable = enabledisFields;
                }
                field("Nature of Disability"; Rec."Nature of Disability")
                {
                    Editable = enabledisFields;
                    ToolTip = 'Specifies the value of the Nature of Disability field.';
                    ApplicationArea = All;
                }


                field("Health Assesment?"; Rec."Health Assesment?")
                {
                    ApplicationArea = all;
                }
                field("Health Assesment Date"; Rec."Health Assesment Date")
                {
                    ApplicationArea = all;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = all;
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }

            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Home Phone Number"; Rec."Home Phone Number")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Postal Address2"; Rec."Postal Address2")
                {
                    ApplicationArea = all;
                    Caption = 'Postal Address 2';
                }
                field("Postal Address3"; Rec."Postal Address3")
                {
                    ApplicationArea = all;
                    Caption = 'Postal Address 3';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = all;
                }
                field("Residential Address"; Rec."Residential Address")
                {
                    ApplicationArea = all;
                }
                field("Residential Address2"; Rec."Residential Address2")
                {
                    ApplicationArea = all;
                }
                field("Residential Address3"; Rec."Residential Address3")
                {
                    ApplicationArea = all;
                }
                field("Post Code2"; Rec."Post Code2")
                {
                    ApplicationArea = all;
                    Caption = 'Post Code 2';
                }
                field("Cell Phone Number"; Rec."Cell Phone Number")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Work Phone Number"; Rec."Work Phone Number")
                {
                    ApplicationArea = all;
                }
                field("Ext."; Rec."Ext.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Fax Number"; Rec."Fax Number")
                {
                    ApplicationArea = all;
                }
                field("Interview date"; Rec."Interview date")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755009; "HRM-Job Applications Factbox")
            {
                ApplicationArea = all;
                SubPageLink = "Application No" = FIELD("Application No");
            }
            systempart(Control1102755008; Outlook)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Functions")
            {
                Caption = '&Functions';


                action("&Upload to Employee Card")
                {
                    ApplicationArea = all;
                    Caption = '&Upload to Employee Card';
                    Image = ImportDatabase;
                    Promoted = true;
                    PromotedCategory = Category4;


                    trigger OnAction()
                    begin
                        if Rec."Employee No" = '' then begin
                            IF NOT CONFIRM('Are you sure you want to Upload Applicants information to the Employee Card', FALSE) THEN EXIT;
                            HRJobApplications.SetFilter(HRJobApplications."Application No", Rec."Application No");
                            REPORT.Run(51177, true, false, HRJobApplications);

                            // AcademicQual.Reset();
                            // AcademicQual.SetRange(AcademicQual."Employee No.", Rec."Employee No");
                            // if AcademicQual.Find('-') then
                            // AcademicQual."Academic Qualification" := appQual."Qualification Description";


                            //MESSAGE('Requires a setup of the number series for it to work!');
                        end else begin
                            Message('This applicants information already exists in the employee card');
                        end;

                        AcademicQual.Modify()
                    end;
                }
                action(offer)
                {
                    ApplicationArea = All;
                    Caption = 'Generate Offer Letter';
                    Image = Insurance;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        inv: Record "HRM-Job Applications (B)";
                    begin
                        inv.Reset();
                        inv.SetRange("Application No", Rec."Application No");
                        Report.Run(85524, true, true, inv);
                    end;

                    // RunObject = Report "HRM-Offer letter";
                }
                action(InterView)
                {
                    Caption = 'Send Offer Letter On Email';
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    trigger OnAction()
                    begin
                        SendWithAttachemnts();
                        Message('Notification Successfully Sent!!');
                        //Rec.TestField("Application No");
                    end;

                }

                action(oFF)
                {
                    ApplicationArea = All;
                    Caption = 'Passed Interview';
                    Image = MailAttachment;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = True;
                    Visible = false;
                    trigger OnAction()
                    begin
                        if Confirm('This will move this application to the awaiting offer letter list', false) = false then begin exit end;
                        Rec.TestField("Application No");
                        Rec."Interview Status" := Rec."Interview Status"::Passed;
                        Rec.Modify();
                        Message('The Applicant Passed the Interview');



                    end;


                }
                action(upload)
                {
                    ApplicationArea = All;
                    Caption = 'Upload Interview Results';
                    Image = Apply;
                    Promoted = True;
                    PromotedCategory = Category4;
                    PromotedIsBig = True;
                    RunObject = Page "Document Attachment Details";
                    RunPageLink = "No." = field("Application No");



                }
                action("&Failed Interview")
                {
                    ApplicationArea = all;
                    Caption = '&Failed Interview';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;
                    trigger OnAction()
                    begin
                        if Confirm('Did this Applicant Fail the Interview', false) = false then begin exit end;
                        Rec.TestField("Application No");
                        Rec."Interview Status" := Rec."Interview Status"::Failed;
                        Rec.Sifted := Rec.Sifted::Rejected;
                        Rec.Modify();
                        Message('The Applicant Failed to Pass the Interview');



                    end;
                }





                action(Qualifications)
                {
                    ApplicationArea = all;
                    Caption = 'Academic Qualifications';
                    Image = QualificationOverview;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "ACA-Applicant Qualifications";
                    RunPageLink = "Application No" = FIELD("Application No");
                }
                action("Next of Keen")
                {
                    ApplicationArea = all;
                    Caption = 'Next Of Kin';
                    Image = Simulate;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "HRM-Employees Kin";
                    RunPageLink = "Employee Code" = FIELD("Application No");
                }
                action(Referees)
                {
                    ApplicationArea = all;
                    Caption = 'Referees';
                    Image = ContactReference;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HRM-Applicant Referees";
                    RunPageLink = "Job Application No" = FIELD("Application No");
                }
                action(Hobbies)
                {
                    ApplicationArea = all;
                    Caption = 'Hobbies';
                    Image = Holiday;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HRM-Applicant Hobbies";
                    RunPageLink = "Job Application No" = FIELD("Application No");
                    Visible = false;
                }
                action("&Print")
                {
                    ApplicationArea = all;
                    Caption = '&Print';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HRJobApplications.Reset;
                        HRJobApplications.SetRange(HRJobApplications."Application No", Rec."Application No");
                        if HRJobApplications.Find('-') then
                            REPORT.Run(51153, true, true, HRJobApplications);
                        //REPORT.Run(51153, true, true);

                    end;
                }

                action(EDMS)
                {
                    ApplicationArea = All;
                    Caption = 'Applicant Attachments';
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        RecRef: RecordRef;
                        DocumentAttachment: Page "HRM Document Attachment";
                    begin
                        Clear(DocumentAttachment);
                        RecRef.GETTABLE(Rec);
                        DocumentAttachment.OpenForRecReference(RecRef);
                        DocumentAttachment.RUNMODAL;
                    end;
                }
            }
        }
    }

    var
        HRJobApplications: Record "HRM-Job Applications (B)";
        AcademicQual: Record "HRM-Emp. Qualifications Final";
        appQual: Record "HRM-Applicant Qualifications";
        SMTP: Codeunit "Email Message";
        HREmailParameters: Record "HRM-EMail Parameters";
        Employee: Record "HRM-Employee (D)";
        Text19064672: Label 'Shortlisting Summary';
        enabledisFields: Boolean;
        CTEXTURL: Text[30];
        Text001: Label 'Are you sure you want to Upload Applicants Details to the Employee Card?';
        Text002: Label 'Are you sure you want to Send this Interview invitation?';
        Interview: Record "HRM-Job Interview";
        EmailSubject: Text[50];
        EmailBody: Text[800];
        EmailRecipient: List of [Text];
        SendMail: Codeunit "Email Message";
        emailObj: Codeunit Email;


    local procedure SendWithAttachemnts()
    var
        salutation: Text[50];
        FileMgt: Codeunit "File Management";
        AttachmentInStream: InStream;
        AttachmentOutStream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        mail: Text;
    begin

        Clear(EmailBody);
        Clear(EmailSubject);
        Clear(EmailRecipient);
        rec.Reset();
        rec.SetRange("Application No", rec."Application No");
        if rec.Find('-') then begin
            mail := Rec."E-Mail";
            EmailBody := 'Dear ' + Rec."First Name" + ', Please find attached your offfer Letter. For any equiries, kindly send them to hr@cuea.edu';
            EmailSubject := 'OFFER LETTER';
            TempBlob.CreateOutStream(AttachmentOutStream);
            Report.SaveAs(Report::"HRM-Offer letter", rec."Application No", ReportFormat::Pdf, AttachmentOutStream);
            TempBlob.CreateInStream(AttachmentInStream);
            SendMail.Create(mail, EmailSubject, EmailBody);
            SendMail.AddAttachment(mail + '.pdf', 'PDF', AttachmentInStream);
            emailObj.Send(SendMail, Enum::"Email Scenario"::Notification);
        end;


    end;
}

