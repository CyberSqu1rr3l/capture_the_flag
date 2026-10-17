void lp_collect_system_info(void)

{
  __uid_t __uid;
  long lVar1;
  passwd *ppVar2;
  FILE *__stream;
  size_t sVar3;
  long in_FS_OFFSET;
  statvfs local_688;
  sysinfo local_618;
  utsname local_5a8;
  char local_418 [1032];
  long local_10;

  local_10 = *(long *)(in_FS_OFFSET + 0x28);
  uname(&local_5a8);
  system_name = &local_5a8;
  node_name = local_5a8.nodename;
  release = local_5a8.release;
  version = local_5a8.version;
  machine_architecture = local_5a8.machine;
  kernel_version = local_5a8.release;
  cpu_architecture = local_5a8.machine;
  lVar1 = sysconf(0x54);
  num_cpu_cores = (undefined4)lVar1;
  sysinfo(&local_618);
  total_memory = local_618.totalram;
  free_memory = local_618.freeram;
  available_memory = local_618.bufferram + local_618.freeram;
  statvfs("/",&local_688);
  total_disk_space = local_688.f_frsize * local_688.f_blocks;
  free_disk_space = local_688.f_frsize * local_688.f_bfree;
  file_system_type = &DAT_0010700d;
  pid = getpid();
  ppid = getppid();
  __uid = getuid();
  ppVar2 = getpwuid(__uid);
  current_user = ppVar2->pw_name;
  current_working_directory = getcwd((char *)0x0,0);
  uid = getuid();
  gid = getgid();
  environment_variables = getenv("PATH");
  __stream = fopen("/etc/passwd","r");
  if (__stream == (FILE *)0x0) {
    passwd_file = "Invalid";
  }
  else {
    sVar3 = fread(local_418,1,0x3ff,__stream);
    local_418[sVar3] = '\0';
    passwd_file = strdup(local_418);
    fclose(__stream);
  }
  if (local_10 != *(long *)(in_FS_OFFSET + 0x28)) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
  return;
}

