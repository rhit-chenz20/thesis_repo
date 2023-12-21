COMMENT_SYMBOL = "//"

def parse_script(filename):
    with open(filename) as script:
        line = script.readline()
        processed_script = ""
        while line:
            stripped = line.replace(" ", "").replace("\t", "").replace("\n", "").split(COMMENT_SYMBOL, 1)[0]
            if(stripped):
                processed_script += stripped
            line = script.readline()
        return processed_script

def get_blocks(script):
    indices = [-1]
    indices.extend([i for i, x in enumerate(script) if x=="{" or x=="}"])
    func_declaration_to_code = {}
    for i in range(1,len(indices),2):
        dec = script[indices[i-1]+1:indices[i]]
        code = script[indices[i]+1:indices[i+1]].split(";")
        code = code[:len(code)-1]
        func_declaration_to_code.update({dec: code})
    return func_declaration_to_code

script_no_char = parse_script("test_script.txt")
# print(script_no_char)
func_dec_to_code = get_blocks(script_no_char)
# print(func_dec_to_code)
for _, key in enumerate(func_dec_to_code):
    print(key)
    print(func_dec_to_code.get(key))
    print()
