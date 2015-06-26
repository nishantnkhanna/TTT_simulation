//
// This file is part of an OMNeT++/OMNEST simulation example.
//
// Copyright (C) 1992-2008 Andras Varga
//
// This file is distributed WITHOUT ANY WARRANTY. See the file
// `license' for details on this and other legal matters.
//



#include <omnetpp.h>
#include "HttpMsg_m.h"



class HTTPClient : public cSimpleModule
{
  private:

    int addr;
    int srvAddr;
    int clientRole;
    int clientsCount;

  protected:
    virtual void initialize();
    virtual void handleMessage(cMessage *msg);
    void sendHTTPRequest();
    void sendHTTPRequestPost();
    //void sendHTTPRequestToPeer();
    void sendHTTPResponseToPeer();
    void processHTTPReply(HTTPMsg *httpMsg);
};

Define_Module(HTTPClient);

void HTTPClient::initialize()
{

    addr = par("addr");
    srvAddr = par("srvAddr");
    clientRole = par("clientRole");
    clientsCount = par("clientsCount");

    cMessage *timer = new cMessage("timer");
    scheduleAt(simTime()+par("sendIaTime").doubleValue(), timer);
}

void HTTPClient::handleMessage(cMessage *msg)
{
    if (msg->isSelfMessage())
    {
       EV  << "Starting service of ";

        if(clientRole == 1){
            sendHTTPRequestPost();
        }else{
            sendHTTPRequest();
        }
        scheduleAt(simTime()+par("sendIaTime").doubleValue(), msg);

    }
    else
    {
        processHTTPReply(check_and_cast<HTTPMsg *>(msg));
    }
}

void HTTPClient::sendHTTPRequest()
{
    const char *header = "GET / HTTP/1.0\r\n\r\n";

    // assemble and send HTTP request
    HTTPMsg *httpMsg = new HTTPMsg();
    httpMsg->setPayload(header);
    httpMsg->setDestAddress(srvAddr);
    httpMsg->setSrcAddress(addr);
  //  int dest = httpMsg->getDestAddress();
//    int n = gateSize("voiceUpload");
//    int k = intuniform(0,n-1);
    send(httpMsg,"voiceUpload$o",0);


 /*if (dest == 0){

     int n = gateSize("voicePush");
        int k = intuniform(0,n-1);void HTTPClient::sendHTTPRequestPost()
        send(httpMsg, "voicePush",k);
 }
 else if (dest==1){
     int n = gateSize("voiceUpload");
             int k = intuniform(0,n-1);
             send(httpMsg, "voiceUpload",k);
 }*/

}

void HTTPClient::sendHTTPRequestPost()
{
   // const char *header = "GET / HTTP/1.0\r\n\r\n";
    const char *header =  "POST / HTTP/1.1\r\n\r\n";
    // assemble and send HTTP request
    HTTPMsg *httpMsg = new HTTPMsg();
    httpMsg->setPayload(header);
    httpMsg->setDestAddress(srvAddr);
    httpMsg->setSrcAddress(addr);
    send(httpMsg,"voiceUpload$o",0);

    // int dest = httpMsg->getDestAddress();
    // int n = gateSize("voiceFromPresenter");
    // int k = intuniform(0,n-1);
    for (int i=0; i<clientsCount; i++) {
        HTTPMsg *httpMsg = new HTTPMsg();
        httpMsg->setPayload(header);
        httpMsg->setSrcAddress(addr);

        httpMsg->setDestAddress(2+i);

        send(httpMsg,"voiceP2P$o",0);
    }
}

void sendHTTPResponseToPeer()
{

    const char *header =  "POST / HTTP/1.1\r\n\r\n";
       // assemble and send HTTP request
       HTTPMsg *httpMsg = new HTTPMsg();
       httpMsg->setPayload(header);
       httpMsg->setDestAddress(srvAddr);
       httpMsg->setSrcAddress(addr);
       int dest = httpMsg->getDestAddress();
       if (dest >= 2){
            //detect if the request received from peer node, peer node address greater than 2

      // for (int i=0; i<clientsCount; i++) {

           //HTTPMsg *httpMsg = new HTTPMsg();
         //  httpMsg->setPayload(header);
           httpMsg->setSrcAddress(addr);
           httpMsg->setDestAddress(2+i);
           send(httpMsg,"voiceP2P$o",0);

        }


   }




void HTTPClient::processHTTPReply(HTTPMsg *httpMsg)
{
    delete httpMsg;
}

