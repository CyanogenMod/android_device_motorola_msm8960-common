/*
 * Copyright (C) 2007 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* This file is used to define the properties of the filesystem
** images generated by build tools (mkbootfs and mkyaffs2image) and
** by the device side of adb.
*/

#ifndef _ANDROID_FILESYSTEM_CONFIG_H_
#define _ANDROID_FILESYSTEM_CONFIG_H_

#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <stdint.h>

#ifdef HAVE_ANDROID_OS
#include <linux/capability.h>
#else
#include "android_filesystem_capability.h"
#endif

/* This is the master Users and Groups config for the platform.
** DO NOT EVER RENUMBER.
*/

#define AID_ROOT             0  /* traditional unix root user */

#define AID_SYSTEM        1000  /* system server */

#define AID_RADIO         1001  /* telephony subsystem, RIL */
#define AID_BLUETOOTH     1002  /* bluetooth subsystem */
#define AID_GRAPHICS      1003  /* graphics devices */
#define AID_INPUT         1004  /* input devices */
#define AID_AUDIO         1005  /* audio devices */
#define AID_CAMERA        1006  /* camera devices */
#define AID_LOG           1007  /* log devices */
#define AID_COMPASS       1008  /* compass device */
#define AID_MOUNT         1009  /* mountd socket */
#define AID_WIFI          1010  /* wifi subsystem */
#define AID_ADB           1011  /* android debug bridge (adbd) */
#define AID_INSTALL       1012  /* group for installing packages */
#define AID_MEDIA         1013  /* mediaserver process */
#define AID_DHCP          1014  /* dhcp client */
#define AID_SDCARD_RW     1015  /* external storage write access */
#define AID_VPN           1016  /* vpn system */
#define AID_KEYSTORE      1017  /* keystore subsystem */
#define AID_USB           1018  /* USB devices */
#define AID_DRM           1019  /* DRM server */
#define AID_MDNSR         1020  /* MulticastDNSResponder (service discovery) */
#define AID_GPS           1021  /* GPS daemon */
#define AID_UNUSED1       1022  /* deprecated, DO NOT USE */
#define AID_MEDIA_RW      1023  /* internal media storage write access */
#define AID_MTP           1024  /* MTP USB driver access */
#define AID_UNUSED2       1025  /* deprecated, DO NOT USE */
#define AID_DRMRPC        1026  /* group for drm rpc */
#define AID_NFC           1027  /* nfc subsystem */
#define AID_SDCARD_R      1028  /* external storage read access */
#define AID_CLAT          1029  /* clat part of nat464 */
#define AID_LOOP_RADIO    1030  /* loop radio devices */
#define AID_MEDIA_DRM     1031  /* MediaDrm plugins */
#define AID_AUDIT         1032  /* audit daemon */
#define AID_FM_RADIO      1033  /* FM radio */
#define AID_SMARTCARD     1134  /* smart card subsystem */

#define AID_THEMEMAN      1300  /* theme manager */

#define AID_SHELL         2000  /* adb and debug shell user */
#define AID_CACHE         2001  /* cache access */
#define AID_DIAG          2002  /* access to diagnostic resources */

/* The 3000 series are intended for use as supplemental group id's only.
 * They indicate special Android capabilities that the kernel is aware of. */
#define AID_NET_BT_ADMIN  3001  /* bluetooth: create any socket */
#define AID_NET_BT        3002  /* bluetooth: create sco, rfcomm or l2cap sockets */
#define AID_INET          3003  /* can create AF_INET and AF_INET6 sockets */
#define AID_NET_RAW       3004  /* can create raw INET sockets */
#define AID_NET_ADMIN     3005  /* can configure interfaces and routing tables. */
#define AID_NET_BW_STATS  3006  /* read bandwidth statistics */
#define AID_NET_BW_ACCT   3007  /* change bandwidth statistics accounting */
#define AID_NET_BT_STACK  3008  /* bluetooth: access config files */
#define AID_QCOM_ONCRPC   3009  /* can read/write /dev/oncrpc files */
#define AID_QCOM_DIAG     3010  /* can read/write /dev/diag */

