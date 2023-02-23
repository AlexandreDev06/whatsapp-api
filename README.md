# Config basics

This project created for use in anothers projects with library wppconnect-server (https://github.com/wppconnect-team/wppconnect-server)

For run this project, use foreman for start services in local

But in almost cases use the Dockerfile config for use with docker compose in anothers projects

# EndPoints

{{url_base}} is the url that you will configure the domain and the port to access the api, but a example is: localhost:5050/api

## Auth
1 - Get Token
url: {{url_base}}/auths/create_token
type: POST
description: This end points is used to create the Bearer token
body(required):
{
  "email": "xandemacedo1712@gmail.com",
  "password": "Recdin2023!"
}

response: 
{ 
  "access_token": "bearer_token_example", 
  "expires_at": 'Never' 
}

## Wpp Sessions
##### 1 - Create session
url: {{url_base}}/wpp_sessions/create_session
type: POST
description: Is used to start session and to start generation of QRCode to login WhatsApp
response:
{
  "message": "Starting service...."
}

##### 2 - Status session
url: {{url_base}}/wpp_sessions/status_session
type: GET
description: Is used to check status of connection of WhatsApp, and when the token is generated, the token is returned in base64
response:
{
  "status": "CONNECTED",
  "message": "Session connected."
}

if is QRCODE:
{
  "status": "QRCODE",
  "qrcode": "base64 of qrcode" 
}

##### 3 - Close session
url: {{url_base}}/wpp_sessions/close_session
type: POST
description: is used to close session of WhatsApp
response:
{
  "status": "CLOSED", 
  "message": "Session closed."
}

## Messages
##### 1 - Send message
url: {{url_base}}/messages/send_message
type: POST
description: is used to send message, and is applied all validations to send a message
body(required):
{
  "text": "message of bot 🤖",
  "phone_number": "551112345678"
}

response: 
{
  "status": "SENDED",
  "message": "Message will sent at: 1 minutes"
}