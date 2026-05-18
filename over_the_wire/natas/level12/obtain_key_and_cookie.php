<?php

// The cookie value as retrieved by the storage tab in the developer tools
$original_cookie = "HmYkBwozJw4WNyAAFyB1VUcqOE1JZjUIBis7ABdmbU1GIjEJAyIxTRg=";

// The original default data of the cookie as it was used before
$default_data = array("showpassword"=>"no", "bgcolor"=>"#ffffff");

// The desired modified data array value to show the password
$modified_data = array("showpassword"=>"yes", "bgcolor"=>"#ffffff");

function xor_converter($in, $key) {
    $text = $in;
    $result = "";

    // Iterate through each character and encode the text XORed with the key
    for($i = 0; $i < strlen($text); $i++) {
        $result .= $text[$i] ^ $key[$i % strlen($key)];
    }

    return $result;
}

$plaintext_key_rep = xor_converter(
    base64_decode($original_cookie), json_encode($default_data)
);

// Obtain only a single repetition of the previously retrieved key repetition
preg_match('/^(.+?)\1+.*$/', $plaintext_key_rep, $plaintext_key);
$plaintext_key = $plaintext_key[1];

print "The decoded key from the cookie where it is repeated: ";
print $plaintext_key;
print "\n";

print "The modified cookie value after is was XOR encrypted: ";
print base64_encode(xor_converter(json_encode($modified_data), $plaintext_key));
print "=\n";

?>
