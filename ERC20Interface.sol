/*
  Copyright 2017 RigoBlock, Rigo Investment Sagl
  Copyright 2017 ZeroEx Intl.
  
  Original Code from 0x project, this contract from RigoBlock allows interaction with the 0x exchange protocol

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

*/

pragma solidity 0.4.15;


/// @title Exchange Interface - Facilitates interaction with the 0x exchange protocol.
/// @author Gabriele Rigo - <gab@rigoblock.com>

interface Exchange {
    
    // EVENTS

    event LogFill(address indexed maker, address taker, address indexed feeRecipient, address makerToken, address takerToken, uint filledMakerTokenAmount, uint filledTakerTokenAmount, uint paidMakerFee, uint paidTakerFee, bytes32 indexed tokens, bytes32 orderHash );
    event LogCancel(address indexed maker, address indexed feeRecipient, address makerToken, address takerToken, uint cancelledMakerTokenAmount, uint cancelledTakerTokenAmount, bytes32 indexed tokens, bytes32 orderHash );
    event LogError(uint8 indexed errorId, bytes32 indexed orderHash);

    // NON-CONSTANT METHODS
    
    function deposit(address _token, uint _amount) payable returns (bool success) {}
    function withdraw(address _token, uint _amount) returns (bool success) {}
    function fillOrder(address[5] orderAddresses, uint[6] orderValues, uint fillTakerTokenAmount, bool shouldThrowOnInsufficientBalanceOrAllowance, uint8 v, bytes32 r, bytes32 s) returns (uint filledTakerTokenAmount);
    function cancelOrder(address[5] orderAddresses, uint[6] orderValues, uint cancelTakerTokenAmount) returns (uint);
    function fillOrKillOrder(address[5] orderAddresses, uint[6] orderValues, uint fillTakerTokenAmount, uint8 v, bytes32 r, bytes32 s);
    function batchFillOrders(address[5][] orderAddresses, uint[6][] orderValues, uint[] fillTakerTokenAmounts, bool shouldThrowOnInsufficientBalanceOrAllowance, uint8[] v, bytes32[] r, bytes32[] s);
    function batchFillOrKillOrders(address[5][] orderAddresses, uint[6][] orderValues, uint[] fillTakerTokenAmounts, uint8[] v, bytes32[] r, bytes32[] s);
    function fillOrdersUpTo(address[5][] orderAddresses, uint[6][] orderValues, uint fillTakerTokenAmount, bool shouldThrowOnInsufficientBalanceOrAllowance, uint8[] v, bytes32[] r, bytes32[] s) returns (uint);
    function batchCancelOrders(address[5][] orderAddresses, uint[6][] orderValues, uint[] cancelTakerTokenAmounts);

    // CONSTANT METHODS

    function getOrderHash(address[5] orderAddresses, uint[6] orderValues) constant returns (bytes32);
    function isValidSignature( address signer, bytes32 hash, uint8 v, bytes32 r, bytes32 s) constant returns (bool);
    function isRoundingError(uint numerator, uint denominator, uint target) constant returns (bool);
    function getPartialAmount(uint numerator, uint denominator, uint target) constant returns (uint);
    function getUnavailableTakerTokenAmount(bytes32 orderHash) constant returns (uint);
}

//! this is the alternative interface contract for who does not want to use the solidity interface
/*
contract Exchange {
    
    // EVENTS

    event LogFill(address indexed maker,
        address taker,
        address indexed feeRecipient,
        address makerToken,
        address takerToken,
        uint filledMakerTokenAmount,
        uint filledTakerTokenAmount,
        uint paidMakerFee,
        uint paidTakerFee,
        bytes32 indexed tokens,
        bytes32 orderHash
    );
    
    event LogCancel(address indexed maker,
        address indexed feeRecipient,
        address makerToken,
        address takerToken,
        uint cancelledMakerTokenAmount,
        uint cancelledTakerTokenAmount,
        bytes32 indexed tokens,
        bytes32 orderHash
    );
    
    event LogError(uint8 indexed errorId, bytes32 indexed orderHash);

    // NON-CONSTANT METHODS

    function fillOrder(
        address[5] orderAddresses,
        uint[6] orderValues,
        uint fillTakerTokenAmount,
        bool shouldThrowOnInsufficientBalanceOrAllowance,
        uint8 v,
        bytes32 r,
        bytes32 s)
        public
        returns (uint filledTakerTokenAmount)
    {}

    function cancelOrder(
        address[5] orderAddresses,
        uint[6] orderValues,
        uint cancelTakerTokenAmount)
        public
        returns (uint)
    {}

    function fillOrKillOrder(
        address[5] orderAddresses,
        uint[6] orderValues,
        uint fillTakerTokenAmount,
        uint8 v,
        bytes32 r,
        bytes32 s)
        public
    {}

    function batchFillOrders(
        address[5][] orderAddresses,
        uint[6][] orderValues,
        uint[] fillTakerTokenAmounts,
        bool shouldThrowOnInsufficientBalanceOrAllowance,
        uint8[] v,
        bytes32[] r,
        bytes32[] s)
        public
    {}

    function batchFillOrKillOrders(
        address[5][] orderAddresses,
        uint[6][] orderValues,
        uint[] fillTakerTokenAmounts,
        uint8[] v,
        bytes32[] r,
        bytes32[] s)
        public
    {}

    function fillOrdersUpTo(
        address[5][] orderAddresses,
        uint[6][] orderValues,
        uint fillTakerTokenAmount,
        bool shouldThrowOnInsufficientBalanceOrAllowance,
        uint8[] v,
        bytes32[] r,
        bytes32[] s)
        public
        returns (uint)
    {}
    
    function batchCancelOrders(
        address[5][] orderAddresses,
        uint[6][] orderValues,
        uint[] cancelTakerTokenAmounts)
        public
    {}

    // CONSTANT METHODS

    function getOrderHash(address[5] orderAddresses, uint[6] orderValues) public constant returns (bytes32) {}
    function isValidSignature( address signer, bytes32 hash, uint8 v, bytes32 r, bytes32 s) public constant returns (bool) {}
    function isRoundingError(uint numerator, uint denominator, uint target) public constant returns (bool) {}
    function getPartialAmount(uint numerator, uint denominator, uint target) public constant returns (uint) {}
    function getUnavailableTakerTokenAmount(bytes32 orderHash) public constant returns (uint) {}
}
*/