#define AID_MOT_ACCY      9000  /* access to accessory */
#define AID_MOT_PWRIC     9001  /* power IC */
#define AID_MOT_USB       9002  /* mot usb */
#define AID_MOT_DRM       9003  /* can access DRM resource. */
#define AID_MOT_TCMD      9004  /* mot_tcmd */
#define AID_MOT_SEC_RTC   9005  /* mot cpcap rtc */
#define AID_MOT_TOMBSTONE 9006
#define AID_MOT_TPAPI     9007  /* mot_tpapi */
#define AID_MOT_SECCLKD   9008  /* mot_secclkd */
#define AID_MOT_WHISPER   9009  /* Whisper Protocol access */
#define AID_MOT_CAIF      9010  /* can create CAIF sockets */
#define AID_MOT_DLNA      9011  /* DLNA native */
#define AID_MOT_ATVC      9012 /* mot_atvc - This is for use of the ATVC service ONLY */

#define AID_MISC          9998  /* access to misc storage */
#define AID_NOBODY        9999

#define AID_APP          10000  /* first app user */

#define AID_ISOLATED_START 99000 /* start of uids for fully isolated sandboxed processes */
#define AID_ISOLATED_END   99999 /* end of uids for fully isolated sandboxed processes */

#define AID_USER        100000  /* offset for uid ranges for each user */

#define AID_SHARED_GID_START 50000 /* start of gids for apps in each user to share */
#define AID_SHARED_GID_END   59999 /* start of gids for apps in each user to share */

#if !defined(EXCLUDE_FS_CONFIG_STRUCTURES)
struct android_id_info {
    const char *name;
    unsigned aid;
};

static const struct android_id_info android_ids[] = {
    { "root",      AID_ROOT, },
    { "system",    AID_SYSTEM, },
    { "radio",     AID_RADIO, },
    { "bluetooth", AID_BLUETOOTH, },
    { "graphics",  AID_GRAPHICS, },
    { "input",     AID_INPUT, },
    { "audio",     AID_AUDIO, },
    { "camera",    AID_CAMERA, },
    { "log",       AID_LOG, },
    { "compass",   AID_COMPASS, },
    { "mount",     AID_MOUNT, },
    { "wifi",      AID_WIFI, },
    { "dhcp",      AID_DHCP, },
    { "adb",       AID_ADB, },
    { "install",   AID_INSTALL, },
    { "media",     AID_MEDIA, },
    { "drm",       AID_DRM, },
    { "mdnsr",     AID_MDNSR, },
    { "nfc",       AID_NFC, },
    { "drmrpc",    AID_DRMRPC, },
    { "shell",     AID_SHELL, },
    { "cache",     AID_CACHE, },
    { "diag",      AID_DIAG, },
    { "net_bt_admin", AID_NET_BT_ADMIN, },
    { "net_bt",    AID_NET_BT, },
    { "net_bt_stack",    AID_NET_BT_STACK, },
    { "sdcard_r",  AID_SDCARD_R, },
    { "sdcard_rw", AID_SDCARD_RW, },
    { "media_rw",  AID_MEDIA_RW, },
    { "vpn",       AID_VPN, },
    { "keystore",  AID_KEYSTORE, },
    { "smartcard", AID_SMARTCARD, },
    { "usb",       AID_USB, },
    { "mtp",       AID_MTP, },
    { "gps",       AID_GPS, },
    { "inet",      AID_INET, },
    { "net_raw",   AID_NET_RAW, },
    { "net_admin", AID_NET_ADMIN, },
    { "net_bw_stats", AID_NET_BW_STATS, },
    { "net_bw_acct", AID_NET_BW_ACCT, },
    { "loop_radio", AID_LOOP_RADIO, },
    { "qcom_oncrpc", AID_QCOM_ONCRPC, },
    { "qcom_diag", AID_QCOM_DIAG, },
    { "fm_radio",  AID_FM_RADIO, },
    { "mot_accy",	AID_MOT_ACCY, },
    { "mot_pwric",	AID_MOT_PWRIC, },
    { "mot_usb",	AID_MOT_USB, },
    { "mot_drm",	AID_MOT_DRM, },
    { "mot_tcmd",	AID_MOT_TCMD, },
    { "mot_sec_rtc",	AID_MOT_SEC_RTC, },
    { "mot_tombstone",	AID_MOT_TOMBSTONE, },
    { "mot_tpapi",	AID_MOT_TPAPI, },
    { "mot_secclkd",	AID_MOT_SECCLKD, },
    { "mot_whisper",	AID_MOT_WHISPER, },
    { "mot_caif",	AID_MOT_CAIF, },
    { "mot_dlna",	AID_MOT_DLNA, },
    { "mot_atvc",	AID_MOT_ATVC, },
    { "misc",      AID_MISC, },
    { "nobody",    AID_NOBODY, },
    { "clat",      AID_CLAT, },
    { "mediadrm",  AID_MEDIA_DRM, },
    { "theme_man", AID_THEMEMAN },
    { "audit",      AID_AUDIT, },
};

