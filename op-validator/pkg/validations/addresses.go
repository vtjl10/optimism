package validations

import (
	"fmt"

	"github.com/ethereum/go-ethereum/common"
)

const (
	VersionV180 = "v1.8.0"
	VersionV200 = "v2.0.0"
)

var addresses = map[uint64]map[string]common.Address{
	11155111: {
		// Bootstrapped on 03/02/2025 using OP Deployer.
		VersionV180: common.HexToAddress("0x0a5bf8ebb4b177b2dcc6eba933db726a2e2e2b4d"),
		// Bootstrapped on 03/02/2025 using OP Deployer.
		VersionV200: common.HexToAddress("0x37739a6b0a3f1e7429499a4ec4a0685439daff5c"),
	},
}

func ValidatorAddress(chainID uint64, version string) (common.Address, error) {
	chainAddresses, ok := addresses[chainID]
	if !ok {
		return common.Address{}, fmt.Errorf("unsupported chain ID: %d", chainID)
	}

	address, ok := chainAddresses[version]
	if !ok {
		return common.Address{}, fmt.Errorf("unsupported version: %s", version)
	}
	return address, nil
}
