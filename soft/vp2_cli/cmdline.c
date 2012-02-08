/*! \file cmdline.c \brief Command-Line Interface Library. */
//*****************************************************************************
//
// File Name	: 'cmdline.c'
// Title		: Command-Line Interface Library
// Author		: Pascal Stang - Copyright (C) 2003
// Created		: 2003.07.16
// Revised		: 2003.07.23
// Version		: 0.1
// Target MCU	: Atmel AVR Series
// Editor Tabs	: 4
//
// NOTE: This code is currently below version 1.0, and therefore is considered
// to be lacking in some functionality or documentation, or may not be fully
// tested.  Nonetheless, you can expect most functions to work.
//
// This code is distributed under the GNU Public License
//		which can be found at http://www.gnu.org/licenses/gpl.txt
//
//*****************************************************************************

//----- Include Files ---------------------------------------------------------
#include <string.h>			// include standard C string functions
#include <stdlib.h>			// include stdlib for string conversion functions
#include <stdint.h>
#include <conio.h>

#include "cmdline.h"

// include project-specific configuration
// #include "cmdlineconf.h"

// defines
#define ASCII_BEL				0x07
#define ASCII_BS				0x08
#define ASCII_CR				0x0D
#define ASCII_LF				0x0A
#define ASCII_ESC				0x1B
#define ASCII_DEL				0x7F

#define VT100_ARROWUP			'A'
#define VT100_ARROWDOWN			'B'
#define VT100_ARROWRIGHT		'C'
#define VT100_ARROWLEFT			'D'

#define CMDLINE_HISTORY_SAVE	0
#define CMDLINE_HISTORY_PREV	1
#define CMDLINE_HISTORY_NEXT	2

#define CMDLINE_MAX_COMMANDS 30
#define CMDLINE_MAX_CMD_LENGTH 50
#define CMDLINE_BUFFERSIZE 50
#define CMDLINE_HISTORYSIZE 5

/* long strtol(const char * nptr, char ** endptr, int base); */

// Global variables

// strings
uint8_t CmdlinePrompt[] = "cmd> ";
uint8_t CmdlineNotice[] = "cmdline: ";
uint8_t CmdlineCmdNotFound[] = "command not found";

// command list
// -commands are null-terminated strings
static char CmdlineCommandList[CMDLINE_MAX_COMMANDS][CMDLINE_MAX_CMD_LENGTH];
// command function pointer list
static CmdlineFuncPtrType CmdlineFunctionList[CMDLINE_MAX_COMMANDS];
// number of commands currently registered
uint8_t CmdlineNumCommands;

uint8_t CmdlineBuffer[CMDLINE_BUFFERSIZE];
uint8_t CmdlineBufferLength;
uint8_t CmdlineBufferEditPos;
uint8_t CmdlineInputVT100State;
uint8_t CmdlineHistory[CMDLINE_HISTORYSIZE][CMDLINE_BUFFERSIZE];
CmdlineFuncPtrType CmdlineExecFunction;

// Functions

// function pointer to single character output routine
//static void (*cmdlineOutputFunc)(unsigned char c);

#define cmdlineOutputFunc cputc

void cmdlineInit(void)
{
	// reset vt100 processing state
	CmdlineInputVT100State = 0;
	// initialize input buffer
	CmdlineBufferLength = 0;
	CmdlineBufferEditPos = 0;
	// initialize executing function
	CmdlineExecFunction = 0;
	// initialize command list
	CmdlineNumCommands = 0;
}

void cmdlineAddCommand(uint8_t* newCmdString, CmdlineFuncPtrType newCmdFuncPtr)
{
	// add command string to end of command list
	strcpy(CmdlineCommandList[CmdlineNumCommands], newCmdString);
	// add command function ptr to end of function list
	CmdlineFunctionList[CmdlineNumCommands] = newCmdFuncPtr;
	// increment number of registered commands
	CmdlineNumCommands++;
}

