require 'net/ssh'

options = {
  host_key: ['rsa-sha2-512'],
  # host_key: ['rsa-ed25519'],
  auth_methods: ['publickey'],
  send_env: false,
  port: 22,
  timeout: 10,
  verify_host_key: :never,
  # user_known_hosts_file: '/dev/null',
  user_known_hosts_file: '/Users/upuls/.ssh/known_hosts',
  keys_only: true,
  keys: ['./ssh_assets/id_opf_ssh_user_ed25519']
}

Net::SSH.start('ssh-server', 'opf_ssh_user', options) do |ssh|
  puts ssh.exec!('pwd')
  # ssh.exec!('cd .ssh')
  puts ssh.exec!(['cd .ssh', ' pwd'])
  output = ssh.exec!('ls -la')
  puts output
  puts 'YEAH!!!!!+======================='
  output = ssh.exec!('cd .ssh')
  output = ssh.exec!('ls -la')
  puts output
end
