int px = 600;
int py = 500;
int pw = 90;
int ph = 30;
int ow = 40;
int oh = 40;
int[] oy = new int[13];//oy upper
int[] oz = new int[13];//oz lower
int[] o1Color = new int[13];
int[] o2Color = new int[13];
int[] o1Wait = new int[13];
int[] o2Wait = new int[13];
int score;
int hp;
int gseq;
int mcnt;

void setup() {
    size(1200, 1000);
    noStroke();
    gameInit();
    for (int i=0; i<13; i++) {
        objInit1(i);
        objInit2(i);
    }
    score = 0;
    hp = 10;
    gseq = 0;
}
void draw() {
    background(252, 209, 250);
    if ( gseq == 0 ) {
        gamePlay();
    } else if ( gseq == 1 ) {
        gameOver();
    }
}
void playerDisp() {
    fill(255, 255, 255);
    rect(px, py, pw, ph, 10);
}
void playerMove() {
    if ((keyPressed == true)&&(key == CODED)) {
        if ((keyCode == RIGHT)&&(px <1200-pw)) {
            px += 4;
        }
        if ((keyCode == LEFT)&&(px >0)) {
            px -= 4;
        }
    }
}
void objDisp1() {
    for (int i=0; i<13; i++) {
        if ( o1Color[i] == 0 ) {
            fill(255, 0, 0);
        } else {
            fill(0, 255, 0);
        }
        rect(i*90+5, oy[i], ow, oh, 10);
    }
}
void objDisp2() {
    for (int i=0; i<13; i++) {
        if ( o2Color[i] == 0 ) {
            fill(255, 0, 0);
        } else {
            fill(0, 255, 0);
        }
        rect(50+i*90+5, oz[i], ow, oh, 10);
    }
}

void objMove1() {
    for (int i=0; i<13; i++) {
        if ( o1Wait[i] > 10 ) {
            o1Wait[i]--;
        } else {
            oy[i] += 6;
        }
        if ( oy[i] > 530 ) {

            objInit1(i);
        }
    }
}
void objInit1(int no) {
    oy[no] = 40;
    o1Color[no] = int(random(2));
    o1Wait[no] = int(random(20, 400));
}
void objMove2() {
    for (int i=0; i<13; i++) {
        if ( o2Wait[i] > 250 ) {
            o2Wait[i]--;
        } else {
            oz[i] -= 6;
        }
        if ( oz[i] < 470 ) {


            objInit2(i);
        }
    }
}
void objInit2(int no) {
    oz[no] = 960;
    o2Color[no] = int(random(2));
    o2Wait[no] = int(random(20, 500));
}
void hitCheck1() {
    int ox;
    for (int i=0; i<13; i++) {
        ox = i*90+5;
        if ( (px < (ox+ow)) && ((px+pw) > ox)
            && (py < (oy[i]+oh)) && ((py+ph) > oy[i]) ) {
            if ( o1Color[i] == 1 ) {
                score += 10;
            } else {
                hp--;
            }
            objInit1(i);
        }
    }
}


void hitCheck2() {
    int ox;
    for (int i=0; i<13; i++) {
        ox = 50+i*90+5;
        if ( (px < (ox+ow)) && ((px+pw) > ox)
            && (py < (oz[i]+oh)) && ((py+ph) > oz[i]) ) {
            if ( o2Color[i] == 1 ) {
                score += 10;
            } else {
                hp--;
            }
            objInit2(i);
        }
    }
}
void scoreDisp() {
    textSize(24);
    fill(255);
    text("score:"+score, 10, 25);
    text("HP:"+hp, 300, 25);
}
void gamePlay() {
    objMove1();
    objMove2();
    objDisp1();
    objDisp2();
    playerMove();
    playerDisp();
    hitCheck1();
    hitCheck2();
    scoreDisp();
    if ( hp < 1 ) {
        gseq = 1;
    }
}
void gameOver() {
    objDisp1();
    objDisp2();
    playerDisp();
    scoreDisp();
    textSize(100);
    fill(255, 255, 0);
    text("GAME OVER", 300, 500);
    mcnt++;
    if ( (mcnt%60) < 40) {
        textSize(30);
        fill(255);
        text("Push any key!", 500, 550);
    }
}
void gameInit() {
    for (int i=0; i<13; i++) {
        objInit1(i);
        objInit2(i);
    }
    score = 0;
    hp = 10;
    gseq = 0;
}
void keyPressed() {
    if ( (gseq == 1) && (mcnt >120 )) {
        gameInit();
    }
}
