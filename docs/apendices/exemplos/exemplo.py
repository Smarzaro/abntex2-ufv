"""Exemplo de módulo usado no Apêndice D do guia abntex2-ufv."""


def media(valores):
    """Calcula a média aritmética de uma lista de números."""
    if not valores:
        return 0.0
    total = 0  # acumulador
    for v in valores:
        total += v
    return total / len(valores)


def aprovado(nota, minimo=6.0):
    return nota >= minimo


if __name__ == "__main__":
    notas = [8.5, 7.0, 9.25]
    print(f"Média: {media(notas):.2f}")
    print("Aprovado" if aprovado(media(notas)) else "Reprovado")
