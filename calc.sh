#!/usr/bin/env python3

def hex_to_hex(hex1, hex2):
    # Convert hexadecimal values to decimal
    dec1 = int(hex1, 16)
    dec2 = int(hex2, 16)
    
    # Multiply the two decimal numbers
    product = dec1 * dec2
    
    # Convert the product to hexadecimal, remove the '0x' prefix, and convert to uppercase
    hex_product = hex(product)[2:].upper()
    
    # Take the first 8 characters (if available)
    first_8_chars = hex_product[:8]
    
    return first_8_chars

# Example usage
if __name__ == "__main__":
    import sys
    
    if len(sys.argv) != 3:
        print("Usage: python hex_to_hex.py <number_in_hex> <constant>")
        sys.exit(1)
    
    hex1 = sys.argv[1]
    hex2 = sys.argv[2]
    
    result = hex_to_hex(hex1, hex2)
    
    print(f"The number is:   {hex1}")
    print(f"The constant is: {hex2}")
    print(f"The first 8 characters of the product in hexadecimal is: {result}")

