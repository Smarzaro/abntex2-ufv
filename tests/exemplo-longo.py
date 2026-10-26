"""Exemplo com uma linha de 127 caracteres, para testar a quebra de linha."""
def calcula(ações):
    resultado = sum(ações) / len(ações) + sum(ações) * 2 - len(ações) ** 2 + max(ações) - min(ações) + 12345.6789 + 0.5
    return resultado  # comentário com acentuação: média, ação, coração
