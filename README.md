# DelphiIntuitAccess
Demonstrate OAuth2 Authentication to Intuit online API.

I created this program to turn a Recipient Created Tax Invoice (RCTI) into a Tax Invoice in Quickbooks.  My code takes a PDF and extracts out most of the data, displaying it on the form for me to verify that it has been correctly decoded.  When I have checked it, I use it to create an invoice in Quickbooks and upload the RCTI PDF file as an attachment to the invoice.

  The sample does not include the class that handles the PDF Decoding, as it needs QuickPDF and the PDF format that it decodes is particular to my customer.

The code takes a list of Pdf files and looks for a json file of the same as a pdf file.  It reads this information in ready for creating the actual invoice in Quickbooks.    
  


## What does this example show
  - Initial OAuth2 Authentication flow with web browser.
	- Uses the new TEdgeBrowser component in recent versions of delphi.  Make sure you have ```WebView2Loader.dll``` in the same directory as the executable file
  - OAuth2 Authentication using stored refresh_token that are encrypted using Windows Encryption API's.
  - Listing Quickbooks Customers
  - Listing Quickbooks Invoices
  - Listing Quickbooks Suppliers
  - Attaching and uploading a file to an invoice in Quickbooks
  - Uploading Invoice data
  
## What you need to do to get this to work
  - rename secrets.example.pas to secrets.pas
  - update constants with your correct values
  - You will need a ClientID and ClientSecret from Intuit. See [Intuit Dashboard](https://developer.intuit.com/app/developer/dashboard)