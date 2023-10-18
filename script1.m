clear; clc; close all; % limpa as variaves e texto do ambiente

%PARTE 1: Aplicar os 3 algoritimos em octave dentro de uma função para o facil acesso dos 3 metodos
function metodo_newton_raphson(func,dfunc,xr,es)

	ea = 100; iter = 0;

	while (1)
		printf("I:%d Aproximação:%.10f EA: %.10f \n",iter,xr,ea);
		xr_velho = xr;
		xr = xr - func(xr)/dfunc(xr);
		iter = iter + 1;
		ea = abs((xr - xr_velho)/xr) * 100;
		if ea <= es
			printf("I:%d Aproximação:%.10f EA: %.10f \n",iter,xr,ea);
			break;
		endif;
	endwhile;

endfunction;

function secante_modificado(func,xr,es)

	ea = 100; iter = 0; fracp = 10^-6;

	while (1)
		printf("I:%d Aproximação: %.10f EA: %.10f \n",iter,xr,ea);
		xr_velho = xr;
		xr = xr_velho - (fracp.*xr.*func(xr))./((func(xr+fracp.*xr))-func(xr));
		iter = iter + 1;
			ea = abs((xr - xr_velho)/xr) * 100;
			if ea <= es
				printf("I:%d Aproximação: %.10f EA: %.10f \n",iter,xr,ea);
				break;
			endif;
	endwhile;

endfunction;

function secante(func,xr,xi,es)

	ea = 100; iter = 0;

	while (1)
		printf("I:%d Aproximação: %.10f EA: %.10f \n",iter,xr,ea);
		xr_velho = xi;
		raiz = xi - ((func(xi).*(xi - xr))./(func(xi)-func(xr)));
		iter = iter + 1;
		ea = abs((xr - xr_velho)/xr) * 100;
		if ea <= es
			printf("I:%d Aproximação: %.10f EA: %.10f \n",iter,raiz,ea);
			break;
		endif;
		xr = xi;
		xi = raiz;
	endwhile;

endfunction;
%parte 2:Definindo Variaveis a serem utilizadas
%=======================================================================
%VARIAVEIS DO EXERCICIO
funcao_exercicio = @(x) (sin(sqrt(x)) - x);
derivada_funcao_exercicio = @(x) (((cos(sqrt(x)))/(2.*sqrt(x))) - 1);



%parte 3: Execução; Esse pedaço de codigo serve para rodar os diferentes metodos
%usando as variaveis especificadas a cima

printf("Metodo_Newton_Raphson:\nI= iteracao; EA = erro aproximado \n");
metodo_newton_raphson(funcao_exercicio,derivada_funcao_exercicio,0.5,0.0001);
printf("Metodo_Secante_Modificada:\nI= iteracao; EA = erro aproximado \n");
secante_modificado(funcao_exercicio,0.5,0.0001);
printf("Metodo_Secante:\nI= iteracao; EA = erro aproximado \n");
secante(funcao_exercicio,0.5,1,0.0001);