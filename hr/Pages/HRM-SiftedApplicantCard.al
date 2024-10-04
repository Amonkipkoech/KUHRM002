page 85510 "HRM Sifted Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions,Other Details,Kin Details,Attachment';
    SourceTable = "HRM-Job Applications (B)";
    Editable = true;

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
                    Editable = false;
                }
                field("Employee Requisition No"; Rec."Employee Requisition No")
                {
                    ApplicationArea = all;
                    Caption = 'Application Reff No.';
                    Importance = Promoted;
                    Editable = false;
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
                    Editable = false;
                }
                field("Job Ref No"; Rec."Job Ref No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
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
                field(Citizenship; Rec.Citizenship)
                {
                    ApplicationArea = all;
                    Caption = 'Nationality';
                    trigger OnValidate()
                    begin
                        if Rec.Citizenship = Text19064673 then
                            kenyan := TRUE
                        ELSE
                            kenyan := false;

                        CurrPage.Update();

                    end;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = all;
                    Editable = kenyan;
                }
                field(Initials; Rec.Initials)
                {
                    Visible = false;
                    ApplicationArea = all;
                }

                field("Applicant Type"; Rec."Applicant Type")
                {
                    ApplicationArea = all;
                    Enabled = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }


                field(Gender; Rec.Gender)
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }

                field("Country Details"; Rec."Citizenship Details")
                {
                    ApplicationArea = all;
                    Editable = false;
                }


                // field("Shortlisting Summary"; '')
                // {
                //     ApplicationArea = all;
                //     CaptionClass = Text19064672;
                //     Caption = 'Shortlisting Summary';
                //     Style = Strong;
                //     StyleExpr = TRUE;
                // }
                field(Qualified; Rec.Qualified)
                {
                    ApplicationArea = all;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    Visible = false;
                }
                field("Interview Invitation Sent"; Rec."Interview Invitation Sent")
                {
                    ApplicationArea = all;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    Visible = false;
                }
            }
            group(Personal)
            {
                Caption = 'Personal';
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Visible = false;
                }

                field(Religion; Rec.Religion)
                {
                    ToolTip = 'Specifies the value of the Religion field.';
                    ApplicationArea = All;
                    Editable = enabledisFields;
                }
                field(Denomination; Rec.Denomination)
                {
                    ToolTip = 'Specifies the value of the Denomination field.';
                    ApplicationArea = All;
                    Editable = enabledisFields;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Editable = enabledisFields;
                }

                field("Ethnic Origin"; Rec."Ethnic Origin")
                {
                    ApplicationArea = all;

                    Editable = enabledisFields;
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
                // field("Nature of Disability"; Rec."Nature of Disability")
                // {

                //     ToolTip = 'Specifies the value of the Nature of Disability field.';
                //     ApplicationArea = All;
                //     Editable = enabledisFields;
                // }
                field("Disabling Details"; Rec."Disabling Details")
                {
                    ToolTip = 'Specifies the value of the Nature of Disability field.';
                    ApplicationArea = All;
                    Caption = 'Nature of Disability';
                    Editable = enabledisFields;
                }


                // field("Health Assesment?"; Rec."Health Assesment?")
                // {
                //     ApplicationArea = all;
                // }
                // field("Health Assesment Date"; Rec."Health Assesment Date")
                // {
                //     ApplicationArea = all;
                // }

                field(DAge; DAge)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Age';
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Cell Phone Number"; Rec."Cell Phone Number")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Home Phone Number"; Rec."Home Phone Number")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Visible = false;
                }
                field("Postal Address2"; Rec."Postal Address2")
                {
                    ApplicationArea = all;
                    Caption = 'Postal Address 2';
                    Visible = false;
                }
                field("Postal Address3"; Rec."Postal Address3")
                {
                    ApplicationArea = all;
                    Caption = 'Postal Address 3';
                    Visible = false;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;

                }
                // field("Residential Address"; Rec."Residential Address")
                // {
                //     ApplicationArea = all;

                // }
                // field("Residential Address2"; Rec."Residential Address2")
                // {
                //     ApplicationArea = all;
                // }
                // field("Residential Address3"; Rec."Residential Address3")
                // {
                //     ApplicationArea = all;
                // }
                // field("Post Code2"; Rec."Post Code2")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Post Code 2';
                // }

                // field("Work Phone Number"; Rec."Work Phone Number")
                // {
                //     ApplicationArea = all;
                // }
                // field("Ext."; Rec."Ext.")
                // {
                //     Visible = false;
                //     ApplicationArea = all;
                // }

                // field("Fax Number"; Rec."Fax Number")
                // {
                //     ApplicationArea = all;
                // }
            }
            group("Interview Details")
            {
                field("Interview date"; Rec."Interview date")
                {
                    ApplicationArea = All;

                }
                field("Interview Time"; Rec."Interview Time")
                {
                    ApplicationArea = All;

                }
                field("Interview venue"; Rec."Interview venue")
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

                action("&Reject Application")
                {
                    ApplicationArea = all;
                    Caption = '&Reject Application';
                    Image = Export;
                    Promoted = true;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    begin
                        if Confirm('Reject Application', false) = false then begin exit end;
                        Rec.TestField("Application No");
                        Rec.Sifted := Rec.Sifted::Rejected;
                        Rec.Status := Rec.Status::"Not Successfull";
                        Message('Application Rejected');


                    end;
                }


                action("Send Interview Invitation")
                {
                    ApplicationArea = all;
                    Caption = 'Generate Interview Invitation';
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = false;
                    trigger OnAction()
                    begin
                        HRJobApplications.Reset;
                        HRJobApplications.SetRange(HRJobApplications."Application No", Rec."Application No");
                        if HRJobApplications.Find('-') then
                            REPORT.Run(85525, true, false, HRJobApplications);
                        if Confirm('Send Interview Invitation', false) = false then begin exit end;





                    end;

                }

                action(InterView)
                {
                    Caption = 'Send Interview Invitation';
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    trigger OnAction()
                    begin
                        Send();
                        Message('Notification Successfully Sent!!');
                        Rec.TestField("Application No");
                        Rec.Sifted := Rec.Sifted::Interview;
                    end;

                }
                action(InterviewAttach)
                {
                    Caption = 'Send Interview Invitation Attachment';
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = false;


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
                action("Work Experience")
                {
                    ApplicationArea = all;
                    Caption = 'Work experience';
                    Image = QualificationOverview;
                    RunObject = page "HRM Work Experience";
                    RunPageLink = "Application No" = FIELD("Application No");

                }
                action("Professional Qualification ")
                {
                    ApplicationArea = all;
                    Caption = 'Professional Qualification ';
                    Image = QualificationOverview;
                    RunObject = page "App Prof Qualifications";
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

                action(Attachments1)
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
        kenyan: Boolean;
        Text19064673: Label 'KE';
        Dates: Codeunit "HR Dates";
        DAge: Text[100];
        smtpSetup: Codeunit "Mail Management";
        UserSetup: Record "User Setup";
        EmailSubject: Text[50];
        EmailBody: Text[800];
        EmailRecipient: List of [Text];
        SendMail: Codeunit "Email Message";
        emailObj: Codeunit Email;
        interviewInv: Record "HRM-Job Applications (B)";

    local procedure Send()
    var
        salutation: Text[50];
        FileMgt: Codeunit "File Management";
        hrEmp: Record "HRM-Employee (D)";
        progLeader: text;
        mail: Text;
    begin

        Clear(EmailBody);
        Clear(EmailSubject);
        Clear(mail);
        mail := Rec."E-Mail";
        EmailBody := 'Dear,' + ' ' + Rec."First Name" + ' ' + 'Reference is made to your application for the position of' + ' ' + Rec."Job Applied for Description" + ' ' + 'at our institution.We are glad to inform you that you have been shortlisted for an interview scheduled on' + ' ' + Format(Rec."Interview date") + ' ' + 'on' + ' ' + Rec."Interview Time" + ' ' + 'at' + ' ' + Rec."Interview venue" + '. You are further requested to come with your original certificates(Academic and Professional),publications,National identity card/passport and three letters from your referees(one should be from your Parish Priest/Pastor).Kindly Report to Human Resources office for further direction to the venue of the Interview.Please note that this is a system generated E-mail, kindly send your Reponse to hr@cuea.edu';
        SendMail.Create(mail, EmailSubject, EmailBody);
        emailObj.Send(SendMail, Enum::"Email Scenario"::Notification);
    end;

    local procedure SendWithAttachemnt()
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
        if rec.Find('-') then
            mail := Rec."E-Mail";
        EmailBody := 'Hello, <br> Reference is made to your application for the position of' + ' ' + Rec."Job Applied for Description" + ' ' + 'at our institution.We are glad to inform you that you have been shortlisted for an interview scheduled on' + ' ' + Format(Rec."Interview date") + ' ' + 'on' + ' ' + Rec."Interview Time" + ' ' + 'at' + ' ' + Rec."Interview venue" + '. You are further requested to come with your original certificates(Academic and Prophesionals),publications,National identity card/passport and three latters from your referees(one should be from your parish priest/Pastor).Kindly Report to Human Resources office for further direction to the venue of the Please note that this is a system generated E-mail. Please send your Reponse to hr@cuea.edu';
        EmailSubject := 'INTERVIEW INVITE';
        TempBlob.CreateOutStream(AttachmentOutStream);

        Report.SaveAs(85525, Rec."Application No", ReportFormat::Pdf, AttachmentOutStream);

        TempBlob.CreateInStream(AttachmentInStream);
        SendMail.Create(mail, EmailSubject, EmailBody);

        //SendMail.Create(mail, EmailSubject, EmailBody);

        SendMail.AddAttachment(mail + '.pdf', 'PDF', AttachmentInStream);

        // emailObj.Send(SendMail);

        emailObj.Send(SendMail, Enum::"Email Scenario"::Notification);

    end;






}

