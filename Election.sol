// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Eleccion {
    event VotoEmitido(string candidato, uint votosTotales);
    event EleccionAbierta();
    event EleccionCerrada();
    event VotanteRegistrado(address votante);
    event OwnerSet(address indexed oldOwner, address indexed newOwner);
    event CandidatoAgregado(string nombre);

    address public owner;
    bool public isOpen;
    
    string[] public listaCandidatos;

    mapping(string => uint) public votosPorCandidato;

    mapping(address => bool) public aprobado;

    mapping(address => bool) public yavoto;

    constructor(address _owner) {
        owner = _owner;
        emit OwnerSet(address(0), owner);
    }

    modifier isOwner() {
        require(msg.sender == owner, "Caller is not owner");
        _;
    }

    modifier onlyWhileOpen() {
        require(isOpen, "La eleccion no esta abierta");
        _;
    }

    function aprobarVotante(address _votante) public isOwner {
        aprobado[_votante] = true;
        emit VotanteRegistrado(_votante);
    }

    function agregarCandidato(string memory _nombre) public isOwner {
        require(!existeCandidato(_nombre), "Candidato ya existe");
        listaCandidatos.push(_nombre);
        votosPorCandidato[_nombre] = 0;
        emit CandidatoAgregado(_nombre);
    }

    function abrirEleccion() public isOwner {
        require(!isOpen, "Eleccion ya esta abierta");
        isOpen = true;
        emit EleccionAbierta();
    }

    function cerrarEleccion() public isOwner {
        require(isOpen, "Eleccion ya esta cerrada");
        isOpen = false;
        emit EleccionCerrada();
    }

    function votar(string memory candidato) public onlyWhileOpen {
        require(aprobado[msg.sender], "No estas autorizado para votar");
        require(!yavoto[msg.sender], "Ya votaste");
        require(existeCandidato(candidato), "Candidato no encontrado");

        votosPorCandidato[candidato] += 1;
        yavoto[msg.sender] = true;
        emit VotoEmitido(candidato, votosPorCandidato[candidato]);
    }

    function existeCandidato(string memory _nombre) internal view returns (bool) {
        for (uint i = 0; i < listaCandidatos.length; i++) {
            if (keccak256(bytes(listaCandidatos[i])) == keccak256(bytes(_nombre))) {
                return true;
            }
        }
        return false;
    }

    function cantidadCandidatos() public view returns (uint) {
        return listaCandidatos.length;
    }
}
