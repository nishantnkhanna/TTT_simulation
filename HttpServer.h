//
// This file is part of an OMNeT++/OMNEST simulation example.
//
// Copyright (C) 1992-2008 Andras Varga
//
// This file is distributed WITHOUT ANY WARRANTY. See the file
// `license' for details on this and other legal matters.
//


#ifndef __HTTPSERVER_H
#define __HTTPSERVER_H

#include <map>
#include <string>

#include <platdep/sockets.h>
#include "SocketRTScheduler.h"

#include "QueueBase.h"

/**
 * Simple model of an HTTP server.
 */
class HTTPServer : public QueueBase
{
  private:
    typedef std::map<std::string, std::string> StringMap;
    StringMap htdocs;

    cMessage *rtEvent;
    cSocketRTScheduler *rtScheduler;

    char recvBuffer[4000];
    int numRecvBytes;

  protected:
    virtual void initialize();
    virtual simtime_t startService(cMessage *msg);
    virtual void endService(cMessage *msg);
    std::string processHTTPCommand(const char *req);
    std::string getContentFor(const char *uri);
    std::string postContentFor(const char *uri);
};

#endif



