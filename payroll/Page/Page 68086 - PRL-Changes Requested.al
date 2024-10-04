page 68086 "PRL-Changes Requested"
{
    PageType = List;
    SourceTable = "PRL-Payroll Variations";
    SourceTableView = WHERE(Closed = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                ShowCaption = false;
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = All;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Basic Pay"; Rec."Basic Pay")
                {
                    ApplicationArea = All;
                }
                field("Effective Date"; Rec."Effective Date")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = All;
                }
                field("New Amount"; Rec."New Amount")
                {
                    ApplicationArea = All;
                }
                field("Hrs Worked"; Rec."Hrs Worked")
                {
                    ApplicationArea = All;
                }
                field("Overtime Type"; Rec."Overtime Type")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                }
                field("Approved By"; Rec."Approved By")
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
            group("Function")
            {
                Caption = 'Function';
                action(Approve)
                {
                    Caption = 'Approve';
                    Image = Approve;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.SetRange(Status, Rec.Status::Approved);
                        Rec.SetRange(Closed, false);
                        if Rec.Find('-') then begin
                            repeat
                                Rec.Closed := true;
                                Rec."Date Closed" := Today;
                                Rec."Approved By" := UserId;
                                Rec.Modify;
                            until Rec.Next = 0;
                        end;
                    end;
                }
                separator(Separator1102756031)
                {
                }
                action(Print)
                {
                    Caption = 'Print';
                    Image = Print;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.Reset;
                        REPORT.Run(39005528);
                        Rec.Reset;
                    end;
                }
            }
        }
    }
}

