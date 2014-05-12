require 'spec_helper'

describe '基本設定' do
  describe '基本設定' do
    it 'eth0のリンクが確立していること' do
      expect( command 'ethtool eth0' ).to return_stdout /Link\s+detected:\s+yes/
    end

    it '外部ネットワークへ到達できること' do
      expect( host 'google.com' ).to be_reachable
    end

    it 'タイムゾーンがJSTであること' do
      expect( command 'date' ).to return_stdout /JST/
    end

    describe 'vagrantユーザー' do
      subject { user 'vagrant' }

      it '存在すること' do
        expect(subject).to exist
      end

      it 'wheelグループに所属していること' do
        expect(subject).to belong_to_group 'wheel'
      end

      it 'ホームディレクトリを持つこと' do
        expect(subject).to have_home_directory '/home/vagrant'
      end
    end

    describe file('/home/vagrant/.ssh') do
      it { should be_directory }
      it { should be_mode 700 }
      it { should be_owned_by 'vagrant' }
      it { should be_grouped_into 'wheel' }
    end

    describe '不要サービスのoff' do
      it 'iptablesの自動起動が有効ではないこと' do
        expect( service 'iptables' ).not_to be_enabled
      end

      it 'iptablesが動作していないこと' do
        expect( service 'iptables' ).not_to be_running
      end

      it 'SElinuxが無効になっていること' do
        expect( selinux ).to be_disabled
      end
    end

  end
end

describe 'yumレポジトリ' do
  describe 'epel' do
    subject { yumrepo 'epel' }

    it 'setted' do
      expect(subject).to exist
    end

    it 'usable' do
      expect(subject).to be_enabled
    end
  end

  describe 'remi' do
    subject { yumrepo 'remi' }

    it 'setted' do
      expect(subject).to exist
    end

    it 'usable' do
      expect(subject).to be_enabled
    end
  end  
end


describe 'nginx' do
  it 'nginxがインストールされていること' do
    expect( package 'nginx' ).to be_installed
  end

  describe 'nginx service' do
    subject { service 'nginx' }

    it '自動起動が有効であること' do
      expect(subject).to be_enabled
    end

    it '動作していること' do
      expect(subject).to be_running
    end
  end

  it '80番ポートでListenしていること' do
    expect( port 80 ).to be_listening
  end
end

describe 'MySQL基本設定' do
  subject { service 'mysqld' }

  it '自動起動が有効であること' do
    expect(subject).to be_enabled
  end

  it '起動していること' do
    expect(subject).to be_running
  end

  it '3306番ポートでListenしていること' do
    expect(port 3306).to be_listening
  end
end

describe 'MySQL5.6' do
  describe 'packages' do
    it 'installed mysql client' do
      expect(package 'mysql-community-client').to be_installed.with_version '5.6'
    end

    it 'installed mysql server' do
      expect(package 'mysql-community-server').to be_installed.with_version '5.6'
    end

    it 'installed mysql devel' do
      expect(package 'mysql-community-devel').to be_installed.with_version '5.6'
    end

    it 'installed mysql utilities' do
      expect(package 'mysql-utilities').to be_installed
    end
  end
end

describe '共通パッケージ群' do
  describe 'インストール' do
    it 'gitがインストールされていること' do
      expect( package 'git' ).to be_installed
    end

    it 'wgetがインストールされていること' do
      expect( package 'wget' ).to be_installed
    end

    it 'curlがインストールされていること' do
      expect( package 'curl' ).to be_installed
    end

    it 'treeがインストールされていること' do
      expect( package 'tree' ).to be_installed
    end

    it 'htopがインストールされていること' do
      expect( package 'htop' ).to be_installed
    end
  end
end

describe 'Perl環境' do
  it 'perl5.8.12が使用可能なこと' do
    expect( command 'su - vagrant -c \'perl -v\'' ).to return_stdout /5.18.2/
  end

  # it 'cpanmコマンドが利用可能であること' do
  #   expect( command 'cpanm' ).to return_exit_status 0
  # end
end

describe 'schoolg ミドルウェア' do
  describe 'インストール' do
    it 'memcachedがインストールされていること' do
      expect( package 'memcached' ).to be_installed
    end

    it 'libxml2がインストールされていること' do
      expect( package 'libxml2').to be_installed
    end

    it 'libxml2-develがインストールされていること' do
      expect( package 'libxml2-devel').to be_installed
    end

    it 'monitがインストールされていること' do
      expect( package 'monit' ).to be_installed
    end

    it 'libgtop2がインストールされていること' do
      expect( package 'libgtop2' ).to be_installed
    end

    it 'libgtop2-develがインストールされていること' do
      expect( package 'libgtop2-devel' ).to be_installed
    end

    it 'httpdがインストールされていること' do
      expect( package 'httpd' ).to be_installed
    end

    it 'nfs-utilsがインストールされていること' do
      expect( package 'nfs-utils' ).to be_installed
    end

    it 'nfs-utils-libがインストールされていること' do
      expect( package 'nfs-utils-lib' ).to be_installed
    end

    it 'firefoxがインストールされていること' do
      expect( package 'firefox' ).to be_installed
    end

    it 'xorg-x11-server-Xvfbがインストールされていること' do
      expect( package 'xorg-x11-server-Xvfb' ).to be_installed
    end

    it 'urw-fontsがインストールされていること' do
      expect( package 'urw-fonts' ).to be_installed
    end

    it 'xorg-x11-xauthがインストールされていること' do
      expect( package 'xorg-x11-xauth' ).to be_installed
    end
  end
end
