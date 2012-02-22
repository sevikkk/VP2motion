uint8_t opendisk(void);
uint8_t openfile(char *fname);
int16_t readfile(void);
uint8_t writeblock(uint32_t n, uint8_t *buf);

extern uint8_t	buf[512];
extern uint32_t secno;

void do_dump(void);
void do_ls(void);
void do_rename(void);
void do_rm(void);

