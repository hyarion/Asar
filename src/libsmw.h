#pragma once
extern unsigned char * romdata;
extern int romlen;
extern const char * openromerror;
bool openrom(const char * filename, bool confirm=true);
void closerom(bool save=true);

enum mapper_t {
	lorom,
	hirom,
	sa1rom,
	sfxrom,
	norom,
} extern mapper;

extern int sa1banks[8];//only 0, 1, 4, 5 are used

//#define CONV_UNHEADERED 0
//#define CONV_HEADERED 1
//#define CONV_PCTOSNES 2
//#define CONV_SNESTOPC 0
//#define CONV_LOROM 0
//int convaddr(int addr, int mode);
//Tip: Use snestopc and pctosnes if possible.

inline int snestopc(int addr)
{
	if (addr<0 || addr>0xFFFFFF) return -1;//not 24bit
	if (mapper==lorom)
	{
		if ((addr&0xF00000)==0x700000 ||//wram, sram
			(addr&0x408000)==0x000000)//hardware regs, ram mirrors, rom mirrors, other strange junk
				return -1;
		addr=((addr&0x7F0000)>>1|(addr&0x7FFF));
		return addr;
	}
	if (mapper==hirom)
	{
		if ((addr&0xFE0000)==0x7E0000 ||//wram
			(addr&0x408000)==0x000000)//hardware regs, ram mirrors, other strange junk
				return -1;
		return addr&0x3FFFFF;
	}
	if (mapper==sfxrom)
	{
		if ((addr&0x600000)==0x600000 ||//wram, sram, open bus
			(addr&0x408000)==0x000000 ||//hardware regs, ram mirrors, rom mirrors, other strange junk
			(addr&0x800000)==0x800000)//fastrom isn't valid either in superfx
				return -1;
		if (addr&0x400000) return addr&0x3FFFFF;
		else return (addr&0x7F0000)>>1|(addr&0x7FFF);
	}
	if (mapper==sa1rom)
	{
		if ((addr&0x408000)==0x008000)
		{
			return sa1banks[(addr&0xE00000)>>21]|((addr&0x1F0000)>>1)|(addr&0x007FFF);
		}
		if ((addr&0xC00000)==0xC00000)
		{
			return sa1banks[(addr&0x700000)>>20]|(addr&0x1FFFFF);
		}
		return -1;
	}
	if (mapper==norom)
	{
		return addr;
	}
	return -1;
}

inline int pctosnes(int addr)
{
	if (mapper==lorom)
	{
		if (addr<0 || addr>=0x400000) return -1;
		addr=((addr<<1)&0x7F0000)|(addr&0x7FFF)|0x8000;
		if ((addr&0xF00000)==0x700000) return -1;
		return addr;
	}
	if (mapper==hirom)
	{
		if (addr<0 || addr>=0x400000) return -1;
		return addr|0xC00000;
	}
	if (mapper==sa1rom)
	{
		for (int i=0;i<8;i++)
		{
			if (sa1banks[i]==(addr&0x600000)) return 0x008000|(i<<21)|((addr&0x0F8000)<<1)|(addr&0x7FFF);
		}
		return -1;
	}
	if (mapper==norom)
	{
		return addr;
	}
	return -1;
}

int getpcfreespace(int size, bool isforcode, bool autoexpand=true, bool respectbankborders=true);
int getsnesfreespace(int size, bool isforcode, bool autoexpand=true, bool respectbankborders=true);

void resizerats(int snesaddr, int newlen);
void removerats(int snesaddr);
int ratsstart(int pcaddr);

bool goodchecksum();
void fixchecksum();

void WalkRatsTags(void(*func)(int loc, int len));//This one calls func() for each RATS tag in the ROM. The pointer is SNES format.
void WalkMetadata(int loc, void(*func)(int loc, char * name, int len, unsigned char * contents));//This one calls func() for each metadata block in the RATS tag whose contents (metadata) start at loc in the ROM. Do not replace name with an invalid metadata name, and note that name is not null terminated.
