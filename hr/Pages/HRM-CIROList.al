page 85502 "HRM List Submitted to CIRO"
{
    CardPageID = "HRM CIRO CARD";
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'Action,Process,Job,Report,Print/send';
    SourceTable = "HRM-Employee Requisitions";
    SourceTableView = where(CIRO = filter(true), Advertised = filter(false));


    layout
    {
        area(content)
        {
            repeater(General)
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
                }
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = all;
                    Caption = 'Position To Be Advertised';
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
                }
                field("Reporting To:"; Rec."Reporting To:")
                {
                    ApplicationArea = All;
                }
                field("Reason For Request"; Rec."Reason For Request")
                {
                    ApplicationArea = all;
                    Editable = "Reason For RequestEditable";
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
                }
                field("Closing Date"; Rec."Closing Date")
                {
                    ApplicationArea = all;
                    Editable = "Closing DateEditable";
                    Importance = Promoted;
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
                Visible = false;
                field("Any Additional Information"; Rec."Any Additional Information")
                {
                    ApplicationArea = all;
                    Editable = AnyAdditionalInformationEditab;
                }
                field("Reason for Request(Other)"; Rec."Reason for Request(Other)")
                {
                    ApplicationArea = all;
                    Editable = ReasonforRequestOtherEditable;
                }
            }
        }
        // area(factboxes)
        // {

        //     part(Control1102755022; "HRM-Employee Req. Factbox")
        //     {
        //         ApplicationArea = all;
        //         SubPageLink = "Job ID" = FIELD("Job ID");
        //     }
        //     systempart(Control1102755020; Outlook)
        //     {
        //         ApplicationArea = All;
        //     }
        // }
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
                    Promoted = false;



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
                action("&Approvals")
                {
                    ApplicationArea = all;
                    Caption = '&Approvals';
                    Image = Approvals;
                    Promoted = false;


                    trigger OnAction()
                    begin
                        DocumentType := DocumentType::"Employee Requisition";
                        ApprovalEntries.Setfilters(DATABASE::"HRM-Employee Requisitions", DocumentType, Rec."Requisition No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("&Send Approval Request")
                {

                    Caption = '&Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = false;

                    trigger OnAction()
                    var
                        approvalMang: Codeunit "Approval Mgmnt. Ext(hr)";
                    begin
                        approvalMang.CheckEmployeeRequisitionApprovalPossible(Rec);
                        approvalMang.OnSendEmployeeRequisitionForApproval(Rec);

                        //Rec."Job ID" := USERID;
                        Rec."Requisition Date" := TODAY;
                        //Rec.Status := Rec.Status::"Appro";
                    end;
                }

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
                    Promoted = false;


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
                    Promoted = false;


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




