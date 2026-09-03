# Security Policy

---

## Supported Versions

| Version | Supported |
|---------|-----------|
| 1.0.x   | ✅ Yes    |
| < 1.0   | ❌ No     |

---

## Reporting a Vulnerability

If you discover a security vulnerability, please:

1. **DO NOT** open a public issue
2. Email the maintainer directly: YOUR_EMAIL@example.com
3. Provide detailed information about the vulnerability
4. Include steps to reproduce
5. Include any proof of concept if available

### What to Include

- Description of the vulnerability
- Steps to reproduce
- Affected versions
- Potential impact
- Suggested fix (if any)

### Response Time

| Priority | Response Time |
|----------|---------------|
| Critical | Within 24 hours |
| High | Within 48 hours |
| Medium | Within 72 hours |
| Low | Within 1 week |

---

## Security Best Practices

### For Users

- Always use strong encryption keys (min 16 characters)
- Save your encryption keys securely offline
- Never share keys with untrusted people
- Keep XMB 420 updated to the latest version
- Download scripts only from trusted sources
- Verify script contents before running
- Backup your data regularly
- Use unique passwords for encryption

### For Contributors

- Never commit sensitive data to the repository
- No malicious code
- No data stealing
- No account stealing
- Follow security best practices
- Use environment variables for secrets
- Review code for security issues

---

## Encryption

### Algorithm
- **Algorithm**: AES-256-CBC
- **Implementation**: OpenSSL
- **Key Length**: 256-bit
- **Block Mode**: CBC (Cipher Block Chaining)

### Key Generation
- Auto-generated per session
- Uses OpenSSL's secure random generator
- Keys are not stored anywhere
- Users must save their own keys

### Key Storage
- XMB 420 does NOT store encryption keys
- Keys are displayed once after encryption
- Users are responsible for key storage
- Lost keys = lost data (irrecoverable)

---

## Data Privacy

### What XMB 420 Stores

| Data | Stored? | Location |
|------|---------|----------|
| Downloaded scripts | ✅ Yes | `~/.xmb420/downloads/` |
| Encrypted scripts | ✅ Yes | `~/.xmb420/encrypted/` |
| Configuration | ✅ Yes | `~/.xmb420_config.lua` |
| Encryption keys | ❌ No | (User manages) |
| Personal data | ❌ No | (Not collected) |
| Usage data | ❌ No | (Not tracked) |

### Data Collection

XMB 420:
- Stores all data locally on your device
- Does NOT send data anywhere
- Does NOT collect personal information
- Does NOT track usage
- Does NOT require internet except for downloads
- Does NOT have analytics

---

## Secure Development

### Code Review Process

1. All changes are reviewed by maintainer
2. Security vulnerabilities are prioritized
3. Testing is required before release
4. Dependencies are kept updated

### Security Scanning

- Regular dependency checks
- Code review for vulnerabilities
- Security best practices followed

---

## Responsible Disclosure

We follow responsible disclosure guidelines:

1. Report vulnerability privately
2. We confirm and investigate
3. We work on a fix
4. We release a patch
5. Public disclosure after fix

---

## Vulnerability History

| Date | CVE | Severity | Status |
|------|-----|----------|--------|
| None | N/A | N/A | No known vulnerabilities |

---

## Security Contacts

| Contact | Method |
|---------|--------|
| Email | snkzzcpm@gmail.com|
| GitHub Issues | Use "Security" label |
| Discord |  |

---

## Recommendations

### Strong Encryption Keys

```bash
# Generate a strong key
openssl rand -base64 32

# Example output: 7F4jK9sL2pQ5xR8tW1yA3dE6gH0nM4vC