# crypt-decrypt-txt
Atividade proposta na matéria de Segurança e Auditoria de Sistemas. Com o código é possível gerar chaves assimétrica com base na entrada do usuário, além de encriptar e decriptar um arquivo .txt


## Atividade proposta

Ao inicializar, o programa deve solicitar a geração das chaves de criptografia / descriptografia que devem ser armazenadas em dois arquivos distintos caso o usuário desejar, poder usar chaves previamente geradas pelo sistema (neste caso o programa deve ler os arquivos das chaves). Para isto, seu sistema deve ser capaz de gerar as chaves de criptografia (dica: pesquisar sobre como gerar chaves RSA).

O programa deverá pedir a ação a ser efetuada (criptografia/descriptografia). Deve em seguida, solicitar a localização do arquivo original (deve ser um arquivo .txt). Após isso, deve gravar o arquivo criptografado com uma extensão .crypt. Deve ser possível descriptografar um arquivo, retornando o mesmo a sua forma original.

Definição de OK: Deve ser possível criptografar/descriptografar um arquivo TXT.
