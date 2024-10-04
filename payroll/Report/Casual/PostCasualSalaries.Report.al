/* report 70251 "Post Casual Salaries"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; 70201)
        {

            trigger OnAfterGetRecord()
            begin
                HRMEmployeeD.RESET;
                HRMEmployeeD.SETRANGE("No.", "Import Casual Pay Buffer"."No.");
                IF HRMEmployeeD.FIND('-') THEN BEGIN
                    HRMEmployeeD."Employee Type" := HRMEmployeeD."Employee Type"::Casual;
                    HRMEmployeeD.Status := HRMEmployeeD.Status::Normal;
                    HRMEmployeeD."Department Code" := "Import Casual Pay Buffer"."Department Code";
                    HRMEmployeeD."Main Bank" := "Import Casual Pay Buffer"."Bank Code";
                    HRMEmployeeD."Branch Bank" := "Import Casual Pay Buffer"."Branch Code";
                    HRMEmployeeD."Bank Account Number" := "Import Casual Pay Buffer"."A/C No.";
                    HRMEmployeeD."First Name" := "Import Casual Pay Buffer"."F. Name";
                    HRMEmployeeD."Middle Name" := "Import Casual Pay Buffer"."M. Name";
                    HRMEmployeeD."Last Name" := "Import Casual Pay Buffer"."L. Name";
                    HRMEmployeeD."Daily Rate" := "Import Casual Pay Buffer"."Daily Rate";
                    HRMEmployeeD."Posting Group" := 'Casual';
                    HRMEmployeeD.MODIFY;
                END ELSE BEGIN
                    HRMEmployeeD.INIT;
                    HRMEmployeeD."No." := "Import Casual Pay Buffer"."No.";
                    HRMEmployeeD."Employee Type" := HRMEmployeeD."Employee Type"::Casual;
                    HRMEmployeeD.Status := HRMEmployeeD.Status::Normal;
                    HRMEmployeeD."Department Code" := "Import Casual Pay Buffer"."Department Code";
                    HRMEmployeeD."Main Bank" := "Import Casual Pay Buffer"."Bank Code";
                    HRMEmployeeD."Branch Bank" := "Import Casual Pay Buffer"."Branch Code";
                    HRMEmployeeD."Bank Account Number" := "Import Casual Pay Buffer"."A/C No.";
                    HRMEmployeeD."First Name" := "Import Casual Pay Buffer"."F. Name";
                    HRMEmployeeD."Middle Name" := "Import Casual Pay Buffer"."M. Name";
                    HRMEmployeeD."Last Name" := "Import Casual Pay Buffer"."L. Name";
                    HRMEmployeeD."Daily Rate" := "Import Casual Pay Buffer"."Daily Rate";
                    HRMEmployeeD."Posting Group" := 'Casual';
                    HRMEmployeeD.INSERT;
                END;

                HRMEmployeeC.RESET;
                HRMEmployeeC.SETRANGE("No.", "Import Casual Pay Buffer"."No.");
                IF HRMEmployeeC.FIND('-') THEN BEGIN
                    HRMEmployeeC."Employee Type" := HRMEmployeeC."Employee Type"::Casuals;
                    HRMEmployeeC.Status := HRMEmployeeC.Status::Active;
                    HRMEmployeeC."Department Code" := "Import Casual Pay Buffer"."Department Code";
                    HRMEmployeeC."Main Bank" := "Import Casual Pay Buffer"."Bank Code";
                    HRMEmployeeC."Branch Bank" := "Import Casual Pay Buffer"."Branch Code";
                    HRMEmployeeC."Bank Account Number" := "Import Casual Pay Buffer"."A/C No.";
                    HRMEmployeeC."First Name" := "Import Casual Pay Buffer"."F. Name";
                    HRMEmployeeC."Middle Name" := "Import Casual Pay Buffer"."M. Name";
                    HRMEmployeeC."Last Name" := "Import Casual Pay Buffer"."L. Name";
                    //  HRMEmployeeC."Daily Rate":="Import Casual Pay Buffer"."Daily Rate";
                    HRMEmployeeC.MODIFY;
                END ELSE BEGIN
                    HRMEmployeeC.INIT;
                    HRMEmployeeC."No." := "Import Casual Pay Buffer"."No.";
                    HRMEmployeeC."Employee Type" := HRMEmployeeC."Employee Type"::Casuals;
                    HRMEmployeeC.Status := HRMEmployeeC.Status::Active;
                    HRMEmployeeC."Department Code" := "Import Casual Pay Buffer"."Department Code";
                    HRMEmployeeC."Main Bank" := "Import Casual Pay Buffer"."Bank Code";
                    HRMEmployeeC."Branch Bank" := "Import Casual Pay Buffer"."Branch Code";
                    HRMEmployeeC."Bank Account Number" := "Import Casual Pay Buffer"."A/C No.";
                    HRMEmployeeC."First Name" := "Import Casual Pay Buffer"."F. Name";
                    HRMEmployeeC."Middle Name" := "Import Casual Pay Buffer"."M. Name";
                    HRMEmployeeC."Last Name" := "Import Casual Pay Buffer"."L. Name";
                    //HRMEmployeeC."Daily Rate":="Import Casual Pay Buffer"."Daily Rate";
                    HRMEmployeeC.INSERT;
                END;

                PRLCasualPayrollPeriods.RESET;
                PRLCasualPayrollPeriods.SETRANGE("Period Month", "Import Casual Pay Buffer"."Period Month");
                PRLCasualPayrollPeriods.SETRANGE("Period Year", "Import Casual Pay Buffer"."Period Year");
                PRLCasualPayrollPeriods.SETRANGE("Current Instalment", "Import Casual Pay Buffer".Instalment);
                IF PRLCasualPayrollPeriods.FIND('-') THEN BEGIN
                END ELSE
                    ERROR('Period missing');

                PRLEmployeeDaysWorked.RESET;
                PRLEmployeeDaysWorked.SETRANGE("Employee Code", "Import Casual Pay Buffer"."No.");
                PRLEmployeeDaysWorked.SETRANGE("Payroll Period", PRLCasualPayrollPeriods."Date Openned");
                PRLEmployeeDaysWorked.SETRANGE("Current Instalment", PRLCasualPayrollPeriods."Current Instalment");
                IF PRLEmployeeDaysWorked.FIND('-') THEN BEGIN
                    PRLEmployeeDaysWorked."Days Worked" := "Import Casual Pay Buffer".Days;
                    PRLEmployeeDaysWorked."Daily Rate" := "Import Casual Pay Buffer"."Daily Rate";
                    PRLEmployeeDaysWorked.MODIFY;
                END ELSE BEGIN
                    PRLEmployeeDaysWorked.INIT;
                    PRLEmployeeDaysWorked."F.  Name" := "Import Casual Pay Buffer"."F. Name" + ' ' + "Import Casual Pay Buffer"."M. Name" + ' ' + "Import Casual Pay Buffer"."L. Name";
                    PRLEmployeeDaysWorked."Employee Code" := "Import Casual Pay Buffer"."No.";
                    PRLEmployeeDaysWorked."Payroll Period" := PRLCasualPayrollPeriods."Date Openned";
                    PRLEmployeeDaysWorked."Current Instalment" := PRLCasualPayrollPeriods."Current Instalment";
                    PRLEmployeeDaysWorked."Days Worked" := "Import Casual Pay Buffer".Days;
                    PRLEmployeeDaysWorked."Daily Rate" := "Import Casual Pay Buffer"."Daily Rate";
                    PRLEmployeeDaysWorked."Period Month" := "Import Casual Pay Buffer"."Period Month";
                    PRLEmployeeDaysWorked."Period Year" := "Import Casual Pay Buffer"."Period Year";
                    PRLEmployeeDaysWorked.INSERT;
                END;
            end;
        }
        dataitem(DataItem1000000001; Table70202)
        {

            trigger OnAfterGetRecord()
            begin
                PRLTransCodesTransactions.RESET;
                PRLTransCodesTransactions.SETRANGE("Transaction Code", "Casual Transactions Import"."Trans. Code");
                IF PRLTransCodesTransactions.FIND('-') THEN BEGIN
                END;

                PRLCasualPayrollPeriods.RESET;
                PRLCasualPayrollPeriods.SETRANGE("Period Month", "Casual Transactions Import"."Period Month");
                PRLCasualPayrollPeriods.SETRANGE("Period Year", "Casual Transactions Import"."Period Year");
                PRLCasualPayrollPeriods.SETRANGE("Current Instalment", "Casual Transactions Import".Instalment);
                IF PRLCasualPayrollPeriods.FIND('-') THEN BEGIN
                END ELSE
                    ERROR('Period missing');

                PRLCasualEmpTransactions.RESET;
                PRLCasualEmpTransactions.SETRANGE("Employee Code", "Casual Transactions Import"."Emp. No.");
                PRLCasualEmpTransactions.SETRANGE("Current Instalment", "Casual Transactions Import".Instalment);
                PRLCasualEmpTransactions.SETRANGE("Transaction Code", "Casual Transactions Import"."Trans. Code");
                PRLCasualEmpTransactions.SETRANGE("Payroll Period", PRLCasualPayrollPeriods."Date Openned");
                IF PRLCasualEmpTransactions.FIND('-') THEN BEGIN
                    PRLCasualEmpTransactions.Amount := "Casual Transactions Import".Amount;
                    PRLCasualEmpTransactions."Transaction Name" := PRLTransCodesTransactions."Transaction Name";
                    PRLCasualEmpTransactions."Transaction Type" := PRLTransCodesTransactions."Transaction Type";
                    PRLCasualEmpTransactions."Current Instalment" := "Casual Transactions Import".Instalment;
                    PRLCasualEmpTransactions."Recurance Index" := 99;
                    PRLCasualEmpTransactions.MODIFY;
                END ELSE BEGIN
                    PRLCasualEmpTransactions.INIT;
                    PRLCasualEmpTransactions."Employee Code" := "Casual Transactions Import"."Emp. No.";
                    PRLCasualEmpTransactions."Transaction Code" := "Casual Transactions Import"."Trans. Code";
                    PRLCasualEmpTransactions."Period Month" := "Casual Transactions Import"."Period Month";
                    PRLCasualEmpTransactions."Period Year" := "Casual Transactions Import"."Period Year";
                    PRLCasualEmpTransactions."Payroll Period" := PRLCasualPayrollPeriods."Date Openned";
                    PRLCasualEmpTransactions."Current Instalment" := "Casual Transactions Import".Instalment;
                    ;
                    PRLCasualEmpTransactions."Transaction Name" := PRLTransCodesTransactions."Transaction Name";
                    PRLCasualEmpTransactions.Amount := "Casual Transactions Import".Amount;
                    PRLCasualEmpTransactions."Recurance Index" := 99;
                    PRLCasualEmpTransactions.INSERT;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        PRLCasualEmpTransactions: Record "70251";
        HRMEmployeeD: Record "61118";
        HRMEmployeeC: Record "61188";
        PRLCasualPayrollPeriods: Record "70250";
        PRLTransCodesTransactions: Record "61082";
        PRLEmployeeDaysWorked: Record "70200";
} */

