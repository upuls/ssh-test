FROM linuxkit/sshd:75f399fbfb6455dfccd4cb30543d0b4b494d28c8-amd64

# Add ssh user
RUN adduser -D opf_ssh_user
# Hack - set singel character pw for user
RUN sed -i -e "s/^opf_ssh_user:!:/opf_ssh_user:*:/" /etc/shadow
# Add ssh group
RUN addgroup sshusers
# Add user to group
RUN addgroup opf_ssh_user sshusers

# Copy Key assets for sshd
COPY ./ssh_assets/*_key /etc/ssh
COPY ./ssh_assets/*_key.pub /etc/ssh

# Create and set ownership and permissions for user's .ssh directory
RUN mkdir -p /home/opf_ssh_user/.ssh
RUN chown -R opf_ssh_user:opf_ssh_user /home/opf_ssh_user/.ssh
RUN chmod 700 /home/opf_ssh_user/.ssh
# Copy public key for user and set permissions
COPY ./ssh_assets/id_opf_ssh_user_ed25519.pub /home/opf_ssh_user/.ssh/authorized_keys
RUN chmod -R 644 /home/opf_ssh_user/.ssh/authorized_keys

# Edit /etc/ssh/sshd_config 
# ...to chage LogLevel 
RUN sed -i -e "s/^#LogLevel INFO/LogLevel DEBUG/" /etc/ssh/sshd_config
# ...to grant permissions
RUN echo '' >> /etc/ssh/sshd_config
RUN echo '# Permit group access' >> /etc/ssh/sshd_config
RUN echo "AllowGroups sshusers" >> /etc/ssh/sshd_config
# RUN echo "AllowUsers opf_ssh_user" >> /etc/ssh/sshd_config

# CMD ["ls -la /home/opf_ssh_user/.ssh/authorized_keys"]
CMD ["/sbin/tini", "-s", "/usr/bin/ssh.sh"]