void cmdlineInputFunc(unsigned char c)
{
	uint8_t i;
	// process the received character

	// VT100 handling
	// are we processing a VT100 command?
	if(CmdlineInputVT100State == 2)
	{
		// we have already received ESC and [
		// now process the vt100 code
		switch(c)
		{
		case VT100_ARROWUP:
			cmdlineDoHistory(CMDLINE_HISTORY_PREV);
			break;
		case VT100_ARROWDOWN:
			cmdlineDoHistory(CMDLINE_HISTORY_NEXT);
			break;
		case VT100_ARROWRIGHT:
			// if the edit position less than current string length
			if(CmdlineBufferEditPos < CmdlineBufferLength)
			{
				// increment the edit position
				CmdlineBufferEditPos++;
				// move cursor forward one space (no erase)
				cmdlineOutputFunc(ASCII_ESC);
				cmdlineOutputFunc('[');
				cmdlineOutputFunc(VT100_ARROWRIGHT);
			}
			else
			{
				// else, ring the bell
				cmdlineOutputFunc(ASCII_BEL);
			}
			break;
		case VT100_ARROWLEFT:
			// if the edit position is non-zero
			if(CmdlineBufferEditPos)
			{
				// decrement the edit position
				CmdlineBufferEditPos--;
				// move cursor back one space (no erase)
				cmdlineOutputFunc(ASCII_BS);
			}
			else
			{
				// else, ring the bell
				cmdlineOutputFunc(ASCII_BEL);
			}
			break;
		default:
			break;
		}
		// done, reset state
		CmdlineInputVT100State = 0;
		return;
	}
	else if(CmdlineInputVT100State == 1)
	{
		// we last received [ESC]
		if(c == '[')
		{
			CmdlineInputVT100State = 2;
			return;
		}
		else
			CmdlineInputVT100State = 0;
	}
	else
	{
		// anything else, reset state
		CmdlineInputVT100State = 0;
	}

	// Regular handling
	if( (c >= 0x20) && (c < 0x7F) )
	{
		// character is printable
		// is this a simple append
		if(CmdlineBufferEditPos == CmdlineBufferLength)
		{
			// echo character to the output
			cmdlineOutputFunc(c);
			// add it to the command line buffer
			CmdlineBuffer[CmdlineBufferEditPos++] = c;
			// update buffer length
			CmdlineBufferLength++;
		}
		else
		{
			// edit/cursor position != end of buffer
			// we're inserting characters at a mid-line edit position
			// make room at the insert point
			CmdlineBufferLength++;
			for(i=CmdlineBufferLength; i>CmdlineBufferEditPos; i--)
				CmdlineBuffer[i] = CmdlineBuffer[i-1];
			// insert character
			CmdlineBuffer[CmdlineBufferEditPos++] = c;
			// repaint
			cmdlineRepaint();
			// reposition cursor
			for(i=CmdlineBufferEditPos; i<CmdlineBufferLength; i++)
				cmdlineOutputFunc(ASCII_BS);
		}
	}
	// handle special characters
	else if(c == ASCII_CR)
	{
		// user pressed [ENTER]
		// echo CR and LF to terminal
		cmdlineOutputFunc(ASCII_CR);
		cmdlineOutputFunc(ASCII_LF);
		// add null termination to command
		CmdlineBuffer[CmdlineBufferLength++] = 0;
		CmdlineBufferEditPos++;
		// command is complete, process it
		cmdlineProcessInputString();
		// reset buffer
		CmdlineBufferLength = 0;
		CmdlineBufferEditPos = 0;
	}
	else if(c == ASCII_DEL)
	{
		if(CmdlineBufferEditPos)
		{
			// is this a simple delete (off the end of the line)
			if(CmdlineBufferEditPos == CmdlineBufferLength)
			{
				// destructive backspace
				// echo backspace-space-backspace
				cmdlineOutputFunc(ASCII_BS);
				cmdlineOutputFunc(' ');
				cmdlineOutputFunc(ASCII_BS);
				// decrement our buffer length and edit position
				CmdlineBufferLength--;
				CmdlineBufferEditPos--;
			}
			else
			{
				// edit/cursor position != end of buffer
				// we're deleting characters at a mid-line edit position
				// shift characters down, effectively deleting
				CmdlineBufferLength--;
				CmdlineBufferEditPos--;
				for(i=CmdlineBufferEditPos; i<CmdlineBufferLength; i++)
					CmdlineBuffer[i] = CmdlineBuffer[i+1];
				// repaint
				cmdlineRepaint();
				// add space to clear leftover characters
				cmdlineOutputFunc(' ');
				// reposition cursor
				for(i=CmdlineBufferEditPos; i<(CmdlineBufferLength+1); i++)
					cmdlineOutputFunc(ASCII_BS);
			}
		}
		else
		{
			// else, ring the bell
			cmdlineOutputFunc(ASCII_BEL);
		}
	}
	/* else if(c == ASCII_DEL)
	{
		// not yet handled
	} */
	else if(c == ASCII_ESC)
	{
		CmdlineInputVT100State = 1;
	}
}

void cmdlineRepaint(void)
{
	uint8_t* ptr;
	uint8_t i;

	// carriage return
	cmdlineOutputFunc(ASCII_CR);
	// print fresh prompt
	cmdlinePrintPrompt();
	// print the new command line buffer
	i = CmdlineBufferLength;
	ptr = CmdlineBuffer;
	while(i--) cmdlineOutputFunc(*ptr++);
}

