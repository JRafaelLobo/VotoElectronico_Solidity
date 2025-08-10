// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Election.sol";

contract Factory {
    mapping(address => address[]) private elecciones;

    function CrearEleccion() external returns (address) {
        Eleccion nuevaEleccion = new Eleccion(msg.sender);
        address direccion = address(nuevaEleccion);
        elecciones[msg.sender].push(direccion);
        return direccion;
    }

    function EliminarEleccion(uint index) external {
        address[] storage lista = elecciones[msg.sender];
        require(index < lista.length, "Indice fuera de rango");
        
        lista[index] = lista[lista.length - 1];
        lista.pop();
    }

    function verMisElecciones() external view returns (address[] memory) {
        return elecciones[msg.sender];
    }
}
