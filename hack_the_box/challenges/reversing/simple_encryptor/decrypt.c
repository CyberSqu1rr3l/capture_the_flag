#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(void) {
    FILE *encrypted_flag_fs, *decrypted_flag_fs;
    size_t file_size;
    void *file_data;
    u_int32_t timestamp_as_int;
    long byte_index;
    int random_value;
    u_int32_t random_shift_value;

    // 1. Open the encrypted file for reading the encrypted flag data
    encrypted_flag_fs = fopen("flag.enc", "rb");
    if (!encrypted_flag_fs) {
        perror("ERROR: Failed to open encrypted file flag.enc in the current directory.");
        return 1;
    }

    // 2. Read the random seed from the beginning of the encrypted file
    fread(&timestamp_as_int, 1, sizeof(timestamp_as_int), encrypted_flag_fs);

    // 3. Obtain the size of the encrypted file
    fseek(encrypted_flag_fs, 0, SEEK_END);
    file_size = ftell(encrypted_flag_fs) - sizeof(timestamp_as_int);
    fseek(encrypted_flag_fs, sizeof(timestamp_as_int), SEEK_SET);

    // 4. Allocate memory for the encrypted data
    file_data = malloc(file_size);
    if (!file_data) {
        perror("ERROR: Failed to allocate memory for file data.");
        fclose(encrypted_flag_fs);
        return 1;
    }

    // 5. Read the encrypted data into memory and then close the file stream
    fread(file_data, 1, file_size, encrypted_flag_fs);
    fclose(encrypted_flag_fs);

    // 6. Seed the random number generator with the seed from the encrypted file
    srand(timestamp_as_int);

    // 7. Reverse the encryption with XOR operation and bitwise rotation
    for (byte_index = 0; byte_index < file_size; byte_index++) {
        random_value = rand();

        // 8. Reverse the bitwise rotation by rotating in the opposite direction
        random_shift_value = rand();
        random_shift_value &= 7;

        // 9. Perform the reverse rotation, i.e. right instead of left
        ((unsigned char *)file_data)[byte_index] =
            ((unsigned char *)file_data)[byte_index] >> random_shift_value |
            ((unsigned char *)file_data)[byte_index] << (8 - random_shift_value);

        // 10. Reverse the XOR operation, i.e. XOR again with the same random value
        ((unsigned char *)file_data)[byte_index] ^= (unsigned char)random_value;
    }

    // 11. Write the decrypted data to a new file and then free the memory
    decrypted_flag_fs = fopen("flag.dec", "wb");
    if (!decrypted_flag_fs) {
        perror("ERROR: Failed to open decrypted file flag.dec for writing.");
        free(file_data);
        return 1;
    }

    fwrite(file_data, 1, file_size, decrypted_flag_fs);
    fclose(decrypted_flag_fs);
    free(file_data);

    printf("NOTE: Decryption successful and resulting file saved as 'flag.dec'.\n");

    return 0;
}
