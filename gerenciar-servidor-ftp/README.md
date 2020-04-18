## Configurações da quota:

Configurar PATH:

    D='/home/vagrant/scripts/accounts_manager' directory of accounts_manager
    files=$(ls $D/bin/)
    for i in $files; do j=$(echo "accounts_manager_$i"| cut -d. -f1); ln -s $D/bin/$i /usr/local/bin/$j ;done
    ln -s $D/menu.sh /usr/local/bin/accounts_manager

Dependências:

    apt-get install quota

Formatação do disco:

    fdisk  /dev/sdb # n + p + w
    mkfs.ext4 /dev/sdb1
    ls -l /dev/disk/by-uuid/ | grep sdb1 # pegar UUID

Criar pasta:

    /home/sftpfflch

Inserir a linha em /etc/fstab:

    UUID=8506ca08-8797-476d-863d-bd1d79eeb92c       /home/sftpfflch   ext4    errors=remount-ro,grpquota,usrquota     0       2

Recarregar partições:

    mount -a

Iniciar o serviço de quota:

    quotacheck -mcug /home/sftpfflch
    quotaon /home/sftpfflch


0 3 * * 0 /sbin/quotacheck -avug
/sbin/quotacheck -favug

setquota -u linux 100 200 10 15 -a /your_drive

repquota /your_drive



## Configuração do sftp:

Instalação dos pacotes básicos:

    apt-get -y install openssh-server

Adicionar o grupo sftpfflch:

    sudo addgroup --system sftpfflch

Configuração do arquivo /etc/ssh/sshd_config:

    #Subsystem sftp /usr/lib/openssh/sftp-server
    Subsystem sftp internal-sftp
    Match Group sftpfflch
        ChrootDirectory %h
        X11Forwarding no
        AllowTcpForwarding no
        ForceCommand internal-sftp

Restart ssh:

    /etc/init.d/ssh restart

## apache per user

Pacotes básicos:

    apt-get install apache2 php libapache2-mod-php -y
    a2enmod userdir
    service apache2 restart

Acrescentar nas configurações de /etc/apache2/mods-enabled/userdir.conf:

    <Directory /home/sftpfflch/*/public_html>
      AllowOverride All
      Options All
      DirectoryIndex index.php index index.html default.html default.htm
      ...
    </Directory>

Comentar bloco em /etc/apache2/mods-enabled/php7.0.conf:

    #<IfModule mod_userdir.c>
    #  <Directory /home/*/public_html>
    #    php_admin_flag engine Off
    #  </Directory>
    #</IfModule>

Bibliotecas PHP para instalar o Drupal:

    apt-get install php-dom php-xml php-gd php-pgsql php-mysql -y