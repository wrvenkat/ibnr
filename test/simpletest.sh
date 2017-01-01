
penkernelver=''
while read first kernelver rest
do
    printf "Uninstalling kernel version: %s ....\n" "$kernelver"
    penkernelver=$(printf "%s %s\n" "$penkernelver" "$kernelver")
done < <(dpkg --list | grep -e ii[[:space:]]*linux-image.*)

printf "KernelVersions are %s" "$penkernelver"
