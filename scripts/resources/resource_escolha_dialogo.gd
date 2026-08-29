class_name EscolhaDialogo
extends DialogoExport

@export var nome_falante: String = ""
@export var imagem_falante: Texture
@export var qtd_frames_falante: int = 1
@export var frame_selecionada_falante: int = 0

@export_multiline var texto: String

@export var texto_escolha: Array[String]
@export var chamada_funcoes_escolha: Array[FuncaoDialogo]
