for res in $(find ~/docs/); do
	if [[ -f $res ]]; then
		# fname=$(basename $res)
		echo ${res}
	fi
done
