import re, sys

def tokenize_line(line):
    line = line.strip()

    if not line:
        return None

    if line.startswith('//'):
        return ['COMMENT']
    else:
        # Order matters here
        patterns = [
            ('floatdcl', re.compile('^f$')),
            ('intdcl', re.compile('^i$')),
            ('print', re.compile('^p$')),
            ('assign', re.compile('^=$')),
            ('plus', re.compile('^\+$')),
            ('minus', re.compile('^\-$')),
            ('times', re.compile('^\*$')),
            ('among', re.compile('^\/$')),
            ('inum', re.compile('^\d+$')),
            ('fnum', re.compile('^\d+\.\d+$')),
            ('id', re.compile('^[a-zA-Z]$'))
        ]

        raw_tokens = re.findall(r'\d+\.\d+|\d+|[a-zA-Z]|[=+\-*/]', line)

        tokens = []
        for tok in raw_tokens:
            tok = tok.strip()
            token_type = None
            for ttype, pattern in patterns:
                if pattern.match(tok):
                    token_type = ttype
                    break
            if token_type:
                tokens.append(token_type)
            else:
                tokens.append('UNKNOWN')

        return tokens

def main():
    file_name = sys.argv[1]
    with open(file_name, 'r') as f:
        lines = f.readlines()

    for line in lines:
        tokens = tokenize_line(line)
        if tokens:
            print(' '.join(tokens))

if __name__ == '__main__':
    main()
