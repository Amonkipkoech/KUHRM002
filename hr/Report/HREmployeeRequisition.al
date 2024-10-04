report 50129  employeeRequisition
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Report/SSR/hrmEmployeeReq.rdl';
    ApplicationArea = Basic, Suite;
    Caption = 'Employeee Requisition';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    
    dataset
    {
        dataitem(empReq; "HRM-Employee Requisitions")
        {
            column(Job_ID;"Job ID")
            {
                
            }
            column(Requisition_Date;"Requisition Date")
            {

            }
            column(Priority;Priority)
            {

            }
            column(Job_Description;"Job Description")
            {
                
            }
            column(Reason_For_Request;"Reason For Request")
            {

            }
            column(Type_of_Contract_Required;"Type of Contract Required")
            {

            }
            column(Vacant_Positions;"Vacant Positions")
            {

            }
            column(Required_Positions;"Required Positions")
            {

            }
            column(Requisition_Type;"Requisition Type")
            {

            }
            column(Opening_Date;"Opening Date")
            {

            }
            column(Closing_Date;"Closing Date")
            {

            }
            column(Advertised;Advertised)
            {

            }
            column(pic; CompanyInformation.Picture)
            {

            }
            column(name; CompanyInformation.Name)
            {

            }
            column(Requestor;Requestor)
            {
                
            }
            dataitem(DataItem1102755001; 454)
            {
                DataItemLink = "Document No." = FIELD("Requisition No.");
                DataItemTableView = SORTING("Table ID", "Document Type", "Document No.", "Sequence No.")
                                    ORDER(Ascending)
                                    WHERE(Status = CONST(Approved));
                column(Comment_ApprovalEntry; Comment)
                {
                    IncludeCaption = true;
                }
                column(ApproverID_ApprovalEntry; "Approver ID")
                {
                    IncludeCaption = true;
                }
                column(DateTimeSentforApproval_ApprovalEntry; "Date-Time Sent for Approval")
                {
                    IncludeCaption = true;
                }
                column(SenderID_ApprovalEntry; "Sender ID")
                {
                    IncludeCaption = true;
                }
                column(LastDateTimeModified_ApprovalEntry; "Last Date-Time Modified")
                {
                }
                /* column(LastModifiedByID_ApprovalEntry; "Last Modified By ID")
                {
                } */
                dataitem(DataItem1102755002; 91)
                {
                    DataItemLink = "User ID" = FIELD("Approver ID");
                    DataItemTableView = SORTING("User ID")
                                        ORDER(Ascending);
                    column(UserID_UserSetup; "User ID")
                    {
                        IncludeCaption = true;
                    }
                }
            }
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
    trigger OnInitReport()
    begin
        if CompanyInformation.Get() then begin
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        end;
    end;

    var
        myInt: Integer;
        CompanyInformation: Record "Company Information";
   
}