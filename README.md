# Config basics

This project created for use in anothers projects with library wppconnect-server (https://github.com/wppconnect-team/wppconnect-server)

For run this project, use foreman for start services in local

But in almost cases use the Dockerfile config for use with docker compose in anothers projects

# EndPoints

{{url_base}} is the url that you will configure the domain and the port to access the api, but a example is: <b>localhost:5050/api</b>

## Auth
##### 1 - Get Token 
<b>url</b>: {{url_base}}/auths/create_token<br>
<b>type</b>: POST<br>
<b>description</b>: This end points is used to create the Bearer token<br>
<b>body(required)</b>:<br>
```
{
  "email": "xandemacedo1712@gmail.com",
  "password": "Whatsapp123!"
}
```
<b>response</b>: <br>
```
{ 
  "access_token": "bearer_token_example", 
  "expires_at": 'Never' 
}
```

## Wpp Sessions
##### 1 - Create session
<b>url</b>: {{url_base}}/wpp_sessions/create_session<br>
<b>type</b>: POST<br>
<b>description</b>: Is used to start session and to start generation of QRCode to login WhatsApp<br>
<b>response</b>:<br>
```
{
  "message": "Starting service...."
}
```

##### 2 - Status session
<b>url</b>: {{url_base}}/wpp_sessions/status_session<br>
<b>type</b>: GET<br>
<b>description</b>: Is used to check status of connection of WhatsApp, and when the token is generated, the token is returned in base64<br>
<b>response</b>:<br>
```
{
  "status": "CONNECTED",
  "message": "Session connected."
}
```

<b>if is QRCODE</b>:<br>
```
{
  "status": "QRCODE",
  "qrcode": "base64 of qrcode" 
}
```

##### 3 - Close session
<b>url</b>: {{url_base}}/wpp_sessions/close_session<br>
<b>type</b>: POST<br>
<b>description</b>: is used to close session of WhatsApp<br>
<b>response</b>:<br>
```
{
  "status": "CLOSED", 
  "message": "Session closed."
}
```

## Messages
##### 1 - Send message
<b>url</b>: {{url_base}}/messages/send_message<br>
<b>type</b>: POST<br>
<b>description</b>: is used to send message, and is applied all validations to send a message<br>
<b>body(required)</b>:<br>
```
{
  "text": "message of bot 🤖",
  "phone_number": "551112345678"
}
```

<b>response</b>: <br>
```
{
  "status": "SENDED",
  "message": "Message will sent at: 1 minutes"
}
```

## Example env

```
REDIS_URL=redis://localhost:6379/1
REDIS_PASSWORD=RedisPassword

# Database config 
DATABASE_HOST=postgres
DATABASE_PORT=5432
DATABASE_USER=postgres
DATABASE_PASSWORD=postgres

# Whatsapp 
WHATSAPP_URL_LOCALHOST=http://wppconnect-server:21465
WHATSAPP_SECRET_KEY=My53cr3tKY
```

But alter this envs according your enviroment