void cmdlineDoHistory(uint8_t action)
{
	switch(action)
	{
	case CMDLINE_HISTORY_SAVE:
		// copy CmdlineBuffer to history if not null string
		if( strlen(CmdlineBuffer) )
			strcpy(CmdlineHistory[0], CmdlineBuffer);
		break;
	case CMDLINE_HISTORY_PREV:
		// copy history to current buffer
		strcpy(CmdlineBuffer, CmdlineHistory[0]);
		// set the buffer position to the end of the line
		CmdlineBufferLength = strlen(CmdlineBuffer);
		CmdlineBufferEditPos = CmdlineBufferLength;
		// "re-paint" line
		cmdlineRepaint();
		break;
	case CMDLINE_HISTORY_NEXT:
		break;
	}
}

void cmdlineProcessInputString(void)
{
	uint8_t cmdIndex;
	uint8_t i=0;

	// save command in history
	cmdlineDoHistory(CMDLINE_HISTORY_SAVE);

	// find the end of the command (excluding arguments)
	// find first whitespace character in CmdlineBuffer
	while( !((CmdlineBuffer[i] == ' ') || (CmdlineBuffer[i] == 0)) ) i++;

	if(!i)
	{
		// command was null or empty
		// output a new prompt
		cmdlinePrintPrompt();
		// we're done
		return;
	}

	// search command list for match with entered command
	for(cmdIndex=0; cmdIndex<CmdlineNumCommands; cmdIndex++)
	{
		if( !strncmp(CmdlineCommandList[cmdIndex], CmdlineBuffer, i) )
		{
			// user-entered command matched a command in the list (database)
			// run the corresponding function
			CmdlineExecFunction = CmdlineFunctionList[cmdIndex];
			// new prompt will be output after user function runs
			// and we're done
			return;
		}
	}

	// if we did not get a match
	// output an error message
	cmdlinePrintError();
	// output a new prompt
	cmdlinePrintPrompt();
}

void cmdlineMainLoop(void)
{
	// do we have a command/function to be executed
	if(CmdlineExecFunction)
	{
		// run it
		CmdlineExecFunction();
		// reset
		CmdlineExecFunction = 0;
		// output new prompt
		cmdlinePrintPrompt();
	}
}

void cmdlinePrintPrompt(void)
{
	// print a new command prompt
	uint8_t* ptr = CmdlinePrompt;
	while(*ptr) cmdlineOutputFunc(*(ptr++));
}

void cmdlinePrintError(void)
{
	uint8_t * ptr;

	// print a notice header
	// (uint8_t*) cast used to avoid compiler warning
	ptr = (uint8_t*)CmdlineNotice;
	while(*ptr) cmdlineOutputFunc( *(ptr++) );
	
	// print the offending command
	ptr = CmdlineBuffer;
	while((*ptr) && (*ptr != ' ')) cmdlineOutputFunc(*ptr++);

	cmdlineOutputFunc(':');
	cmdlineOutputFunc(' ');

	// print the not-found message
	// (uint8_t*) cast used to avoid compiler warning
	ptr = (uint8_t*)CmdlineCmdNotFound;
	while(*ptr) cmdlineOutputFunc( *(ptr++) );

	cmdlineOutputFunc('\r');
	cmdlineOutputFunc('\n');
}

// argument retrieval commands

// return string pointer to argument [argnum]
uint8_t* cmdlineGetArgStr(uint8_t argnum)
{
	// find the offset of argument number [argnum]
	uint8_t idx=0;
	uint8_t arg;
	
	// find the first non-whitespace character
	while( (CmdlineBuffer[idx] != 0) && (CmdlineBuffer[idx] == ' ')) idx++;
	
	// we are at the first argument
	for(arg=0; arg<argnum; arg++)
	{
		// find the next whitespace character
		while( (CmdlineBuffer[idx] != 0) && (CmdlineBuffer[idx] != ' ')) idx++;
		// find the first non-whitespace character
		while( (CmdlineBuffer[idx] != 0) && (CmdlineBuffer[idx] == ' ')) idx++;
	}
	// we are at the requested argument or the end of the buffer
	return &CmdlineBuffer[idx];
}

// return argument [argnum] interpreted as a decimal integer
long cmdlineGetArgInt(uint8_t argnum)
{
	char* endptr;
	return strtol(cmdlineGetArgStr(argnum), &endptr, 10);
}

// return argument [argnum] interpreted as a hex integer
long cmdlineGetArgHex(uint8_t argnum)
{
	char* endptr;
	return strtol(cmdlineGetArgStr(argnum), &endptr, 16);
}
