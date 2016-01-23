//
//  Des3Encrypt.m
//  uYoung
//
//  Created by 独自天涯 on 16/1/23.
//  Copyright © 2016年 uYoungCommon. All rights reserved.
//

#import "Des3Encrypt.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>
#import "GTMBase64.h"

static char ENCODE_STR[] =  {0xef, 0x2b, 0xcc, 0xdc, 0x9b, 0x3b, 0xf7, 0x2a, 0x68, 0xad, 0xeb, 0x72, 0xe3, 0x78, 0x2f, 0x5e, 0x7, 0x77, 0xd5, 0xc1, 0x7d, 0x40, 0x66, 0xb8, '\0'};

@implementation Des3Encrypt

+(NSString*)TripleDES:(NSString*)plainText withRandom:(NSString*)random{
    
    const void *vplainText;
    size_t plainTextBufferSize;
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    plainTextBufferSize = [data length];
    vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    char key[24];
    genCroptyKey(ENCODE_STR, [random UTF8String], key);
    
    NSString *initIv = @"12345678";
    const void *iv = (const void *)[initIv UTF8String];
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       key,
                       kCCKeySize3DES,
                       iv,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result;
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    result = [GTMBase64 stringByEncodingData:myData];
    
    return result;
}

/*
 *生成密钥 encodeKeyA.length=24
 */
void genCroptyKey(char* encodeKeyA, const char* random, char* result){
    if (encodeKeyA == nil) {
        return ;
    }
    
    const char* A = encodeKeyA;
    char B[24];
    char C[24];
    strcpy(C, random);
    unsigned long alen = strlen(A);
    unsigned long clen = strlen(C);
    if (alen != 24 || (clen < 8 || clen > 20))
        return ;
    long demension = alen - clen;
    arrcopy(B, C, 0, strlen(C));
    
    int piont = 1;
    while (demension > 0) {
        if (demension > clen) {
            arrcopy(B, C, clen * piont + 0, clen);
            piont++;
            
        } else {
            arrcopy(B, C, clen * piont + 0, demension);
        }
        demension = demension - clen;
        
    }
    
    for (int i = 0; i < alen; i++) { //0 ^  1 |  2 &
        
        switch ((i + 1) % 3) {
            case 0:
                result[i] = (char) (A[i] ^ B[i]);
                break;
            case 1:
                result[i] = (char) (A[i] & B[i]);
                break;
            case 2:
                result[i] = (char) (A[i] | B[i]);
                break;
        }
        
    }
    
}

void arrcopy(char* dest, char* src, long index, long len){
    
    for(int j=0;j<index;j++){
        dest++;
    }
    
    memcpy(dest,src,len);
    
}

@end
