report 50000 "Payroll Analysis Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll/Report/SSR/Payroll Analysis Report.rdl';

    dataset
    {
        dataitem("PRL-Period Transactions"; "PRL-Period Transactions")
        {
            DataItemTableView = sorting("Payroll Period");


            RequestFilterFields = "Payroll Period";

            column(code; Trans."Transaction Code")
            {

            }
            column(description; trans."Transaction Name")
            {

            }
            column(Previousmonth; trans."Period Month")
            {

            }
            column(currentmonth; trans."Period Month")
            { }
            column(employees; trans."Employee Code")
            {

            }
            column(pic; info.Picture)
            {

            }
            column(compname; info.Name)
            {

            }
            column(compaddress; info.Address)
            {

            }
            column(TransName; "PRL-Period Transactions"."Transaction Name")
            {
            }
            column(TransCode; "PRL-Period Transactions"."Transaction Code")
            { }

            column(GText; "PRL-Period Transactions"."Group Text")
            {
            }
            column(Amnt; "PRL-Period Transactions".Amount)
            {
            }
            column(TIME_PRINTED_____FORMAT_TIME_; 'Time Printed:' + Format(Time))
            {
                AutoFormatType = 1;
            }
            column(DATE_PRINTED_____FORMAT_TODAY_0_4_; 'Date Printed:' + Format(Today, 0, 4))
            {
                AutoFormatType = 1;
            }
            column(Printed_By_Caption_Control1102755026; 'Printed By:' + Format(UserId))
            {
            }
            column(TotLabel; "PRL-Period Transactions"."Transaction Code" + ': ' + "PRL-Period Transactions"."Transaction Name")
            {
            }
            column(Transaction; "PRL-Period Transactions"."Transaction Code" + ': ' + "PRL-Period Transactions"."Transaction Name")
            {
            }
            column(compphone; info."Phone No.")
            { }
            column(compemail; info."E-Mail")
            { }
            trigger OnPreDataItem()
            begin
                trans.reset;
                if info.get(info.Picture) then
                    Info.CalcFields(Info.Picture);
                info.name := Info.Name;

            end;
        }
    }
    var
        trans: Record "PRL-Period Transactions";
        info: Record "Company Information";

}