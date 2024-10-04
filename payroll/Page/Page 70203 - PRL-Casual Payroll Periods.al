page 70203 "PRL-Casual Payroll Periods"
{
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = List;
    SourceTable = "PRL-Casual Payroll Periods";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Date Openned"; Rec."Date Openned")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Current Instalment"; Rec."Current Instalment")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Period Month"; Rec."Period Month")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Period Year"; Rec."Period Year")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Period Name"; Rec."Period Name")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Casuals Daily Rate"; Rec."Casuals Daily Rate")
                {
                    ApplicationArea = all;
                }
                field("No. of Instalments"; Rec."No. of Instalments")
                {
                    ApplicationArea = all;
                }
                field("Instalment Description"; Rec."Instalment Description")
                {
                    ApplicationArea = all;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = all;
                    
                }
                field("Period Instalment Prefix"; Rec."Period Instalment Prefix")
                {
                    ApplicationArea = all;
                }
                field("Closed By"; Rec."Closed By")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Date Closed"; Rec."Date Closed")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("No of Days"; Rec."No of Days")
                {
                    ApplicationArea = all;
                }
                field("Payslip Message"; Rec."Payslip Message")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ClosePeriod)
            {
                ApplicationArea = all;
                Caption = 'Close Period';
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    /*
                    Warn user about the consequence of closure - operation is not reversible.
                    Ask if he is sure about the closure.
                    */

                    fnGetOpenPeriod;

                    Question := 'Once a period has been closed it can NOT be opened.\It is assumed that you have PAID out salaries.\'
                    + 'Do still want to close [' + strPeriodName + ']';

                    //For Multiple Payroll
                    ContrInfo.Get();
                    if ContrInfo."Multiple Payroll" then begin
                        PayrollDefined := '';
                        PayrollType.SetCurrentKey(EntryNo);
                        if PayrollType.FindFirst then begin
                            NoofRecords := PayrollType.Count;
                            repeat
                                i += 1;
                                PayrollDefined := PayrollDefined + '&' + PayrollType."Payroll Code";
                                if i < NoofRecords then
                                    PayrollDefined := PayrollDefined + ','
                            until PayrollType.Next = 0;
                        end;


                        Selection := StrMenu(PayrollDefined, 3);
                        PayrollType.Reset;
                        PayrollType.SetRange(PayrollType.EntryNo, Selection);
                        if PayrollType.Find('-') then begin
                            PayrollCode := PayrollType."Payroll Code";
                        end;
                    end;
                    //End Multiple Payroll



                    Answer := DIALOG.Confirm(Question, false);
                    if Answer = true then begin
                        Clear(objOcx);
                        PayPeriod.Reset;
                        PayPeriod.SetRange(PayPeriod.Closed, false);
                        if PayPeriod.Find('-') then begin
                            objOcx.fnClosePayrollPeriod(PayPeriod."Date Openned", 'CASUAL', PayPeriod."Current Instalment");
                            Message('Process Complete');
                        end;
                    end else begin
                        Message('You have selected NOT to Close the period');
                    end

                end;
            }
            action(UpdateP9)
            {
                ApplicationArea = all;
                Caption = 'UpdateP9';

                trigger OnAction()
                begin
                    if not (Rec.Closed) then Error('The period is still open!');
                    if not (Confirm('Update P9 information for ' + Rec."Period Name" + '?')) then Error('Cancelled by user!');
                    Clear(objOcx);
                    objOcx.fnP9PeriodClosure(Rec."Period Month", Rec."Period Year", Rec."Date Openned", PayrollCode);
                    Message('P9 information for ' + Rec."Period Name" + ' Successfully updated.');
                end;
            }
        }
    }

    var
        PayPeriod: Record "PRL-Casual Payroll Periods";
        strPeriodName: Text[30];
        Text000: Label '''Leave without saving changes?''';
        Text001: Label '''You selected %1.''';
        Question: Text[250];
        Answer: Boolean;
        objOcx: Codeunit "prPayrollProcessing Casual";
        dtOpenPeriod: Date;
        PayrollType: Record "PRL-Payroll Type";
        Selection: Integer;
        PayrollDefined: Text[30];
        PayrollCode: Code[10];
        NoofRecords: Integer;
        i: Integer;
        ContrInfo: Record "HRM-Control-Information";
        OpenInt: Integer;

    procedure fnGetOpenPeriod()
    begin
        Clear(OpenInt);
        //Get the open/current period
        PayPeriod.SetRange(PayPeriod.Closed, false);
        //PayPeriod.SETRANGE(date,Rec."Payroll Code");
        if PayPeriod.Find('-') then begin
            Rec.Validate(Closed);
            strPeriodName := PayPeriod."Period Name";
            dtOpenPeriod := PayPeriod."Date Openned";
            OpenInt := PayPeriod."Current Instalment";
        end;
    end;
}

