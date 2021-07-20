for email in /tmp/.enemies-of-carlotta/travel@natalian.org/archive/*
do
	subject=$(formail -x Subject < $email)
	slug=$(echo "$subject"| iconv -t ascii//TRANSLIT | sed -r s/[^a-zA-Z0-9]+/-/g | sed -r s/^-+\|-+$//g | tr A-Z a-z)
	formail -x Date < $email
	d=$(date -d "$(formail -x Date < $email)" --rfc-3339=date)

cat <<- EOF > content/blog/${d}_${slug}.md
	+++
title = "$subject"
[taxonomies]
tags = [ "" ]
+++
EOF

formail -I "" < $email | sed -n '/--/q;p' >> content/blog/${d}_${slug}.md

done
