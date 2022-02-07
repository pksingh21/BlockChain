const crypto = import('crypto');

class transaction{
    constructor(from, to, amount){
        this.from = from;
        this.to = to;
        this.amount = amount;
    }
}

class wallet{
    constructor(){
        const keypair = crypto.generateKeyPairSync('rsa',{
            modulusLength: 2048,
            publicKeyEncoding: {
                type: 'spki',
                format: 'pem',
            },
            privateKeyEncoding: {
                type: 'pkcs8',
                format: 'pem',
            },
        });
        this.privateKey = keypair.privateKey;
        this.publicKey = keypair.publicKey;
        this.amount = 0;
    }
}

class block{
    constructor(prevHash = ""){
        this.transactions = []; //array of transactions
        this.prevHash = prevHash; // the hash of the previous block
        this.nonce = 0; //this will be used in the proof of work
    }
}