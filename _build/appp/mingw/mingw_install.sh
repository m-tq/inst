###############

silent() { "$@" >/dev/null 2>&1; }

echo "Installing Dependencies"
silent apt-get update -y
silent apt-get install -y curl sudo mc
echo "Installed Dependencies"

silent apt-get install -y mingw-w64 wine64

cat > /root/hello.c << 'EOL'
#include <stdio.h>
int main() {
    printf("Hello world!\n");
}
EOL

cat > /root/compile.sh << 'EOL'
cd /root
x86_64-w64-mingw32-gcc -g -o hello hello.c
wine64 ./hello.exe
EOL

echo "Cleaning up"
silent apt-get -y autoremove
silent apt-get -y autoclean
echo "Cleaned"

##############
