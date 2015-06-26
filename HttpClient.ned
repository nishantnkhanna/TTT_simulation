//
// This file is part of an OMNeT++/OMNEST simulation example.
//
// Copyright (C) 1992-2008 Andras Varga
//
// This file is distributed WITHOUT ANY WARRANTY. See the file
// `license' for details on this and other legal matters.
//


//
// A real-time interface
//
simple HTTPClient
{
    parameters:
        int addr;
        int srvAddr;
        int clientRole;
        int clientsCount;
        volatile double sendIaTime @unit(s);
        @display("i=device/pc2");
    gates:
       // input voiceFromCloud[];
       // input voiceFromPresenter[];
       // output voicePush[];
        //output voiceUpload[];
        
        inout voiceUpload[];
        inout voiceP2P[];
        input p2pin[];
        output p2pout[];
        //inout voiceFromPresenter[];
        //inout voiceFromCloud[];
}



