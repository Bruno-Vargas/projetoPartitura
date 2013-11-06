//
//  Afinador.m
//  TesteGithub
//
//  Created by Rodrigo Rovaron on 28/10/13.
//  Copyright (c) 2013 Bruno Vargas. All rights reserved.
//

#import "Afinador.h"
#import <math.h>

@implementation Afinador

-(id) init{
    
    self = [super init];
    
    if(self){
        
        //chamar metodo para carregar notas e frequencias de cada nota
        [self carregaNotasFrequencias];
        
        //determina qual o percentual para dizer se o instrumento está afinado é permitido
        self.rangeToleranciaAfinacao = 10.00;
        
    }
    
    return self;
    
}


//metodo para carregar notas e frequencias de cada nota
-(void) carregaNotasFrequencias{
    self.notasMusicais = [[NSMutableArray alloc]init];
    
    
    //Obs: deve-se inserir notas e frequencia em ordem crescence a partir do DO
    
    //inserir notas musicais no indice 0(zero) da matriz
    [self.notasMusicais addObject:[NSMutableArray arrayWithObjects:@"DO", @"DO#", @"RE", @"RE#", @"MI", @"FA", @"FA#", @"SOL", @"SOL#", @"LA", @"LA#", @"SI", nil]];
    
    
    //inserir frequencias no indice 1 da matriz
    [self.notasMusicais addObject:[NSMutableArray arrayWithObjects:
                                   [NSString stringWithFormat: @"%f",[@"32.700" doubleValue ]],
                                   [NSString stringWithFormat: @"%f",[@"34.625" doubleValue ]],
                                   
                                   [NSString stringWithFormat: @"%f",[@"36.6875" doubleValue ]],
                                   [NSString stringWithFormat: @"%f",[@"38.875" doubleValue ]],
                                   
                                   [NSString stringWithFormat: @"%f",[@"41.200" doubleValue ]],
                                   
                                   
                                   [NSString stringWithFormat: @"%f",[@"43.65" doubleValue ]],
                                   [NSString stringWithFormat: @"%f",[@"46.25" doubleValue ]],
                                   
                                   [NSString stringWithFormat: @"%f",[@"49.00" doubleValue ]],
                                   [NSString stringWithFormat: @"%f",[@"51.8875" doubleValue ]],
                                   
                                   [NSString stringWithFormat: @"%f",[@"55.000" doubleValue ]],
                                   [NSString stringWithFormat: @"%f",[@"58.275" doubleValue ]],
                                   
                                   [NSString stringWithFormat: @"%f",[@"61.725" doubleValue ]],
                                   
                                   nil]];
    
    
    //determinando a menor e a maior frequencia base
    self.menorFrequencia = [self.notasMusicais[1][0] doubleValue];
    self.maiorFrequencia = [self.notasMusicais[1][([self.notasMusicais[1] count]-1)] doubleValue ];
    
}


-(void) calculaNumOitava:(double)freqAtual{
  
    //oitva sempre inicia em 1
    self.numOitava = 1;
    
    //faz divisoes sucessivas contanto a qtde de oitavas que possui na frequencia
    while(freqAtual > self.maiorFrequencia){
        freqAtual /= 2;
        self.numOitava++;
        self.freqReduzida = freqAtual;
    }
    
    
}

//indice auxiliar para ajudar na localizacao de valores de frequencia das notas
int aux_indice = 0;

//metodo resposavel por receber a freq atual.. e verificar se a nota esta afinada ou nao
-(double) calculaAfinacao: (NSString *) freqAtual{
    
    //devido a comparacoes constantes entre os valores das notas.. inicia essa variavel para manter um parametro na comparacao
    self.notaMaisAfinada = @"1000";
    
    
    //buscar numero de oitavas que esta
    [self calculaNumOitava:[freqAtual doubleValue]];
    
    
    //guardar o valor de frequencia real.. usada quando for necessario saber a diferenca negativa de uma nota
    self.freqReal = [[NSMutableArray alloc]init];
    for(int i=0; i< [self.notasMusicais[0] count];i++){
        
        self.freqReal[i] = [NSString stringWithFormat:@"%f",[self.notasMusicais[1][i] doubleValue]-self.freqReduzida];
        
    }

    
    
    //realoca matriz para efetuar calculos de frequencias mais proximas das notas
    self.matrizAfinada = [[NSMutableArray alloc]init];
    self.moduloMatrizAfinada = [[NSMutableArray alloc]init];
    
    
    //inicio da busca pela nota mais afinada.. a mais proxima de zero - 0
    for(int i=0; i< [self.notasMusicais[0] count];i++){
        self.matrizAfinada[i] = [NSString stringWithFormat:@"%f", [self.notasMusicais[1][i] doubleValue]- self.freqReduzida];
        
        
        //realiza o modulo da matriz afinada.. trazendo apenas valores positivos
        if([self.matrizAfinada[i] doubleValue] < 0){
            self.moduloMatrizAfinada[i] = [NSString stringWithFormat:@"%f", [self.matrizAfinada[i] doubleValue]*-1];
        }else{
            self.moduloMatrizAfinada[i] = self.matrizAfinada[i];
        }
        
        
        
        
        //procurar menor valor de frequencia.. inicialmente no moduloMatrizAfinada
        if([self.moduloMatrizAfinada[i] doubleValue] < [self.notaMaisAfinada doubleValue]){
            
            self.notaMaisAfinada = self.moduloMatrizAfinada[i];
            aux_indice = i;
            
        }
    }
    
    
    //passando o nome das notas para as variaveis referentes
    self.notaAtual = self.notasMusicais[0][aux_indice];
    
   
    
    //se a nota atual for a primeira nota.. mostrar a ultima nota como anterior
    if(aux_indice==0){
        self.notaAnterior = self.notasMusicais[0][[self.notasMusicais[0] count] -1];
    }else{
        self.notaAnterior = self.notasMusicais[0][aux_indice-1];
    }
    
    //se a nota atual for a ultima nota.. mostrar a primeira nota como proxima
    if(aux_indice == [self.notasMusicais[0] count]-1){
        self.notaProxima = self.notasMusicais[0][0];
    }else{
        self.notaProxima = self.notasMusicais[0][aux_indice+1];
    }
    
    self.diferencaFreqReal = [self.freqReal[aux_indice] doubleValue];
    
    return [self.notaMaisAfinada doubleValue];
}


@end
