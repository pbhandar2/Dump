#!/usr/bin/python3

from bcc import BPF
from time import sleep 
import sys 

program="""
	#include <linux/sched.h>
	#include <linux/fs_struct.h>
	#include <linux/dcache.h>
	#include <linux/slab.h>
	#include <linux/types.h>        /* for size_t */

	int read_probe(void *ctx) {

		struct task_struct *task;
		task = (struct task_struct *)bpf_get_current_task();

		char comm_string[TASK_COMM_LEN];
		bpf_probe_read(&comm_string,TASK_COMM_LEN,(const void *) task->comm);

		struct fs_struct *cur_fs;
		cur_fs=(struct fs_struct *)task->fs;

		struct path cur_pwd;
		cur_pwd=cur_fs->root;
		
		struct dentry *dentry_mnt;
		dentry_mnt=cur_pwd.dentry;

		struct qstr file_name_struct;
		bpf_probe_read(&file_name_struct,sizeof(struct qstr),(const void *) &dentry_mnt->d_name);

		//bpf_trace_printk("ROOT MOUNT: %s\\n", file_name_struct.name);
		bpf_trace_printk("%s\\n", comm_string);

		return 0;
	}
"""

b=BPF(text=program)
b.attach_kprobe(event="sys_read", fn_name="read_probe")

while True:
	(task, pid, cpu, flags, ts, msg)=b.trace_fields()
	print(ts,msg)
	print(str(task))
	







#	for k,v in b["commands"].items():
#		print(k,v)
