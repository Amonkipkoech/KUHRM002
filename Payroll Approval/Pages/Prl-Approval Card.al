page 61843 "Prl-Approval Card"
{
    PageType = Card;
    SourceTable = "Prl-Approval";
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
            {

                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payroll Period field.';
                }
                field("Period Month"; Rec."Period Month")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period Month field.';
                }
                field("Period Year"; Rec."Period Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period Year field.';

                }
                field("Period Name"; Rec."Period Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period Name field.';

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Net Amount field.';
                    Editable = false;
                }
                field("Gross Amount"; Rec."Gross Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gross Amount field.';
                    Editable = false;
                }
                field("Total deductions"; Rec."Total deductions")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total deductions field.';
                }
            }
            group("Approval Comments")
            {
                field("Approval Comment1"; Rec."Approval Comment1")
                {
                    ApplicationArea = All;
                    Caption = 'HR Approval Comment';
                    MultiLine = true;
                    //Editable = false;
                }
                field("Approval Comment2"; Rec."Approval Comment2")
                {
                    ApplicationArea = All;
                    Caption = 'CFO  Approval Comment';
                    MultiLine = true;
                }
                field(ApprovePayroll; Rec."Approval Comment3")
                {
                    ApplicationArea = All;
                    Caption = 'SA Vc Approval Comment';
                    MultiLine = true;
                }
                field("Approval Comment4"; Rec."Approval Comment4")
                {
                    ApplicationArea = All;
                    Caption = 'Vc Approval Comment';
                    MultiLine = True;
                }
            }
            // part(PRL; "PRL Approval Active List")
            // {
            //     SubPageLink = Status = filter(Active);
            //     ApplicationArea = All;
            // }
        }
    }

    actions
    {
        area(processing)
        {
            action("Master Payroll Summary")
            {
                ApplicationArea = all;
                Caption = 'Master Payroll Summary';
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report "PRL-Company Payroll Summary 4";
            }
            // action("Monthly Payroll Variance")
            // {
            //     ApplicationArea = all;
            //     Image = "Report";
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Report "PR Payroll Summary - Variance";
            // }
            action("Company Payslip")
            {
                ApplicationArea = all;
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report "PRL-Company Payroll Summary 4";
            }
            action("External Deductions")
            {
                ApplicationArea = ALL;
                Image = Payables;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = report "PRl-External Deductions";
            }


            action("Payroll Master Report")
            {
                ApplicationArea = all;
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report "Payroll Summary 3";
            }
            action("Bank Advice")
            {
                ApplicationArea = all;
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report "PRL-Bank Schedule";

            }
            // action("Departmental Stats")
            // {
            //     ApplicationArea = all;
            //     Image = "Report";
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Report "Payroll Summary Dept";
            // }
            action("Provident")
            {
                ApplicationArea = all;
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report "Provident Report";
            }



            // action("Deductions Summary")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Deductions Summary';
            //     Image = Report;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Report "PRL-Deductions Summary 2 a";
            // }
            // action("Earnings Summary")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Earnings Summary';
            //     Image = DepositSlip;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Report "PRL-Earnings Summary 5";
            // }

            // action("Third Rule")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Third Rule';
            //     Image = AddWatch;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Report "A third Rule Report";

            // }

            // action("bank Schedule")
            // {
            //     ApplicationArea = all;
            //     Caption = 'bank Schedule';
            //     Image = "Report";
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Report "PRL-Bank Schedule";
            // }

            group("Request Approval")
            {
                action(Sendapproval)
                {
                    Caption = 'Approval Request';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit IntCodeunit;
                    begin
                        //Testfield(ap)
                        if ApprovalMgt.IsPrlApprovalEnabled(Rec) = true then begin

                            ApprovalMgt.OnSendPrlApprovalforApproval(Rec);

                        end else
                            Message('Check Your Approval Workflow');
                    end;
                }

                action(Approvals)
                {
                    Caption = 'Approvals';
                    
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Fin-Approval Entries";
                    RunPageLink = "Document No." = const('01/08/23');
                    ApplicationArea = All;

                    // trigger OnAction()
                    // var
                    //     Approvalentries: Page "Approval Entries";
                    // begin
                    //     Approvalentries.Setfilters(DATABASE::"Prl-Approval", 6, format(Rec."Payroll Period"));
                    //     Approvalentries.RUN;
                    // end;
                }

                action(Cancelapproval)
                {
                    Caption = 'Cancel Request';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit IntCodeunit;
                    begin
                        ApprovalMgt.OnCancelPrlApprovalForApproval(Rec);
                    end;
                    
                }
            }
        }
    }
}