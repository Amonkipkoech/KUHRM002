page 68717 "HRM-Employee Requisition Card"
{
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Action,Process,Job,Request Approval,Approval,Post,Report,Print/send,Advertise';
    SourceTable = "HRM-Employee Requisitions";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Requisition No."; Rec."Requisition No.")
                {
                    ApplicationArea = all;
                    Editable = "Requisition No.Editable";
                    Importance = Promoted;
                }
                field("Requisition Date"; Rec."Requisition Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                }
                field(Requestor; Rec.Requestor)
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Visible = false;
                }
                field("Requestor Staff ID"; Rec."Requestor Staff ID")
                {
                    ApplicationArea = All;

                }

                field("Requestor Name"; Rec."Requestor Name")
                {
                    ApplicationArea = All;
                    //Editable = false;
                }
                field("Staff Exiting StaffID"; Rec."Staff Exiting StaffID")
                {
                    ApplicationArea = All;

                }
                field("Staff Exiting Name"; Rec."Staff Exiting Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Department; Rec.Department)
                {

                }
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = all;
                    Caption = 'Position To Be Advertised';
                }
                field("Position Description"; Rec."Position Description")
                {
                    ApplicationArea = ALL;
                    Caption = ' Job Specialization ';
                }
                field("Job Description"; Rec."Job Description")
                {
                    ApplicationArea = all;
                }
                field("Job Ref No"; Rec."Job Ref No")
                {
                    ApplicationArea = all;
                }
                field("Job Grade"; Rec."Job Grade")
                {
                    ApplicationArea = all;
                    Enabled = false;
                    Caption = 'Proposed Job Grade';
                    Visible = false;
                }
                field("Reporting To:"; Rec."Reporting To:")
                {
                    ApplicationArea = All;
                }
                field("Reason For Request"; Rec."Reason For Request")
                {
                    ApplicationArea = all;
                    Editable = "Reason For RequestEditable";
                    MultiLine = true;
                }
                field("Type of Contract Required"; Rec."Type of Contract Required")
                {
                    ApplicationArea = all;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = all;
                    Editable = PriorityEditable;
                }
                field("Vacant Positions"; Rec."Vacant Positions")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Caption = 'Number of Vacancies to Be Field';
                }
                field("Required Positions"; Rec."Required Positions")
                {
                    ApplicationArea = all;
                    Editable = "Required PositionsEditable";
                    Importance = Promoted;
                }
                field("Opening Date"; Rec."Opening Date")
                {
                    ApplicationArea = all;
                    visible = false;
                }
                field("Closing Date"; Rec."Closing Date")
                {
                    ApplicationArea = all;
                    Editable = "Closing DateEditable";
                    Importance = Promoted;
                    visible = false;
                }
                field("Proposed Starting Date"; Rec."Proposed Starting Date")
                {
                    ApplicationArea = All;

                }
                field("Requisition Type"; Rec."Requisition Type")
                {
                    ApplicationArea = all;
                    Editable = "Requisition TypeEditable";
                    Importance = Promoted;
                }
                field(Advertised; Rec.Advertised)
                {
                    ApplicationArea = all;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Editable = true;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
            }
            group("Additional Information")
            {
                Caption = 'Additional Information';
                field("Any Additional Information"; Rec."Any Additional Information")
                {
                    Caption = 'Approval Comments';
                    ApplicationArea = all;
                    Editable = true;
                    MultiLine = True;

                }
                field("Reason for Request(Other)"; Rec."Reason for Request(Other)")
                {
                    ApplicationArea = all;
                    Editable = ReasonforRequestOtherEditable;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755022; "HRM-Employee Req. Factbox")
            {
                ApplicationArea = all;
                SubPageLink = "Job ID" = FIELD("Job ID");
            }
            systempart(Control1102755020; Outlook)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Fu&nctions")
            {
                Caption = 'Fu&nctions';
                action(Print)
                {
                    ApplicationArea = all;
                    Caption = 'Print/Send';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Category9;
                    //RunObject =  report "HR Employee Requisition";

                }
                action(Advertise)
                {
                    ApplicationArea = all;
                    Caption = 'Advertise';
                    Image = Salutation;
                    Promoted = true;
                    PromotedCategory = Category10;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //For external advertisement
                        //TESTFIELD("Requisition Type","Requisition Type"::Internal);
                        if Rec."Requisition Type" <> Rec."Requisition Type"::Internal then
                            if Rec.Advertised then begin
                                if not Confirm('Are you sure you want to Un do advertisement for this job', false) then exit;
                                Rec.Advertised := false;
                                Rec.Modify;
                                Message('Are you sure you want to Un do advertisement for this job', Rec."Job Ref No");

                            end else begin
                                if not Confirm('Are you sure you want to advertise this Job', false) then exit;
                                Rec.Advertised := true;
                                Rec.Modify;
                                Message('Job vacancy %1 has been successfuly advertised', Rec."Job Ref No");
                            end
                        else
                            //For Internal advertisement.
                            if Rec."Requisition Type" = Rec."Requisition Type"::Internal then
                                HREmp.SetRange(HREmp.Status, HREmp.Status::Active);
                        if HREmp.Find('-') then

                            //GET E-MAIL PARAMETERS FOR JOB APPLICATIONS
                            HREmailParameters.Reset;
                        HREmailParameters.SetRange(HREmailParameters."Associate With", HREmailParameters."Associate With"::"Vacancy Advertisements");
                        if HREmailParameters.Find('-') then begin
                            repeat
                            //todo   HREmp.TestField(HREmp."Company E-Mail");
                            //todo  SMTP.CreateMessage(HREmailParameters."Sender Name", HREmailParameters."Sender Address", HREmp."Company E-Mail",
                            //todo  HREmailParameters.Subject, 'Dear' + ' ' + HREmp."First Name" + ' ' +
                            //todo   HREmailParameters.Body + ' ' + Rec."Job Description" + ' ' + HREmailParameters."Body 2" + ' ' + Format(Rec."Closing Date") + '. ' +
                            //todo   HREmailParameters."Body 3", true);
                            //todo   SMTP.Send();
                            until HREmp.Next = 0;

                            Message('All Employees have been notified about this vacancy');
                            HREmpReq.Advertised := true;

                        end;
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    RunObject = Page "Fin-Approval Entries";
                    RunPageLink = "Document No." = field("Requisition No.");
                }
                // action("&Approvals")
                // {
                //     ApplicationArea = all;
                //     Caption = '&Approvals';
                //     Image = Approvals;
                //     Promoted = true;
                //     PromotedCategory = Category6;

                //     trigger OnAction()
                //     begin
                //         DocumentType := DocumentType::"Employee Requisition";
                //         ApprovalEntries.Setfilters(DATABASE::"HRM-Employee Requisitions", DocumentType::"Employee Requisition", Rec."Requisition No.");
                //         ApprovalEntries.Run;
                //     end;
                // }
                action("&Send Approval Request")
                {

                    Caption = '&Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        approvalMang: Codeunit "Approval Mgmnt. Ext(hr)";
                    begin
                        approvalMang.CheckEmployeeRequisitionApprovalPossible(Rec);
                        approvalMang.OnSendEmployeeRequisitionForApproval(Rec);

                        //Rec."Job ID" := USERID;
                        Rec."Requisition Date" := TODAY;
                        Rec.Status := Rec.Status::Approved;
                        Rec."Requisition Status" := Rec."Requisition Status"::" "
                    end;
                }
                //     action(sendApproval)
                // {
                //     Caption = 'Submit Application';
                //     Image = SendApprovalRequest;
                //     Promoted = true;
                //     PromotedCategory = process;
                //     PromotedIsBig = true;
                //     ApplicationArea = All;

                //     trigger OnAction()
                //     var
                //         ApprovalMgt: Codeunit "Export F/O Consolidation";
                //         showmessage: Boolean;
                //         ManualCancel: Boolean;
                //         State: Option Open,"Pending Approval",Cancelled,Approved;
                //         DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                //         tableNo: Integer;
                //     begin
                //         //Release the Application for Approval
                //         Rec.TESTFIELD("First Name");
                //         Rec.TESTFIELD(Surname);
                //         Rec.TESTFIELD("First Degree Choice");
                //         Rec.TESTFIELD("Settlement Type");
                //         Rec.TESTFIELD("Intake Code");
                //         Rec.TESTFIELD(Campus);
                //         Rec.TESTFIELD("Next of kin Name");
                //         Rec.TESTFIELD("Next of kin Mobile");
                //         Rec.TESTFIELD("Next of Kin R/Ship");
                //         Rec.TESTFIELD("Fee payer Names");
                //         Rec.TESTFIELD("Fee payer mobile");
                //         Rec.TESTFIELD("Fee payer R/Ship");
                //         Rec.TESTFIELD("Fee payer Email");
                //         Rec.TESTFIELD("Passport Number");
                //         Rec.TESTFIELD("Telephone No. 1");
                //         Rec.TESTFIELD(Email);
                //         Rec.TESTFIELD("First Degree Choice");
                //         Rec.TESTFIELD("Programme Level");
                //         Rec.TESTFIELD("First Choice Stage");
                //         Rec.TESTFIELD("Mode of Study");
                //         Rec.TESTFIELD("First Choice Semester");

                //         //TESTFIELD("Application Form Receipt No.");
                //         //TESTFIELD("Address for Correspondence1");
                //         //TESTFIELD("Date Of Birth");
                //         IF AppSetup.GET() THEN
                //             //IF (TODAY-"Date Of Birth")<(AppSetup."Minimum Age"*365) THEN ERROR('The Minimum Required Age for Admission is '+FORMAT(AppSetup."Minimum Age")+' years');

                //             IF CONFIRM('Send this Application for Approval?', TRUE) = FALSE THEN EXIT;

                //         IF Rec."Application No." = '' THEN
                //             ERROR('There are no Applicants Specified.');

                //         Apps.RESET;
                //         Apps.SETRANGE(Apps."Application No.", Rec."Application No.");

                //         IF Rec."Application Date" = 0D THEN
                //             ERROR('Provide the Application Date First!');
                //         if Rec."Receipt Slip No." = '' then
                //             error('Provide a valid receip no.');

                //         /* Rec."User ID" := USERID;
                //         Rec."Date of Receipt" := TODAY;
                //         Rec."Documents Verified" := Rec."Documents Verified"::Yes;
                //         Rec.Status := Rec.Status::"Provisional Admission";
                //         Rec.MODIFY; */


                //     end;}

                action("&Cancel Approval Request")
                {

                    Caption = '&Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        approvalMang: Codeunit "Approval Mgmnt. Ext(hr)";
                    begin
                        approvalMang.OnCancelEmployeeRequisitionForApproval(Rec);
                    end;
                }
                action("Mark as Closed/Open")
                {
                    ApplicationArea = all;
                    Caption = 'Mark as Closed/Open';
                    Image = ReopenCancelled;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Rec.Closed then begin
                            if not Confirm('Are you sure you want to Re-Open this Document', false) then exit;
                            Rec.Closed := false;
                            Rec.Modify;
                            Message('Employee Requisition %1 has been Re-Opened', Rec."Requisition No.");

                        end else begin
                            if not Confirm('Are you sure you want to close this Document', false) then exit;
                            Rec.Closed := true;
                            Rec.Modify;
                            Message('Employee Requisition %1 has been marked as Closed', Rec."Requisition No.");
                        end;
                    end;
                }
                action("Re-Open")
                {
                    ApplicationArea = all;
                    Caption = 'Re-Open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.Status := Rec.Status::New;
                        Rec.Modify;
                    end;
                }
            }
            group(Job)
            {
                Caption = 'Job';
                action(Requirements)
                {
                    ApplicationArea = all;
                    Caption = 'Requirements';
                    Image = JobListSetup;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HRM-Job Requirement Lines(B)";
                    RunPageLink = "Job Id" = FIELD("Job ID");
                }
                action(Responsibilities)
                {
                    ApplicationArea = all;
                    Caption = 'Responsibilities';
                    Image = JobResponsibility;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HRM-Job Resp. Lines";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateControls;
        /*
        HRLookupValues.SETRANGE(HRLookupValues.Code,"Type of Contract Required");
        IF HRLookupValues.FIND('-') THEN
        ContractDesc:=HRLookupValues.Description;
        */

    end;

    trigger OnInit()
    begin
        TypeofContractRequiredEditable := true;
        AnyAdditionalInformationEditab := true;
        "Required PositionsEditable" := true;
        "Requisition TypeEditable" := true;
        "Closing DateEditable" := true;
        PriorityEditable := true;
        ReasonforRequestOtherEditable := true;
        "Reason For RequestEditable" := true;
        "Responsibility CenterEditable" := true;
        "Job IDEditable" := true;
        "Requisition DateEditable" := true;
        "Requisition No.Editable" := true;
    end;

    var
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval";
        ApprovalEntries: Page "Approval Entries";
        //todo  ApprovalMgt: Codeunit "Approvals Management";
        HREmpReq: Record "HRM-Employee Requisitions";
        SMTP: Codeunit "Email Message";
        HRSetup: Record "HRM-Setup";
        CTEXTURL: Text[30];
        HREmp: Record "HRM-Employee (D)";
        HREmailParameters: Record "HRM-EMail Parameters";
        ContractDesc: Text[30];
        HRLookupValues: Record "HRM-Lookup Values";
        [InDataSet]
        "Requisition No.Editable": Boolean;
        [InDataSet]
        "Requisition DateEditable": Boolean;
        [InDataSet]
        "Job IDEditable": Boolean;
        [InDataSet]
        "Responsibility CenterEditable": Boolean;
        [InDataSet]
        "Reason For RequestEditable": Boolean;
        [InDataSet]
        ReasonforRequestOtherEditable: Boolean;
        [InDataSet]
        PriorityEditable: Boolean;
        [InDataSet]
        "Closing DateEditable": Boolean;
        [InDataSet]
        "Requisition TypeEditable": Boolean;
        [InDataSet]
        "Required PositionsEditable": Boolean;
        [InDataSet]
        AnyAdditionalInformationEditab: Boolean;
        [InDataSet]
        TypeofContractRequiredEditable: Boolean;

    procedure TESTFIELDS()
    begin
        Rec.TestField("Job ID");
        Rec.TestField("Closing Date");
        Rec.TestField("Type of Contract Required");
        Rec.TestField("Requisition Type");
        Rec.TestField("Required Positions");
        if Rec."Reason For Request" = Rec."Reason For Request"::Other then
            Rec.TestField("Reason for Request(Other)");
    end;

    procedure UpdateControls()
    begin

        if Rec.Status = Rec.Status::New then begin
            "Requisition No.Editable" := true;
            "Requisition DateEditable" := true;
            "Job IDEditable" := true;
            "Responsibility CenterEditable" := true;
            "Reason For RequestEditable" := true;
            ReasonforRequestOtherEditable := true;
            PriorityEditable := true;
            "Closing DateEditable" := true;
            "Requisition TypeEditable" := true;
            "Required PositionsEditable" := true;
            "Required PositionsEditable" := true;
            AnyAdditionalInformationEditab := true;
            TypeofContractRequiredEditable := true;
        end else begin
            "Requisition No.Editable" := false;
            "Requisition DateEditable" := false;
            "Job IDEditable" := false;
            "Responsibility CenterEditable" := false;
            "Reason For RequestEditable" := false;
            ReasonforRequestOtherEditable := false;
            PriorityEditable := false;
            "Closing DateEditable" := false;
            "Requisition TypeEditable" := false;
            "Required PositionsEditable" := false;
            "Required PositionsEditable" := false;
            AnyAdditionalInformationEditab := false;

            TypeofContractRequiredEditable := false;
        end;
    end;
}

