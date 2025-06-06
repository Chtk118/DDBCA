import hashlib
from ecdsa import SECP256k1, SigningKey, VerifyingKey

def generate_keys():
    signing_key = SigningKey.generate(curve=SECP256k1)
    verifying_key = signing_key.get_verifying_key()
    return signing_key, verifying_key

def create_sha256_hash(message):
    return hashlib.sha256(message.encode()).hexdigest()

def sign_message(signing_key, message):
    message_hash = create_sha256_hash(message)
    signature = signing_key.sign(message_hash.encode())
    return signature

def verify_signature(verifying_key, message, signature):
    message_hash = create_sha256_hash(message)
    try:
        verifying_key.verify(signature, message_hash.encode())
        print("Signature is valid.")
    except:
        print("Signature is invalid.")

# Main code
private_key, public_key = generate_keys()
print("Private Key:", private_key.to_string().hex())
print("Public Key:", public_key.to_string().hex())

message = "This is a secret message."
signature = sign_message(private_key, message)
print("Signature:", signature.hex())

verify_signature(public_key, message, signature)