#define android_id_count \
    (sizeof(android_ids) / sizeof(android_ids[0]))

struct fs_path_config {
    unsigned mode;
    unsigned uid;
    unsigned gid;
    uint64_t capabilities;
    const char *prefix;
};

/* Rules for directories.
** These rules are applied based on "first match", so they
** should start with the most specific path and work their
** way up to the root.
*/

static const struct fs_path_config android_dirs[] = {
    { 00770, AID_SYSTEM, AID_CACHE,  0, "cache" },
    { 00771, AID_SYSTEM, AID_SYSTEM, 0, "data/app" },
    { 00771, AID_SYSTEM, AID_SYSTEM, 0, "data/app-private" },
    { 00771, AID_SYSTEM, AID_SYSTEM, 0, "data/dalvik-cache" },
    { 00771, AID_SYSTEM, AID_SYSTEM, 0, "data/data" },
    { 00771, AID_SHELL,  AID_SHELL,  0, "data/local/tmp" },
    { 00771, AID_SHELL,  AID_SHELL,  0, "data/local" },
    { 01771, AID_SYSTEM, AID_MISC,   0, "data/misc" },
    { 00770, AID_DHCP,   AID_DHCP,   0, "data/misc/dhcp" },
    { 00775, AID_MEDIA_RW, AID_MEDIA_RW, 0, "data/media" },
    { 00775, AID_MEDIA_RW, AID_MEDIA_RW, 0, "data/media/Music" },
    { 00771, AID_SYSTEM, AID_SYSTEM, 0, "data" },
    { 00750, AID_ROOT,   AID_SHELL,  0, "sbin" },
    { 00755, AID_ROOT,   AID_ROOT,   0, "system/addon.d" },
    { 00755, AID_ROOT,   AID_SHELL,  0, "system/bin" },
    { 00755, AID_ROOT,   AID_SHELL,  0, "system/vendor" },
    { 00755, AID_ROOT,   AID_SHELL,  0, "system/xbin" },
    { 00755, AID_ROOT,   AID_ROOT,   0, "system/etc/ppp" },
    { 00755, AID_ROOT,   AID_SHELL,  0, "vendor" },
    { 00777, AID_ROOT,   AID_ROOT,   0, "sdcard" },
    { 00755, AID_ROOT,   AID_ROOT,   0, 0 },
};

