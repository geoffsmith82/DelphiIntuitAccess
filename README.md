# DelphiIntuitAccess
Demonstrate OAuth2 Authentication to Intuit online API.

I created this program to turn a Recipient Created Tax Invoice (RCTI) into a Tax Invoice in Quickbooks.  My code takes a PDF and extracts out most of the data, displaying it on the form for me to verify that it has been correctly decoded.  When I have checked it, I use it to create an invoice in Quickbooks and upload the RCTI PDF file as an attachment to the invoice.

  The sample does not include the class that handles the PDF Decoding, as it needs QuickPDF and the PDF format that it decodes is particular to my customer.

  
This project wont compile by itself.  There is a object called TPDFInvoice that is not included.  All the code referencing this can be commented out however and you should still be able to get the sample to work.  

## What does this example show
  - Initial OAuth2 Authentication flow with web browser.
  - OAuth2 Authentication using stored refresh_token.
  - Listing Quickbooks customers
  - Listing Quickbooks invoices
  - Attaching and uploading a file to an invoice in Quickbooks
  - Uploading Invoice data
  
## What you need to do to get this to work
  - rename secrets.example.pas to secrets.pas
  - update constants with your correct values