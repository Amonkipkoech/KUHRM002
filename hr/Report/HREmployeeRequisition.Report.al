report 51153 "HR Leave Application"
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Report/HRLeaveApplication1.rdl';

    dataset
    {
        dataitem(DataItem1102755000; "HRM-Employee Requisitions")
        {
            PrintOnlyIfDetail = false;
            column(RequisitionNo_HREmployeeRequisitions; "Requisition No.")
            {
                IncludeCaption = true;
            }
            column(JobDescription_HREmployeeRequisitions; "Job Description")
            {
                IncludeCaption = true;
            }
            column(JobGrade_HREmployeeRequisitions; "Job Grade")
            {
                IncludeCaption = true;
            }
            column(GlobalDimension2Code_HREmployeeRequisitions; "Global Dimension 2 Code")
            {
                IncludeCaption = true;
            }
            column(ReasonforRequestOther_HREmployeeRequisitions; "Reason for Request(Other)")
            {
                IncludeCaption = true;
            }
            column(ReasonForRequest_HREmployeeRequisitions; "Reason For Request")
            {
                IncludeCaption = true;
            }
            column(TypeofContractRequired_HREmployeeRequisitions; "Type of Contract Required")
            {
                IncludeCaption = true;
            }
            column(AnyAdditionalInformation_HREmployeeRequisitions; "Any Additional Information")
            {
                IncludeCaption = true;
            }
            column(RequisitionDate_HREmployeeRequisitions; "Requisition Date")
            {
                IncludeCaption = true;
            }
            column(JobSupervisorManager_HREmployeeRequisitions; "Job Supervisor/Manager")
            {
                IncludeCaption = true;
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_Address2; CI."Address 2")
            {
                IncludeCaption = true;
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
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

    labels
    {
    }

    trigger OnPreReport()
    begin
        CI.RESET;
        CI.GET();
        CI.CALCFIELDS(CI.Picture);
    end;

    var
        CI: Record 79;
}

