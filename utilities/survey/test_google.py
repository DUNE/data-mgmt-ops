import os.path
import json

from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError

# If modifying these scopes, delete the file token.json.
SCOPES = ["https://www.googleapis.com/auth/spreadsheets.readonly"]


SPREADSHEET_ID = '1D14oi3RIM7nzMpDGvNjZ55haagcYlzIaO4sNMKI3ZQ0'
SPREADSHEET_ID = '1OB9oElVpHSwNvs8lyd-QWIMv7x7hwqV2GYnxSAEg68s'

RANGE_NAME = 'Form Responses 1!A1:K'

def main():
  """Shows basic usage of the Sheets API.
  Prints values from a sample spreadsheet.
  """
  creds = None
  # The file token.json stores the user's access and refresh tokens, and is
  # created automatically when the authorization flow completes for the first
  # time.
  if os.path.exists("token.json"):
    creds = Credentials.from_authorized_user_file("token.json", SCOPES)
  # If there are no (valid) credentials available, let the user log in.
  if not creds or not creds.valid:
    if creds and creds.expired and creds.refresh_token:
      creds.refresh(Request())
    else:
      flow = InstalledAppFlow.from_client_secrets_file(
          "credentials.json", SCOPES
      )
      creds = flow.run_local_server(port=0)
    # Save the credentials for the next run
    with open("token.json", "w") as token:
      token.write(creds.to_json())

  try:
    service = build("sheets", "v4", credentials=creds)

    # Call the Sheets API
    sheet = service.spreadsheets()
    result = (
        sheet.values()
        .get(spreadsheetId=SPREADSHEET_ID, range=RANGE_NAME)
        .execute()
    )
    values = result.get("values", [])

    if not values:
      print("No data found.")
      return

    fields = values[0]
    print (fields)
    tagfinder = {'Timestamp':"Timestamp", 'Email Address':"email", 'Your 8 character FNAL (or CERN) userid':"creator", 'Give this project a name so we can give your output a name':"name", "task":'What are you trying do do?', "what":'What do you want to store', 'Is this detector data or Monte Carlo':"core.file_type",'What detector produced your data?':"core.run_type", 'What data stream is this (data)':"core.data_stream", 'What data tier is this':"core.data_tier", 'What file format is this?':"core.file_format"}
 

    tags = {}
    for i in range(0,len(fields)):
        if fields[i] in tagfinder:
            tags[i] = tagfinder[fields[i]]
        else:
            tags[i] = fields[i]

    print (tags)
    
    results = []
    for row in values[1:]:
        
      # Print columns A and E, which correspond to indices 0 and 4.
        print(row)
        newresult = {}
        for i in range(0,len(fields)):
            print (tags[i],row[i])
            newresult[tags[i]] = row[i]
        print (newresult)
        if "name" not in newresult:
            print ("can't output as no name")
        else:
            jsonname = newresult["name"]+"_template.json"
            j = {}
            j["creator"]=newresult["creator"]
            j["metadata"]={}
            for x,v in newresult.items():
                if "core" in x:
                    j["metadata"][x] = v
            print (j)
            f = open(jsonname,'w')
            f.write(json.dumps(j,indent=4))
            f.close()

        results.append(result)
  except HttpError as err:
    print(err)


if __name__ == "__main__":
  main()