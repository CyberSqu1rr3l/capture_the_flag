#!/usr/bin/env python3
from itertools import permutations

keylen = 7
ciphertext="ydonoaT4ethh1tpStefeo1e30brmKuinor7saighsgndareanwsaretr-n-aatrsityangdaalunopelaTmltwhnsirexptecoonuaoYibteceorrtedpuaet13nhoOocthft1e30broaBck(l7aiy)rdFodnvncadtasceitriceehrobeyusinngogllniqadssdseiauncfisoteadTctsyraleohbaerhmcesntasheadlelsrtstteealdmalotiransiovffietweitcsichhatehoeopgtretmonhennotadnrfeteobrmnieohtohegfnOtct3h11e30brotnosad7tilyrctolwtolfsitrenhotnsciuaninotctthedoeIrfyodwifltuaoyrouamoveesslreewihrtabnulelcredpendtwaneeaorrefv-t-assektecdanfeyoroalsvereufnaiadstoountleestdrneaoumtileorwlrznedaigclefoipTchereoaplsoePlinowlokayobctlhipPiuaVsdIhpoepevleoiwnhsdtregtasiellhwyhtePutpnedepuosrsuperwHileerehattrlstplnoeaFnctriucrcsheinnsadhtgeaiateossrcpetgrnhosnofudotriceehhneeitstnhaetvPhoptetlastfieciondsoenhiiutpuorspsyooufrtnloteyRethenhooothpfl-spur-erofayutnhthtiiawleonesnsaterymoudandobeLrrytouihw"

# Split the ciphertext into blocks of seven characters each
blocks = [ciphertext[i:i+keylen] for i in range(0, len(ciphertext), keylen)]

possible_key_perms = list(permutations(range(7)))

def apply_permutation(block, perm):
    """Loop through the permutation tuple and pick characters from the block."""
    return ''.join(block[i] for i in perm)

# Judging from the question, we assume the word faith appears in the plaintext
for perm in possible_key_perms:
    plaintext = ''.join(apply_permutation(block, perm) for block in blocks)
    if "faith" in plaintext.lower():
        print("\nPossible key permutation:", perm)
        print("Decrypted text snippet:", plaintext[:50])

key = [6, 4, 1, 5, 0, 2, 3]
plaintext = ''.join(apply_permutation(block, key) for block in blocks)
print("\n" + plaintext)
