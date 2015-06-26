//
// This file is part of an OMNeT++/OMNEST simulation example.
//
// Copyright (C) 1992-2008 Andras Varga
//
// This file is distributed WITHOUT ANY WARRANTY. See the file
// `license' for details on this and other legal matters.
//


#include <omnetpp.h>
#include "NetPkt_m.h"

/**
 * Represents the network "cloud" between clients and the server;
 * see NED file for more info.
 */
class Cloud : public cSimpleModule
{
  private:
    simtime_t propDelay;

  protected:
    virtual void initialize();
    virtual void handleMessage(cMessage *msg);
};

Define_Module(Cloud);

void Cloud::initialize()
{
    propDelay = (double)par("propDelay");
}

void Cloud::handleMessage(cMessage *msg)
{
    // determine destination address
    NetPkt *pkt = check_and_cast<NetPkt *>(msg);
    int dest = pkt->getDestAddress();
    EV << "Relaying packet to addr=" << dest << endl;

    if (dest == 0) {
        sendDelayed(pkt, propDelay, "voiceServer$o", 0);
    }
    if (dest == 1) {
        sendDelayed(pkt, propDelay, "voicePresenter$o", 0);
    }
    if (dest > 1) {
        // int n = gateSize("voiceListeners");
        // int k = intuniform(0,n-1);
        // send msg to destination after the delay
        sendDelayed(pkt, propDelay, "voiceListeners$o", dest-2);
    }
}


