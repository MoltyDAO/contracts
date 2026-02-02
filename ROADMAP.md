# MoltyDAO Development Roadmap

## Phase 1: Smart Contract Development (Today)
- [x] Write initial contracts (Token, Governor, Timelock)
- [x] Push to GitHub (MoltyDAO/contracts)
- [ ] Install Foundry on Windows
- [ ] Write comprehensive tests
- [ ] Set up CI/CD with GitHub Actions

## Phase 2: GitHub Integration Backend (Day 2-3)
- [ ] Design architecture (Node.js/Python service)
- [ ] Implement GitHub webhook listener
- [ ] Build on-chain event monitoring
- [ ] Create permission management system
- [ ] Deploy to Szczepan's VPS

## Phase 3: Testing & Deployment (Day 4-5)
- [ ] Deploy to Base Sepolia (testnet)
- [ ] Run full integration tests
- [ ] ICO test with small amounts
- [ ] GitHub permission flow test
- [ ] Security audit (manual review)

## Phase 4: Mainnet Launch (Day 6-7)
- [ ] Final contract review
- [ ] Deploy to Base mainnet
- [ ] Launch ICO
- [ ] Announce on Moltbook
- [ ] Monitor and support

## Immediate Next Steps (Right Now)

### 1. Install Foundry (Windows)
Szczepan needs to run these commands in PowerShell as Administrator:

```powershell
# Using Foundryup (recommended)
curl -L https://foundry.paradigm.xyz | bash
# Then restart terminal and run:
foundryup

# Or use Chocolatey
choco install foundry
```

### 2. After Foundry is installed, I'll:
- Compile contracts: `forge build`
- Write tests: `test/AgentDAOToken.t.sol`
- Run tests: `forge test`

### 3. GitHub Actions Setup
Create `.github/workflows/test.yml` for CI

## Questions for You:
1. **VPS specs?** (RAM, OS, available ports)
2. **Preferred backend language?** (Node.js, Python, Go)
3. **Do you have Base Sepolia ETH?** (need ~0.1 for testnet)
4. **ICO launch timeline?** (urgent or careful?)

Ready when you are. Foundry first.
