page 69108 "HRM-Import Emp. Trans Buff"
{
    PageType = List;
    SourceTable = "HRM-Emp. Trans. Adjst Buffer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = all;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = all;
                }
                field(Period; Rec.Period)
                {
                    ApplicationArea = all;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(imp)
            {
                ApplicationArea = all;
                Caption = 'Import transactons';
                Image = ImportExcel;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Import?', false) = false then Error('Cancelled by user!');
                    XMLPORT.Run(50222, false, true);
                end;
            }
            action(pos)
            {
                ApplicationArea = all;
                Caption = 'post transactions';
                Image = PostBatch;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Update Transactions?', false) = false then Error('Cancelled by user!');
                    if Confirm('These will update the transactions for all employees on this page, continue?', false) = false then Error('Cancelled by ' + UserId);
                    rectrans.Reset;
                    if rectrans.Find('-') then begin
                        repeat
                        begin
                            premptrans.Reset;
                            premptrans.SetRange(premptrans."Employee Code", rectrans."Employee No");
                            premptrans.SetRange(premptrans."Transaction Code", rectrans."Transaction Code");
                            premptrans.SetRange(premptrans."Payroll Period", rectrans.Period);
                            if premptrans.Find('-') then begin
                                premptrans.Amount := rectrans.Amount;
                                premptrans.Modify;
                            end else begin
                                premptrans.Init;
                                premptrans."Employee Code" := rectrans."Employee No";
                                premptrans."Transaction Code" := rectrans."Transaction Code";
                                premptrans."Period Month" := Date2DMY(rectrans.Period, 2);
                                premptrans."Period Year" := Date2DMY(rectrans.Period, 3);
                                premptrans."Payroll Period" := rectrans.Period;
                                premptrans.Amount := rectrans.Amount;
                                premptrans.Insert(true);
                            end;
                            rectrans.Delete(true);
                        end;
                        until rectrans.Next = 0;
                    end else
                        Error('There are no records to update');
                end;
            }
        }
    }

    var
        rectrans: Record "HRM-Emp. Trans. Adjst Buffer";
        premptrans: Record "PRL-Employee Transactions";
}

