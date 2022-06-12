// SPDX-License-Identifier: LGPL-3.0-or-later
pragma solidity ^0.8.11;

/**
 * Buddle Bridge Interface
 *
 */
interface IBuddleBridge {

    struct BuddleContracts {
        address source;
        address destination;
    }

    /********************** 
     * onlyOwner functions *
     ***********************/

    /**
     * Set the Buddle source side contract for the respective L2 chain
     *
     * @param _src The address of the deployed Source Side contract
     */
    function setSource(
        address _src
    ) external;

    /**
     * Set the Buddle destination side contract for the respective L2 chain
     *
     * @param _dest The address of the deployed Destination Side contract
     */
    function setDestination(
        address _dest
    ) external;

    /**
     * Add a token mapping (from L2 to L1) to the contract for a specific ERC20 token
     *
     * @param _l2TokenAddress The token address on Layer-2
     * @param _l1TokenAddress The token address on Layer-1
     */
    function addTokenMap(
        address _l2TokenAddress,
        address _l1TokenAddress 
    ) external;

    /**
     * Update an existing token mapping in the contract for a specific ERC20 token
     *
     * @param _l2TokenAddress The token address on Layer-2
     * @param _l1TokenAddress The token address on Layer-1
     */
    function updateTokenMap(
        address _l2TokenAddress,
        address _l1TokenAddress 
    ) external;

    /**
     * Add a buddle bridge contract for an alternate layer-2 chain
     *
     * @param _chain Chain ID for the target layer 2 blockchain
     * @param _contract Contract address of the deployed Buddle contract on layer 1
     */
    function addBuddleBridge(
        uint256 _chain,
        address _contract
    ) external;

    /**
     * Update an existing buddle bridge contract for the alternate layer-2 chain
     *
     * @param _chain Chain ID for the target layer 2 blockchain
     * @param _contract Contract address of the deployed Buddle contract on layer 1
     */
    function updateBuddleBridge(
        uint256 _chain,
        address _contract
    ) external;

    /********************** 
     * public functions *
     ***********************/

    /**
     * Claim the bounty for the current pool. A ticket must be emitted prior to this function.
     *
     * @param _ticket The ticket generated by the source L2 contract
     * @param _chain The chain ID for the destination contract
     * @param _tokens List of tokens (L2 addresses) supported by Buddle Source
     * @param _amounts List of amounts corresponding to _tokens
     * @param _bounty List of bounty amounts corresponding to _tokens
     * @param _firstIdForTicket The first transfer id included in _ticket
     * @param _lastIdForTicket The last transfer id included in _ticket
     * @param stateRoot State root emitted with the corresponding _ticket
     */
    function claimBounty(
        bytes32 _ticket,
        uint256 _chain,
        address[] memory _tokens,
        uint256[] memory _amounts,
        uint256[] memory _bounty,
        uint256 _firstIdForTicket,
        uint256 _lastIdForTicket,
        bytes32 stateRoot
    ) external payable;

    /**
     * Transfer funds from layer 1 to layer 2 using the standard bridge of the respective chain
     *
     * @param _tokens The list of token addresses on layer 2
     * @param _amounts The list of corresponding amounts to be transferred
     * @param bountySeeker The address providing liquidity on layer 1 for bounty fee
     */
    function transferFunds(
        address[] memory _tokens,
        uint256[] memory _amounts,
        address bountySeeker,
        bytes32 _ticket
    ) external payable;

    /**
     * Approve a state root on the respective layer 2 destination side Buddle contract
     *
     * @param _root The state root to be approved
     */
    function approveRoot(
        bytes32 _root
    ) external;
}