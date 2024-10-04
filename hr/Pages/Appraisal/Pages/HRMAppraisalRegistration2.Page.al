// page 75025 "HRM-Appraisal Registration 2"
// {
//     Editable = true;
//     PageType = Document;
//     SourceTable = "HRM-Employee C";

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 Editable = true;
//                 field("No."; "No.")
//                 {
//                     Caption = 'No.(*)';
//                     Editable = false;
//                 }
//                 field("First Name"; "First Name")
//                 {
//                     Editable = false;
//                 }
//                 field("Middle Name"; "Middle Name")
//                 {
//                     Editable = false;
//                 }
//                 field("Last Name"; "Last Name")
//                 {
//                     Editable = false;
//                 }
//                 field(Initials; Initials)
//                 {
//                 }
//                 field("Search Name"; "Search Name")
//                 {
//                     Caption = 'County';
//                 }
//                 field("Postal Address"; "Postal Address")
//                 {
//                     Editable = false;
//                 }
//                 field("Residential Address"; "Residential Address")
//                 {
//                     Editable = false;
//                 }
//                 field(City; City)
//                 {
//                     Editable = false;
//                 }
//                 field("Post Code"; "Post Code")
//                 {
//                     Editable = false;
//                 }
//                 field(County; County)
//                 {
//                     Editable = false;
//                 }
//                 field("Home Phone Number"; "Home Phone Number")
//                 {
//                 }
//                 field("Cellular Phone Number"; "Cellular Phone Number")
//                 {
//                 }
//                 field("Work Phone Number"; "Work Phone Number")
//                 {
//                     Editable = false;
//                 }
//                 field("E-Mail"; "E-Mail")
//                 {
//                     Editable = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group(Student)
//             {
//                 Caption = 'Student';
//                 action("Appraisal Registration")
//                 {
//                     Caption = 'Appraisal Registration';
//                     Image = Register;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     RunObject = Page 75023;
//                     RunPageLink = PF No.=FIELD(No.);
//                 }
//                 action("Staff Targets")
//                 {
//                     Caption = 'Staff Targets';
//                     Image = BOMRegisters;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     RunObject = Page 75030;
//                                     RunPageLink = PF. No.=FIELD(No.);
//                 }
//                 action("Appraisal Reg. Details")
//                 {
//                     Caption = 'Appraisal Reg. Details';
//                     Image = Info;
//                     RunObject = Page 75025;
//                                     RunPageLink = No.=FIELD(No.);
//                 }
//             }
//         }
//     }

//     var
//         stud: Record "18";
//         PictureExists: Boolean;
//         GenJnl: Record "81";
//         Units: Record "75004";
//         GenSetUp: Record "75008";
//         CourseReg: Record "75007";
//         CurrentBill: Decimal;
//         GLEntry: Record "17";
//         CustLed: Record "21";
//         BankLedg: Record "271";
//         DCustLedg: Record "379";
//         PDate: Date;
//         DocNo: Code[20];
//         VendLedg: Record "25";
//         DVendLedg: Record "380";
//         VATEntry: Record "254";
//         CReg: Record "75007";
//         CustLed2: Record "21";
//         Cont: Boolean;
//         Cust: Record "18";
//         CustPostGroup: Record "92";
//         window: Dialog;
//         GLPosting: Codeunit "12";
//         CustLedg: Record "21";
//         DueDate: Date;
//         Sems: Record "75016";
//         ChangeLog: Record "405";
//         CurrentBal: Decimal;
//         Prog: Record "75003";
//         "Settlement Type": Record "75006";
//         AccPayment: Boolean;
//         SettlementType: Code[20];
//         CustL: Record "21";
//         Units3: Record "75004";
// }

