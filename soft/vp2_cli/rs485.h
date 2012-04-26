void rs485Init(void);
void rs485MainLoop(void);
void do_sendcmd(void);
void rs485_sendcmd(uint8_t *buf, int8_t len);

extern int8_t rs485_state; 
#define RS485_STATE_IDLE 0
#define RS485_STATE_HDR 1
#define RS485_STATE_DATA 2
#define RS485_STATE_CRC 3
#define RS485_STATE_WAIT 4
#define RS485_STATE_RETRY 5

#define RS485_BUF_SIZE 32 
extern uint8_t rs485_buf[RS485_BUF_SIZE];
extern int8_t rs485_buf_used;
extern int8_t rs485_cmd_len;
extern int8_t rs485_cmd_verbose;


