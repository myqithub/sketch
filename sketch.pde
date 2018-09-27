int[][] dunya;
int kareBoyutu = 10;
int yatayKareSayisi, dikeyKareSayisi;

int boyananKS = 4;

void setup() {
  size(1600,900,P2D);
  
  yatayKareSayisi = width / kareBoyutu;
  dikeyKareSayisi = height / kareBoyutu;
  
  dunya = new int[yatayKareSayisi][dikeyKareSayisi];
  
  for(int i = 0; i < yatayKareSayisi; i++) {
    for(int j = 0; j < dikeyKareSayisi; j++) {
      dunya[i][j] = 0;
    }
  }
}

void draw() {

  if (mousePressed && (mouseButton == LEFT)) {
    etrafiniBoya(int(mouseX/kareBoyutu),int(mouseY/kareBoyutu),1);
  } else if (mousePressed && (mouseButton == RIGHT)) {
    etrafiniBoya(int(mouseX/kareBoyutu),int(mouseY/kareBoyutu),2);
  } else if (mousePressed && (mouseButton == CENTER)) {
    etrafiniBoya(int(mouseX/kareBoyutu),int(mouseY/kareBoyutu),0);
  } 
  
  // hareket etmiş sulara tekrar hareket etme özelliği sağla
  for(int i = 0; i < yatayKareSayisi; i++) {
    for(int j = 0; j < dikeyKareSayisi; j++) {
      if(dunya[i][j] == 3) {
        dunya[i][j] = 2;
      }
    }
  }
  
  // suları akıtır
  for(int i = 0; i < yatayKareSayisi; i++) {
    for(int j = 0; j < dikeyKareSayisi; j++) {
      if(dunya[i][j] == 2) {
        if(j+1 < dikeyKareSayisi) { // hareket edilecek nokta array içinde mi?
          if(dunya[i][j+1] == 0) { // hareket edilecek nokta boş mu dolu mu?
            dunya[i][j+1] = 3;
            dunya[i][j] = 0;
          } else if(i+1 < yatayKareSayisi && i-1 >= 0) { // sağ sol çaprazlar geçerli indeksler
            if(dunya[i+1][j+1] == 0 && dunya[i-1][j+1] == 0) { // sağ sol çaprazlar boş
              if(random(1) < 0.5f) {
                dunya[i+1][j+1] = 3;
                dunya[i][j] = 0;
              } else {
                dunya[i-1][j+1] = 3;
                dunya[i][j] = 0;
              }
            } else {
              if(dunya[i+1][j+1] == 0) {
                dunya[i+1][j+1] = 3;
                dunya[i][j] = 0;
              } else if(dunya[i-1][j+1] == 0) {
                dunya[i-1][j+1] = 3;
                dunya[i][j] = 0;
              } else {
                // iki alt çapraz da dolu
                if(dunya[i+1][j] == 0 && dunya[i-1][j] == 0) { // iki aynı hiza yanı da boş
                  if(random(1) < 0.5f) {
                    dunya[i+1][j] = 3;
                    dunya[i][j] = 0;
                  } else {
                    dunya[i-1][j] = 3;
                    dunya[i][j] = 0;
                  }
                } else if(dunya[i+1][j] == 0){
                  dunya[i+1][j] = 3;
                  dunya[i][j] = 0;
                } else if(dunya[i-1][j] == 0){
                  dunya[i-1][j] = 3;
                  dunya[i][j] = 0;
                } else{
                  // su yukarı çıkar mı?
                }
              }
            }
          }
        }
      }
    }
  }
  
  // kareleri çizer
  for(int i = 0; i < yatayKareSayisi; i++) {
    for(int j = 0; j < dikeyKareSayisi; j++) {
      if(dunya[i][j] == 0) {
        fill(0);
      } else if(dunya[i][j] == 1) {
        fill(#4C5A48);
      } else if(dunya[i][j] == 2) {
        fill(#96C7DE);
      } else if(dunya[i][j] == 3) {
        fill(#96C7DE);
      }
      rect(i*kareBoyutu,j*kareBoyutu,kareBoyutu,kareBoyutu);
    }
  }
  
  textSize(32);
  fill(255);
  text("x:" + mouseX + " y:" + mouseY + " boyut:" + boyananKS, 30, 30); 
}

void etrafiniBoya(int x, int y, int b) {
  int xx = x - boyananKS/2;
  int yy = y - boyananKS/2;
  
  for(int i = xx; i < xx + boyananKS; i++) {
    for(int j = yy; j < yy + boyananKS; j++) {
      if(i >= 0 && i < yatayKareSayisi && j >= 0 && j < dikeyKareSayisi) {
        dunya[i][j] = b;
      }
    }
  }
}

void mouseWheel(MouseEvent event) {
  int e = event.getCount();
  boyananKS -= e;
  if(boyananKS <= 0) {
    boyananKS = 1;
  }
}
