<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Default2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Printing...</title>
    <style type="text/css">
       
        .auto-style2 {
            width: 102px;
        }
        .auto-style4 {
            width: 424px;
        }
        .auto-style5 {
            width: 96px;
        }
        .auto-style6 {
            text-align: center;
            height: 28px;
            width: 1052px;
        }
       
        .auto-style10 {
            width: 216px;
        }
        .auto-style12 {
            width: 310px;
        }
        .auto-style13 {
            width: 311px;
        }
        .auto-style14 {
            width: 214px;
        }
        .auto-style15 {
            width: 312px;
        }
        .auto-style16 {
            text-align: center;
            height: 27px;
        }
       
        .auto-style17 {
            height: 28px;
            width: 1052px;
            border:solid;
            border-width:thin;
        }
       
        .auto-style18 {
            width: 118px;
        }
       
        .auto-style19 {
            width: 1062px;
            border:solid;
            border-width:thin;
        }
       
        .auto-style20 {
            text-align: center;
        }
       
        .auto-style21 {
            border-style: solid;
            border-color: inherit;
            width: 1062px;
            border-width: thin;
            height: 30px;
        }
       
        .auto-style22 {
            width: 410px;
        }
        .auto-style23 {
            width: 198px;
        }
        .auto-style24 {
            width: 297px;
        }
        .auto-style25 {
            width: 291px;
        }
        .auto-style26 {
            width: 179px;
        }
        .auto-style27 {
            width: 1052px;
            height: 100px;
        }
        .auto-style28 {
            border-style: solid;
            border-color: inherit;
            height: 23px;
            width: 1052px;
            border-width: thin;
        }
        .auto-style31 {
            width: 299px;
        }
        .auto-style32 {
            width: 369px;
        }
        .auto-style33 {
            width: 75px;
        }
        .auto-style35 {
            width: 299px;
            margin-left: 0px;
        }
       
        .auto-style36 {
            width: 958px;
        }
       
        .auto-style38 {
            border-style: solid;
            border-color: inherit;
            width: 1064px;
            border-width: thin;
        }
        .auto-style41 {
            border-style: solid;
            border-color: inherit;
            width: 1062px;
            border-width: thin;
        }
       
    </style>
</head>
<body style="height: 158px" onload ="window.print();">
    <form id="form1" runat="server">
        <div>
           <h1 class="auto-style20">SRUJANI FORM</h1>
            <table class="auto-style41">
                <tr>
                    <td class="auto-style2">
                        Suggestion No.</td>
                    <td class="auto-style4">
                        <asp:textbox ID="textbox3" runat="server" class="auto-style22"></asp:textbox></td>
                    <td class="auto-style5">
                        Date</td>
                    <td>
                        <asp:textbox ID="textbox4" runat="server" class="auto-style22"></asp:textbox></td>
                </tr>
            </table>
           
            <div class="auto-style6">
                <h2>Suggestor Details</h2>
            </div>
            <table class="auto-style41">
                <tr>
                    <td class="auto-style2">
                        Name:</td>
                    <td class="auto-style4">
                        <asp:textbox ID="textbox123" runat="server" class="auto-style22"></asp:textbox></td>
                    <td class="auto-style5">
                        Pl No.:</td>
                    <td>
                        <asp:textbox ID="textbox5" runat="server" class="auto-style22"></asp:textbox></td>
                </tr>
            </table>
            <table class="auto-style41">
                <tr>
                    <td class="auto-style10">
                        Designation:</td>
                    <td class="auto-style12"> Department:
                    </td>
                    <td class="auto-style13">
                        &nbsp;&nbsp;
                        Section:&nbsp;&nbsp; </td>
                    <td> Scale Code:
                    </td>
                </tr>
            </table>
            <table class="auto-style21">
                <tr>
                    <td class="auto-style14">
                        <asp:textbox ID="textbox13" runat="server" class="auto-style23"></asp:textbox></td>
                    <td class="auto-style15">
                        <asp:textbox ID="textbox14" runat="server" class="auto-style24"></asp:textbox></td>
                    <td class="auto-style12">
                        <asp:textbox ID="textbox15" runat="server" class="auto-style25"></asp:textbox></td>
                    <td>
                        <asp:textbox ID="textbox16" runat="server" class="auto-style26"></asp:textbox></td>
                </tr>
            </table>
           
            <div class="auto-style16">
                <h2>Suggestion Details</h2>
            </div>
           <table>
               <tr>
                   <td class="auto-style28"> &nbsp; Subject (IN CAPITAL LETTERS) Limited to 200 characters:
                       <br />
                       <asp:textbox ID="textbox2" runat="server" class="auto-style27" TextMode="MultiLine" MaxLength="200"></asp:textbox><br />
                   </td>
               </tr>
           </table>
             <table>
               <tr>
                   <td class="auto-style17"> &nbsp; Description (Max 500 Characters):
                       <br />
                       <asp:textbox ID="textbox1" runat="server" class="auto-style27" TextMode="MultiLine" MaxLength="500"></asp:textbox><br />
                      </td>
               </tr>
           </table>
             
             <table class="auto-style38">
                <tr>
                    <td class="auto-style14"> Signature of the Suggestor: 
                        </td>
                    <td class="auto-style15"> 
                    </td>
                    <td class="auto-style18"> Ph. No.
                        </td>
                    <td>
                    </td>
                </tr>
            </table>
            <p class="auto-style20">*Attach Sketch/Drawing whenever necessary and use plain paper, if additional space is required.</p>
            <p>✂------------------------------------------------------------------------------------------✂-------------------------------------------------------------------------------✂</p>
            <table class="auto-style19">
                <tr>
                    <td class="auto-style14" style="width:75px;"> Suggn. No. 
                        </td>
                    <td class="auto-style15"> 
                        <asp:textbox ID="textbox6" runat="server" class="auto-style35"></asp:textbox></td>
                    <td class="auto-style18" style="width:75px;"> Date
                        </td>
                    <td>
                        <asp:textbox ID="textbox7" runat="server" class="auto-style32"></asp:textbox></td>
                </tr>
            </table>
            <table class="auto-style19">
                <tr>
                    <td class="auto-style33"> Subject: 
                        </td>
                    <td class="auto-style15"> 
                        <asp:textbox ID="textbox8" runat="server" class="auto-style36"></asp:textbox></td>
                    
                </tr>
            </table>
            <table class="auto-style19">
                <tr>
                    <td class="auto-style14" style="width:75px;"> Name: 
                        </td>
                    <td class="auto-style15"> 
                        <asp:textbox ID="textbox9" runat="server" class="auto-style31"></asp:textbox></td>
                    <td class="auto-style18" style="width:75px;"> Pl. No.
                        </td>
                    <td>
                        <asp:textbox ID="textbox10" runat="server" class="auto-style32"></asp:textbox></td>
                </tr>
            </table>
            <table class="auto-style19">
                <tr>
                    <td class="auto-style14" style="width:75px;"> Design. 
                        </td>
                    <td class="auto-style15"> 
                        <asp:textbox ID="textbox11" runat="server" class="auto-style31"></asp:textbox></td>
                    <td class="auto-style18" style="width:75px;"> Deptt.
                        </td>
                    <td>
                        <asp:textbox ID="textbox12" runat="server" class="auto-style32"></asp:textbox></td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
