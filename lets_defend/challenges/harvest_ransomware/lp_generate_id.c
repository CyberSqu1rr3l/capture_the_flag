char * lp_generate_id(void)

{
  long lVar1;
  int iVar2;
  char *__s;
  long in_FS_OFFSET;

  lVar1 = *(long *)(in_FS_OFFSET + 0x28);
  __s = (char *)malloc(5);
  iVar2 = rand();
  snprintf(__s,5,"%04d",(ulong)(uint)(iVar2 % 10000));
  if (lVar1 != *(long *)(in_FS_OFFSET + 0x28)) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
  return __s;
}
