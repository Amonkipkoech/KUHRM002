report 51720 "HR Leave Application (1)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Report/HRLeaveApplication1.rdl';

    dataset
    {
        dataitem(DataItem9741; 61125)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Employee No";


            column(CompName; CompanyInformation.Name)
            {
            }
            column(Address; CompanyInformation.Address + ' ' + CompanyInformation."Address 2")
            {
            }
            column(Phones; CompanyInformation."Phone No." + ' ' + CompanyInformation."Phone No. 2")
            {
            }

            column(Mails; CompanyInformation."E-Mail")
            {
            }

            column(pics; CompanyInformation.Picture)
            {
            }
            /* column(Address; Address + ' ' + "Address 2" + ' ' + City)
            {
            }
            column(pics; Picture)
            {
            }
            column(Phones; "Phone No." + '/' + "Phone No. 2")
            {
            }
            column(Mails; "E-Mail" + '/' + "Home Page")
            {
            } */
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            // column(CurrReport_PAGENO; CurrReport.PageNo)
            // {
            // }
            column(USERID; USERID)
            {
            }
            column(LeaveNo_; "No.")
            {
            }
            column(HR_Leave_Requisition_Date; Date)
            {
            }
            column(HR_Leave_Requisition__Employee_No_; "Employee No")
            {
            }
            column(HR_Leave_Requisition__Employee_Name_; "Employee Name")
            {
            }
            column(HR_Leave_Requisition__Region_Code_; "Campus Code")
            {
            }
            column(HR_Leave_Requisition__Department_Code_; "Department Code")
            {
            }
            column(HR_Leave_Requisition__Applied_Days_; "Applied Days")
            {
            }
            column(HR_Leave_Requisition__Starting_Date_; "Starting Date")
            {
            }
            column(HR_Leave_Requisition__End_Date_; "End Date")
            {
            }
            column(ReturnDate; "Return Date")
            {
            }
            column(HR_Leave_Requisition_Purpose; Purpose)
            {
            }
            column(HR_Leave_Requisition__Leave_Type_; "Leave Type")
            {
            }
            column(HR_Leave_Requisition__Leave_Balance_; "Leave Balance")
            {
            }
            column(HR_Leave_Requisition_Status; Status)
            {
            }
            column(LEAVE_APPLICATIONCaption; LEAVE_APPLICATIONCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(HR_Leave_Requisition__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(HR_Leave_Requisition_DateCaption; FIELDCAPTION(Date))
            {
            }
            column(HR_Leave_Requisition__Employee_No_Caption; FIELDCAPTION("Employee No"))
            {
            }
            /* column(HR_Leave_Requisition__Campus_Code_Caption; FIELDCAPTION("Region Code"))
            {
            } */
            column(HR_Leave_Requisition__Department_Code_Caption; FIELDCAPTION("Department Code"))
            {
            }
            column(HR_Leave_Requisition__Applied_Days_Caption; FIELDCAPTION("Applied Days"))
            {
            }
            column(HR_Leave_Requisition__Starting_Date_Caption; FIELDCAPTION("Starting Date"))
            {
            }
            column(HR_Leave_Requisition__End_Date_Caption; FIELDCAPTION("End Date"))
            {
            }
            column(HR_Leave_Requisition_PurposeCaption; FIELDCAPTION(Purpose))
            {
            }
            column(HR_Leave_Requisition__Leave_Type_Caption; FIELDCAPTION("Leave Type"))
            {
            }
            column(HR_Leave_Requisition__Leave_Balance_Caption; FIELDCAPTION("Leave Balance"))
            {
            }
            column(HR_Leave_Requisition_StatusCaption; FIELDCAPTION(Status))
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            dataitem(DataItem1171; 454)
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Table ID", "Document Type", "Document No.", "Sequence No.") ORDER(Ascending) WHERE("Approved The Document" = FILTER(true));
                column(Approval_Entry__Approver_ID_; "Approver ID")
                {
                }
                column(Approval_Entry_Status; Status)
                {
                }
                column(Approval_Entry__Last_Date_Time_Modified_; "Last Date-Time Modified")
                {
                }
                column(APPROVALSCaption; APPROVALSCaptionLbl)
                {
                }
                column(APPROVER_IDCaption; APPROVER_IDCaptionLbl)
                {
                }
                column(APPROVAL_DATECaption; APPROVAL_DATECaptionLbl)
                {
                }
                column(APPROVAL_ACTIONCaption; APPROVAL_ACTIONCaptionLbl)
                {
                }
                column(Approval_Entry_Table_ID; "Table ID")
                {
                }
                column(Approval_Entry_Document_Type; "Document Type")
                {
                }
                column(Approval_Entry_Document_No_; "Document No.")
                {
                }
                column(Approval_Entry_Sequence_No_; "Sequence No.")
                {
                }
                column(ApprovalTitle; UserSetup."Approval Title")
                {
                }
                column(ApprovalSignature; UserSetup."User Signature")
                {
                }
                column(ApproveDateTime; "Last Date-Time Modified")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", "Approver ID");
                    IF UserSetup.FIND('-') THEN UserSetup.CALCFIELDS("User Signature");
                end;

                trigger OnPreDataItem()
                begin
                    //   SETFILTER("Approver ID",'<>%1',"User ID");
                end;
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

    trigger OnInitReport()
    begin
        CompanyInformation.RESET;
        IF CompanyInformation.FIND('-') THEN BEGIN
            CompanyInformation.CALCFIELDS(Picture);
        END;
    end;

    var
        LEAVE_APPLICATIONCaptionLbl: Label 'LEAVE APPLICATION';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        NameCaptionLbl: Label 'Name';
        APPROVALSCaptionLbl: Label 'APPROVALS';
        APPROVER_IDCaptionLbl: Label 'APPROVER ID';
        APPROVAL_DATECaptionLbl: Label 'APPROVAL DATE';
        APPROVAL_ACTIONCaptionLbl: Label 'APPROVAL ACTION';
        Company: Record 2000000006;
        CompanyInformation: Record 79;
        UserSetup: Record 91;
}

