# Object Builder (Edição Customizada by Jenison)

## O que é o Object Builder?

O **Object Builder** é um editor visual completo para criação e edição de objetos gráficos para o [OTClient](https://github.com/edubart/otclient). Com ele, você pode criar, editar, organizar e compilar **itens**, **outfits (criaturas)**, **efeitos** ou **projéteis (missiles)** para o seu cliente.

---

## Recursos Exclusivos desta Versão:

* 🎨 **Recolorir Inteligente com HSL**:
  * Ajuste de Matiz (Hue), Saturação e Luminosidade em tempo real.
  * Modo Colorir (Colorize) para efeitos monocromáticos ou elementais.
  * Substituição Seletiva de Cores com Conta-Gotas, tolerância ajustável e preservação de luz e sombra.
  * **Presets de Cor**: Shiny, Fogo, Gelo, Veneno, Sombra e Sangue com 1 clique.
  * **Histórico de Cores**: Cores recentes do conta-gotas para reutilizar na substituição.
* 🪄 **Máscara e Seleção de Área (Recolorir Parcial)**:
  * **Varinha Mágica**: Com apenas 1 clique, seleciona toda a parte conectada (ex: mudar só a bainha da espada, a capa ou a camisa de um outfit).
  * **Pincel (1px a 4px)**: Pinte livremente as áreas que deseja modificar.
  * **Borracha**: Apague e desmarque pixels da seleção.
  * **Retângulo de Seleção**: Selecione regiões quadradas ou retangulares com facilidade.
  * **Destaque Visual (Overlay)**: Visualização em tempo real dos pixels selecionados com opção de ligar/desligar.
  * **Undo/Redo da Máscara**: Desfazer e refazer a seleção (botões ou `Ctrl+Z` / `Ctrl+Y`).
  * **Máscara por Frame/Direção**: Persistência da seleção ao trocar frames e direções, com opção de copiar a máscara para todos.
* 💾 **Opções Inteligentes de Salvamento**:
  * **Criar Novo**: Duplica o objeto gerando novo ID e novas sprites (ideal para Shinies e novos itens).
  * **Substituir Atual**: Atualiza as sprites do objeto existente sem alterar seu ID.
  * Ao salvar, o recolor é aplicado no **objeto inteiro** (todos os frames e direções).

---

## Principais Funcionalidades:

* **Suporte a Grupos de Frames**: Gerencie animações e variações com Frame Groups.
* **Alto Desempenho**: Carregamento e compilação de projetos muito mais rápidos.
* **Importação e Exportação em Sprite Sheet**: Exporte e importe objetos diretamente em folhas de sprites.
* **Exportação em Massa**: Exporte todos os objetos ou sprites de uma única vez.
* **Transparência Total**: Suporte nativo a sprites com canal alpha transparente.
* **Recorte de Imagens**: Ferramenta integrada para fatiar e importar imagens externas.
* **Edição de Atributos**: Modifique atributos e flags de servidor diretamente pelo editor.
* **Renderização Otimizada**: Baixo consumo de memória mesmo em bases de dados massivas.
* **Compatível com 4K / High-DPI**: Interface nítida e adaptada para monitores de alta resolução.
* **Substituição em Lote (Bulk Replace)**: Troque objetos e sprites em lote com agilidade.
* **Salvamento Rápido e Múltiplas Janelas**: Atalhos rápidos e suporte a múltiplas janelas simultâneas.
* **Editar Pixels (Edit Pixels)**: Desloque e centralize os pixels do sprite com proteção inteligente de bordas.
* **Visualização em Rolo de Filme (Film Roll)**: Navegação prática quadro a quadro das animações.
* **Grade de Pixels (Pixel Grid)**: Grade para edições cirúrgicas e precisas.
* **Find → Replace de Sprites**: Substitua sprites diretamente pelos resultados da busca (arquivo ou clipboard).
* **Copy/Paste de Sprites na Find**: Copie uma sprite e cole para substituir outra selecionada.

---

## Versões de Cliente Suportadas:
* **7.10** até **13.10**

---

## Downloads (Windows):
* Equipado com a versão mais recente do **Adobe AIR (v51.2.2.6)** integrada (Captive Runtime, não precisa instalar o AIR separadamente).
* Baixe o instalador `.exe` ou a versão portátil `.zip` diretamente na aba de **[Releases](https://github.com/jenison06/ObjectBuilder_by_Jenison/releases)**.

---

## Doações / Apoie o Projeto ☕

Se este projeto te ajudou e você deseja apoiar o desenvolvimento contínuo de novas melhorias:

* 💳 **PayPal**: `arceusp@outlook.com`
* 📱 **PIX (QR Code & Copia e Cola)**:

<p align="center">
  <img src="pix_qrcode.png" alt="PIX QR Code" width="220" /><br>
  <sub><b>JENISON WILKER COSTA SILV</b> - Escaneie no app do seu banco ou use o código abaixo:</sub>
</p>

```text
00020101021126580014BR.GOV.BCB.PIX0136983833f2-f4b1-4536-a81a-6059a7fbca5b5204000053039865802BR5925JENISON WILKER COSTA SILV6009SAO PAULO62080504daqr6304B0F8
```

---

## Créditos

* **Jenison**: Desenvolvimento e implementação da ferramenta de Recolorir Inteligente, Seleção de Área (Varinha Mágica, Pincel, Borracha, Retângulo), salvamento Criar Novo/Substituir, metadados e empacotamento.
* **DevStuart**: Undo/Redo da máscara, presets e histórico de cores no Recolor, Replace/Copy/Paste de sprites na Find.
* **punkice3407**: Manutenção da base do repositório Open Source.
* **Edubart & Mignari**: Autores originais do projeto ObjectBuilder / OTTools.
* **Comunidade OTServ**: Pelo feedback e apoio ao desenvolvimento de ferramentas abertas.
