# 🗳️ Contrato de Votación en Solidity

Este proyecto implementa un contrato inteligente de **Elección** en Solidity que permite:

- Registrar candidatos.
- Autorizar votantes.
- Abrir y cerrar la elección.
- Emitir votos de forma segura.
- Llevar el conteo de votos usando `keccak256` para comparación de nombres.

El contrato está optimizado para reducir costos de gas usando `calldata` y validaciones eficientes.

---

## 📜 Características

- **Solo el dueño (owner)** puede:
  - Agregar candidatos.
  - Aprobar votantes.
  - Abrir y cerrar la elección.
- **Votantes autorizados**:
  - Pueden votar solo una vez.
  - Solo mientras la elección esté abierta.
- Validación de existencia de candidato mediante `keccak256`.
- Registro de eventos para todas las acciones importantes.

---
