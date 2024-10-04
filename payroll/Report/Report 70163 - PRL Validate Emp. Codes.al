report 70163 "PRL Validate Emp. Codes"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("PRL-Employee Transactions"; "PRL-Employee Transactions")
        {

            trigger OnAfterGetRecord()
            begin
                if PRLTransactionCodes.Get("PRL-Employee Transactions"."Transaction Code") then begin
                    "PRL-Employee Transactions"."Transaction Name" := PRLTransactionCodes."Transaction Name";
                    "PRL-Employee Transactions"."Recurance Index" := 999;
                    "PRL-Employee Transactions".Modify;
                end;
                //"PRL-Employee Transactions".VALIDATE("PRL-Employee Transactions"."Transaction Code");
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
        PRLTransactionCodes: Record "PRL-Transaction Codes";
}

