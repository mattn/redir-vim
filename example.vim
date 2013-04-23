call redir#push('a')
silent echo "foo"

call redir#push('b')
silent echo "bar"

let b = redir#pop()

silent echo "baz"
let a = redir#pop()

echo "a=". a
echo "b=". b
