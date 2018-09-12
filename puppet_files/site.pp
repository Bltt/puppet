class standard{
        exec { 'get_jenkins_repo':
          command => 'curl -Lo /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo',
          path    => '/usr/local/bin/:/bin/',
        }
        exec { 'get_jenkins_key':
          command => 'rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key',
          path    => '/usr/local/bin/:/bin/',
        }


        $packages = ['java', 'git', 'maven', 'jenkins']

        package { $packages:
          ensure => installed,
        }

        include ntp

        service { 'jenkins':
          ensure  => 'running',
          enable  => true,
        }
}

node 'markpuppetcent' {
  class { 'standard': }
}

