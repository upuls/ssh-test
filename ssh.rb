require 'net/ssh'

options = {
  host_key: 'ssh-rsa',
  auth_methods: ['publickey'],
  send_env: false,
  port: 22,
  timeout: 10,
  verify_host_key: :never,
  user_known_hosts_file: '/dev/null',
  keys_only: true,
  keys: ['./ssh_assets/id_opf_ssh_user_ed25519']
}

Net::SSH.start('ssh-server', 'opf_ssh_user', options) do |ssh|
  output = ssh.exec!('ls -la')
  puts output
end
