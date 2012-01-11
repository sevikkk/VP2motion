int fatfindfile(char *fname);
int fatreadnext();
char *fatgetbuf();
uint8_t readblock(uint32_t n, uint8_t *buf);
