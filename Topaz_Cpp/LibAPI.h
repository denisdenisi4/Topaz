//==============================================================================
//
//  PROJECT:    Topaz
//
//------------------------------------------------------------------------------
//
//  FILE:       device_unmanaged_global.h
//  CONTENT:
//
//  AUTHOR:     Heiko Gross¸, Xrite
//
//------------------------------------------------------------------------------
//
//              Copyright (C) 2014 Xrite
//
//==============================================================================
#ifndef DEVICEAPI_H
#define DEVICEAPI_H

#ifdef TOPAZ_EXPORTS
#define DEVICE_API __declspec(dllexport)
#else
#define DEVICE_API __declspec(dllimport)
#endif


#endif //DEVICEAPI_H
