# pcd-token-auto-revocation
Secure Token-Based Login with Auto Logout in PCD

This repo provides a secure, credential-free way to interact with PCD using **token-based CLI authentication**, with automatic token revocation on logout.

---

## 🚀 Features

- Secure login using PCD token (no password stored)
- Auto-generated temporary token environment
- Automatic token revocation on shell logout via `.bash_logout`
- Token and environment variables are cleaned up automatically

---

## 📁 File Structure

| File | Description |
|------|-------------|
| `pcd-login.sh` | Prompts user for password and retrieves a token securely |
| `pcd-logout.sh` | Revokes the token and clears cached files |
| `.bash_logout` | Triggers the logout script on shell exit |
| `.pcd_token` | (Auto-created) Stores the issued token temporarily |
| `.pcd_token_env` | (Auto-created) Stores CLI environment variables for token use |

---

## 🛠️ Prerequisites

- pcdctl CLI installed
- Bash shell
- OpenStack credentials (username, project, domain, auth URL)

---

## 🔧 Setup

1. **Clone the repository**

```bash
git clone https://github.com/schakraborty-pf9/pcd-token-auto-revocation.git
cd pcd-token-auto-revocation
```
2. **Edit the PCD details in pcd-login.sh & pcd-logout.sh scripts with your own environment data**
```bash
export OS_AUTH_URL="https://PCD_URL/keystone/v3"
export OS_USERNAME="pcd-username"
export OS_USER_DOMAIN_NAME="Default"
export OS_PROJECT_NAME="tenant_name"
export OS_PROJECT_DOMAIN_NAME="Default"
export OS_REGION_NAME="region_name"
export OS_AUTH_TYPE="password"
```
Update below parameters:
   **PCD_URL** = your-keystone-url<br/>
   **pcd-username** = your-username<br/>
   **tenant_name** = your tenant name in PCD<br/>
   **region_name** = your region name in PCD<br/> 

3. **Make the scripts executable**
```bash
chmod +x pcd-login.sh pcd-logout.sh
```
4. **Enable auto logout by modifying ~/.bash_logout**
```bash
echo 'bash ~/pcd-token-auto-revocation/pcd-logout.sh' >> ~/.bash_logout
```

## 🔐 Login & Use
```bash
./pcd-login.sh      # Prompts for password, stores token securely
source ~/.pcd_token_env
pcdctl compute service list # Example PCD command
```

## 🚪 Logout
Just Run:
```bash
exit
```
The logout script will:
- Revoke your OpenStack token
- Remove token and env files

```bash
🚪 Revoking OpenStack token...
✅ OpenStack token revoked.
```
## 🔒 Security Notes
- Password is never stored or echoed
- Token is stored temporarily in ~/.openstack_token
- Files are permission-restricted (chmod 600)

## 🧹 Cleanup
The logout script ensures all cached files are removed.
To clean manually:
```bash
rm -f ~/.pcd_token ~/.pcd_token_env
```







   

   
   
          
