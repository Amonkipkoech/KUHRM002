page 68981 "HRM-Induction Schedule List"
{
    CardPageID = "HRM-Induction Sched. Card";
    Editable = false;
    PageType = List;
    SourceTable = "HRM-Induction Schedule";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Induction Code"; Rec."Induction Code")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field(Selected; Rec.Selected)
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }
                field("Induction Period"; Rec."Induction Period")
                {
                    ApplicationArea = All;
                }
                field("Induction Start date"; Rec."Induction Start date")
                {
                    ApplicationArea = All;
                }
                field("Induction End  date"; Rec."Induction End  date")
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(ActionGroup1102755003)
            {
            }
            action("&Staff Induction Entries")
            {
                Caption = '&Staff Induction Entries';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    DocumentType := DocumentType::"Induction Approval";
                    Inductionschedule.Reset;
                    Inductionschedule.SetRange(Inductionschedule.Selected, true);
                    Inductionschedule.SetRange(Inductionschedule."Department Code", Rec."Department Code");
                    if Inductionschedule.Find('-') then begin

                        //ENSURE SELECTED RECORDS DO NOT EXCEED ONE
                        Number := 0;
                        Number := Inductionschedule.Count;
                        if Number > 1 then begin
                            Error('You cannot have more than one application selected');
                            // ERROR(FORMAT(Number)+' applications selected');

                        end;

                        ApprovalEntries.Setfilters(DATABASE::"HRM-Induction Schedule", DocumentType, Inductionschedule."Department Code");
                        ApprovalEntries.Run;
                    end else begin
                        Error('No Application Selected');
                    end;
                end;
            }
            action("Send Request to HOD/Superviisor")
            {
                Caption = 'Send Request to HOD/Superviisor';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    Inductionschedule.Reset;
                    Inductionschedule.SetRange(Inductionschedule.Selected, true);
                    Inductionschedule.SetRange(Inductionschedule."Induction Code", Rec."Induction Code");
                    Inductionschedule.SetRange(Inductionschedule."Department Code", Rec."Department Code");
                    if Inductionschedule.Find('-') then begin
                        //ENSURE THAT SELECTED RECORDS DO NOT EXCEED ONE
                        Number := 0;
                        Number := Inductionschedule.Count;
                        if Number > 1 then begin
                            Error('You cannot have more than one application selected');
                        end;

                        TESTFIELDS;

                        if Confirm('Send this Induction Schedule for Approval?', true) = false then exit;

                        //ApprovalMgt.SendInducAppApprovalRequest(Inductionschedule);

                    end else begin
                        Message('Please Select one Induction schedule');
                    end;
                end;
            }
            action("&Cancel Induction Request")
            {
                Caption = '&Cancel Induction Request';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = All;
            }
            action("HR Staff  Induction Report")
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                ApplicationArea = All;
                //todo RunObject = Report "Hostel Status Summary Report";
            }
        }
    }

    var
        "Induction`": Record "HRM-Induction Schedule";
        DepartmentName: Text[40];
        sDate: Date;
        Inductionschedule: Record "HRM-Induction Schedule";
        Number: Integer;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Budget Transfer","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval";
        ApprovalEntries: Page "Approval Entries";
        //todo ApprovalMgt: Codeunit "Approvals Management";
        HRJobs: Record "HRM-Jobs";
        Department: Record "Dimension Value";

    procedure TESTFIELDS()
    begin

        Inductionschedule.TestField(Inductionschedule."Department Code");
        Inductionschedule.TestField(Inductionschedule."Induction Start date");
        Inductionschedule.TestField(Inductionschedule."Induction End  date");
        Inductionschedule.TestField(Inductionschedule."Induction Period");
        //Inductionschedule.TESTFIELD(HRTrainingApplications.Duration);
        //Inductionschedule.TESTFIELD(HRTrainingApplications."Cost Of Training");
        //Inductionschedule.TESTFIELD(HRTrainingApplications.Location);
        //Inductionschedule.TESTFIELD(HRTrainingApplications.Provider);
        //Inductionschedule.TESTFIELD(Inductionschedule.Comments");
    end;

    procedure FillVariables()
    begin
        //GET THE APPLICANT DETAILS

        Department.Reset;
        if Department.Get(Rec."Department Code") then begin
            Rec."Department Name" := Department.Name;
            //Department:=HREmp."Global Dimension 2";
            //"Job Title":=HREmp."Job Description";
            //END ELSE BEGIN
            //Department:='';
        end;

        //GET THE JOB DESCRIPTION FRON THE HR JOBS TABLE AND PASS IT TO THE VARIABLE
        /*HRJobs.RESET;
        IF HRJobs.GET("Job Title") THEN
        BEGIN
        "Job Title":=HRJobs."Job Description";
        END ELSE BEGIN
        "Job Title":='';
        END;
        */
        //GET THE APPROVER NAMES
        /*HREmp.RESET;
        HREmp.SETRANGE(HREmp."User ID",Supervisor);
        IF HREmp.FIND('-') THEN
        BEGIN
        "Supervisor Name":=HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
        END ELSE BEGIN
        "Supervisor Name":='';
        END;
        */

    end;

    procedure UpdateControls()
    begin

        /* IF Status=Status::New THEN BEGIN
         CurrForm."Application No".EDITABLE:=TRUE;
         CurrForm."User ID".EDITABLE:=TRUE;
         CurrForm."Staff Names".EDITABLE:=TRUE;
         CurrForm."Job Title".EDITABLE:=TRUE;
         CurrForm.Supervisor.EDITABLE:=TRUE;
         CurrForm."Supervisor Name".EDITABLE:=TRUE;
         CurrForm."Course Title".EDITABLE:=TRUE;
         CurrForm."Purpose of Training".EDITABLE:=TRUE;
         CurrForm.Status.EDITABLE:=TRUE;
         CurrForm."Employee No.".EDITABLE:=TRUE;
         CurrForm.Selected.EDITABLE:=TRUE;
         CurrForm.Recommendations.EDITABLE:=TRUE;
         CurrForm.Status.EDITABLE:=TRUE;
         CurrForm."Responsibility Center".EDITABLE:=TRUE;
         END ELSE BEGIN
         CurrForm."Application No".EDITABLE:=FALSE;
         CurrForm."User ID".EDITABLE:=FALSE;
         CurrForm."Staff Names".EDITABLE:=FALSE;
         CurrForm."Job Title".EDITABLE:=FALSE;
         CurrForm.Supervisor.EDITABLE:=FALSE;
         CurrForm."Supervisor Name".EDITABLE:=FALSE;
         CurrForm."Course Title".EDITABLE:=FALSE;
         CurrForm."Purpose of Training".EDITABLE:=FALSE;
         CurrForm.Status.EDITABLE:=FALSE;
         CurrForm."Employee No.".EDITABLE:=FALSE;
         CurrForm.Selected.EDITABLE:=FALSE;
         CurrForm.Recommendations.EDITABLE:=FALSE;
         CurrForm.Status.EDITABLE:=FALSE;
         CurrForm."Responsibility Center".EDITABLE:=FALSE;
         END;
         */

    end;

    procedure GetTrainingTypes("Course Title": Text[50])
    begin
    end;
}

