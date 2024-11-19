
new ubunto server

ssh user@172.16.6.13
pass is user
#Get the src :
git clone --depth=1 --branch v6.8 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

#Install Required Packages:
sudo apt-get install build-essential libncurses-dev bison flex libssl-dev libelf-dev

#Configure the Kernel:

#configuration tools:
make menuconfig 
 # Text-based menu

#Step 4: Compile the Kernel
 
 
# image on th phone

#Step 4: Compile the Kernel
make -j$(nproc)

#Install the Modules:
sudo make modules_install

Install the Kernel:
bash

sudo make install

## Step 5: Update Bootloader

   # Update GRUB (if using GRUB):
sudo update-grub

#Step 6: Testing the Kernel

#Reboot the System:
#    Restart your machine and select the new kernel from the boot menu.



#Step 7: Set Up a Testing Framework


Install Testing Tools:

    Install kselftest and LTP:
    sudo apt-get install linux-tools-common linux-tools-$(uname -r)
    sudo apt-get install ltp

Run Kernel Self-Tests:


    make kselftest

    Check results in output.log or the specified log file.

Run Linux Test Project (LTP):

    Navigate to the LTP directory and execute:
    bash

cd /path/to/ltp
./runltp


