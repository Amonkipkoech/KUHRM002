page 68984 "HRM-Induction Sched. Card"
{
    PageType = Card;
    SourceTable = "HRM-Induction Schedule";

    layout
    {
        area(content)
        {
            group(General)
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            /*     part(Control1102755000; "HRM-Induction Part. List")
                 {
                     SubPageLink = "Induction Code" = FIELD("Induction Code");
                 }
                 */
        }
    }

    actions
    {
        area(navigation)
        {
            group(ActionGroup1102755014)
            {
            }
            action("&Approvals")
            {
                Caption = '&Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*todo
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
                                        todo*/
                end;
            }
            action("&Send Approval Request")
            {
                Caption = '&Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*todo
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
                                        todo*/
                end;
            }
            action("&Cancel Approval Request")
            {
                Caption = '&Cancel Approval Request';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = All;
            }
            /*todo     action("Induction Participants ")
                 {
                     Caption = 'Induction Participants';
                     Image = PersonInCharge;
                     Promoted = true;
                     PromotedCategory = Category4;
                     RunObject = Page "HRM-Induction Part. List";
                     RunPageLink = "Induction Code" = FIELD("Induction Code");

                     trigger OnAction()
                     begin

                         /*DocumentType:=DocumentType::"Induction Approval";
                         Inductionschedule.RESET;
                         Inductionschedule.SETRANGE(Inductionschedule.Selected,TRUE);
                         Inductionschedule.SETRANGE(Inductionschedule."Department Code","Department Code");
                         IF Inductionschedule.FIND('-')THEN
                         BEGIN

                             //ENSURE SELECTED RECORDS DO NOT EXCEED ONE
                             Number:=0;
                             Number:=Inductionschedule.COUNT;
                             IF Number > 1 THEN
                             BEGIN
                             ERROR('You cannot have more than one application selected');
                            // ERROR(FORMAT(Number)+' applications selected');

                             END;

                         ApprovalEntries.Setfilters(DATABASE::"HR Induction Schedule",DocumentType,Inductionschedule."Department Code");
                         ApprovalEntries.RUN;
                         END ELSE BEGIN
                         ERROR('No Application Selected');
                         END;
                         */

            //todo end;
            //todo  }
            //  todo*/
            /*todo
            action("HR Staff  Induction Report")
            {
                RunObject = Report "Hostel Status Summary Report";
            }

            todo*/
        }
    }
    /*todo
        var
            "Induction`": Record "HRM-Induction Schedule";
            DepartmentName: Text[40];
            sDate: Date;
            Inductionschedule: Record "HRM-Induction Schedule";
            Number: Integer;
            DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Budget Transfer","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval";
            ApprovalEntries: Page "Approval Entries";
            ApprovalMgt: Codeunit "Approvals Management";
            HRJobs: Record "HRM-Jobs";
            Department: Record "Dimension Value";

        procedure TESTFIELDS()
        begin

            Inductionschedule.TestField(Inductionschedule."Department Code");
            Inductionschedule.TestField(Inductionschedule."Induction Start date");
            Inductionschedule.TestField(Inductionschedule."Induction End  date");
            Inductionschedule.TestField(Inductionschedule."Induction Period");
        end;

        procedure FillVariables()
        begin
            //GET THE APPLICANT DETAILS

            Department.Reset;
            if Department.Get(Rec."Department Code") then begin
                Rec."Department Name" := Department.Name;
            end;
        end;

        procedure UpdateControls()
        begin
        end;

        procedure GetTrainingTypes("Course Title": Text[50])
        begin
        end;
        todo*/
}