/* Rules for files.
** These rules are applied based on "first match", so they
** should start with the most specific path and work their
** way up to the root. Prefixes ending in * denotes wildcard
** and will allow partial matches.
*/
static const struct fs_path_config android_files[] = {
    { 00440, AID_ROOT,      AID_SHELL,     0, "system/etc/init.goldfish.rc" },
    { 00550, AID_ROOT,      AID_SHELL,     0, "system/etc/init.goldfish.sh" },
    { 00550, AID_SYSTEM,    AID_SYSTEM,    0, "system/etc/init.qcom.sdio.sh" },
    { 00440, AID_ROOT,      AID_SHELL,     0, "system/etc/init.trout.rc" },
    { 00550, AID_ROOT,      AID_SHELL,     0, "system/etc/init.ril" },
    { 00550, AID_ROOT,      AID_SHELL,     0, "system/etc/init.testmenu" },
    { 00550, AID_DHCP,      AID_SHELL,     0, "system/etc/dhcpcd/dhcpcd-run-hooks" },
    { 00444, AID_RADIO,     AID_AUDIO,     0, "system/etc/AudioPara4.csv" },
    { 00555, AID_ROOT,      AID_ROOT,      0, "system/etc/ppp/*" },
    { 00555, AID_ROOT,      AID_ROOT,      0, "system/etc/rc.*" },
    { 00755, AID_ROOT,      AID_ROOT,      0, "system/addon.d/*" },
    { 00644, AID_SYSTEM,    AID_SYSTEM,    0, "data/app/*" },
    { 00644, AID_MEDIA_RW,  AID_MEDIA_RW,  0, "data/media/*" },
    { 00644, AID_SYSTEM,    AID_SYSTEM,    0, "data/app-private/*" },
    { 00644, AID_APP,       AID_APP,       0, "data/data/*" },
    { 00755, AID_ROOT,      AID_ROOT,      0, "system/bin/ping" },

    /* the following file is INTENTIONALLY set-gid and not set-uid.
     * Do not change. */
    { 02750, AID_ROOT,      AID_INET,      0, "system/bin/netcfg" },

    /* the following five files are INTENTIONALLY set-uid, but they
     * are NOT included on user builds. */
    { 06755, AID_ROOT,      AID_ROOT,      0, "system/xbin/su" },
    { 06755, AID_ROOT,      AID_ROOT,      0, "system/xbin/librank" },
    { 06755, AID_ROOT,      AID_ROOT,      0, "system/xbin/procrank" },
    { 06755, AID_ROOT,      AID_ROOT,      0, "system/xbin/procmem" },
    { 06755, AID_ROOT,      AID_ROOT,      0, "system/xbin/tcpdump" },
    { 04770, AID_ROOT,      AID_RADIO,     0, "system/bin/pppd-ril" },

    /* the following file has enhanced capabilities and IS included in user builds. */
    { 00750, AID_ROOT,      AID_SHELL,     (1 << CAP_SETUID) | (1 << CAP_SETGID), "system/bin/run-as" },

    { 00755, AID_ROOT,      AID_SHELL,     0, "system/bin/*" },
    { 00755, AID_ROOT,      AID_ROOT,      0, "system/lib/valgrind/*" },
    { 00755, AID_ROOT,      AID_SHELL,     0, "system/xbin/*" },
    { 00755, AID_ROOT,      AID_SHELL,     0, "system/vendor/bin/*" },
    { 00755, AID_ROOT,      AID_SHELL,     0, "vendor/bin/*" },
    { 00750, AID_ROOT,      AID_SHELL,     0, "sbin/*" },
    { 00755, AID_ROOT,      AID_ROOT,      0, "bin/*" },
    { 00750, AID_ROOT,      AID_SHELL,     0, "init*" },
    { 00750, AID_ROOT,      AID_SHELL,     0, "charger*" },
    { 00750, AID_ROOT,      AID_SHELL,     0, "sbin/fs_mgr" },
    { 00640, AID_ROOT,      AID_SHELL,     0, "fstab.*" },
    { 00755, AID_ROOT,      AID_SHELL,     0, "system/etc/init.d/*" },
    { 00644, AID_ROOT,      AID_ROOT,      0, 0 },
};

static inline void fs_config(const char *path, int dir,
                             unsigned *uid, unsigned *gid, unsigned *mode, uint64_t *capabilities)
{
    const struct fs_path_config *pc;
    int plen;

    if (path[0] == '/') {
        path++;
    }

    pc = dir ? android_dirs : android_files;
    plen = strlen(path);
    for(; pc->prefix; pc++){
        int len = strlen(pc->prefix);
        if (dir) {
            if(plen < len) continue;
            if(!strncmp(pc->prefix, path, len)) break;
            continue;
        }
        /* If name ends in * then allow partial matches. */
        if (pc->prefix[len -1] == '*') {
            if(!strncmp(pc->prefix, path, len - 1)) break;
        } else if (plen == len){
            if(!strncmp(pc->prefix, path, len)) break;
        }
    }
    *uid = pc->uid;
    *gid = pc->gid;
    *mode = (*mode & (~07777)) | pc->mode;
    *capabilities = pc->capabilities;

#if 0
    fprintf(stderr,"< '%s' '%s' %d %d %o >\n",
            path, pc->prefix ? pc->prefix : "", *uid, *gid, *mode);
#endif
}
#endif
#endif