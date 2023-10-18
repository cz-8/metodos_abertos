clear; clc; close all; % limpa as variaves e texto do ambiente

%PARTE 1: Aplicar os 3 algoritimos em octave dentro de uma função para o facil acesso dos 3 metodos
function metodo_newton_raphson(func,dfunc,xr,es)

	ea = 100; iter = 0;

	while (1)
		printf("I:%d Raiz ~= %.10f EA: %.10f \n",iter,xr,ea);
		xr_velho = xr;
		xr = xr - func(xr)/dfunc(xr);
		iter = iter + 1;
		ea = abs((xr - xr_velho)/xr) * 100;
		if ea <= es
			printf("I:%d Raiz ~= %.10f EA: %.10f INFO: Criterio de parada satisfeito! \n",iter,xr,ea);
			break;
		endif;
	endwhile;

	printf("\n\n")

endfunction;

function secante_modificado(func,xr,es,fdp)

	ea = 100; iter = 0;

	while (1)
		printf("I:%d Raiz ~= %.10f EA: %.10f \n",iter,xr,ea);
		xr_velho = xr;
		xr = xr_velho - (fdp.*xr.*func(xr))./((func(xr+fdp.*xr))-func(xr));
		iter = iter + 1;
			ea = abs((xr - xr_velho)/xr) * 100;
			if ea <= es
				printf("I:%d Raiz ~= %.10f EA: %.10f INFO: Criterio de parada satisfeito! \n",iter,xr,ea);
				break;
			endif;
	endwhile;

	printf("\n\n")

endfunction;

function secante(func,x1,x2,es)

	ea = 100; iter = 0;

	while (1)
		printf("I:%d Raiz ~= %.10f EA: %.10f \n",iter,x1,ea);
		x1_velho = x2;
		raiz = x2 - ((func(x2).*(x2 - x1))./(func(x2)-func(x1)));
		iter = iter + 1;
		ea = abs((x1 - x1_velho)/x1) * 100;
		if ea <= es
			printf("I:%d Raiz ~= %.10f EA: %.10f INFO: Criterio de parada satisfeito! \n",iter,raiz,ea);
			break;
		endif;
		x1 = x2;
		x2 = raiz;
	endwhile;

	printf("\n\n")

endfunction;


%parte 2:Definindo Variaveis a serem utilizadas:

%=======================================================================
%VARIAVEIS DO EXERCICIO

funcao_exercicio = @(x) (sin(sqrt(x)) - x);
derivada_funcao_exercicio = @(x) (((cos(sqrt(x)))/(2.*sqrt(x))) - 1); % somente para metodo_newton_raphson

es = 0.0001; % 0.01% em forma decimal
estimativa_inicial = 0.5; % valor dado pelo exercicio

fracao_de_perturbacao = 10^-6; % somente para o metodo secante
segunda_estimativa_inicial = 1; %somente para o metodo secante

%=======================================================================


%parte 3: Execução; Esse pedaço de codigo serve para rodar os diferentes metodos:

%usando as variaveis especificadas a cima
printf("Legenda:\n'I' > Iteracao.\n'EA' > Erro Aproximado.\nO criterio de parada utilizado é o do erro aproximado\nNo exercicio o valor do EA é de '0,01(por cento)' ou 0,0001 e forma decimal.\nLogo, o programa para quando EA <= 0.0001 em cada metodo.\n\n");
printf("	Metodo_Newton_Raphson:\n\n");
metodo_newton_raphson(funcao_exercicio,derivada_funcao_exercicio,estimativa_inicial,es);
printf("	Metodo_Secante_Modificada:\n\n");
secante_modificado(funcao_exercicio,estimativa_inicial,es,fracao_de_perturbacao);
printf("	Metodo_Secante:\n\n");
secante(funcao_exercicio,estimativa_inicial,segunda_estimativa_inicial,es);