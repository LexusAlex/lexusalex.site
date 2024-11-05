https://habr.com/ru/companies/macloud/articles/553340/
https://timeweb.cloud/tutorials/network-security/menedzher-parolej-pass
https://emunix.org/post/pass-cli/


gpg --full-gen-key
(9) ECC (sign and encrypt) *default*
(1) Curve 25519 *default*

gpg -k
gpg -K
gpg -e -a -r alexsey_89@bk.ru txt.txt
gpg -d -o f txt.txt.asc
gpg --export -a alexsey_89@bk.ru > public.gpg
gpg --export-secret-key -a alexsey_89@bk.ru > secret.gpg

gpg --delete-keys alexsey_89@bk.ru
gpg --delete-secret-keys alexsey_89@bk.ru

gpg --import public.gpg
gpg --import secret.gpg

gpg --edit-key alexsey_89@bk.ru

https://docs.passwordstore.app/docs/users/common-issues/#gnupg-aead-encryption-2974-2963-2921-2924-2653-2461-2586-2179

sudo apt install pass
pass init alexsey_89@bk.ru
~/.password-store/.gpg-id

pass insert Test/test.com
pass Test/test.com

pass insert Test/test2.com -m

https://devpew.com/blog/pass-sync/

